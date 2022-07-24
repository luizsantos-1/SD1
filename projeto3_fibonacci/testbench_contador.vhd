entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component counter8 is
  port (
    clock: 	in bit;
	  set: 	in bit;		-- set síncrono
    set_value: in bit_vector (7 downto 0);
	  count: 	in bit;		-- habilita contagem
	  cval: 	out bit_vector(7 downto 0)
    );
end component;

signal set_in, count_in: bit;
signal set_value_in, cval_out: bit_vector(7 downto 0);


-- Criando o clock
constant clockPeriod : time := 2 ns; -- clock period
signal keep_simulating: bit := '0'; -- interrompe simulação 
signal clk_in: bit; -- se construção alternativa do clock

begin
	clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
    

  -- Connect DUT
	DUT: counter8 port map(clk_in, set_in, set_value_in, count_in, cval_out);

  process
  begin
  
  	assert false report "Test start." severity note;
    keep_simulating <= '1';
    
    --wait for 2 ns;
    
	set_in <= '1';
    set_value_in <= "11111111";
    count_in  <= '0';
    
    wait for 2 ns; -- espera estabilizar e verifica saída
    set_in <= '0';
    
    
    assert(cval_out ="11111111") report "Fail 0+0" severity error;

	count_in <= '1';
    wait for 2 ns; -- espera estabilizar e verifica saída
    assert(cval_out ="11111110") report "Fail 0+0" severity error;
    
    wait for 2 ns; -- espera estabilizar e verifica saída
    assert(cval_out ="11111101") report "Fail 0+0" severity error;
    
    
    -- Limpa entradas (opcional)
    

    -- Informa fim do teste
    assert false report "Test done." severity note;
    keep_simulating <= '0';
    wait; -- Interrompe execução
 
  end process;
end tb;


