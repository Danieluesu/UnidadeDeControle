
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clk_PC            : in std_logic;
        rst_PC            : in std_logic;
        wr_en_PC          : in std_logic;
        address_in        : in unsigned(6 downto 0);
        address_out       : out unsigned(6 downto 0);
        jump_PC           : in std_logic;
        data_in           : in unsigned(6 downto 0);
        cond_or_incond_PC : in std_logic
    );
end entity;

architecture a_PC of PC is
    signal address_tmp : unsigned(6 downto 0);
begin

    

    process(clk_PC, rst_PC)
    begin
        if rst_PC = '1' then
            address_tmp <= (others => '0');
        elsif rising_edge(clk_PC) then
            if wr_en_PC = '1' then
                address_tmp <= address_in;
            end if;
        end if;
    end process;

    address_out <= address_tmp;

end architecture;
