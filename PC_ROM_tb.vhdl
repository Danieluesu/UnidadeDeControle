library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ROM_tb is
end entity;

architecture a_PC_ROM_tb of PC_ROM_tb is

    component PC_ROM is
    port(
        clk               : in std_logic;
        rst               : in std_logic;
        wr_en_PC          : in std_logic;
        jump_PC           : in std_logic;
        data_in           : in unsigned(15 downto 0);
        cond_or_incond_PC : in std_logic;
        ROM_out           : out unsigned(15 downto 0);
        read_en           : in std_logic
    );
end component;

    constant period_time : time := 100 ns;
    signal finished      : std_logic := '0';

    signal clk_s               : std_logic := '0';
    signal rst_s               : std_logic := '0';
    signal wr_en_PC_s          : std_logic := '1'; 
    signal address_in_s        : unsigned(6 downto 0) := (others => '0');
    signal address_out_s       : unsigned(6 downto 0);
    signal jump_PC_s           : std_logic := '0';
    signal data_in_s           : unsigned(15 downto 0) := (others => '0');
    signal cond_or_incond_PC_s : std_logic := '0';
    signal ROM_out_s           : unsigned(15 downto 0);

begin

    uut: PC_ROM port map(
        clk                 => clk_s,
        rst                 => rst_s,
        wr_en_PC            => wr_en_PC_s,
        jump_PC             => jump_PC_s,
        data_in             => data_in_s,
        cond_or_incond_PC   => cond_or_incond_PC_s,
        ROM_out             => ROM_out_s,
        read_en             => '1' 
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