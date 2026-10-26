library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_register is
    port(  clk_IR    : in  std_logic;
           rst_IR    : in  std_logic;
           wr_en_IR  : in  std_logic;
           instr_in  : in  unsigned(15 downto 0);
           instr_out : out unsigned(15 downto 0)
    );
end entity;

architecture a_instruction_register of instruction_register is

    signal instr_reg : unsigned(15 downto 0) := (others => '0');

begin

    process(clk_IR, rst_IR)
    begin
        if rst_IR = '1' then
            instr_reg <= (others => '0');

        elsif rising_edge(clk_IR) then
            if wr_en_IR = '1' then
                instr_reg <= instr_in;
            end if;
        end if;
    end process;

    instr_out <= instr_reg;

end architecture;
