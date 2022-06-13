    
entity hamming is port(
	entrada: in bit_vector(28 downto 0); -- ARRUMAR!!!!
	dados : out bit_vector(23 downto 0);
	erro: out bit 
	);
end entity;

architecture hamming_arch of hamming is 
	-- declaracoes 
    signal p0_e, p1_e, p2_e, p3_e, p4_e: bit;
    --signal posicao_erro: integer;
    signal vetor_p: bit_vector(4 downto 0);
    --signal vetor_p_u: unsigned(4 downto 0);
    
begin 
	p0_e <= entrada(0) xor entrada(2) xor entrada(4) xor entrada(6) xor 
    		entrada(8) xor entrada(10) xor entrada(12) xor entrada(14) xor
            entrada(16) xor entrada(18) xor entrada(20) xor entrada(22) xor 
            entrada(24) xor entrada(26) xor entrada(28);
            
    p1_e <= entrada(1) xor entrada(2) xor entrada(5) xor entrada(6) xor 
    		entrada(9) xor entrada(10) xor entrada(13) xor entrada(14) xor
            entrada(17) xor entrada(18) xor entrada(21) xor entrada(22) xor 
            entrada(25) xor entrada(26); 
            
    p2_e <= entrada(3) xor entrada(4) xor entrada(5) xor entrada(6) xor 
    		entrada(11) xor entrada(12) xor entrada(13) xor entrada(14) xor
            entrada(19) xor entrada(20) xor entrada(21) xor entrada(22) xor 
            entrada(27) xor entrada(28);
            
   	p3_e <= entrada(7) xor entrada(8) xor entrada(9) xor entrada(10) xor 
    		entrada(11) xor entrada(12) xor entrada(13) xor entrada(14) xor
            entrada(23) xor entrada(24) xor entrada(25) xor entrada(26) xor 
            entrada(27) xor entrada(28);
            
    p4_e <= entrada(15) xor entrada(16) xor entrada(17) xor entrada(18) xor 
    		entrada(19) xor entrada(20) xor entrada(21) xor entrada(22) xor
            entrada(23) xor entrada(24) xor entrada(25) xor entrada(26) xor 
            entrada(27) xor entrada(28);
    
    vetor_p(0) <= p0_e; 
    vetor_p(1) <= p1_e; 
    vetor_p(2) <= p2_e; 
    vetor_p(3) <= p3_e; 
    vetor_p(4) <= p4_e; 
    
    dados(0) <= entrada(2) xor (p0_e and p1_e);
    dados(1) <= entrada(4) xor (p0_e and p2_e);
    dados(2) <= entrada(5) xor (p1_e and p2_e);
    dados(3) <= entrada(6) xor (p0_e and p1_e and p2_e);
    dados(4) <= entrada(8) xor (p0_e and p3_e);
    dados(5) <= entrada(9) xor (p1_e and p3_e);
    dados(6) <= entrada(10) xor (p0_e and p1_e and p3_e);
    dados(7) <= entrada(11) xor (p2_e and p3_e);
    dados(8) <= entrada(12) xor (p0_e and p2_e and p3_e);
    dados(9) <= entrada(13) xor (p1_e and p2_e and p3_e);
    dados(10) <= entrada(14) xor (p0_e and p1_e and p2_e and p3_e);
	dados(11) <= entrada(16) xor (p0_e and p4_e);
    dados(12) <= entrada(17) xor (p1_e and p4_e);
    dados(13) <= entrada(18) xor (p0_e and p1_e and p4_e);
    dados(14) <= entrada(19) xor (p2_e and p4_e);
    dados(15) <= entrada(20) xor (p0_e and p2_e and p4_e);
    dados(16) <= entrada(21) xor (p1_e and p2_e and p4_e);
    dados(17) <= entrada(22) xor (p0_e and p1_e and p2_e and p4_e);
    dados(18) <= entrada(23) xor (p3_e and p4_e);
    dados(19) <= entrada(24) xor (p0_e and p3_e and p4_e);
    dados(20) <= entrada(25) xor (p1_e and p3_e and p4_e);
    dados(21) <= entrada(26) xor (p0_e and p1_e and p3_e and p4_e);
    dados(22) <= entrada(27) xor (p2_e and p3_e and p4_e);
    dados(23) <= entrada(28) xor (p0_e and p2_e and p3_e and p4_e);
   
    
    
	erro <= '1' when ( vetor_p > "11101") else
    		'0';