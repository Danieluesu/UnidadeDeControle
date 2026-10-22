library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_tb is
end entity;

architecture a_ROM_tb of ROM_tb is

    component ROM is
        port(
            endereco : in unsigned(6 downto 0);
            dado : out unsigned(15 downto 0)
        );
    end component;

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal endereco : unsigned(6 downto 0);
    signal dado : unsigned(15 downto 0);

    begin

        utt: ROM port map(
             endereco => endereco,
             dado => dado
         );
        sim_time_proc: process
            begin
                wait for 1500 ns;         -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
                finished <= '1';
                wait;
            end process sim_time_proc;

    process
         begin
            endereco <= "0000000"; wait for period_time;
            endereco <= "0000001"; wait for period_time;
            endereco <= "0000010"; wait for period_time;
            endereco <= "0000011"; wait for period_time;
            endereco <= "0000100"; wait for period_time;
            endereco <= "0000101"; wait for period_time;
            endereco <= "0000110"; wait for period_time;
            endereco <= "0000111"; wait for period_time;
            endereco <= "0001000"; wait for period_time;
            endereco <= "0001001"; wait for period_time;
            endereco <= "0001010"; wait for period_time;
            endereco <= "1111111"; wait for period_time; -- caso omisso
            wait;
    end process;
end architecture;

