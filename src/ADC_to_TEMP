----------------------------------------------------------------------------------
-- Conversion of ADC data to temperature
-- The sensor provides a voltage of 100 mV per °C
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADC_a_TEMP is
    Port ( DATOS_ADC : in  STD_LOGIC_VECTOR (15 downto 0);   -- ADC data
           TEMP      : out  STD_LOGIC_VECTOR (15 downto 0)); -- Temperature output in 
                                                        fixed-point with 6 decimal bits
end ADC_a_TEMP;

architecture a_ADC_a_TEMP of ADC_a_TEMP is

constant FILTRO: unsigned (15 downto 0):= "0000111111111000"; -- Set a '1' in the 
                                                        position of the required bits
signal datos: unsigned (15 downto 0):=(others=>'0');    -- Data read from the converter        
                                                             and filtered
signal datosx32: unsigned (31 downto 0):=(others=>'0'); -- Data multiplied by 32
signal datosx16: unsigned (31 downto 0):=(others=>'0'); -- Data multiplied by 16
signal datosx2: unsigned (31 downto 0):=(others=>'0');  -- Data multiplied by 2
signal datosx50: unsigned (31 downto 0):=(others=>'0'); -- Data multiplied by 50

begin

datos<= unsigned(DATOS_ADC)  and FILTRO;  -- Filtered input data

-- To convert to °C, multiply by 50 and divide by 4096

-- To multiply data*50, we do: data*32 + data*16 + data*2

datosx32 <="00000000000" & datos & "00000";  -- Shift 5 bits left for x32
datosx16 <= "000000000000" & datos & "0000"; -- Shift 4 bits left for x16
datosx2  <= "000000000000000" & datos & '0'; -- Shift 1 bit left for x2
datosx50<= datosx32 + datosx16 + datosx2;    -- Sum the three registers

-- Now take the bits corresponding to 10 integers and 6 decimals

TEMP<=STD_LOGIC_VECTOR(datosx50(21 downto 6)); -- Assign the corresponding bits to 
                                                 the output  

end a_ADC_a_TEMP;
