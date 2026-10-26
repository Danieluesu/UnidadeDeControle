library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ROM_tb is
end entity;

architecture a_PC_ROM_tb of PC_ROM_tb is

    component PC_ROM is
    port(
           clk_PC_ROM     : in std_logic;
           rst_PC_ROM     : in std_logic;
           wr_en_PC_ROM   : in std_logic;
           read_en_PC_ROM : in std_logic;
           inst_ROM       : out unsigned(15 downto 0);
           addr_in_PC     : in unsigned(6 downto 0);  -- PC in
           addr_out_PC    : out unsigned(6 downto 0); -- PC out
           addr_add_PC    : out unsigned(6 downto 0)  -- PC + 1
    );
end component;

    constant period_time : time := 100 ns;
    signal finished      : std_logic := '0';

    signal clk_s         : std_logic := '0';
    signal rst_s         : std_logic := '0';
    signal wr_en_PC_s    : std_logic := '1'; 
    signal address_in_s  : unsigned(6 downto 0) := (others => '0');
    signal address_out_s : unsigned(6 downto 0);
    signal inst_ROM_s    : unsigned(15 downto 0) := (others => '0');
    signal addr_add_PC_s : unsigned(6 downto 0);

begin

    uut: PC_ROM port map(
        clk_PC_ROM     => clk_s,
        rst_PC_ROM     => rst_s,
        wr_en_PC_ROM   => wr_en_PC_s,
        read_en_PC_ROM => '1',
        inst_ROM       => inst_ROM_s,
        addr_in_PC     => address_in_s,
        addr_out_PC    => address_out_s,
        addr_add_PC    => (others => '0')
    );
       

    reset_global: process
    begin
        rst_s <= '1';
        wait for period_time * 2; -- Mantém o reset em '1' por 2 clocks
        rst_s <= '0';
        wait;
    end process;

    clk_proc: process
    begin
        while finished /= '1' loop
            clk_s <= '0';
            wait for period_time / 2;
            clk_s <= '1';
            wait for period_time / 2;
        end loop;
        wait;
    end process clk_proc;

    sim_time_proc: process
    begin
        wait for 1500 ns; 
        
        finished <= '1';
        -- OBRIGATÓRIO: Terminar com wait; para não rodar infinitamente[cite: 5]
        wait; 
    end process sim_time_proc;

end architecture;