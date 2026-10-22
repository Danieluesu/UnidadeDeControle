library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_add is
    port( clk_PC            : in std_logic;
          rst_PC            : in std_logic;
          wr_en_PC          : in std_logic;
          address_out       : out unsigned(6 downto 0);
          jump_PC           : in std_logic;
          data_in           : in unsigned(15 downto 0);
          cond_or_incond_PC : in std_logic
    );
end entity;

architecture a_PC_add of PC_add is

    component PC is
        port(   clk_PC            : in std_logic;
                rst_PC            : in std_logic;
                wr_en_PC          : in std_logic;
                address_in        : in unsigned(6 downto 0);
                address_out       : out unsigned(6 downto 0);
                jump_PC           : in std_logic;
                data_in           : in unsigned(15 downto 0);
                cond_or_incond_PC : in std_logic
    );
    end component;


    component add_um is
        port(	
			data_in	: in unsigned(15 downto 0);
			data_out: out unsigned(15 downto 0)
	);
    end component;

    signal sai_pc     : unsigned(6 downto 0);
    signal sai_add_um : unsigned(6 downto 0);

begin
    
    pc_inst: PC port map(
        clk_PC            => clk_PC,
        rst_PC            => rst_PC,
        wr_en_PC          => wr_en_PC,
        address_in        => sai_add_um,
        address_out       => sai_pc,
        jump_PC           => jump_PC,
        data_in           => data_in,
        cond_or_incond_PC => cond_or_incond_PC
    );

    add_um_inst: add_um port map(
        data_in  => sai_pc,         -- Sai PC entra add_um
        data_out => sai_add_um      -- Sai add_um entra PC
    );

    address_out <= sai_pc;  

end architecture;