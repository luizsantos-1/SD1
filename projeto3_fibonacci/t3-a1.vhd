library IEEE;
use IEEE.numeric_bit.all;

entity fib is port(
	reset, clock, inicio: in bit;
	F1, F2, n: in bit_vector(7 downto 0); 
	Fn: out bit_vector(15 downto 0);
	fim, overflow: out bit); 
end fib;

entity somador_16 is port(
  	entrada1, entrada2: in bit_vector(15 downto 0); 
	saida: out bit_vector(15 downto 0);
	overflow: out bit); 
end somador_16;

entity somador_1 is port(
  	A, B, carry_in: in bit ; 
	carry_out, S: out bit); 
end somador_1;

architecture somador_1_arch of somador_1 is 

    begin 
        S <= A xor B xor carry_in;
        carry_out <= ((A xor B) and carry_in) or (A and B); 

end somador_1_arch;

architecture somador_16_arch of somador_16 is 

    signal carry_out_vec: bit_vector(15 downto 0);

    component somador_1 is port (
		A, B, carry_in: in bit; 
		carry_out, S: out bit); 
    end component;

    begin 
    
        B0: somador_1 port map (entrada1(0), entrada2(0), '0' , carry_out_vec(0), saida(0)); 
        B1: somador_1 port map (entrada1(1), entrada2(1), carry_out_vec(0), carry_out_vec(1), saida(1)); 
        B2: somador_1 port map (entrada1(2), entrada2(2), carry_out_vec(1), carry_out_vec(2), saida(2)); 
        B3: somador_1 port map (entrada1(3), entrada2(3), carry_out_vec(2), carry_out_vec(3), saida(3)); 
        B4: somador_1 port map (entrada1(4), entrada2(4), carry_out_vec(3), carry_out_vec(4), saida(4)); 
        B5: somador_1 port map (entrada1(5), entrada2(5), carry_out_vec(4), carry_out_vec(5), saida(5)); 
        B6: somador_1 port map (entrada1(6), entrada2(6), carry_out_vec(5), carry_out_vec(6), saida(6)); 
        B7: somador_1 port map (entrada1(7), entrada2(7), carry_out_vec(6), carry_out_vec(7), saida(7)); 
        B8: somador_1 port map (entrada1(8), entrada2(8), carry_out_vec(7), carry_out_vec(8), saida(8)); 
        B9: somador_1 port map (entrada1(9), entrada2(9), carry_out_vec(8), carry_out_vec(9), saida(9)); 
        B10: somador_1 port map (entrada1(10), entrada2(10), carry_out_vec(9), carry_out_vec(10), saida(10));  
        B11: somador_1 port map (entrada1(11), entrada2(11), carry_out_vec(10), carry_out_vec(11), saida(11)); 
        B12: somador_1 port map (entrada1(12), entrada2(12), carry_out_vec(11), carry_out_vec(12), saida(12)); 
        B13: somador_1 port map (entrada1(13), entrada2(13), carry_out_vec(12), carry_out_vec(13), saida(13));
        B14: somador_1 port map (entrada1(14), entrada2(14), carry_out_vec(13), carry_out_vec(14), saida(14)); 
        B15: somador_1 port map (entrada1(15), entrada2(15), carry_out_vec(14), carry_out_vec(15), saida(15)); 

    overflow <= carry_out_vec(15);
    
end somador_16_arch;