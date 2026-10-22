-- ROM ASSINCRONA 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ROM is
   port( address_ROM : in unsigned(6 downto 0);
         instruction  : out unsigned(15 downto 0);
         read_en      : in std_logic
   );
end entity;

architecture a_ROM of ROM is
   type mem is array (0 to 127) of unsigned(15 downto 0);
   constant content_rom : mem := (
      -- caso address_ROM => conteudo
      0  => "0000000000100000",
      1  => "1000000000000000",
      2  => "0000000000000000",
      3  => "0000000000000000",
      4  => "1000000000000000",
      5  => "0000000000100000",
      6  => "1111000000110000",
      7  => "0000000000100000",
      8  => "0000000000100000",
      9  => "0000000000010011",
      10 => "0000000000100010",
      -- abaixo: casos omissos => (zero em todos os bits)
      others => (others=>'0')
   );
begin
      instruction <= content_rom(to_integer(address_ROM)) when read_en = '1' else
                     (others => '0');
end architecture;