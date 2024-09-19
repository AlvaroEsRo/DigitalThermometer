----------------------------------------------------------------------------------
--
-- Thermometer based on LM35 and MCP3201 ADC
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity termometro is
    Port ( CLK_50MHz : in  STD_LOGIC;               -- System clock
           SPI_DATA : in  STD_LOGIC;                -- Data input from SPI port
           SPI_CLK : out  STD_LOGIC;                -- Clock output for SPI port
           SPI_CS : out  STD_LOGIC;                 -- Chip select output for SPI port
           AN : out  STD_LOGIC_VECTOR (3 downto 0); -- Display selection output
           SEG7 : out  STD_LOGIC_VECTOR (0 to 6);   -- Output for display segments
           DP : out  STD_LOGIC);                    -- Output for decimal point on displays
end termometro;

architecture a_termometro of termometro is

	-- OTHER COMPONENTS

component div_reloj is
    Port ( CLK_50MHz : in  STD_LOGIC;       -- FPGA clock input 50 MHz
           CLK       : out  STD_LOGIC);     -- 1 kHz clock output
end component;

component visualizacion is
 Port ( ENABLE : in STD_LOGIC;                         -- ENABLE input
	        DECENAS : in  STD_LOGIC_VECTOR (3 downto 0);   -- Tens input
	        UNIDADES : in  STD_LOGIC_VECTOR (3 downto 0);   -- Units input
	        DECIMAS : in  STD_LOGIC_VECTOR (3 downto 0);   -- Decimals input
           CLK     : in  STD_LOGIC;                   -- Clock input
           SEG7 : out  STD_LOGIC_VECTOR (0 to 6);      -- Display output
			  DP   : out STD_LOGIC;                       -- Decimal point output
           AN   : out  STD_LOGIC_VECTOR (3 downto 0)); -- Individual display activation
 end component; 
	 
component aut_control is
    Port ( CLK        : in  STD_LOGIC;                         -- System clock
           SPI_DATA   : in  STD_LOGIC;                         -- Data input from SPI port
			  SPI_CLK    : out  STD_LOGIC;                        -- SPI clock output
           SPI_CS     : out  STD_LOGIC;                        -- SPI chip select
			  FIN_CONV   : out  STD_LOGIC;                        -- End of conversion
			  DATOS_ADC  : out  STD_LOGIC_VECTOR (15 downto 0));  -- ADC data output
end component;

component TEMP_a_BCD is
    Port ( TEMP     : in  STD_LOGIC_VECTOR (15 downto 0);  -- Temperature with 6 decimal bits
           DECENAS  : out  STD_LOGIC_VECTOR (3 downto 0);  -- Tens in BCD
           UNIDADES : out  STD_LOGIC_VECTOR (3 downto 0);  -- Units in BCD
           DECIMAS  : out  STD_LOGIC_VECTOR (3 downto 0)); -- Decimals in BCD 
end component;

component ADC_a_TEMP is
    Port ( DATOS_ADC : in  STD_LOGIC_VECTOR (15 downto 0);     -- ADC data
           TEMP      : out  STD_LOGIC_VECTOR (15 downto 0));   -- Temperature output in fixed point with 6 decimal bits
end component;
	
	
	-- POSSIBLE NECESSARY SIGNALS
	
signal CLK_1ms: STD_LOGIC; -- 1ms clock from the clock divider
signal ENABLE_VIS: STD_LOGIC; -- Variable FIN_CONV from the automaton used as the enable for the register
signal DATOS_AUX: STD_LOGIC_VECTOR (15 downto 0); -- Auxiliary signal connecting the output of the data automaton to the input of ADC to TEMP
signal TEMP_AUX: STD_LOGIC_VECTOR (15 downto 0); -- Auxiliary signal connecting the output of ADC_a_TEMP with the input of TEMP_a_BCD
signal DEC_E3 : STD_LOGIC_VECTOR (3 downto 0); -- Signal connecting the output of tens to the E3 input of the register
signal UNI_E2 : STD_LOGIC_VECTOR (3 downto 0); -- Signal connecting the output of units to the E2 input of the register
signal DECI_E1 : STD_LOGIC_VECTOR (3 downto 0);	-- Signal connecting the output of decimals to the E1 input of the register
	
begin

U1 : div_reloj port map (
	CLK_50MHz=>CLK_50MHz, -- Assign the clock
	CLK=>CLK_1ms -- Assign the clock 
	);
	
U2 : aut_control port map (
	SPI_CS =>SPI_CS, -- Assign the output 
	SPI_CLK=> SPI_CLK, -- Assign the output
	SPI_DATA=>SPI_DATA, -- Assign the input
	CLK=>CLK_1ms, -- Assign the auxiliary signal CLK_1ms to the clock
	FIN_CONV=>ENABLE_VIS, -- FIN_CONV is the ENABLE for the visualization circuit
	DATOS_ADC=>DATOS_AUX -- The output of the automaton is an auxiliary signal
);

U3 : ADC_a_TEMP port map(
	DATOS_ADC=>DATOS_AUX, -- Connect the output of the automaton to the TEMP input with the auxiliary signal 
	TEMP=>TEMP_AUX -- TEMP is passed to an auxiliary signal for interconnection
);

U4: TEMP_a_BCD port map(
	TEMP=>TEMP_AUX, -- Connect the output of TEMP from ADC to the input of TEMP for BCD
	DECENAS=>DEC_E3, -- DECENAS becomes the E3 input of the register
	UNIDADES=>UNI_E2, -- UNIDADES becomes the E2 input of the register
	DECIMAS=>DECI_E1 -- DECIMAS becomes the E1 input of the register
);

U5 : visualizacion port map(
	DECENAS=>DEC_E3, -- E3 is assigned the value of DECENAS 
	UNIDADES=>UNI_E2, -- E2 is assigned the value of UNIDADES
	DECIMAS=>DECI_E1, -- E1 is assigned the value of DECIMAS
	CLK=>CLK_1ms, -- Assign the auxiliary signal CLK_1ms to the clock
	SEG7=>SEG7, -- Assign the signal to an output
	AN=>AN,  -- Assign the signal to an output
	DP=>DP,  -- Assign the signal to an output
	ENABLE=>ENABLE_VIS -- Assign the ENABLE from the FIN_CONV signal
);

end a_termometro;
