--BITS DE PARIDADE NO COMECO de 1 até 29


library IEEE;
use IEEE.numeric_bit.all;


entity organizador is port(
	entrada: in bit_vector(29 downto 1); -- ARRUMAR!!!!
	saida : out bit_vector(29 downto 1) 
	);
end entity;

architecture organizador_arch of organizador is 

    
begin 

	saida(1) <= entrada(1);
    saida(2) <= entrada(2);
	saida(4) <= entrada(3);
    saida(8) <= entrada(4);
    saida(16) <= entrada(5);
    saida(3) <= entrada(6);
    saida(5) <= entrada(7);
    saida(6) <= entrada(8);
    saida(7) <= entrada(9);
    saida(9) <= entrada(10);
    saida(10) <= entrada(11);
    saida(11) <= entrada(12);
	saida(12) <= entrada(13);
    saida(13) <= entrada(14);
    saida(14) <= entrada(15);
    saida(15) <= entrada(16);
    saida(17) <= entrada(17);
    saida(18) <= entrada(18);
    saida(19) <= entrada(19);
    saida(20) <= entrada(20);
    saida(21) <= entrada(21);
    saida(22) <= entrada(22);
    saida(23) <= entrada(23);
    saida(24) <= entrada(24);
    saida(25) <= entrada(25);
    saida(26) <= entrada(26);
    saida(27) <= entrada(27);
    saida(28) <= entrada(28);
    saida(29) <= entrada(29);
    
end organizador_arch;

    
entity hamming is port(
	entrada: in bit_vector(29 downto 1); -- ARRUMAR!!!!
	dados : out bit_vector(23 downto 0);
	erro: out bit 
	);
end entity;

architecture hamming_arch of hamming is 
	-- declaracoes 
    signal p0_e, p1_e, p2_e, p3_e, p4_e: bit;
    signal vetor_p: bit_vector(4 downto 0);
    signal entrada_i: bit_vector(29 downto 1);
    
    component organizador is
		port(	entrada: in  bit_vector (29 downto 1);
  				saida: out bit_vector (29 downto 1));
	end component;
     
begin 

    organizador_1: organizador port map (entrada, entrada_i);

	p0_e <= entrada_i(3) xor entrada_i(5) xor entrada_i(7) xor 
    		entrada_i(9) xor entrada_i(11) xor entrada_i(13) xor entrada_i(15) xor
            entrada_i(17) xor entrada_i(19) xor entrada_i(21) xor entrada_i(23) xor 
            entrada_i(25) xor entrada_i(27) xor entrada_i(29);
            
    p1_e <= entrada_i(3) xor entrada_i(6) xor entrada_i(7) xor 
    		entrada_i(10) xor entrada_i(11) xor entrada_i(14) xor entrada_i(15) xor
            entrada_i(18) xor entrada_i(19) xor entrada_i(22) xor entrada_i(23) xor 
            entrada_i(26) xor entrada_i(27); 
            
    p2_e <= entrada_i(5) xor entrada_i(6) xor entrada_i(7) xor 
    		entrada_i(12) xor entrada_i(13) xor entrada_i(14) xor entrada_i(15) xor
            entrada_i(20) xor entrada_i(21) xor entrada_i(22) xor entrada_i(23) xor 
            entrada_i(28) xor entrada_i(29);
            
   	p3_e <= entrada_i(9) xor entrada_i(10) xor entrada_i(11) xor 
    		entrada_i(12) xor entrada_i(13) xor entrada_i(14) xor entrada_i(15) xor
            entrada_i(24) xor entrada_i(25) xor entrada_i(26) xor entrada_i(27) xor 
            entrada_i(28) xor entrada_i(29);
            
    p4_e <= entrada_i(17) xor entrada_i(18) xor entrada_i(19) xor 
    		entrada_i(20) xor entrada_i(21) xor entrada_i(22) xor entrada_i(23) xor
            entrada_i(24) xor entrada_i(25) xor entrada_i(26) xor entrada_i(27) xor 
            entrada_i(28) xor entrada_i(29);
    
    vetor_p(0) <= p0_e xor entrada_i(1); 
    vetor_p(1) <= p1_e xor entrada_i(2); 
    vetor_p(2) <= p2_e xor entrada_i(4); 
    vetor_p(3) <= p3_e xor entrada_i(8); 
    vetor_p(4) <= p4_e xor entrada_i(16); 
    
    dados(0) <= entrada_i(3) xor (vetor_p(0) and vetor_p(1));
    dados(1) <= entrada_i(5) xor (vetor_p(0) and vetor_p(2));
    dados(2) <= entrada_i(6) xor (vetor_p(1) and vetor_p(2));
    dados(3) <= entrada_i(7) xor (vetor_p(0) and vetor_p(1) and vetor_p(2));
    dados(4) <= entrada_i(9) xor (vetor_p(0) and vetor_p(3));
    dados(5) <= entrada_i(10) xor (vetor_p(1) and vetor_p(3));
    dados(6) <= entrada_i(11) xor (vetor_p(0) and vetor_p(1) and vetor_p(3));
    dados(7) <= entrada_i(12) xor (vetor_p(2) and vetor_p(3));
    dados(8) <= entrada_i(13) xor (vetor_p(0) and vetor_p(2) and vetor_p(3));
    dados(9) <= entrada_i(14) xor (vetor_p(1) and vetor_p(2) and vetor_p(3));
    dados(10) <= entrada_i(15) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(3));
	dados(11) <= entrada_i(17) xor (vetor_p(0) and vetor_p(4));
    dados(12) <= entrada_i(18) xor (vetor_p(1) and vetor_p(4));
    dados(13) <= entrada_i(19) xor (vetor_p(0) and vetor_p(1) and vetor_p(4));
    dados(14) <= entrada_i(20) xor (vetor_p(2) and vetor_p(4));
    dados(15) <= entrada_i(21) xor (vetor_p(0) and vetor_p(2) and vetor_p(4));
    dados(16) <= entrada_i(22) xor (vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(17) <= entrada_i(23) xor (vetor_p(0) and vetor_p(1) and vetor_p(2) and vetor_p(4));
    dados(18) <= entrada_i(24) xor (vetor_p(3) and vetor_p(4));
    dados(19) <= entrada_i(25) xor (vetor_p(0) and vetor_p(3) and vetor_p(4));
    dados(20) <= entrada_i(26) xor (vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(21) <= entrada_i(27) xor (vetor_p(0) and vetor_p(1) and vetor_p(3) and vetor_p(4));
    dados(22) <= entrada_i(28) xor (vetor_p(2) and vetor_p(3) and vetor_p(4));
    dados(23) <= entrada_i(29) xor (vetor_p(0) and vetor_p(2) and vetor_p(3) and vetor_p(4));
    
    
	erro <= '1' when ( vetor_p > "11101") else
    		'0';
    			
end hamming_arch;

