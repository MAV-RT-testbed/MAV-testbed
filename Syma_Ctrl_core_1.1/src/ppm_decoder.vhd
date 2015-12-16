----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2015 10:34:39 AM
-- Design Name: 
-- Module Name: ppm_decoder - ppm_decoder_behavioral
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

entity ppm_decoder is
    Port ( 
           clk : in std_logic;
           ppm_in : in STD_LOGIC;
           ppm_out_1 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           ppm_out_2 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           ppm_out_3 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           ppm_out_4 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           ppm_out_5 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           ppm_out_6 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           ppm_out_7 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           ppm_out_8 : out STD_LOGIC_VECTOR (31 downto 0) := x"00_00_00_00";
           intr_1    : out std_logic := '0';
           intr_comp : out std_logic := '0');
           
 --          ppm_sample : inout std_logic_vector (1 downto 0) := "00";
 --          counter : inout unsigned (31 downto 0) := x"00_00_00_00";
 --          reg_nr : inout unsigned (3 downto 0) := "0000");
end ppm_decoder;

architecture ppm_decoder_behavioral of ppm_decoder is
  signal ppm_sample : std_ulogic_vector (1 downto 0) := "00";
  signal counter : unsigned (31 downto 0) := x"00_00_00_00";
  signal reg_nr : unsigned (3 downto 0) := "0000";
  signal counter_valid : std_logic := '0';
  signal reg_nr_last : unsigned (3 downto 0) := "0000";

begin
ppm_edge_detection: process (clk)
  begin
    if rising_edge(clk) then
      ppm_sample(1) <= ppm_sample(0);   -- record last ppm signal level in ppm_sample(1)
      ppm_sample(0) <= ppm_in;          -- record current ppm signal level in ppm_sample(0)
      
      case ppm_sample is
        when "11" =>        -- signal level high, reset counter to "0"
          counter <= (others => '0');
          counter_valid <= '0';
        when "10" =>        -- falling edge -> start counting
          counter <= x"00_00_00_01";
          counter_valid <= '0';
        when "00" =>        -- signal level is high -> count until overrun detected
          if counter < x"00_03_00_00" then 
            counter <= counter + 1;
          end if;
          counter_valid <= '0';
        when "01" =>        -- rising edge -> save counter value to corresponding register, reset on counter "overflow"
          if counter = x"00_03_00_00" then 
            reg_nr <= "0000";
          else
            reg_nr <= reg_nr + 1;
          end if;
        counter_valid <= '1'
        ;
        when others =>
          ppm_sample <= "11";
          counter_valid <= '0';
      end case;

    end if;
  end process;

rigister_write: process (clk)
  begin
    if rising_edge(clk) and counter_valid = '1' then
      case reg_nr is
        -- when "0000" =>; in this case an overrun occured and there is no valid value
        when "0001" =>
          ppm_out_1 <= std_logic_vector(counter);
        when "0010" =>
          ppm_out_2 <= std_logic_vector(counter);
        when "0011" =>
          ppm_out_3 <= std_logic_vector(counter);
        when "0100" =>
          ppm_out_4 <= std_logic_vector(counter);
        when "0101" =>
          ppm_out_5 <= std_logic_vector(counter);
        when "0110" =>
          ppm_out_6 <= std_logic_vector(counter);
        when "0111" =>
          ppm_out_7 <= std_logic_vector(counter);
        when "1000" =>
          ppm_out_8 <= std_logic_vector(counter);
        when others =>
          -- the values should be saved when not altered -> latches should be generated
      end case;
    end if;
  end process;
  
interrupt: process (clk)
  begin
    if rising_edge(clk) then
    
      if reg_nr /= "0000" and reg_nr /= reg_nr_last then
        intr_1 <= '1';
      else
        intr_1 <= '0';
      end if;
      
      if reg_nr = "0000" and reg_nr /= reg_nr_last then
        intr_comp <= '1';
      else 
        intr_comp <= '1';
      end if;
      reg_nr_last <= reg_nr;
    end if;
    
  end process; --interrupt
  
end ppm_decoder_behavioral;
