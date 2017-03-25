----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:10:58 03/25/2017 
-- Design Name: 
-- Module Name:    read_multiple_data_bytes - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity read_multiple_data_bytes is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           next_data : in  STD_LOGIC;
           data_read : out  STD_LOGIC_VECTOR (63 downto 0));
end read_multiple_data_bytes;

architecture Behavioral of read_multiple_data_bytes is

shared variable i : integer range 0 to 10:= 0; 
signal state: std_logic := '1'; 
-- Add state signal for waiting for next input instead of reading the same input for small clock cycles.
begin
process(next_data,reset, clk)
begin
if(rising_edge(clk)) then
	if(reset = '0') then
		if(next_data = '1' and state = '1' and i<8) then 
			data_read(8*i + 7 downto 8*i) <= data_in;
			i := i + 1;
			state <= '0';
		elsif(next_data = '0' and state = '0') then
			state <= '1';
			i := i;
		end if;
	elsif(reset = '1') then
		i := 0;
	else
		i := i;
	end if;
end if;
end process;

end Behavioral;