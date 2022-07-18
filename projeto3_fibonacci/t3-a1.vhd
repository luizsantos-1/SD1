library IEEE;
use IEEE.numeric_bit.all;

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

entity flipflopd is port(
	D, reset, clock, EN: in bit;
	Q: out bit );
end flipflopd;

architecture behavior of flipflopd is begin
	process (reset, clock) 
    	begin
		if reset=’0’ then Q <= ’0’;
		elsif clock’EVENT and clock=’1’ and EN=’1’ then Q <= D;
		end if;
	end process ;
end behavior;

entity registrador is port(
	reset, clock, EN: in bit;
    D: in bit vector(15 downto 0);
    Q: out bit vector(15 downto 0));
end registrador;
architecture registrador_arch of registrador is 
	
    component flipflopd is port (
		D, reset, clock, EN: in bit;
		Q: out bit );
    end component;
    
    begin
    
    FF0: flipflopd port map (D(0), reset, clock, EN, Q(0));
    FF1: flipflopd port map (D(1), reset, clock, EN, Q(1));
    FF2: flipflopd port map (D(2), reset, clock, EN, Q(2));
    FF3: flipflopd port map (D(3), reset, clock, EN, Q(3));
    FF4: flipflopd port map (D(4), reset, clock, EN, Q(4));
    FF5: flipflopd port map (D(5), reset, clock, EN, Q(5));
    FF6: flipflopd port map (D(6), reset, clock, EN, Q(6));
    FF7: flipflopd port map (D(7), reset, clock, EN, Q(7));
    FF8: flipflopd port map (D(8), reset, clock, EN, Q(8));
    FF9: flipflopd port map (D(9), reset, clock, EN, Q(9));
    FF10: flipflopd port map (D(10), reset, clock, EN, Q(10));
    FF11: flipflopd port map (D(11), reset, clock, EN, Q(11));
    FF12: flipflopd port map (D(12), reset, clock, EN, Q(12));
    FF13: flipflopd port map (D(13), reset, clock, EN, Q(13));
    FF14: flipflopd port map (D(14), reset, clock, EN, Q(14));
    FF15: flipflopd port map (D(15), reset, clock, EN, Q(15));
    
    
    
end registrador_arch;


entity fib is port(
	reset, clock, inicio: in bit;
	F1, F2, n: in bit_vector(7 downto 0); 
	Fn: out bit_vector(15 downto 0);
	fim, overflow: out bit); 
end fib;

architecture fib_arch of fib is 

    begin 
    
end fib_arch;

entity fibUC is
  port (
    clock, reset, inicio : in bit;
    fim: out bit
  );
end entity;

architecture fibUC_arch of fibUC is
  type state_t is (idle_s, exibirf1_s, exibirf2_s, somar_s, fim,_s);
  signal next_state, current_state: state_t;
begin

  -- Processo da máquina de estados
  fsm: process(clock, reset)
  begin
    if reset='1' then
      current_state <= idle_s;
    elsif rising_edge(clock) then
      current_state <= next_state;
    end if;
  end process;

  -- Lógica de próximo estado
  next_state <=
    idle_s  when (reset = '1') or (current_state = idle_s and inicio = '0')else
	exibir_f1_s when (current_state = idle_s) and (inicio = '1') else
	exibir_f2_s when (current_state = exibir_f1_s) else
	somar_s when (current_state = exibir_f2_s) or  (current_state = somar_s and (overflow = '0' and contador /= '0')) else
	fim_s when (contador = '0' or overflow = '1');
	  
  -- Decodifica o estado para gerar sinais de controle
  contador <= 'n' when current_state = idle_s else '0';
  
  -- Decodifica o estado para gerar as saídas da UC
  fim <= '1' when current_state= fim_s else '0';

end architecture;