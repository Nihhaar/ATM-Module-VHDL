----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:15 01/25/2017 
-- Design Name: 
-- Module Name:    display_multiple_data_bytes - Behavioral 
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

entity display_multiple_data_bytes is
    Port ( clk : in  STD_LOGIC;
           reset : in STD_LOGIC;
			  data_in : in  STD_LOGIC_VECTOR (63 downto 0);
           next_data : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0) );
end display_multiple_data_bytes;

architecture Behavioral of display_multiple_data_bytes is
shared variable i: integer := 0;
signal state: std_logic :='1';
begin
process(next_data,clk)
begin
if( clk'event and clk = '0') then
	data_out <= data_in(8*i + 7 downto 8*i);
	if(reset = '0') then
		if(state='1' and next_data='1' and i<7 ) then
			state <= '0';
			i := i + 1;
		elsif(next_data='0' and state='0') then
			state <= '1';
		end if;
	elsif (reset = '1') then
			i := 0;
			data_out <= "00000000";
	end if;
else
end if;
end process;
end Behavioral;
