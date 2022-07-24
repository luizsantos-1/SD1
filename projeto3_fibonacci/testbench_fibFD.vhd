entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component fibFD is port(
    clock: in bit; -- recebe do exterior
    n: in bit_vector (7 downto 0); -- recebe do exterior
    F1, F2: in bit_vector(15 downto 0); -- recebe do exterior
    idle, f1_no_Fn, f2_no_Fn, enable_soma: in bit;--recebe da UC
    Fn: out bit_vector(15 downto 0); -- manda para o exterior
    overflow: out bit;
    done: out bit -- manda para UC
);

end component;

signal idle_in, f1_no_Fn_in, f2_no_Fn_in, enable_soma_in: bit;
signal n_in : bit_vector(7 downto 0);
signal F1_in, F2_in, Fn_out: bit_vector(15 downto 0);
signal done_out, overflow_out: bit;


-- Criando o clock
constant clockPeriod : time := 2 ns; -- clock period
signal keep_simulating: bit := '0'; -- interrompe simulação 
signal clk_in: bit; -- se construção alternativa do clock

begin
	clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
    

  -- Connect DUT
FluxoDeDados: fibFD port map (clk_in, n_in, F1_in, F2_in, idle_in, f1_no_Fn_in, f2_no_Fn_in, enable_soma_in, Fn_out, overflow_out, done_out);

  process
  begin
  
  	assert false report "Test start." severity note;
    keep_simulating <= '1';
    
    --wait for 2 ns;
   	
    n_in <= "11111111";
    F1_in <= "0000000000000001";
    F2_in <= "0000000000000010";
   	idle_in <= '1';
    f1_no_Fn_in <= '0';
    f2_no_Fn_in <= '0';
    enable_soma_in <= '0';
    
    wait for 2 ns; -- espera estabilizar e verifica saída 
    
    idle_in <= '0';
    f1_no_Fn_in <= '1';
    f2_no_Fn_in <= '0';
    enable_soma_in <= '0';
    
    wait for 2 ns;
    
    assert(Fn_out ="0000000000000001") report "Fail 0+0" severity error;
    
    idle_in <= '0';
    f1_no_Fn_in <= '0';
    f2_no_Fn_in <= '1';
    enable_soma_in <= '0';
    
    wait for 2 ns;
    
    assert(Fn_out ="0000000000000010") report "Fail 0+0" severity error;
    
    idle_in <= '0';
    f1_no_Fn_in <= '0';
    f2_no_Fn_in <= '0';
    enable_soma_in <= '1';
    
    wait for 2 ns;
    
    assert(Fn_out ="0000000000000011") report "Fail 0+0" severity error;
    
    -- Informa fim do teste
    assert false report "Test done." severity note;
    keep_simulating <= '0';
    wait; -- Interrompe execução
 
  end process;
end tb;

