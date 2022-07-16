library IEEE;
use IEEE.numeric_bit.all;

 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component purrinha is
	port (
    num4, num3, num2, num1: in bit_vector(1 downto 0); 
	guess4, guess3, guess2, guess1: in bit_vector(3 downto 0); 
    display: out bit_vector(6 downto 0)
    );
end component;

signal n4, n3 , n2, n1 : bit_vector (1 downto 0);
signal g1, g2, g3, g4: bit_vector (3 downto 0);
signal d: bit_vector(6 downto 0);
begin

  -- Connect DUT
  DUT: purrinha port map(n4, n3, n2, n1, g4, g3 , g2 , g1, d);

  process
  begin
  
  	assert false report "Test start." severity note;
    
    g1 <= "0000";
    g2 <= "1111";
    g3 <= "0110";
    g4 <= "0110";
    
    
    n4 <= "00";
    n3 <= "00";
    n2 <= "00";
    n1 <= "00";
    wait for 3 ns; -- espera estabilizar e verifica saída
    assert(d ="0110000") report "Fail 0+0" severity error;

    n4 <= "00";
    n3 <= "01";
    n2 <= "10";
    n1 <= "11";
    wait for 3 ns; -- espera estabilizar e verifica saída
    assert(d ="1001111") report "Fail 0+0" severity error;
    
    n4 <= "01";
    n3 <= "01";
    n2 <= "11";
    n1 <= "11";
    wait for 3 ns; -- espera estabilizar e verifica saída
    assert(d ="0000001") report "Fail 0+0" severity error;
    
    
    -- Limpa entradas (opcional)
    

    -- Informa fim do teste
    assert false report "Test done." severity note;
    wait; -- Interrompe execução
 
  end process;
end tb;


entity purrinha is 
	port (
    num4, num3, num2, num1: in bit_vector(1 downto 0); 
	guess4, guess3, guess2, guess1: in bit_vector(3 downto 0); 
    display: out bit_vector(6 downto 0)
    );
end entity;

architecture purrinha_arch of purrinha is 
	-- declaracoes 
    -- declarar soma
    signal soma1: unsigned(3 downto 0);
    signal soma2: unsigned(3 downto 0);
    signal somaf: unsigned(3 downto 0);
    signal resultado: bit_vector (3 downto 0);
    signal repeticao: bit;
begin 
	soma1 <= unsigned("00" & num1) + unsigned("00" & num2);
    soma2 <= unsigned("00" & num3) + unsigned("00" & num4);
    somaf <= unsigned(soma1) + unsigned(soma2); 
    
    -- zero é errado
    resultado(0) <= not ((somaf(0) xor guess1(0)) or 
    					(somaf(1) xor guess1(1)) or 
    					(somaf(2) xor guess1(2)) or 
                        (somaf(3) xor guess1(3)));
    resultado(1) <= not ((somaf(0) xor guess2(0)) or 
    					(somaf(1) xor guess2(1)) or 
    					(somaf(2) xor guess2(2)) or 
                        (somaf(3) xor guess2(3)));
    resultado(2) <= not ((somaf(0) xor guess3(0)) or 
    					(somaf(1) xor guess3(1)) or 
    					(somaf(2) xor guess3(2)) or 
                        (somaf(3) xor guess3(3)));
    resultado(3) <= not ((somaf(0) xor guess4(0)) or 
    					(somaf(1) xor guess4(1)) or 
                        (somaf(2) xor guess4(2)) or 
                        (somaf(3) xor guess4(3)));

    repeticao <= (resultado(0) and resultado(1)) or
    			 (resultado(0) and resultado(2)) or
                 (resultado(0) and resultado(3)) or
    			 (resultado(1) and resultado(2)) or
                 (resultado(1) and resultado(3)) or
    			 (resultado(2) and resultado(3));
    
    
    
	display <= "1001111" when (repeticao = '1') else
    		   "0110000" when (resultado(0) = '1') else
    		   "1101100" when (resultado(1) = '1') else
               "1111001" when (resultado(2) = '1') else
               "0110011" when (resultado(3) = '1') else
               "0000001"; -- ninguem acertou
              
    			
end purrinha_arch;
    