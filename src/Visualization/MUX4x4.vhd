----------------------------------------------------------------------------------
-- MUX4x4

--  4-input, 4-bit Multiplexer
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4x4 is
    Port ( E0 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 0
           E1 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 1
           E2 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 2
           E3 : in  STD_LOGIC_VECTOR (3 downto 0);   -- Input 3
           S  : in  STD_LOGIC_VECTOR (1 downto 0);   -- Control signal
           Y  : out  STD_LOGIC_VECTOR (3 downto 0)); -- Output
end MUX4x4;

architecture a_MUX4x4 of MUX4x4 is

begin

with S select Y<= -- Control signal
    E0 when "00",  -- Indicates which input the MUX will select
    E1 when "01",  -- Assigns each input to the corresponding selection bit
    E2 when "10",
    E3 when others;

end a_MUX4x4;
