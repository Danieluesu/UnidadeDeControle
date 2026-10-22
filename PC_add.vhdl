library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_add is
    port( clk   : in std_logic;
          rst   : in std_logic;
          pc_out: out unsigned(15 downto 0)  --Para ver no tb
    );
end entity;

architecture a_PC_add of PC_add is

    component PC is
        port(   clk_reg   : in std_logic;
                rst_reg   : in std_logic;
                wr_en_reg : in std_logic;
                data_in   : in unsigned(15 downto 0);
                data_out  : out unsigned(15 downto 0)
    );
    end component;


    component add_um is
        port(	
			data_in	: in unsigned(15 downto 0);
			data_out: out unsigned(15 downto 0)
	);
    end component;

    signal sai_pc     : unsigned(15 downto 0);
    signal sai_add_um : unsigned(15 downto 0);

begin
    
    pc_inst: PC port map(
        clk_reg   => clk,
        rst_reg   => rst,
        wr_en_reg => '1',           -- sempre habilitado para escrita
        data_in   => sai_add_um,    -- Sai add_um entra PC
        data_out  => sai_pc         -- Sai PC entra add_um
    );

    add_um_inst: add_um port map(
        data_in  => sai_pc,         -- Sai PC entra add_um
        data_out => sai_add_um      -- Sai add_um entra PC
    );

    pc_out <= sai_pc;  

end architecture;