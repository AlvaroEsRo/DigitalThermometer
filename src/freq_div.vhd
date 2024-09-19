----------------------------------------------------------------------------------
--
-- Clock frequency divider to 1 KHz.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity div_reloj is
    Port ( CLK_50MHz : in  STD_LOGIC;     -- 50 MHz FPGA clock input
           CLK       : out  STD_LOGIC);   -- 1 KHz clock output
end div_reloj;

architecture a_div_reloj of div_reloj is

signal contador : unsigned (31 downto 0); -- Counter
signal frec_div : STD_LOGIC;              -- Divided frequency signal

begin

process(CLK_50MHz)
  begin
  if (CLK_50MHz'event and CLK_50MHz='1') then -- On each rising edge
    contador<=contador+1; 			-- Increment counter
	 if (contador>=25000) then                 -- Half-period of 500 µs, Maximum value
	   contador<=(others=>'0'); 		       -- Reset the counter to '0'
		frec_div<=not frec_div;             -- Toggle the value of frec_div
	 end if;
  end if;

  end process;
  
CLK<=frec_div; -- Assign frec_div as output

end a_div_reloj;
