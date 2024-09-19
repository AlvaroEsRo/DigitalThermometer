----------------------------------------------------------------------------------
-- 
-- Receiver control automaton
-- Establishes SPI communication with the MCP3201 and acquires the sampled data
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity aut_control is
    Port ( CLK    : in  STD_LOGIC;     -- System clock
       SPI_DATA   : in  STD_LOGIC;     -- SPI data input
       SPI_CLK    : out  STD_LOGIC;    -- SPI clock output
       SPI_CS     : out  STD_LOGIC;    -- SPI Chip Select
       FIN_CONV   : out  STD_LOGIC;    -- A/D conversion end
       DATOS_ADC  : out  STD_LOGIC_VECTOR (15 downto 0)); -- Data read from ADC
end aut_control;

architecture a_aut_control  of aut_control is

type STATE_TYPE is (WAIT_1S,ACTIVATE_CS,CLK1,CLK0,DEACTIVATE_CS);

signal ST : STATE_TYPE := WAIT_1S;                 -- State signal
signal cont : unsigned (15 downto 0):=(others=>'0'); -- Counter signal
signal data : unsigned (15 downto 0):=(others=>'0'); -- Filtered input data
                               
begin

process (CLK)
  begin
  if (CLK'event and CLK='1') then -- On clock edge
    case ST is
	 
    when WAIT_1S =>              -- When STATE WAIT_1S
        cont<=cont+1;           -- Increment counter
        data<=(others=>'0');    -- Assign '0' to data 
        if cont>=1000 then      -- If counter reaches 1000
            ST<=ACTIVATE_CS;  -- Change state to ACTIVATE_CS
        else
            ST<=WAIT_1S;   -- Otherwise, remain in WAIT_1S
        end if;
			
   when ACTIVATE_CS =>
        cont<=(others=>'0'); -- Reset counter to 0
        ST<=CLK0;            -- Always move to CLK0
		  
   when CLK0 => 
        data<=data(14 downto 0) & SPI_DATA; -- Shift data left by 1 bit and
                            -- place SPI_DATA value at position 0
        cont<=cont+1; -- Increase counter 
        ST<=CLK1; -- Change to CLK1
			
    when CLK1 =>
        if (cont>=15) then ST<=DEACTIVATE_CS; -- If counter>=15, change state
        else ST<=CLK0; -- Otherwise, remain in CLK0
        end if;
			
    when DEACTIVATE_CS => 
        cont<=(others=>'0'); -- Reset counter to 0
        ST<=WAIT_1S;       -- Return to initial state
         		
    end case;
	 
  end if;
  
end process;
