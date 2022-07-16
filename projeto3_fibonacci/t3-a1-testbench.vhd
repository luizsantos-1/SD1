-- Code your testbench here

entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component somador_16 is port(
  	entrada1, entrada2: in bit_vector(15 downto 0); 
	saida: out bit_vector(15 downto 0);
	overflow: out bit); 
	
end component;

signal e1, e2 , s: bit_vector(15 downto 0);
signal o : bit;


begin
	

  -- Connect DUT
	DUT: somador_16 port map(e1,e2,s,o);

  process
  begin
  
  	assert false report "Test start." severity note;
    
    e1 <= "0000000000000000";
    e2 <= "1111111111111111";
    
    wait for 6 ns;
    assert(s ="1111111111111111") report "Fail 0+0" severity error;
    
    e1 <= "1010101010101010";
    e2 <= "0000001111111111";
    
    wait for 6 ns;
    assert(s ="1010111010101001") report "Fail 0+0" severity error;


    
    wait for 6 ns; -- espera estabilizar e verifica saída
    assert(false) report "Test done" severity note;
    wait;

  end process;
end tb;
    
   
    -- Informa fim do teste