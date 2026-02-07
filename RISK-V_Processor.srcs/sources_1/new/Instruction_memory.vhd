----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 02:30:37 PM
-- Design Name: 
-- Module Name: Instruction_memory - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_memory is
    generic (
        N : positive := 6;
        M : positive := 32
    );
    port (
        A     : in  STD_LOGIC_VECTOR (N-1 downto 0);
        Instr : out STD_LOGIC_VECTOR (M-1 downto 0)
    );
end entity Instruction_memory;

architecture Behavioral of Instruction_memory is
    type ROM_array is array (0 to (2**N) - 1) of STD_LOGIC_VECTOR (M-1 downto 0);


    constant ROM_content : ROM_array := (
        X"00A00093", X"01400113",x"002081B3",x"00302223",
        x"00402283",x"0020C333",x"40108233",x"0000F393",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000",
        x"00000000",x"00000000",x"00000000",x"00000000"
    );

begin
    Instr <= ROM_content(to_integer(unsigned(A)));

end Behavioral;
