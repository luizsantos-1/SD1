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
    signal soma1: bit_vector(3 downto 0);
    signal soma2: bit_vector(3 downto 0);
    signal somaf: bit_vector(3 downto 0);
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
    		   "1101101" when (resultado(1) = '1') else
               "1111001" when (resultado(2) = '1') else
               "0110011" when (resultado(3) = '1') else
               "0000001"; -- ninguem acertou
              
    			
end purrinha_arch;

entity flipflopd is port(
  D, reset, clock, EN: in bit;
  Q: out bit );
end flipflopd;

architecture behavior of flipflopd is 
begin
  process (reset, clock) 
  	begin
      if reset='0' 
      	then Q <= '0';
      elsif clock'EVENT and clock='1' and EN='1' 
      	then Q <= D;
      end if;
  end process;
end behavior;

entity purrinha_plus is port(
  reset, clock: in bit;
  --! armazenam os dados dos jogadores
  load4, load3, load2, load1: in bit;
  --! atualiza o resultado no display
  atualiza: in bit;
  --! palitos com cada jogador
  num4, num3, num2, num1: in bit_vector(1 downto 0);
  --! palpites de cada jogador
  guess4, guess3, guess2, guess1: in bit_vector(3 downto 0); --! resultado do jogo
  display: out bit_vector(6 downto 0)
  );
end purrinha_plus;

architecture purrinha_plus_arch of flipflopd is 
	
    signal num1_guardado, num2_guardado, num3_guardado, num4_guardado: bit_vector(1 downto 0);
    signal guess1_guardado, guess2_guardado, guess3_guardado, guess4_guardado: bit_vector(3 downto 0);
    signal display_i: bit_vector(6 downto0);
    
    component purrinha is port (
    num4, num3, num2, num1: in bit_vector(1 downto 0); 
	guess4, guess3, guess2, guess1: in bit_vector(3 downto 0); 
    display: out bit_vector(6 downto 0)
    );
	end component;
 
	component flipflopd is port( 
  		D, reset, clock, EN: in bit;
  		Q: out bit );
	end component;
    
	begin
    
    ff_num10: flipflopd port map (num1(0), reset, clock, load1, num1_guardado(0));
    ff_num11: flipflopd port map (num1(1), reset, clock, load1, num1_guardado(1));
    
    ff_num20: flipflopd port map (num2(0), reset, clock, load2, num2_guardado(0));
    ff_num21: flipflopd port map (num2(1), reset, clock, load2, num2_guardado(1));
    
    ff_num30: flipflopd port map (num3(0), reset, clock, load3, num3_guardado(0));
    ff_num31: flipflopd port map (num3(1), reset, clock, load3, num3_guardado(1));
    
    ff_num40: flipflopd port map (num4(0), reset, clock, load4, num4_guardado(0));
    ff_num41: flipflopd port map (num4(1), reset, clock, load4, num4_guardado(1));
    
    ff_guess10: flipflopd port map (guess1(0), reset, clock, load1, guess1_guardado(0));
    ff_guess11: flipflopd port map (guess1(1), reset, clock, load1, guess1_guardado(1));
    ff_guess12: flipflopd port map (guess1(2), reset, clock, load1, guess1_guardado(2));
    ff_guess13: flipflopd port map (guess1(3), reset, clock, load1, guess1_guardado(3));
    
    ff_guess20: flipflopd port map (guess2(0), reset, clock, load2, guess2_guardado(0));
    ff_guess21: flipflopd port map (guess2(1), reset, clock, load2, guess2_guardado(1));
    ff_guess22: flipflopd port map (guess2(2), reset, clock, load2, guess2_guardado(2));
    ff_guess23: flipflopd port map (guess2(3), reset, clock, load2, guess2_guardado(3));
    
    ff_guess30: flipflopd port map (guess3(0), reset, clock, load3, guess3_guardado(0));
    ff_guess31: flipflopd port map (guess3(1), reset, clock, load3, guess3_guardado(1));
    ff_guess32: flipflopd port map (guess3(2), reset, clock, load3, guess3_guardado(2));
    ff_guess33: flipflopd port map (guess3(3), reset, clock, load3, guess3_guardado(3));
    
    ff_guess40: flipflopd port map (guess4(0), reset, clock, load4, guess4_guardado(0));
    ff_guess41: flipflopd port map (guess4(1), reset, clock, load4, guess4_guardado(1));
    ff_guess42: flipflopd port map (guess4(2), reset, clock, load4, guess4_guardado(2));
    ff_guess43: flipflopd port map (guess4(3), reset, clock, load4, guess4_guardado(3));
    
    p1: purrinha port map (num1_guardado, num2_guardado, num3_guardado, num4_guardado, 
    						guess1_guardado, guess2_guardado, guess3_guardado, guess4_guardado, 
                            display_i);
                            
    ff_display0: flipflopd port map (display_i(0), reset, clock, atualiza, display(0));
    ff_display1: flipflopd port map (display_i(1), reset, clock, atualiza, display(1));
    ff_display2: flipflopd port map (display_i(2), reset, clock, atualiza, display(2));
    ff_display3: flipflopd port map (display_i(3), reset, clock, atualiza, display(3));
    ff_display4: flipflopd port map (display_i(4), reset, clock, atualiza, display(4));
    ff_display5: flipflopd port map (display_i(5), reset, clock, atualiza, display(5));
    ff_display6: flipflopd port map (display_i(6), reset, clock, atualiza, display(6));
  	
end purrinha_plus_arch;