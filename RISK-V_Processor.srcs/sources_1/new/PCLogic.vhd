----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 09:14:47 PM
-- Design Name: 
-- Module Name: PCLogic - Behavioral
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

entity PCLogic is
    Port ( 
        funct3 : in STD_LOGIC_VECTOR(2 downto 0);
        rop    : in STD_LOGIC_VECTOR(2 downto 0);
        NZVC   : in STD_LOGIC_VECTOR(3 downto 0);
        PCSrc  : out STD_LOGIC
    );
end PCLogic;

architecture Behavioral of PCLogic is

begin

    Process(rop, funct3, NZVC)
        variable funct3_v : STD_LOGIC_VECTOR(2 downto 0);
        variable rop_v    : STD_LOGIC_VECTOR(2 downto 0);
        variable NZVC_v   : STD_LOGIC_VECTOR(3 downto 0);
        variable PCSrc_v  : STD_LOGIC;
    begin
        funct3_v := funct3;
        rop_v    := rop;
        NZVC_v   := NZVC;
        PCSrc_v  := '0'; -- default value

        case rop_v is
            when "000" | "001" | "010" | "011" =>
                PCSrc_v := '0'; 
            when others =>
                PCSrc_v := '0';
        end case;
        PCSrc <= PCSrc_v;
    end Process; 
        
        
end Behavioral;