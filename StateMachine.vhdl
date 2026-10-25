library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StateMachine is
   port( clk            : in std_logic;
         rst            : in std_logic;
         pc_wr_en_o     : out std_logic; 
         rom_read_en_o  : out std_logic;
         data_out       : out unsigned(6 downto 0); -- endereco absoluto ou salto cte   
         instr          : in unsigned(15 downto 0); -- instrução a ser decodificada
         jump           : out std_logic; -- flag para saber se tem ou nao salto
         cond_or_incond : out std_logic -- tipo de condicional
   );
end entity;

architecture a_StateMachine of StateMachine is
   signal state                 : std_logic := '0';
   signal opcode                : unsigned(3 downto 0);
   signal data_signal           : unsigned(6 downto 0);
   signal jump_signal           : std_logic;
   signal cond_or_incond_signal : std_logic;
   signal cond_instr_signal     : unsigned(0 downto 0);

begin
   -- 1. BLOCO SEQUENCIAL: Exclusivo para o Flip-Flop T e Reset
   process(clk, rst)  
   begin
      if rst = '1' then
         state <= '0';  
      elsif rising_edge(clk) then
         state <= not state;  -- alterna entre FETCH e DECODE/EXECUTE
      end if;
   end process;

   -- 2. LÓGICA COMBINACIONAL: Fora do processo
   opcode <= unsigned(instr(15 downto 12)) when state = '0' and rst = '0';
   cond_instr_signal <= unsigned(instr(11 downto 11)) when state = '0'and rst = '0';

   --data_signal <= "0000010" when opcode = "0000" else -- 0x002
     --             "0000100" when opcode = "0001" else    -- 0x004
      --         "0000110" when opcode = "0010" else -- 0x006
       --        "0001000" when opcode = "0011" else -- 0x008
        --       "0001010" when opcode = "0100" else -- 0x00A
         --      "0000000" when opcode = "0101" else -- 0x000
          --     (others => '0');
   
   --cond_or_incond_signal <= '1' when
     --                                opcode = "0001" else
       --                     '0'; --  0101 é incondicional
                  

   jump_signal <= '1' when 
                           opcode = "0001" 
                      else 
                  '0';
   data_signal <= instr(6 downto 0) when jump_signal = '1' else
                  (others => '0'); 

   cond_or_incond_signal <= '1' when  jump_signal = '1' and cond_instr_signal = "1" else
                           '0' when jump_signal = '1' and cond_instr_signal = "0" else
                           '0'; -- default

   rom_read_en_o <= '1' when state = '0' and rst = '0' else '0'; -- FETCH
   pc_wr_en_o    <= '1' when state = '1' and rst = '0' else '0'; -- DECODE/EXECUTE

   data_out       <= data_signal;
   jump           <= jump_signal;
   cond_or_incond <= cond_or_incond_signal;
      
end architecture;
