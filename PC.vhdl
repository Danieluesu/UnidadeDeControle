library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC is
    port( clk_reg   : in std_logic;
          rst_reg   : in std_logic;
          wr_en_reg : in std_logic;
          data_in   : in signed(15 downto 0);
          data_out  : out signed(15 downto 0)
    );
end entity;

architecture a_PC of PC is
    signal registro: signed(15 downto 0);

begin
    process(clk_reg, rst_reg, wr_en_reg)  -- acionado se houver mudança em clk, rst ou wr_en
    begin
        if rst_reg = '1' then
            registro <= (others => '0');  -- reset assíncro
        elsif wr_en_reg = '1' then
            if rising_edge(clk_reg) then
                registro <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= registro;  -- conexao direta, fora do processo
end architecture;