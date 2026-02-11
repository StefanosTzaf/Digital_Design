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
            RegWrite      : in  STD_LOGIC;
            ALUSrc        : in  STD_LOGIC;
            MemWrite      : in  STD_LOGIC;
            ResultSrc     : in  STD_LOGIC;
            ALUControl    : in  STD_LOGIC_VECTOR(2 downto 0);
            ImmSrc        : in  STD_LOGIC_VECTOR(1 downto 0);
            NZVC          : out STD_LOGIC_VECTOR(3 downto 0);
            
            PC_out        : out STD_LOGIC_VECTOR(N-1 downto 0);
            Instr_out     : out STD_LOGIC_VECTOR(N-1 downto 0);
            ALUResult_out : out STD_LOGIC_VECTOR(N-1 downto 0);
            WriteData_out : out STD_LOGIC_VECTOR(N-1 downto 0);
            Result_out    : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
    end component;

    signal Clk_tb, Reset_tb : STD_LOGIC := '0';
    signal RegWrite_tb, ALUSrc_tb, MemWrite_tb, ResultSrc_tb: std_logic := '0';
    signal ALUControl_tb : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal ImmSrc_tb     : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal NZVC_tb       : STD_LOGIC_VECTOR(3 downto 0);
    
    signal PC_out_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Instr_out_tb     : STD_LOGIC_VECTOR(N-1 downto 0);
    signal ALUResult_out_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    signal WriteData_out_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Result_out_tb    : STD_LOGIC_VECTOR(N-1 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    UUT: datapath
        port map (
            Clk           => Clk_tb,
            Reset         => Reset_tb,
            RegWrite      => RegWrite_tb,
            ALUSrc        => ALUSrc_tb,
            MemWrite      => MemWrite_tb,
            ResultSrc     => ResultSrc_tb,
            ALUControl    => ALUControl_tb,
            ImmSrc        => ImmSrc_tb,
            NZVC          => NZVC_tb,
            PC_out        => PC_out_tb,
            Instr_out     => Instr_out_tb,
            ALUResult_out => ALUResult_out_tb,
            WriteData_out => WriteData_out_tb,
            Result_out    => Result_out_tb
        );

    clk_process: process
    begin
        Clk_tb <= '0'; 
        wait for CLK_PERIOD/2;
        Clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    test: process
    begin

        Reset_tb <= '1';
        wait for 100 ns;
        Reset_tb <= '0';
        
        ResultSrc_tb <= '0';
        MemWrite_tb  <= '0';
        ALUSrc_tb    <= '0';
        ImmSrc_tb    <= "00";
        RegWrite_tb  <= '0';

        -- 1. ADDI x1, x0, 10
        wait until falling_edge(Clk_tb);
        RegWrite_tb   <= '1';
        ALUSrc_tb     <= '1';  -- Immediate

        ------------------------------------------------------------
        -- 2. ADDI x2, x0, 22
        wait for CLK_PERIOD;
        
        ------------------------------------------------------------
        -- 3. ADD x3, x1, x2 (Result = 32)
        wait for CLK_PERIOD;
        ALUSrc_tb     <= '0';  -- Register (x2)

        -- 4. SUB x4, x2, x1 (Result = 12)
        wait for CLK_PERIOD;

        -- 5. OR x5, x1, x2 (Result = 30)
        wait for CLK_PERIOD;

        -- 6. AND x6, x1, x2 (Result = 2)
        wait for CLK_PERIOD;

        -- 7. XOR x7, x1, x2 (Result = 28)
        wait for CLK_PERIOD;

        

        wait;
    end process;

end Behavioral;
