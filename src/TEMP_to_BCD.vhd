----------------------------------------------------------------------------------
-- 
-- Converts 16 bits in fixed-point with 10 integers and 6 decimals to BCD
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TEMP_a_BCD is
    Port ( TEMP     : in  STD_LOGIC_VECTOR (15 downto 0);  -- Temperature with 6 bits 
                                                              decimal part
           DECENAS  : out  STD_LOGIC_VECTOR (3 downto 0);  -- Tens in BCD
           UNIDADES : out  STD_LOGIC_VECTOR (3 downto 0);  -- Units in BCD
           DECIMAS  : out  STD_LOGIC_VECTOR (3 downto 0)); -- Decimals in BCD 
end TEMP_a_BCD;

architecture a_TEMP_a_BCD of TEMP_a_BCD is

signal ENT    : unsigned (9 downto 0):="0000000000";  -- Integer part of the temperature
signal DEC    : unsigned (5 downto 0):="000000";      -- Decimal part of the temperature
signal s_unid : unsigned (9 downto 0):="0000000000";  -- Units of the temperature

begin

-- Separate integer part and decimal part

ENT<= unsigned(TEMP(15 downto 6));
DEC<= unsigned(TEMP(5 downto 0));

-- Tens are determined based on the value range where the temperature falls

DECENAS<= "1001" when ENT>="0001011010" else -- Integer >= 90 then DECENAS = 9
          "1000" when ENT>="0001010000" else -- Integer >= 80 then DECENAS = 8
          "0111" when ENT>="0001000110" else -- Integer >= 70 then DECENAS = 7
          "0110" when ENT>="0000111100" else -- Integer >= 60 then DECENAS = 6
          "0101" when ENT>="0000110010" else -- Integer >= 50 then DECENAS = 5
          "0100" when ENT>="0000101000" else -- Integer >= 40 then DECENAS = 4
          "0011" when ENT>="0000011110" else -- Integer >= 30 then DECENAS = 3
          "0010" when ENT>="0000010100" else -- Integer >= 20 then DECENAS = 2
          "0001" when ENT>="0000001010" else -- Integer >= 10 then DECENAS = 1
          "0000";                            -- Otherwise, DECENAS = 0
-- Units are determined by subtracting the tens from the temperature value.

s_unid<= ENT-"0001011010" when ENT>="0001011010" else -- Integer >= 90, Uni = ENT-90
         ENT-"0001010000" when ENT>="0001010000" else -- Integer >= 80, Uni = ENT-80
         ENT-"0001000110" when ENT>="0001000110" else -- Integer >= 70, Uni = ENT-70
         ENT-"0000111100" when ENT>="0000111100" else -- Integer >= 60, Uni = ENT-60
         ENT-"0000110010" when ENT>="0000110010" else -- Integer >= 50, Uni = ENT-50
         ENT-"0000101000" when ENT>="0000101000" else -- Integer >= 40, Uni = ENT-40
         ENT-"0000011110" when ENT>="0000011110" else -- Integer >= 30, Uni = ENT-30
         ENT-"0000010100" when ENT>="0000010100" else -- Integer >= 20, Uni = ENT-20
         ENT-"0000001010" when ENT>="0000001010" else -- Integer >= 10, Uni = ENT-10
         ENT;                                         -- Otherwise, Uni = ENT 
			 
-- For the decimal part, determine which decimal (between 10 values from 0 to 9)  
-- according to the 6-bit binary value between 0 and 64

DECIMAS<= "0000" when DEC<"000110" else -- If DEC < 6, DEC = 0
         "0001" when DEC<"001100" else -- If DEC < 12, DEC = 1
         "0010" when DEC<"010010" else -- If DEC < 18, DEC = 2
         "0011" when DEC<"011000" else -- If DEC < 24, DEC = 3
         "0100" when DEC<"011110" else -- If DEC < 30, DEC = 4
         "0101" when DEC<"100100" else -- If DEC < 36, DEC = 5
         "0110" when DEC<"101010" else -- If DEC < 42, DEC = 6
         "0111" when DEC<"110000" else -- If DEC < 48, DEC = 7
         "1000" when DEC<"110110" else -- If DEC < 54, DEC = 8
         "1001";                       -- Otherwise, DEC = 9
         
-- Assign the signal used for calculating units to the units output signal
		
UNIDADES<= STD_LOGIC_VECTOR(s_unid(3 downto 0)); 

end a_TEMP_a_BCD;
