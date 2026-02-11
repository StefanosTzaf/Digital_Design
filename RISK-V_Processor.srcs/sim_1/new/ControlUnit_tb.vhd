----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2026 06:17:25 PM
-- Design Name: 
-- Module Name: ControlUnit_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit_tb is
--  Port ( );
end ControlUnit_tb;

architecture Behavioral of ControlUnit_tb is

    component ControlUnit is
        Port (
            opcode : in std_logic_vector(4 downto 0);
            funct3 : in std_logic_vector(2 downto 0);
            funct7 : in std_logic;
            NZVC   : in std_logic_vector(3 downto 0);


            ResultSrc  : out std_logic;
            MemWrite   : out std_logic;
            ALUSrc     : out std_logic;
            ImmSrc     : out std_logic_vector(1 downto 0);
            RegWrite   : out std_logic;
            ALUControl : out std_logic_vector(2 downto 0)
        );
    end component;

    signal opcode_tb     : STD_LOGIC_VECTOR(4 downto 0);
    signal funct3_tb     : STD_LOGIC_VECTOR(2 downto 0);
    signal funct7_tb     : STD_LOGIC;
    signal NZVC_tb       : STD_LOGIC_VECTOR(3 downto 0);
    signal ResultSrc_tb  : STD_LOGIC;
    signal MemWrite_tb   : STD_LOGIC;
    signal ALUSrc_tb     : STD_LOGIC;
    signal ImmSrc_tb     : STD_LOGIC_VECTOR(1 downto 0);
    signal RegWrite_tb   : STD_LOGIC;
    signal ALUControl_tb : STD_LOGIC_VECTOR(2 downto 0);


begin
    UUT: ControlUnit
        Port map (
            opcode     => opcode_tb,
            funct3     => funct3_tb,
            funct7     => funct7_tb,
            NZVC       => NZVC_tb,
            ResultSrc  => ResultSrc_tb,
            MemWrite   => MemWrite_tb,
            ALUSrc     => ALUSrc_tb,
            ImmSrc     => ImmSrc_tb,
            RegWrite   => RegWrite_tb,
            ALUControl => ALUControl_tb
        );


    test_process: process
    begin

    end process;
end Behavioral;
