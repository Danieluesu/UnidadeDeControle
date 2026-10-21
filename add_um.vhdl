library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_um is
	port(	
			data_in	: in signed(15 downto 0);
			data_out: out signed(15 downto 0)
	);
end entity;

architecture a_add_um of add_um is
begin
    data_out <= data_in + 1;

end architecture;