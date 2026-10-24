library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SM_PC_ROM is
   port( clk_geral      : in std_logic;
         rst_geral      : in std_logic;
         address_out    : out unsigned(6 downto 0)
       );
end entity;

architecture a_SM_PC_ROM of SM_PC_ROM is
   component PC_ROM is
    port(
        clk               : in std_logic;
        rst               : in std_logic;
        wr_en_PC          : in std_logic;
        jump_PC           : in std_logic;
        data_in           : in unsigned(6 downto 0);
        cond_or_incond_PC : in std_logic;
        ROM_out           : out unsigned(15 downto 0);
        read_en           : in std_logic;
        addr_out          : out unsigned(6 downto 0)
    );
end component;

    component StateMachine is
        port( clk            : in std_logic;
              rst            : in std_logic;
              pc_wr_en_o     : out std_logic; 
              rom_read_en_o  : out std_logic;
              data_out       : out unsigned(6 downto 0);
              instr          : in unsigned(15 downto 0);
              jump           : out std_logic;
              cond_or_incond : out std_logic
        );
    end component;

    signal pc_wr_en_signal       : std_logic;
    signal rom_read_en_signal    : std_logic;
    signal data_signal           : unsigned(6 downto 0);
    signal instr_signal          : unsigned(15 downto 0);
    signal jump_signal           : std_logic;
    signal cond_or_incond_signal : std_logic;
    signal addr_from_rom         : unsigned(6 downto 0);

begin
    
    sm_inst: StateMachine port map(
        clk            => clk_geral,
        rst            => rst_geral,
        pc_wr_en_o     => pc_wr_en_signal,
        rom_read_en_o  => rom_read_en_signal,
        data_out       => data_signal,
        instr          => instr_signal,
        jump           => jump_signal,
        cond_or_incond => cond_or_incond_signal
    );

    pc_rom_inst: PC_ROM port map(
    clk               => clk_geral,
    rst               => rst_geral,
    wr_en_PC          => pc_wr_en_signal,
    jump_PC           => jump_signal,
    data_in           => data_signal,
    cond_or_incond_PC => cond_or_incond_signal,
    ROM_out           => instr_signal,
    read_en           => rom_read_en_signal,
    addr_out          => addr_from_rom
);

address_out <= addr_from_rom;

end architecture;