entity flipflopd is
port(
    D, reset, clock, EN: in bit;
    Q: out bit
    );
end flipflopd;
architecture behavior of flipflopd is
    begin
        process (reset, clock)
        begin
        if reset=’0’ then
        Q <= ’0’;
        elsif clock’EVENT and clock=’1’ and EN=’1’ then
        Q <= D;
        end if;
        end process ;
end behavior;

entity purrinha_plus is
    port(
    reset, clock: in bit;
    
    --! armazenam os dados dos jogadores
    load4, load3, load2, load1: in bit;
    --! atualiza o resultado no display
    atualiza: in bit;
    --! palitos com cada jogador
    num4, num3, num2, num1: in bit_vector(1 downto 0);
    --! palpites de cada jogador
    guess4, guess3, guess2, guess1: in bit_vector(3 downto 0);
    --! resultado do jogo
    display: out bit_vector(6 downto 0)
    );
end purrinha_plus;