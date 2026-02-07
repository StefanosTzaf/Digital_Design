----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 02:32:32 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is

    generic (
        N : positive := 32
    );

    Port ( 
        SrcA            : in STD_LOGIC_VECTOR (N-1 downto 0);
        SrcB            : in STD_LOGIC_VECTOR (N-1 downto 0);
        ALUControl      : in STD_LOGIC_VECTOR (2 downto 0);
        SLTUorSLT       : in STD_LOGIC;

        N_flag          : out STD_LOGIC;
        Z_flag          : out STD_LOGIC;
        C_flag          : out STD_LOGIC;
        V_flag          : out STD_LOGIC;
        ALUResult  : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
    
end ALU;

architecture Behavioral of ALU is
begin
-- Follow Esa Protocol, everything with variables inside a single process
P_ALU_COMB: process(SrcA, SrcB, ALUControl, SLTUorSLT)
        variable v_res     : signed(N-1 downto 0);
        variable v_srcA    : signed(N-1 downto 0);
        variable v_srcB    : signed(N-1 downto 0);
        variable v_flags   : std_logic_vector(3 downto 0);
        variable v_ext_res : unsigned(N downto 0);

    begin
        
        v_srcA    := signed(SrcA);
        v_srcB    := signed(SrcB);
        v_res     := (others => '0');
        v_ext_res := (others => '0');
        v_flags   := "0000";
        
        case ALUControl is
            when "000" =>
                v_res     := v_srcA + v_srcB;
                v_ext_res := unsigned('0' & std_logic_vector(v_srcA)) + unsigned('0' & std_logic_vector(v_srcB));
                                   
            when "001" =>
                v_res     := v_srcA - v_srcB;
                v_ext_res := unsigned('0' & std_logic_vector(v_srcA)) - unsigned('0' & std_logic_vector(v_srcB));

            when "100" =>
                v_res     := v_srcA and v_srcB;

            when "101" =>
                v_res     := v_srcA or v_srcB;

            when "110" | "111" =>
                v_res     := v_srcA xor v_srcB;

            when "010" =>
                if SLTUorSLT = '0' then
                    v_res := v_srcA xor v_srcB;
                else
                    v_res := v_srcA + v_srcB;
                end if;
            when others =>
                v_res     := (others => '0');
        end case;
        
        -- FLAGS
        if(ALUControl = "000" or ALUControl = "001" or (ALUControl = "010" and SLTUorSLT = '1')) then
            -- Carry flag
            if v_ext_res(N) = '1' then
                v_flags(1) := '1';
            end if;

            -- Overflow flag SUB case
            if(ALUControl = "001") then
                if((v_srcA(N-1) /= v_srcB(N-1)) and (v_res(N-1) /= v_srcA(N-1))) then
                    v_flags(0) := '1';
                end if;
            else -- ADD case
                if((v_srcA(N-1) = v_srcB(N-1)) and (v_res(N-1) /= v_srcA(N-1))) then
                    v_flags(0) := '1';
                end if;
            end if;    

            -- Zero flag
            if v_res = 0 then 
                v_flags(2) := '1'; 
            end if;

            -- Negative flag
            v_flags(3) := v_res(N-1);
        end if;
        -- write outputs
        ALUResult <= std_logic_vector(v_res);
        N_flag    <= v_flags(3);
        Z_flag    <= v_flags(2);
        C_flag    <= v_flags(1);
        V_flag    <= v_flags(0);
        
    end process P_ALU_COMB;


end Behavioral;