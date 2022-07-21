-- Code your testbench here
--library IEEE;
--use IEEE.std_logic_1164.all;
-- Testbench for adder4bits

 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component fib is port(
	reset, clock, inicio: in bit;
	F1, F2, n: in bit_vector(7 downto 0); 
	Fn: out bit_vector(15 downto 0);
	fim, overflow: out bit); 
end component;

signal reset_in, inicio_in: bit;
signal F1_in, F2_in, n_in: bit_vector(7 downto 0);
signal Fn_out: bit_vector(15 downto 0);
signal fim_out, overflow_out: bit;


-- Criando o clock
constant clockPeriod : time := 2 ns; -- clock period
signal keep_simulating: bit := '0'; -- interrompe simulação 
signal clk_in: bit; -- se construção alternativa do clock

begin
	clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
    

  -- Connect DUT
fibo: fib port map (reset_in, clk_in, inicio_in, F1_in, F2_in, n_in,Fn_out, fim_out, overflow_out);

  process
  begin
  
  	assert false report "Test start." severity note;
    keep_simulating <= '1';
    
    --wait for 2 ns;
   	
    reset_in <= '1';
    inicio_in <= '0';
    n_in <= "00000100";
    F1_in <= "00000001";
    F2_in <= "00000010";
    
    wait for 4 ns; -- espera estabilizar e verifica saída 
    
    reset_in <= '0';
    inicio_in <= '1';
    wait for 2 ns;
    inicio_in <= '0'; 
    
    wait for 10 ns;
  

    -- Informa fim do teste
    assert false report "Test done." severity note;
    keep_simulating <= '0';
    wait; -- Interrompe execução
 
  end process;
end tb;

