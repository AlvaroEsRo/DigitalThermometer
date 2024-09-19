----------------------------------------------------------------------------------
-- refresh
-- Circuit that periodically refreshes the displays
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity refresco is
    Port ( CLK : in  STD_LOGIC;                         -- Refresh clock
           S   : out  STD_LOGIC_VECTOR (1 downto 0);    -- Control for the mux
           DP  : out STD_LOGIC;                         -- Decimal point control
           AN  : out  STD_LOGIC_VECTOR (3 downto 0));   -- Individual display control
end refresco;

architecture a_refresco of refresco is
signal QS : unsigned (1 downto 0):="00"; -- Create an auxiliary signal to work with
begin

  process (CLK)
    begin
     if (CLK'event and CLK='1') then -- On the clock edge
        QS<=QS+1; -- Increment QS, which takes values from 0 to 3
     end if;
  end process;

 -- Combinational logic part

 S<=STD_LOGIC_VECTOR(QS);      -- Map SCONTROL to the signal QS
 AN<="1110" when QS="00" else  -- The AN signal is mapped so that each display is activated
                     "1101" when QS="01" else      -- based on the value of QS
                     "1011" when QS="10" else      -- Displays are turned on with a '0'
                     "0111" when QS="11";          -- Place a '0' in the position of the number to be selected
 DP<='0' when QS="10" else '1';-- When QS = '10', the second display (starting from the left) is selected
                               -- thus turning on the decimal point

end a_refresco;
