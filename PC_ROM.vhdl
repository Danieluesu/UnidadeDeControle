library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ROM is
    port(   clk                 : in std_logic;
            rst                 : in std_logic;
            wr_en_PC            : in std_logic;
            jump_PC             : in std_logic;
            data_in             : in unsigned(15 downto 0);
            cond_or_incond_PC   : in std_logic;
            ROM_out             : out unsigned(15 downto 0);
            read_en             : in std_logic
    );
end entity;

architecture a_PC_ROM of PC_ROM is

    component PC_add is
        port( clk_PC            : in std_logic;
              rst_PC            : in std_logic;
              wr_en_PC          : in std_logic;
              address_out       : out unsigned(6 downto 0);
              jump_PC           : in std_logic;
              data_in           : in unsigned(15 downto 0);
              cond_or_incond_PC : in std_logic
        );
    end component;

    component ROM_ass is
        port(   address_ROM  : in unsigned(6 downto 0);
                instruction  : out unsigned(15 downto 0);
                read_en      : in std_logic
        );
    end component;

    signal sai_pc     : unsigned(6 downto 0);

begin
    pc_add_inst: PC_add port map(
        clk_PC            => clk,
        rst_PC            => rst,
        wr_en_PC          => wr_en_PC,
        address_out       => sai_pc,
        jump_PC           => jump_PC,
        data_in           => data_in,
        cond_or_incond_PC => cond_or_incond_PC
    );

    rom_inst: ROM_ass port map(
        address_ROM => sai_pc,
        instruction => ROM_out,
        read_en     => read_en
    );

end architecture;