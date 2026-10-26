library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ROM is
    port(  clk_PC_ROM     : in std_logic;
           rst_PC_ROM     : in std_logic;
           wr_en_PC_ROM   : in std_logic;
           read_en_PC_ROM : in std_logic;
           inst_ROM       : out unsigned(15 downto 0);
           addr_in_PC     : in unsigned(6 downto 0);  -- PC in
           addr_out_PC    : out unsigned(6 downto 0); -- PC out
           addr_add_PC    : out unsigned(6 downto 0)  -- PC + 1
    );
end entity;

architecture a_PC_ROM of PC_ROM is

    component PC_add is
        port(  clk_PC_add   : in std_logic;
               rst_PC_add   : in std_logic;
               wr_en_PC_add : in std_logic;
               address_out  : out unsigned(6 downto 0);
               address_in   : in unsigned(6 downto 0);
               address_add  : out unsigned(6 downto 0)
        );
    end component;

    component ROM is
        port(  address_ROM : in unsigned(6 downto 0);
               instruction : out unsigned(15 downto 0);
               read_en     : in std_logic        
        );
    end component;

    signal conection : unsigned(6 downto 0);

begin
    pc_add_inst: PC_add port map(
        clk_PC_add   => clk_PC_ROM,
        rst_PC_add   => rst_PC_ROM,
        wr_en_PC_add => wr_en_PC_ROM,
        address_out  => conection,
        address_in   => addr_in_PC,
        address_add  => addr_add_PC
    );

    rom_inst: ROM port map(
        address_ROM => conection,
        instruction => inst_ROM,
        read_en     => read_en_PC_ROM
    );

    addr_out_PC <= conection;

end architecture;