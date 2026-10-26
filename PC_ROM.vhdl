library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ROM is
    port(   clk               : in std_logic;
            rst               : in std_logic;
            wr_en_PC          : in std_logic;
            ROM_out           : out unsigned(15 downto 0);
            read_en           : in std_logic;
            addr_out          : out unsigned(6 downto 0);
            addr_in           : in unsigned(6 downto 0);
            addr_add          : out unsigned(6 downto 0)
    );
end entity;

architecture a_PC_ROM of PC_ROM is

    component PC_add is
        port( clk_PC            : in std_logic;
          rst_PC            : in std_logic;
          wr_en_PC          : in std_logic;
          address_out       : out unsigned(6 downto 0);
          address_in        : in unsigned(6 downto 0);
          address_add       : out unsigned(6 downto 0)
        );
    end component;

    component ROM is
    port(
        address_ROM : in unsigned(6 downto 0);
        instruction : out unsigned(15 downto 0);
        read_en     : in std_logic
    );
    end component;

    signal conexao    : unsigned(6 downto 0);

begin
    pc_add_inst: PC_add port map(
        clk_PC            => clk,
        rst_PC            => rst,
        wr_en_PC          => wr_en_PC,
        address_out       => conexao,
        address_in        => addr_in,
        address_add       => addr_add
    );

    rom_inst: ROM port map(
        address_ROM => conexao,
        instruction => ROM_out,
        read_en     => read_en
    );

    addr_out <= conexao;

end architecture;