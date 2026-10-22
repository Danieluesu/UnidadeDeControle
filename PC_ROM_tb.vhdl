library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ROM_tb is
end entity;

architecture a_PC_ROM_tb of PC_ROM_tb is

    -- 1. Declaração do componente que será testado (UUT)
    component PC_ROM is
    port(
        clk               : in std_logic;
        rst               : in std_logic;
        wr_en_PC          : in std_logic;
        jump_PC           : in std_logic;
        data_in           : in unsigned(15 downto 0);
        cond_or_incond_PC : in std_logic;
        ROM_out           : out unsigned(15 downto 0);
        read_en           : in std_logic
    );
end component;

    -- 2. Sinais de controle da simulação
    constant period_time : time := 100 ns;
    signal finished      : std_logic := '0';

    -- 3. Sinais internos para conectar aos pinos do componente[cite: 4]
    signal clk_s               : std_logic := '0';
    signal rst_s               : std_logic := '0';
    signal wr_en_PC_s          : std_logic := '1'; -- Fixo em '1' para o PC contar livremente[cite: 2]
    signal address_in_s        : unsigned(6 downto 0) := (others => '0');
    signal address_out_s       : unsigned(6 downto 0);
    signal jump_PC_s           : std_logic := '0';
    signal data_in_s           : unsigned(15 downto 0) := (others => '0');
    signal cond_or_incond_PC_s : std_logic := '0';
    signal ROM_out_s           : unsigned(15 downto 0);

begin

    -- 4. Instanciação da Unit Under Test (UUT)[cite: 4, 5]
    uut: PC_ROM port map(
        clk                 => clk_s,
        rst                 => rst_s,
        wr_en_PC            => wr_en_PC_s,
        address_in          => address_in_s,
        address_out         => address_out_s,
        jump_PC             => jump_PC_s,
        data_in             => data_in_s,
        cond_or_incond_PC   => cond_or_incond_PC_s,
        ROM_out             => ROM_out_s
    );

    -- 5. Processo de geração do Reset Global (Pulso inicial)[cite: 5]
    reset_global: process
    begin
        rst_s <= '1';
        wait for period_time * 2; -- Mantém o reset em '1' por 2 clocks
        rst_s <= '0';
        wait;
    end process;

    -- 6. Processo de geração do Clock contínuo[cite: 5]
    clk_proc: process
    begin
        while finished /= '1' loop
            clk_s <= '0';
            wait for period_time / 2;
            clk_s <= '1';
            wait for period_time / 2;
        end loop;
        wait;
    end process clk_proc;

    -- 7. Processo de estímulos principais e tempo de simulação[cite: 5]
    sim_time_proc: process
    begin
        -- Deixa o circuito rodar (PC contando e ROM sendo lida) por um tempo específico
        wait for 1500 ns; 
        
        -- Sinaliza o fim da simulação e paralisa o clock[cite: 5]
        finished <= '1';
        
        -- OBRIGATÓRIO: Terminar com wait; para não rodar infinitamente[cite: 5]
        wait; 
    end process sim_time_proc;

end architecture;