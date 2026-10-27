library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StateMachine is
    port (  clk_SM         : in std_logic;
            rst_SM         : in std_logic;
            state          : out std_logic -- 0 = FETCH, 1 = DECODE/EXECUTE
    );
        
end entity;

architecture a_StateMachine of StateMachine is

  signal state_tmp : std_logic := '0';
    
begin
  
  process (clk_SM, rst_SM)
  begin
    if rst_SM = '1' then
      state_tmp <= '0';
    elsif rising_edge(clk_SM) then
      state_tmp <= not state_tmp; -- alterna entre FETCH e DECODE/EXECUTE
    end if;
  end process;

  state <= state_tmp;

end architecture;
