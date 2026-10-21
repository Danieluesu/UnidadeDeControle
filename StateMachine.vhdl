library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StateMachine is
   port( clk            : in std_logic;
         rst            : in std_logic;
         pc_wr_en_o     : out std_logic; 
         rom_read_en_o  : out std_logic
   );
end entity;

architecture a_StateMachine of StateMachine is
   signal estado: std_logic := '0';
begin
   process(clk,rst)  -- tirei wr_en 
   begin
      if rst='1' then
         estado <= '0';  -- estado inicial
      elsif rising_edge(clk) then
        estado <= not estado;  -- alterna entre FETCH e DECODE/EXECUTE
      end if;
   end process;

   rom_read_en_o <= '1' when estado = '0' else '0'; --FETCH
   pc_wr_en_o <= '1' when estado = '1' else '0';    --DECODE/EXECUTE

end architecture;