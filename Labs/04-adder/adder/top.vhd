------------------------------------------------------------------------
--
-- Implementation of 4-bit adder.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
port (
    SW0_CPLD :   in  std_logic;       -- Input A
    SW1_CPLD :   in  std_logic;
    SW2_CPLD :   in  std_logic;
    SW3_CPLD :   in  std_logic;
    SW8_CPLD :   in  std_logic;       -- Input B
    SW9_CPLD :   in  std_logic;
    SW10_CPLD :  in  std_logic;
    SW11_CPLD :  in  std_logic;
	 
	 LD15_CPLD : out  std_logic;
	 LD14_CPLD : out  std_logic;
	 LD13_CPLD : out  std_logic;
	 LD12_CPLD : out  std_logic;
	 LD11_CPLD : out  std_logic;
	 LD10_CPLD : out  std_logic;
	 LD9_CPLD : out  std_logic;
	 LD8_CPLD : out  std_logic;
	 
	 LD0_CPLD : out  std_logic;
	 LD1_CPLD : out  std_logic;
	 LD2_CPLD : out  std_logic;
	 LD3_CPLD : out  std_logic;
	 LD4_CPLD : out  std_logic;
	 
    disp_seg_o : out std_logic_vector(7-1 downto 0);
    disp_dig_o : out std_logic_vector(4-1 downto 0)
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_dataA, s_dataB : std_logic_vector(4-1 downto 0);
    signal s_carry0, s_carry1, s_carry2 : std_logic;
    signal s_result : std_logic_vector(4-1 downto 0);
    signal s_carryOut : std_logic;
begin

    -- Combine two 4-bit inputs to internal signals s_dataA and s_dataB
    -- WRITE YOUR CODE HERE

		s_dataA(0) <= SW0_CPLD;
		s_dataA(1) <= SW1_CPLD;
		s_dataA(2) <= SW2_CPLD;
		s_dataA(3) <= SW3_CPLD;
		
		s_dataB(0) <= SW8_CPLD;
		s_dataB(1) <= SW9_CPLD;
		s_dataB(2) <= SW10_CPLD;
		s_dataB(3) <= SW11_CPLD;

    --------------------------------------------------------------------
    -- Sub-blocks of four full_adders
    FULL_ADDER_0 : entity work.full_adder
    port map (
       a_i => s_dataA(0),
		 b_i => s_dataB(0),
		 carry_i => '0',
		 sum_o => s_result(0),
		 carry_o => s_carry0
    );

    FULL_ADDER_1 : entity work.full_adder
    port map (
       a_i => s_dataA(1),
		 b_i => s_dataB(1),
		 carry_i => s_carry0,
		 sum_o => s_result(1),
		 carry_o => s_carry1
    );

    FULL_ADDER_2 : entity work.full_adder
    port map (
       a_i => s_dataA(2),
		 b_i => s_dataB(2),
		 carry_i => s_carry1,
		 sum_o => s_result(2),
		 carry_o => s_carry2
    );

    FULL_ADDER_3 : entity work.full_adder
    port map (
       a_i => s_dataA(3),
		 b_i => s_dataB(3),
		 carry_i => s_carry2,
		 sum_o => s_result(3),
		 carry_o => s_carryOut
    );


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    HEX2SSEG : entity work.hex_to_7seg
    port map (
        hex_i => s_result,
        seg_o => disp_seg_o
    );

    -- Select display position
    disp_dig_o <= "1110";
	 


    -- Show carry output bit on Coolrunner-II LED
    -- WRITE YOUR CODE HERE
	 

    -- Show two 4-bit inputs on CPLD expansion LEDs
    -- WRITE YOUR CODE HERE
	 
	   LD15_CPLD <= s_dataB(3);
		LD14_CPLD <= s_dataB(2);
		LD13_CPLD <= s_dataB(1);
		LD12_CPLD <= s_dataB(0);
		
		LD11_CPLD <= s_dataA(3);
		LD10_CPLD <= s_dataA(2);
		LD9_CPLD <= s_dataA(1);
		LD8_CPLD <= s_dataA(0);
		
		LD0_CPLD <= s_result(0);
		LD1_CPLD <= s_result(1);
		LD2_CPLD <= s_result(2);
		LD3_CPLD <= s_result(3);
		
		LD4_CPLD <= s_carryOut;
		
end architecture Behavioral;