--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:20:28 03/25/2017
-- Design Name:   
-- Module Name:   /home/nihhaar/Documents/VHDL/Lab01/top_tb.vhd
-- Project Name:  Lab01
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Controller_Top_Module
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Controller_Top_Module
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         data_in_sliders : IN  std_logic_vector(7 downto 0);
         next_data_in_button : IN  std_logic;
         next_data_out_button : IN  std_logic;
         start_encrypt_button : IN  std_logic;
         start_decrypt_button : IN  std_logic;
         done : OUT  std_logic;
         data_out_leds : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal data_in_sliders : std_logic_vector(7 downto 0) := (others => '0');
   signal next_data_in_button : std_logic := '0';
   signal next_data_out_button : std_logic := '0';
   signal start_encrypt_button : std_logic := '0';
   signal start_decrypt_button : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal data_out_leds : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Controller_Top_Module PORT MAP (
          clk => clk,
          reset => reset,
          data_in_sliders => data_in_sliders,
          next_data_in_button => next_data_in_button,
          next_data_out_button => next_data_out_button,
          start_encrypt_button => start_encrypt_button,
          start_decrypt_button => start_decrypt_button,
          done => done,
          data_out_leds => data_out_leds
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
