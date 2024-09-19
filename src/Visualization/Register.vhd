----------------------------------------------------------------------------------
-- 
-- Register that stores the data of DECENAS, UNIDADES, and DECIMAS
-- each time the ENABLE signal is activated
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro is
    Port ( CLK     : in   STD_LOGIC;                       -- Clock input
           ENABLE  : in   STD_LOGIC;                       -- Enable signal
           E0      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E0 input
           E1      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E1 input
           E2      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E2 input
           E3      : in   STD_LOGIC_VECTOR (3 downto 0);   -- E3 input
           Q0      : out  STD_LOGIC_VECTOR (3 downto 0);   -- Q0 output
           Q1      : out  STD_LOGIC_VECTOR (3 downto 0);   -- Q1 output
           Q2      : out  STD_LOGIC_VECTOR (3 downto 0);   -- Q2 output
           Q3      : out  STD_LOGIC_VECTOR (3 downto 0));  -- Q3 output
end registro;

architecture a_registro of registro is

signal QS0 : STD_LOGIC_VECTOR (3 downto 0):="0000"; -- Signal that stores the value 
                                                  -- of Q0
signal QS1 : STD_LOGIC_VECTOR (3 downto 0):="0000"; -- Signal that stores the value 
                                                  -- of Q1
signal QS2 : STD_LOGIC_VECTOR (3 downto 0):="0000"; -- Signal that stores the value 
                                                  -- of Q2
signal QS3 : STD_LOGIC_VECTOR (3 downto 0):="0000"; -- Signal that stores the value 
                                                  -- of Q3

begin
  process (CLK)
    begin
      if (CLK'event and CLK='1') then   -- On each active clock edge, perform the capture process
        if (ENABLE='1') then -- If enable is '1', update the auxiliary signals
            QS0 <= E0; -- Assign inputs to auxiliary signals
            QS1 <= E1;
            QS2 <= E2;
            QS3 <= E3;
        end if;
      end if;
  end process;
	 
  -- CONNECT OUTPUTS
  Q0 <= QS0; -- Assign auxiliary signals to outputs
  Q1 <= QS1;
  Q2 <= QS2;
  Q3 <= QS3;

end a_registro;
