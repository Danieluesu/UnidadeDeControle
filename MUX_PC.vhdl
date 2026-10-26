library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_PC is
   port(  adress_in          : in unsigned(6 downto 0);
          adress_in_add_um   : in unsigned(6 downto 0);  
          address_out        : out unsigned(6 downto 0);
          jump_MUX           : in std_logic;
          cond_or_incond_MUX : in std_logic;
          data_in_MUX        : in unsigned(6 downto 0)
   );
end entity;

architecture a_MUX_PC of MUX_PC is
begin

    address_out <= adress_in + data_in_MUX when (jump_MUX = '1' and cond_or_incond_MUX = '1') else
                   data_in_MUX when (jump_MUX = '1' and cond_or_incond_MUX = '0') else
                   adress_in_add_um;

end architecture;