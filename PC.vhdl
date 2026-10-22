library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC is
    port( clk_PC            : in std_logic;
          rst_PC            : in std_logic;
          wr_en_PC          : in std_logic;
          address_in        : in unsigned(7 downto 0);
          address_out       : out unsigned(7 downto 0);
          jump_PC           : in std_logic;
          data_in           : in unsigned(7 downto 0);
          cond_or_incond_PC : in std_logic
    );
end entity;

architecture a_PC of PC is

    signal address     : unsigned(7 downto 0);
    signal address_tmp : unsigned(7 downto 0);

begin
    
    process(clk_PC, rst_PC, wr_en_PC)  -- acionado se houver mudança em clk, rst ou wr_en
    begin
        if rst_PC = '1' then
            address <= (others => '0');  -- reset assíncro
        elsif wr_en_PC = '1' then
            if rising_edge(clk_PC) then
                
                address_tmp <= address_in + data_in when jump_PC = '1' and cond_or_incond_PC = '1' else
                               data_in              when jump_PC = '1' and cond_or_incond_PC = '0' else
                               address_in; 
                               
                address <= address_tmp;
                
            end if;
        end if;
    end process;
    
    address_out <= address;  
    
end architecture;