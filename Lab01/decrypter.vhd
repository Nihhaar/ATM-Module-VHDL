----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:17:39 01/26/2017 
-- Design Name: 
-- Module Name:    decrypter - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decrypter is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           ciphertext : in  STD_LOGIC_VECTOR (63 downto 0);
           start : in  STD_LOGIC;
           plaintext : out  STD_LOGIC_VECTOR (63 downto 0);
           done : out  STD_LOGIC);
end decrypter;

architecture Behavioral of decrypter is

signal v0: std_logic_vector(31 downto 0) ;
signal v1: std_logic_vector(31 downto 0) ;
constant delta: std_logic_vector(31 downto 0) :=x"9e3779b9";

constant k0: std_logic_vector(31 downto 0) :=x"ff0f7457";
constant k1: std_logic_vector(31 downto 0) :=x"43fd99f7";
constant k2: std_logic_vector(31 downto 0) :=x"75f8c48f";
constant k3: std_logic_vector(31 downto 0) :=x"2927c18c";
signal i: std_logic_vector(6 downto 0):= "0000000";   -- variable used to execute statements in required ordered
signal sum : std_logic_vector(31 downto 0):= x"c6ef3720";
signal temp : std_logic := '0';    -- state variable to decect start of decrtption 

begin
process(clk,reset)
begin
if(rising_edge(clk)) then
done <= '1';
if(start = '1' and reset = '0') then
	if(temp = '0') then             -- after start initializes v0 and v1
		v0 <= ciphertext(31 downto 0);
		v1 <= ciphertext(63 downto 32);
		done <= '0';
		temp <= '1';
		sum <= sum;
		i <= i;
	elsif(i < "1000000" and i(0) = '1') then
		sum <= sum - delta;
		v0 <= v0 - (((v1(27 downto 0)&"0000") + k0) XOR (v1 + sum) XOR (("00000" &(v1(31 downto 5)) + k1)));
		i <= i + "0000001";
		temp <= temp;
		v1 <= v1;
		
	elsif(i < "1000000" and i(0) = '0') then
		v1 <= v1 - (((v0(27 downto 0)&"0000") + k2) XOR (v0 + sum) XOR (("00000" &(v0(31 downto 5)) + k3)));
		i <= i + "0000001";
		temp <= temp;
		v0 <= v0;
		sum <= sum;
	elsif (i = "1000000") then
		plaintext(31 downto 0) <= v0;
		plaintext(63 downto 32) <= v1;
		v0 <= v0;
		v1 <= v1;
		sum <= sum;
		temp <= temp;
		i <= i;
		done <= '1';
	else
	end if;
elsif (reset = '1') then
	done <= '1';
	i <= "0000000";
	sum <= x"c6ef3720";
	temp <= '0';
	v0 <= v0;
	v1 <= v1;
	
else
end if;
else
end if;
end process;


end Behavioral;

