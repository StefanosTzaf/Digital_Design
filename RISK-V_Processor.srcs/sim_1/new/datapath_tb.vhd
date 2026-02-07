----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2026 12:32:59 AM
-- Design Name: 
-- Module Name: datapath_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Datapath_tb is
end Datapath_tb;


architecture Behavioral of Datapath_tb is

    constant N : integer := 32;

    component datapath is
        Port (
            Clk, Reset    : in  STD_LOGIC;
            PCSrc         : in  STD_LOGIC;
            RegWrite      : in  STD_LOGIC;
            ALUSrc        : in  STD_LOGIC;
            MemWrite      : in  STD_LOGIC;
            ResultSrc     : in  STD_LOGIC;
            ALUControl    : in  STD_LOGIC_VECTOR(2 downto 0);
            ImmSrc        : in  STD_LOGIC_VECTOR(1 downto 0);
            SLTUorSLT     : in  STD_LOGIC;
            inst_out      : out STD_LOGIC_VECTOR(N-1 downto 0);
            NZVC          : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;

    signal Clk_tb, Reset_tb : std_logic := '0';
    signal PCSrc_tb, RegWrite_tb, ALUSrc_tb, MemWrite_tb, ResultSrc_tb, SLTUorSLT_tb : std_logic := '0';
    signal ALUControl_tb : std_logic_vector(2 downto 0) := "000";
    signal ImmSrc_tb     : std_logic_vector(1 downto 0) := "00";
    signal inst_out_tb   : std_logic_vector(N-1 downto 0);
    signal NZVC_tb       : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    UUT: datapath
        port map (
        Clk => Clk_tb, Reset => Reset_tb,
        PCSrc => PCSrc_tb, RegWrite => RegWrite_tb, ALUSrc => ALUSrc_tb,
        MemWrite => MemWrite_tb, ResultSrc => ResultSrc_tb,
        ALUControl => ALUControl_tb, ImmSrc => ImmSrc_tb, SLTUorSLT => SLTUorSLT_tb,
        inst_out => inst_out_tb, NZVC => NZVC_tb
    );

    -- Clock Process
    clk_process: process
    begin
        Clk_tb <= '0'; wait for CLK_PERIOD/2;
        Clk_tb <= '1'; wait for CLK_PERIOD/2;
    end process;

    test: process
    begin

        Reset_tb <= '1';
        wait for 100 ns;
        Reset_tb <= '0';
        
        -- 1. ADDI x1, x0, 10
        wait until falling_edge(Clk_tb);
        PCSrc_tb     <= '0';  -- PC + 4 not branch
        RegWrite_tb   <= '1';
        ALUSrc_tb     <= '1';  -- Immediate
        MemWrite_tb   <= '0';
        ResultSrc_tb  <= '0'; -- ALU Result
        ALUControl_tb <= "000"; -- ADD
        ImmSrc_tb     <= "00"; -- I-Type
        
        ------------------------------------------------------------
        -- 2. ADDI x2, x0, 20
        wait for CLK_PERIOD;
        
        ------------------------------------------------------------
        -- 3. ADD x3, x1, x2 (Result = 30)
        wait for CLK_PERIOD;
        ALUSrc_tb     <= '0';  -- Register (x2)

        
        ------------------------------------------------------------
        -- 4. SW x3, 4(x0) (Store 30 to Mem[4])
        wait for CLK_PERIOD;
        RegWrite_tb   <= '0';
        MemWrite_tb   <= '1';  -- write to memory
        ALUSrc_tb     <= '1';  -- Immediate για διεύθυνση (0 + 4)
        ImmSrc_tb     <= "01";  -- S-Type Extension

        ------------------------------------------------------------
        -- 5. LW x5, 4(x0) (Load 30 from Mem[4] to x5)
        wait for CLK_PERIOD;
        RegWrite_tb   <= '1';
        MemWrite_tb   <= '0';
        ResultSrc_tb  <= '1'; -- Memory Data
        ImmSrc_tb     <= "00"; -- I-Type
        ALUControl_tb <= "010";
        
        ------------------------------------------------------------
        -- 6. XOR x6, x1, x2 (Result = 30)
        wait for CLK_PERIOD;
        ResultSrc_tb  <= '0'; -- alu result
        ALUSrc_tb     <= '0'; -- Register
        ALUControl_tb <= "110";
        
        ------------------------------------------------------------
        -- 7. SUB x4, x1, x1 (Result = 0) -> ZERO FLAG CHECK
        wait for CLK_PERIOD;
        ALUControl_tb <= "001";

        ------------------------------------------------------------
        -- 8. ANDI x7, x1, 0 (Result = 0)
        wait for CLK_PERIOD;
        ALUSrc_tb     <= '1';
        ALUControl_tb <= "100"; -- AND
        ImmSrc_tb     <= "00";

        wait;
    end process;

end Behavioral;
