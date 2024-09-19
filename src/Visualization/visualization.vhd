----------------------------------------------------------------------------------
-- 
-- Display module, shows the data
-- on the displays by capturing it with the ENABLE signal.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity visualization is
    Port ( ENABLE  : in STD_LOGIC;                        -- ENABLE input
           DECENAS : in  STD_LOGIC_VECTOR (3 downto 0);   -- Tens input
           UNIDADES: in  STD_LOGIC_VECTOR (3 downto 0);   -- Units input
           DECIMAS : in  STD_LOGIC_VECTOR (3 downto 0);   -- Decimals input
           CLK     : in  STD_LOGIC;                       -- Clock input
           SEG7    : out  STD_LOGIC_VECTOR (0 to 6);      -- Output to the displays 
           DP      : out STD_LOGIC;                       -- Decimal point output
           AN      : out  STD_LOGIC_VECTOR (3 downto 0)); -- Individual activation
end visualization;

architecture a_visualization of visualization is

-- Connect all the elements of this module 
-- Perform port map of each component with its variables 

component decodBCDa7s 
  Port ( BCD       : in  STD_LOGIC_VECTOR (3 downto 0); -- BCD value input
         SEGMENTOS : out  STD_LOGIC_VECTOR (0 to 6));   -- Outputs to the display
end component;



component registro
	Port (  CLK     : in   STD_LOGIC;                       -- Clock input
	        ENABLE  : in   STD_LOGIC;                       -- Enable 
           E0      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E0 input
           E1      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E1 input
           E2      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E2 input
           E3      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E3 input
           Q0      : out  STD_LOGIC_VECTOR (3 downto 0);   -- Q0 output
           Q1      : out  STD_LOGIC_VECTOR (3 downto 0);   -- Q1 output
           Q2      : out  STD_LOGIC_VECTOR (3 downto 0);   -- Q2 output
           Q3      : out  STD_LOGIC_VECTOR (3 downto 0));  -- Q3 output
end component;

component refresco 
	 Port ( CLK : in  STD_LOGIC;                       -- Refresh clock
           S   : out  STD_LOGIC_VECTOR (1 downto 0);  -- Control for the mux
	        DP  : out STD_LOGIC;                       -- Decimal point control
           AN  : out  STD_LOGIC_VECTOR (3 downto 0)); -- Individual displays control
end component;

component MUX4x4
	Port (  E0 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 0
           E1 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 1
           E2 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 2
           E3 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 3
           S  : in  STD_LOGIC_VECTOR (1 downto 0);   -- Control signal
           Y  : out  STD_LOGIC_VECTOR (3 downto 0)); -- Output
end component;

-- AUXILIARY SIGNALS TO HELP WITH INTERCONNECTION

signal salida_mux: STD_LOGIC_VECTOR (3 downto 0); -- Connects the mux output with the 
                                                  input of the DECODaBCD
signal QA0: STD_LOGIC_VECTOR (3 downto 0);        -- Q0 output from register with the input
                                                  E0 of the MUX                                 
signal QA1: STD_LOGIC_VECTOR (3 downto 0);        -- Q1 output from register with the input
							    E1 of the MUX
signal QA2: STD_LOGIC_VECTOR (3 downto 0);        -- Q2 output from register with the input
                                                  E2 of the MUX
signal QA3: STD_LOGIC_VECTOR (3 downto 0);        -- Q3 output from register with the input 
                                                  E3 of the MUX
signal saux: STD_LOGIC_VECTOR (1 downto 0);       -- Refresh output with the MUX 
                                                  select signal

begin

-- CONNECTION OF COMPONENTS WITH SIGNALS

U1 : decodBCDa7s 
	port map (
		BCD=>salida_mux,
		SEGMENTOS=>SEG7
	);
U2: registro
	port map (
		CLK=>CLK,
		ENABLE=>ENABLE,
		E0=>"1100", -- The last digit of the display must show C for 
                      Celsius, which in hexadecimal is '1100'
		E1=> DECIMAS,
		E2=>UNIDADES,
		E3=>DECENAS,
		Q0=>QA0,
		Q1=>QA1,
		Q2=>QA2,
		Q3=>QA3
	);
U3: refresco
	port map (
		CLK=>CLK,
		DP=>DP,
		AN=>AN,
		S=>saux
	);
U4: MUX4x4
	port map(
		E0=>QA0,
		E1=>QA1,
		E2=>QA2,
		E3=>QA3,
		S=>saux,
		Y=>salida_mux
	);
		
end a_visualization;
