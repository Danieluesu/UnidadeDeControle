
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_PC_ROM is
   port(  clk_geral   : in  std_logic;
          rst_geral   : in  std_logic;
          address_out : out unsigned(6 downto 0)
   );
end entity;

architecture UC_SM_PC_ROM of SM_PC_ROM is

   component PC_ROM is
      port(  clk_PC_ROM     : in std_logic;
             rst_PC_ROM     : in std_logic;
             wr_en_PC_ROM   : in std_logic;
             read_en_PC_ROM : in std_logic;
             inst_ROM       : out unsigned(15 downto 0);
             addr_in_PC     : in unsigned(6 downto 0);  -- PC in
             addr_out_PC    : out unsigned(6 downto 0); -- PC out
             addr_add_PC    : out unsigned(6 downto 0)  -- PC + 1
      );
   end component;

   component MUX_PC is
      port(  adress_in          : in unsigned(6 downto 0);
             adress_in_add_um   : in unsigned(6 downto 0);  
             address_out        : out unsigned(6 downto 0);
             jump_MUX           : in std_logic;
             cond_or_incond_MUX : in std_logic;
             data_in_MUX        : in unsigned(6 downto 0)
      );
   end component;

   component UC is
      port(  clk_UC         : in std_logic;
             rst_UC         : in std_logic;
             pc_wr_en_o     : out std_logic;
             rom_read_en_o  : out std_logic;
             ir_wr_en_o     : out std_logic;
             data_out       : out unsigned(6 downto 0); -- endereco absoluto ou salto cte   
             instr          : in unsigned(15 downto 0); -- instrução a ser decodificada
             jump           : out std_logic; -- flag para saber se tem ou nao salto
             cond_or_incond : out std_logic  -- tipo de condicional
      );
   end component;

   component instruction_register is
      port(  clk_IR    : in  std_logic;
             rst_IR    : in  std_logic;
             wr_en_IR  : in  std_logic;
             instr_in  : in  unsigned(15 downto 0);
             instr_out : out unsigned(15 downto 0)
      );
   end component;

   signal pc_wr_en_signal       : std_logic;
   signal rom_read_en_signal    : std_logic;
   signal ir_wr_en_signal       : std_logic;
   signal data_signal           : unsigned(6 downto 0);
   signal instr_rom             : unsigned(15 downto 0);
   signal instr_ir              : unsigned(15 downto 0);
   signal jump_signal           : std_logic;
   signal cond_or_incond_signal : std_logic;
   signal conection_outMUX_inPC : unsigned(6 downto 0);
   signal conection_inMUX_outPC : unsigned(6 downto 0);
   signal conection_addUM_inMUX : unsigned(6 downto 0);

begin

   -- Unidade de controle: UC
   sm_inst: UC
      port map(
         clk_UC => clk_geral,
         rst_UC => rst_geral,
         pc_wr_en_o     => pc_wr_en_signal,
         rom_read_en_o  => rom_read_en_signal,
         ir_wr_en_o     => ir_wr_en_signal,
         data_out       => data_signal,
         instr          => instr_ir,
         jump           => jump_signal,
         cond_or_incond => cond_or_incond_signal
      );

   -- Registrador de instrução
   ir_inst: instruction_register
      port map(
         clk_IR    => clk_geral,
         rst_IR    => rst_geral,
         wr_en_IR  => ir_wr_en_signal,
         instr_in  => instr_rom,
         instr_out => instr_ir
      );

   -- MUX que escolhe o próximo endereço do PC
   mux_pc_inst: MUX_PC
      port map(
         adress_in          => conection_inMUX_outPC,
         adress_in_add_um   => conection_addUM_inMUX,
         address_out        => conection_outMUX_inPC,
         jump_MUX           => jump_signal,
         cond_or_incond_MUX => cond_or_incond_signal,
         data_in_MUX        => data_signal
      );

   -- PC e ROM
   pc_rom_inst: PC_ROM
      port map(
         clk_PC_ROM     => clk_geral,
         rst_PC_ROM     => rst_geral,
         wr_en_PC_ROM   => pc_wr_en_signal,
         read_en_PC_ROM => rom_read_en_signal,
         inst_ROM       => instr_rom,
         addr_in_PC     => conection_outMUX_inPC,
         addr_out_PC    => conection_inMUX_outPC,
         addr_add_PC    => conection_addUM_inMUX
      );

   address_out <= conection_inMUX_outPC;

end architecture;