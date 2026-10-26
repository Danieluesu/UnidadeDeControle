library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_add is
    port( clk_PC            : in std_logic;
          rst_PC            : in std_logic;
          wr_en_PC          : in std_logic;
          address_out       : out unsigned(6 downto 0);
          address_in        : in unsigned(6 downto 0);
          address_add       : out unsigned(6 downto 0)
    );
end entity;

architecture a_PC_add of PC_add is

    component PC is
        port(   clk_PC            : in std_logic;
                rst_PC            : in std_logic;
                wr_en_PC          : in std_logic;
                address_in        : in unsigned(6 downto 0);
                address_out       : out unsigned(6 downto 0)
    );
    end component;

    component add_um is
        port(	
			data_in	: in unsigned(6 downto 0);
			data_out: out unsigned(6 downto 0)
	);
    end component;

    signal conexao   : unsigned(6 downto 0);
    
begin
    
    pc_inst: PC port map(
        clk_PC            => clk_PC,
        rst_PC            => rst_PC,
        wr_en_PC          => wr_en_PC,
        address_in        => address_in,
        address_out       => conexao
    );

    add_um_inst: add_um port map(
        data_in  => conexao,         -- Sai PC entra add_um
        data_out => address_add      -- Sai add_um entra PC
    );

    
    address_out <= conexao;  

end architecture;