library IEEE;
use IEEE.numeric_bit.all; -- Supports signed and unsigned arithmetic

-- Half adder with 4 bits 
entity hadder4bits is
port(
  a:     in  bit_vector (3 downto 0);
  b:     in  bit_vector (3 downto 0);
  sum:   out bit_vector (3 downto 0));
end hadder4bits;

architecture hadder_arch of hadder4bits is
  signal internal : unsigned (3 downto 0);
begin
  internal <= unsigned(a) + unsigned(b);
  sum <= bit_vector(internal); -- soma com 4 bits
end hadder_arch;

-- Comparator with 4 bits
entity comp4bits is
port(
  a:        in  bit_vector (3 downto 0);
  b:        in  bit_vector (3 downto 0);
  equals:   out bit);
end comp4bits;

architecture comp4bits_arch of comp4bits is
begin
  equals <= '1' when (a = b) else '0'; -- soma com 4 bits
end comp4bits_arch;

-- Binary encoder 4:2 bits, plus error bit (most significant)
entity enc4_2err is
port(
  data   : in  bit_vector (3 downto 0);
  encoded: out bit_vector (2 downto 0));
end enc4_2err;

architecture enc4_2_arch of enc4_2err is
begin
  encoded <= "000" when data = "0001" else
  			 "001" when data = "0010" else 
             "010" when data = "0100" else 
             "011" when data = "1000" else 
             "100" when data = "0000" else -- error: no bit set to 1
             "111"; 					   -- error: more than one bit set to 1
end enc4_2_arch;


--Complete game
entity purrinha is
  port (
    num4, num3, num2, num1: 		in  bit_vector(1 downto 0);
    guess4, guess3, guess2, guess1: in  bit_vector(3 downto 0);
    display: 						out bit_vector(6 downto 0));
end entity;


architecture arch of purrinha is
	-- Inputs from players extended to 4 bits
    signal num4_4bits, num3_4bits, num2_4bits, num1_4bits: bit_vector(3 downto 0);
    -- Sums 
    signal sum43, sum21, sumAll: bit_vector(3 downto 0);
    -- Result of guesses 
    signal correct: bit_vector(3 downto 0);
    -- Internal encoding
    signal encodedWinner:  bit_vector(2 downto 0);
    
    component hadder4bits is
		port( 	a:     in  bit_vector (3 downto 0);
  				b:     in  bit_vector (3 downto 0);
  				sum:   out bit_vector (3 downto 0));
	end component;
    
    component comp4bits is
		port(	a:      in  bit_vector (3 downto 0);
  				b:      in  bit_vector (3 downto 0);
  				equals: out bit);
	end component;
    
    component enc4_2err is
		port(	data   : in  bit_vector (3 downto 0);
  				encoded: out bit_vector (2 downto 0));
	end component;
    
begin
  	num4_4bits <= "00" & num4;
    num3_4bits <= "00" & num3;
    num2_4bits <= "00" & num2;
    num1_4bits <= "00" & num1;
    
    -- Additions
    adder43: hadder4bits port map (num4_4bits, num3_4bits, sum43);
    adder21: hadder4bits port map (num2_4bits, num1_4bits, sum21);
    
    adderall: hadder4bits port map (sum43, sum21, sumAll);
    
    -- Comparators: results vs guesses 
    win4: comp4bits port map (sumAll, guess4, correct(3));
    win3: comp4bits port map (sumAll, guess3, correct(2));
    win2: comp4bits port map (sumAll, guess2, correct(1));
    win1: comp4bits port map (sumAll, guess1, correct(0));
    
    
    -- Get encoded winner number
    callWinner: enc4_2err port map (correct, encodedWinner);
    
    -- Decode winner in 7-seg display
    with encodedWinner select
    	display <= 	"0110000" when "000",  -- player 1 wins
        			"1101101" when "001",  -- player 2 wins
                    "1111001" when "010",  -- player 3 wins
                    "0110011" when "011",  -- player 4 wins
                    "0000001" when "100",  -- no winner: "-"
					"1001111" when others; -- error: "E"
        
end architecture;

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

architecture purrinha_plus_arch of purrinha_plus is 
	
    signal num1_guardado, num2_guardado, num3_guardado, num4_guardado: bit_vector(1 downto 0);
    signal guess1_guardado, guess2_guardado, guess3_guardado, guess4_guardado: bit_vector(3 downto 0);
    signal display_i: bit_vector(6 downto 0);
    
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