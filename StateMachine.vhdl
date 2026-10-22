library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StateMachine is
   port( clk            : in std_logic;
         rst            : in std_logic;
         pc_wr_en_o     : out std_logic; 
         rom_read_en_o  : out std_logic;
         data_out       : out signed(7 downto 0);
         instr          : in signed(15 downto 0);
         jump           : out std_logic;
         cond_or_incond : out std_logic
   );
end entity;

architecture a_StateMachine of StateMachine is
   signal state: std_logic := '0';
   signal opcode: unsigned(3 downto 0);
   signal data_signal: signed(7 downto 0);
   signal jump_signal: std_logic := '0';
   signal cond_or_incond_signal: std_logic := '0';

begin
   process(clk,rst)  
   begin
      if rst='1' then
         state <= '0';  -- estado inicial
      elsif rising_edge(clk) then

         opcode <= unsigned(instr(15 downto 12));

         data_signal <= "00000000" when opcode = "0000" else -- endereco absoluto: 0x004
                        "00000001" when opcode = "0001" else -- endereco absoluto: 0x008
                        "00000011" when opcode = "0010" else -- endereco absoluto: 0x00C
                        "00000100" when opcode = "0011" else -- endereco absoluto: 0x010
                        "00000010" when opcode = "0100" else -- salto cte: 0x002
                        "00000101" when opcode = "0101" else -- salto cte: 0x005 
                        (others => '0');
         
         cond_or_incond_signal <= '1' when opcode = "0000" or
                                           opcode = "0001" or 
                                           opcode = "0010" or
                                           opcode = "0011" else 
                                  '0';

         jump_signal <= '1' when opcode = "0000" or
                                 opcode = "0001" or 
                                 opcode = "0010" or
                                 opcode = "0011" or 
                                 opcode = "0100" or
                                 opcode = "0101"
                              else 
                        '0';

         

         state <= not state;  -- alterna entre FETCH e DECODE/EXECUTE
      end if;
   end process;

   rom_read_en_o <= '1' when state = '0' else '0'; --FETCH
   pc_wr_en_o <= '1' when state = '1' else '0';    --DECODE/EXECUTE

   data_out <= data_signal;
   jump <= jump_signal;
   cond_or_incond <= cond_or_incond_signal;
      
end architecture;