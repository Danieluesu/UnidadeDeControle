library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SM_PC_ROM_tb is
end entity;

architecture a_SM_PC_ROM_tb of SM_PC_ROM_tb is

    component SM_PC_ROM is
        port( clk_geral : in std_logic;
              rst_geral : in std_logic;
              address_out : out unsigned(6 downto 0)
        );
    end component;

    constant period_time : time := 100 ns;
    signal finished      : std_logic := '0';

    signal clk_s : std_logic := '0';
    signal rst_s : std_logic := '0';
    signal address_out_tb : unsigned(6 downto 0);

begin

    uut: SM_PC_ROM port map(
        clk_geral => clk_s,
        rst_geral => rst_s,
        address_out => address_out_tb
    );

   
    reset_global: process
    begin
        rst_s <= '1';
        wait for period_time * 2; -- Mantém o reset em '1' por 2 ciclos de clock
        rst_s <= '0';
        wait;
    end process;

  
    sim_time_proc: process
    begin
        wait for 8000 ns; -- <== TEMPO TOTAL DA SIMULAÇÃO
        finished <= '1';
        wait;
    end process sim_time_proc;

    
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

end architecture;