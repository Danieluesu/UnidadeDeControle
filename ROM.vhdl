-- ROM ASSINCRONA 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
   port( address_ROM  : in unsigned(6 downto 0);
         instruction  : out unsigned(15 downto 0);
         read_en      : in std_logic
   );
end entity;

architecture a_ROM of ROM is
   type mem is array (0 to 127) of unsigned(15 downto 0);
   constant content_rom : mem := (
      -- caso address_ROM => conteudo
      0  => "0001100000000010",
      1  => "1111000000000000", -- NOP
      2  => "0001100000000010",
      3  => "0000000000000000", -- NOP
      4  => "0001100000000010",
      5  => "0000000000100000", -- NOP
      6  => "0001100000000100",
      7  => "0000000000100000", -- NOP
      8  => "0001100000001010",
      9  => "0000000000010011", -- NOP
      10 => "00010000000000000",
      -- abaixo: casos omissos => (zero em todos os bits)
      others => (others=>'0')
   );
begin
      instruction <= content_rom(to_integer(address_ROM)) when read_en = '1' else
                     (others => '0');
end architecture;