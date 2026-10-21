library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_um_tb is
end entity;

architecture a_add_um_tb of add_um_tb is

    component add_um is
        port(
            data_in	: in unsigned(15 downto 0);
			data_out: out unsigned(15 downto 0)
        );
    end component;

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal data_in  : unsigned(15 downto 0);
    signal data_out : unsigned(15 downto 0);

begin

    uut: add_um port map(
        data_in => data_in,
        data_out => data_out
    );

    sim_time_proc: process
    begin
        wait for 1500 ns;         -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
        finished <= '1';
        wait;
    end process sim_time_proc;

    process
    begin
        data_in <= "0110011101100110"; wait for period_time;
        data_in <= "0000000000010010"; wait for period_time;
        data_in <= "0010001000000000"; wait for period_time;
        data_in <= "0000000000000011"; wait for period_time;
        data_in <= "0000000000000100"; wait for period_time;
        data_in <= "1111111111111111"; wait for period_time; -- caso omisso
        wait;
    end process;
end architecture;