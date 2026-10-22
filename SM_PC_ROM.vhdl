library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SM_PC_ROM is
   port( clk_geral : in std_logic;
         rst_geral : in std_logic
       );
end entity;

architecture a_SM_PC_ROM of SM_PC_ROM is
   component PC_ROM is
        port( clk_PC            : in std_logic;
              rst_PC            : in std_logic;
              wr_en_PC          : in std_logic;
              address_in        : in unsigned(6 downto 0);
              address_out       : out unsigned(6 downto 0);
              jump_PC           : in std_logic;
              data_in           : in unsigned(15 downto 0);
              cond_or_incond_PC : in std_logic;
              read_en           : in std_logic;
        );
    end component;

    component StateMachine is
        port( clk            : in std_logic;
              rst            : in std_logic;
              pc_wr_en_o     : out std_logic; 
              rom_read_en_o  : out std_logic;
              data_out       : out unsigned(7 downto 0);
              instr          : in unsigned(15 downto 0);
              jump           : out std_logic;
              cond_or_incond : out std_logic
        );
    end component;
begin
     
end architecture;