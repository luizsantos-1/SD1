
architecture hamming_arch of hamming is 
	-- declaracoes 
    signal p0_e, p1_e, p2_e, p3_e, p4_e: bit;
    signal vetor_p: bit_vector(4 downto 0);
    signal entrada_i: bit_vector(28 downto 0);
    
    component organizador is
		port(	entrada: in  bit_vector (28 downto 0);
  				saida: out bit_vector (28 downto 0));
	end component;
     
begin 

    organizador_1: organizador port map (entrada, entrada_i);

	p0_e <= entrada_i(2) xor entrada_i(4) xor entrada_i(6) xor 
    		entrada_i(8) xor entrada_i(10) xor entrada_i(12) xor entrada_i(14) xor
            entrada_i(16) xor entrada_i(18) xor entrada_i(20) xor entrada_i(22) xor 
            entrada_i(24) xor entrada_i(26) xor entrada_i(28);
            
    p1_e <= entrada_i(2) xor entrada_i(5) xor entrada_i(6) xor 
    		entrada_i(9) xor entrada_i(10) xor entrada_i(13) xor entrada_i(14) xor
            entrada_i(17) xor entrada_i(18) xor entrada_i(21) xor entrada_i(22) xor 
            entrada_i(25) xor entrada_i(26); 
            
    p2_e <= entrada_i(5) xor entrada_i(5) xor entrada_i(6) xor 
    		entrada_i(11) xor entrada_i(12) xor entrada_i(13) xor entrada_i(14) xor
            entrada_i(19) xor entrada_i(20) xor entrada_i(21) xor entrada_i(22) xor 
            entrada_i(27) xor entrada_i(28);
            
   	p3_e <= entrada_i(8) xor entrada_i(9) xor entrada_i(10) xor 
    		entrada_i(11) xor entrada_i(12) xor entrada_i(13) xor entrada_i(14) xor
            entrada_i(23) xor entrada_i(24) xor entrada_i(25) xor entrada_i(26) xor 
            entrada_i(27) xor entrada_i(28);
            
    p4_e <= entrada_i(16) xor entrada_i(17) xor entrada_i(18) xor 
    		entrada_i(19) xor entrada_i(20) xor entrada_i(21) xor entrada_i(22) xor
            entrada_i(23) xor entrada_i(24) xor entrada_i(25) xor entrada_i(26) xor 
            entrada_i(27) xor entrada_i(28);
    
    vetor_p(0) <= p0_e xor entrada_i(0); 
    vetor_p(1) <= p1_e xor entrada_i(1); 
    vetor_p(2) <= p2_e xor entrada_i(3); 
    vetor_p(3) <= p3_e xor entrada_i(7); 
    vetor_p(4) <= p4_e xor entrada_i(15); 
    
    dados(0) <= entrada_i(2) xor (vetor_p(0) and vetor_p(1));
    dados(1) <= entrada_i(4) xor (vetor_p(0) and vetor_p(2));
    dados(2) <= entrada_i(5) xor (vetor_p(1) and vetor_p(2));
    dados(3) <= entrada_i(6) xor (vetor_p(0) and vetor_p(1) and vetor_p(2));
    dados(4) <= entrada_i(8) xor (vetor_p(0) and vetor_p(3));
    dados(5) <= entrada_i(9) xor (vetor_p(1) and vetor_p(3));
    dados(6) <= entrada_i(10) xor (vetor_p(0) and vetor_p(1) and vetor_p(3));
    dados(7) <= entrada_i(11) xor (vetor_p(2) and vetor_p(3));
    dados(8) <= entrada_i(12) xor (vetor_p(0) and vetor_p(2) and vetor_p(3));
    dados(9) <= entrada_i(13) xor (vetor_p(1) and vetor_p(2) and vetor_p(3));
    dados(10) <= entrada_i(14) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(3));
	dados(11) <= entrada_i(16) xor (vetor_p(0) and vetor_p(4));
    dados(12) <= entrada_i(17) xor (vetor_p(1) and vetor_p(4));
    dados(13) <= entrada_i(18) xor (vetor_p(0) and vetor_p(1) and vetor_p(4));
    dados(14) <= entrada_i(19) xor (vetor_p(2) and vetor_p(4));
    dados(15) <= entrada_i(20) xor (vetor_p(0) and vetor_p(2) and vetor_p(4));
    dados(16) <= entrada_i(21) xor (vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(17) <= entrada_i(22) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(18) <= entrada_i(23) xor (vetor_p(3) and vetor_p(4));
    dados(19) <= entrada_i(24) xor (vetor_p(0) and vetor_p(3) and vetor_p(4));
    dados(20) <= entrada_i(25) xor (vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(21) <= entrada_i(26) xor (vetor_p(0) and vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(22) <= entrada_i(27) xor (vetor_p(2) and vetor_p(3) and vetor_p(4));
    dados(23) <= entrada_i(28) xor (vetor_p(0) and vetor_p(2) and vetor_p(3) and vetor_p(4));
    
    
	erro <= '1' when ( vetor_p > "11101") else
    		'0';

end hamming_arch;


architecture hamming_arch of hamming is 
	-- declaracoes 
    signal p0_e, p1_e, p2_e, p3_e, p4_e: bit;
    signal vetor_p: bit_vector(4 downto 0);
    signal entrada_i: bit_vector(28 downto 0);
    
    component organizador is
		port(	entrada: in  bit_vector (28 downto 0);
  				saida: out bit_vector (28 downto 0));
	end component;
     
begin 

    organizador_1: organizador port map (entrada, entrada_i);

	p0_e <= entrada_i(2) xor entrada_i(4) xor entrada_i(6) xor 
    		entrada_i(8) xor entrada_i(10) xor entrada_i(12) xor entrada_i(14) xor
            entrada_i(16) xor entrada_i(18) xor entrada_i(20) xor entrada_i(22) xor 
            entrada_i(24) xor entrada_i(26) xor entrada_i(28);
            
    p1_e <= entrada_i(2) xor entrada_i(5) xor entrada_i(6) xor 
    		entrada_i(9) xor entrada_i(10) xor entrada_i(13) xor entrada_i(14) xor
            entrada_i(17) xor entrada_i(18) xor entrada_i(21) xor entrada_i(22) xor 
            entrada_i(25) xor entrada_i(26); 
            
    p2_e <= entrada_i(5) xor entrada_i(5) xor entrada_i(6) xor 
    		entrada_i(11) xor entrada_i(12) xor entrada_i(13) xor entrada_i(14) xor
            entrada_i(19) xor entrada_i(20) xor entrada_i(21) xor entrada_i(22) xor 
            entrada_i(27) xor entrada_i(28);
            
   	p3_e <= entrada_i(8) xor entrada_i(9) xor entrada_i(10) xor 
    		entrada_i(11) xor entrada_i(12) xor entrada_i(13) xor entrada_i(14) xor
            entrada_i(23) xor entrada_i(24) xor entrada_i(25) xor entrada_i(26) xor 
            entrada_i(27) xor entrada_i(28);
            
    p4_e <= entrada_i(16) xor entrada_i(17) xor entrada_i(18) xor 
    		entrada_i(19) xor entrada_i(20) xor entrada_i(21) xor entrada_i(22) xor
            entrada_i(23) xor entrada_i(24) xor entrada_i(25) xor entrada_i(26) xor 
            entrada_i(27) xor entrada_i(28);
    
    vetor_p(0) <= p0_e xor entrada_i(0); 
    vetor_p(1) <= p1_e xor entrada_i(1); 
    vetor_p(2) <= p2_e xor entrada_i(3); 
    vetor_p(3) <= p3_e xor entrada_i(7); 
    vetor_p(4) <= p4_e xor entrada_i(15); 
    
    dados(0) <= entrada_i(2) xor (vetor_p(0) and vetor_p(1));
    dados(1) <= entrada_i(4) xor (vetor_p(0) and vetor_p(2));
    dados(2) <= entrada_i(5) xor (vetor_p(1) and vetor_p(2));
    dados(3) <= entrada_i(6) xor (vetor_p(0) and vetor_p(1) and vetor_p(2));
    dados(4) <= entrada_i(8) xor (vetor_p(0) and vetor_p(3));
    dados(5) <= entrada_i(9) xor (vetor_p(1) and vetor_p(3));
    dados(6) <= entrada_i(10) xor (vetor_p(0) and vetor_p(1) and vetor_p(3));
    dados(7) <= entrada_i(11) xor (vetor_p(2) and vetor_p(3));
    dados(8) <= entrada_i(12) xor (vetor_p(0) and vetor_p(2) and vetor_p(3));
    dados(9) <= entrada_i(13) xor (vetor_p(1) and vetor_p(2) and vetor_p(3));
    dados(10) <= entrada_i(14) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(3));
	dados(11) <= entrada_i(16) xor (vetor_p(0) and vetor_p(4));
    dados(12) <= entrada_i(17) xor (vetor_p(1) and vetor_p(4));
    dados(13) <= entrada_i(18) xor (vetor_p(0) and vetor_p(1) and vetor_p(4));
    dados(14) <= entrada_i(19) xor (vetor_p(2) and vetor_p(4));
    dados(15) <= entrada_i(20) xor (vetor_p(0) and vetor_p(2) and vetor_p(4));
    dados(16) <= entrada_i(21) xor (vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(17) <= entrada_i(22) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(18) <= entrada_i(23) xor (vetor_p(3) and vetor_p(4));
    dados(19) <= entrada_i(24) xor (vetor_p(0) and vetor_p(3) and vetor_p(4));
    dados(20) <= entrada_i(25) xor (vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(21) <= entrada_i(26) xor (vetor_p(0) and vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(22) <= entrada_i(27) xor (vetor_p(2) and vetor_p(3) and vetor_p(4));
    dados(23) <= entrada_i(28) xor (vetor_p(0) and vetor_p(2) and vetor_p(3) and vetor_p(4));
    
    
	erro <= '1' when ( vetor_p > "11101") else
    		'0';

end hamming_arch;

