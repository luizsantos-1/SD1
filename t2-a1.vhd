--BITS DE PARIDADE NAO ESTÃO NO COMECO DE 1 até 29



library IEEE;
use IEEE.numeric_bit.all;


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
    somaf <= soma1 + soma2; 
    
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
    		   "1101101" when (resultado(1) = '1') else
               "1111001" when (resultado(2) = '1') else
               "0110011" when (resultado(3) = '1') else
               "0000001"; -- ninguem acertou
              
    			
end purrinha_arch;
    
entity hamming is port(
	entrada: in bit_vector(29 downto 1); -- ARRUMAR!!!!
	dados : out bit_vector(23 downto 0);
	erro: out bit 
	);
end entity;

architecture hamming_arch of hamming is 
	-- declaracoes 
    signal p0_e, p1_e, p2_e, p3_e, p4_e: bit;
    signal posicao_erro: integer;
    signal vetor_p: bit_vector(4 downto 0);
    --signal vetor_p_u: unsigned(4 downto 0);
    
begin 
	p0_e <= entrada(3) xor entrada(5) xor entrada(7) xor 
    		entrada(9) xor entrada(11) xor entrada(13) xor entrada(15) xor
            entrada(17) xor entrada(19) xor entrada(21) xor entrada(23) xor 
            entrada(25) xor entrada(27) xor entrada(29);
            
    p1_e <= entrada(3) xor entrada(6) xor entrada(7) xor 
    		entrada(10) xor entrada(11) xor entrada(14) xor entrada(15) xor
            entrada(18) xor entrada(19) xor entrada(22) xor entrada(23) xor 
            entrada(26) xor entrada(27); 
            
    p2_e <= entrada(5) xor entrada(6) xor entrada(7) xor 
    		entrada(12) xor entrada(13) xor entrada(14) xor entrada(15) xor
            entrada(20) xor entrada(21) xor entrada(22) xor entrada(23) xor 
            entrada(28) xor entrada(29);
            
   	p3_e <= entrada(9) xor entrada(10) xor entrada(11) xor 
    		entrada(12) xor entrada(13) xor entrada(14) xor entrada(15) xor
            entrada(24) xor entrada(25) xor entrada(26) xor entrada(27) xor 
            entrada(28) xor entrada(29);
            
    p4_e <= entrada(17) xor entrada(18) xor entrada(19) xor 
    		entrada(20) xor entrada(21) xor entrada(22) xor entrada(23) xor
            entrada(24) xor entrada(25) xor entrada(26) xor entrada(27) xor 
            entrada(28) xor entrada(29);
    
    vetor_p(0) <= p0_e xor entrada(1); 
    vetor_p(1) <= p1_e xor entrada(2); 
    vetor_p(2) <= p2_e xor entrada(4); 
    vetor_p(3) <= p3_e xor entrada(8); 
    vetor_p(4) <= p4_e xor entrada(16); 
    
    dados(0) <= entrada(3) xor (vetor_p(0) and vetor_p(1));
    dados(1) <= entrada(5) xor (vetor_p(0) and vetor_p(2));
    dados(2) <= entrada(6) xor (vetor_p(1) and vetor_p(2));
    dados(3) <= entrada(7) xor (vetor_p(0) and vetor_p(1) and vetor_p(2));
    dados(4) <= entrada(9) xor (vetor_p(0) and vetor_p(3));
    dados(5) <= entrada(10) xor (vetor_p(1) and vetor_p(3));
    dados(6) <= entrada(11) xor (vetor_p(0) and vetor_p(1) and vetor_p(3));
    dados(7) <= entrada(12) xor (vetor_p(2) and vetor_p(3));
    dados(8) <= entrada(13) xor (vetor_p(0) and vetor_p(2) and vetor_p(3));
    dados(9) <= entrada(14) xor (vetor_p(1) and vetor_p(2) and vetor_p(3));
    dados(10) <= entrada(15) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(3));
	dados(11) <= entrada(17) xor (vetor_p(0) and vetor_p(4));
    dados(12) <= entrada(18) xor (vetor_p(1) and vetor_p(4));
    dados(13) <= entrada(19) xor (vetor_p(0) and vetor_p(1) and vetor_p(4));
    dados(14) <= entrada(20) xor (vetor_p(2) and vetor_p(4));
    dados(15) <= entrada(21) xor (vetor_p(0) and vetor_p(2) and vetor_p(4));
    dados(16) <= entrada(22) xor (vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(17) <= entrada(23) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(18) <= entrada(24) xor (vetor_p(3) and vetor_p(4));
    dados(19) <= entrada(25) xor (vetor_p(0) and vetor_p(3) and vetor_p(4));
    dados(20) <= entrada(26) xor (vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(21) <= entrada(27) xor (vetor_p(0) and vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(22) <= entrada(28) xor (vetor_p(2) and vetor_p(3) and vetor_p(4));
    dados(23) <= entrada(29) xor (vetor_p(0) and vetor_p(2) and vetor_p(3) and vetor_p(4));
    
    
	erro <= '1' when ( vetor_p > "11101") else
    		'0';
    
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component hamming is
	port (
    entrada: in bit_vector(29 downto 1); -- ARRUMAR!!!!
	dados : out bit_vector(23 downto 0);
	erro: out bit 
    );
end component;

signal s_entrada : bit_vector (29 downto 1);
signal s_dados: bit_vector (23 downto 0);
signal s_erro: bit;
begin

  -- Connect DUT
  DUT: hamming port map(s_entrada, s_dados, s_erro);

  process
  begin
  
  	assert false report "Test start." severity note;
    
    s_entrada <= "00000000000000000000000000011";
    wait for 3 ns; -- espera estabilizar e verifica saída
    assert(s_dados ="000000000000000000000001") report "Fail 0+0" severity error;
    
    s_entrada <= "11000000000000000000000000000";
    wait for 3 ns; -- espera estabilizar e verifica saída
    assert(s_dados ="110000000000000000000000") report "Fail 0+0" severity error;
    
    s_entrada <= "11000000000000000000000000000";
    wait for 3 ns; -- espera estabilizar e verifica saída
    assert(s_erro = '0') report "Fail 0+0" severity error;

    s_entrada <= "00000000000001000000010001011";
    wait for 3 ns; -- espera estabilizar e verifica saída
    assert(s_erro = '1') report "Fail 0+0" severity error;


	assert false report "Test done." severity note;
    wait; -- Interrompe execução
 
  end process;
end tb;			
end hamming_arch;