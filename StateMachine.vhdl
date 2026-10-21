library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StateMachine is
   port( clk            : in std_logic;
         rst            : in std_logic;
         data_in        : in unsigned(7 downto 0);
         pc_wr_en_o     : out std_logic; 
         rom_read_en_o  : out std_logic;
         data_out       : out unsigned(7 downto 0)
   );
end entity;

architecture a_StateMachine of StateMachine is
   signal data_s: unsigned(7 downto 0);  --VER ONDE USAR 
   signal estado: std_logic := '0';
begin
   process(clk,rst)  -- tirei wr_en 
   begin
      if rst='1' then 
      elsif rising_edge(clk) then
        estado <= not estado;  -- alterna entre FETCH e DECODE/EXECUTE
      end if;
   end process;

   rom_read_en_o <= '1' when estado = '0' else '0'; --FETCH
   pc_wr_en_o <= '1' when estado = '1' else '0';    --DECODE/EXECUTE

   data_out <= data_s;  
end architecture;