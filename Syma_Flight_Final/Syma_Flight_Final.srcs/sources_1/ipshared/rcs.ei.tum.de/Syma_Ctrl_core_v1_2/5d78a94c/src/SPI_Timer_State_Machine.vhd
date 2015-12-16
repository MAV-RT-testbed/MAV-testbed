----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2015 10:13:14 AM
-- Design Name: 
-- Module Name: SPI_Timer - Behavioral
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

entity spi_timer is
  Port ( 
    clk : in std_logic;
    axi_done : std_logic;
    axi_start : out std_logic;
    axi_data : out std_logic_vector (7 downto 0) := (x"00");
    axi_addr : out std_logic_vector (7 downto 0) := (x"00");
    slave_cr : in std_logic_vector (7 downto 0);
    slave_sr : out std_logic_vector (7 downto 0) := (x"00");
    slave_flight : in std_logic_vector (31 downto 0);
    ss_init : out std_logic := '0'  -- ss init signal needed by transmitter module, logical or with ss in board design
  ); 
end spi_timer;

architecture spi_timer_behavioral of spi_timer is
  -- state machine states
  type state_type is (idle, init_spi, init_transmit, send_idle_msg, binding, flying);

  shared variable cnt_trigger : std_logic := '0';
  signal axi_start_buf : std_logic := '0';
  signal state   : state_type := idle;


  -- global variables
  shared variable cnt_val : unsigned (23 downto 0) := x"FF_FF_FF";
  signal trigger_nbr : integer range 0 to 15;
  signal axi_done_sample : std_ulogic_vector (1 downto 0) := "00";

begin

  -- main state machine to handle the timings, adresses and data to be sent
  main_sm_p: process(clk)
    -- state machine variables
    variable delay_idx : integer range 0 to 255;
    variable txn_idx : integer range 0 to 255;
    variable axi_sample_nbr : integer range 0 to 255;

    -- declaration of delays, messages and addresses
    -- constants and types
    constant delay_width_c : integer := 24;
    constant data_width_c : integer := 8;
    constant addr_width_C : integer := 8;
    constant init_spi_nbr_c : integer := 4;
    constant init_transmit_nbr_c : integer := 197;
    constant msg_nbr_c : integer := 19;
    constant binding_nbr_c : integer := 6;
    variable msg_ctr_idx : integer range 0 to data_width_c-1 := 0;
    subtype delay_t is unsigned(delay_width_c-1 downto 0);
    subtype data_t is std_logic_vector(data_width_c-1 downto 0);
    subtype addr_t is std_logic_vector(addr_width_c-1 downto 0);
    type init_spi_delay_t is array (0 to init_spi_nbr_c-1) of delay_t;
    type init_spi_data_t is array (0 to init_spi_nbr_c-1) of data_t;
    type init_spi_addr_t is array (0 to init_spi_nbr_c-1) of addr_t;
    type init_transmit_delay_t is array (0 to init_transmit_nbr_c-1) of delay_t;
    type init_transmit_data_t is array (0 to init_transmit_nbr_c-1) of data_t;
    type msg_delay_t is array (0 to msg_nbr_c-1) of delay_t;
    type msg_data_t is array (0 to msg_nbr_c-1) of data_t;
    type binding_delay_t is array (0 to binding_nbr_c-1) of delay_t;
    type binding_data_t is array (0 to binding_nbr_c-1) of data_t;
    type msg_ctr_t is array (0 to 7) of data_t;
    
    constant idle_msg_ctr : msg_ctr_t :=   
    (x"48",
     x"30",
     x"30",
     x"40",
     x"40",
     x"09",
     x"09",
     x"4B"
    );

    constant msg_ctr : msg_ctr_t :=       
    (x"39",
     x"21",
     x"21",
     x"41",
     x"41",
     x"19",
     x"19",
     x"39"
    );

    constant init_spi_delay_c :init_spi_delay_t :=  
    (x"00_FF_FF",
     x"00_FF_FF",
     x"00_FF_FF",
     x"4E_8F_9F"
    );
    constant init_spi_data_c : init_spi_data_t :=   
    (x"0a",
     x"67",
     x"00",
     x"00"
    );
    constant init_spi_addr_c : init_spi_addr_t :=   
    (x"40",
     x"60",
     x"70",
     x"70"
    );
  constant transmitt_addr_c : addr_t := x"68";
  constant init_transmit_delay_c :init_transmit_delay_t :=  
    (
    -- 1 - 10
    x"00_00_03",
    x"00_00_0D",
    x"00_20_92",
    x"00_00_0C",
    x"00_20_92",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    x"00_20_92",
    x"00_00_0C",
    -- 11 - 20
    x"00_20_92",
    x"00_00_0C",
    x"00_20_92",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    x"00_20_92",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    --21 - 30
    x"00_20_91",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0D",
    x"00_20_92",
    x"00_00_0C",
    x"00_20_92",
    x"00_00_0C",
    --31 - 40
    x"00_20_92",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    x"00_20_90",
    x"00_00_0C",
    --41 - 50
    x"00_20_91",
    x"00_00_0C",
    x"00_20_91",
    x"00_00_0C",
    x"00_20_4F",
    x"00_0C_58",
    x"00_0C_70",
    x"00_0C_71",
    x"00_0C_70",
    x"00_0C_70",
    --51 - 60
    x"00_20_4F",
    x"00_0C_0C",
    x"00_12_0B",
    x"00_0C_0C",
    x"00_20_4E",
    x"00_0C_58",
    x"00_0C_70",
    x"00_0C_71",
    x"00_0C_70",
    x"00_21_B2",
    --61 - 70
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_71",
    x"00_24_B3",
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_71",
    x"00_24_B2",
    --71 - 80
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_71",
    x"00_24_B3",
    x"00_0C_58",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_71",
    x"00_24_B4",
    --81 - 90
    x"00_0C_59",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    x"00_24_B3",
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_71",
    x"00_24_B1",
    --91 - 100
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_71",
    x"00_24_B1",
    x"00_0C_57",
    x"00_0C_70",
    x"00_0C_71",
    x"00_0C_71",
    x"00_24_98",
    --101 - 110
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_72",
    x"00_0C_71",
    x"00_24_B2",
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_72",
    x"00_0C_71",
    x"00_24_B2",
    x"00_0C_58",
    --111 - 120
    x"00_0C_72",
    x"00_0C_71",
    x"00_0C_71",
    x"00_24_B2",
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_72",
    x"00_24_B3",
    x"00_0C_59",
    --121 130
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    x"00_24_C9",
    x"00_0C_59",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    --131 - 140
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    x"00_1F_D3",
    x"00_0C_59",
    x"00_0C_72",
    x"00_0C_72",
    x"00_0C_72",
    --141 - 150
    x"00_14_D2",
    x"00_0C_58",
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_71",
    x"4E_D4_A2",
    x"00_0C_0C",
    x"00_12_3A",
    x"00_0C_0C",
    x"00_12_53",
    -- 151 - 160
    x"00_0C_0D",
    x"00_12_A4",
    x"00_0C_0C",
    x"00_12_D6",
    x"00_0C_0C",
    x"00_12_8A",
    x"00_0C_0C",
    x"00_12_EF",
    x"00_0C_0D",
    x"00_12_BD",
    -- 161 - 170
    x"00_0C_0C",
    x"00_12_BD",
    x"00_0C_0C",
    x"00_12_08",
    x"00_0C_57",
    x"00_0C_71",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_71",
    x"00_0C_70",
    -- 171 - 180
    x"00_0C_71",
    x"00_0C_71",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    --181 - 190
    x"11_00_A7",
    x"00_0C_0C",
    x"00_10_85",
    x"00_0C_0B",
    x"00_11_94",
    x"00_0C_49",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_71",
    x"00_0C_39",
    --191 - 196
    x"00_0C_71",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70",
    x"00_0C_70"
    );
    constant init_transmit_data_c : init_transmit_data_t :=   
    (x"07",
     x"00",
     x"20",
     x"0C",
     x"21",
     x"00",
     x"22",
     x"3F",
     x"23",
     x"03",
     x"24",
     x"FF",
     x"25",
     x"01",
     x"26",
     x"27",
     x"27",
     x"70",
     x"28",
     x"00",
     x"29",
     x"00",
     x"2C",
     x"C3",
     x"2D",
     x"C4",
     x"2E",
     x"C5",
     x"2F",
     x"C6",
     x"31",
     x"0A",
     x"32",
     x"0A",
     x"36",
     x"0A",
     x"34",
     x"0A",
     x"35",
     x"0A",
     x"36",
     x"0A",
     x"37",
     x"00",
     x"30",
     x"AB",
     x"AC",
     x"AD",
     x"AE",
     x"AF",
     x"07",
     x"00",
     x"50",
     x"53",
     x"20",
     x"40",
     x"4B",
     x"01",
     x"E2",
     x"21",
     x"C0",
     x"4B",
     x"00",
     x"00",
     x"22",
     x"D0",
     x"FC",
     x"8C",
     x"02",
     x"23",
     x"99",
     x"00",
     x"39",
     x"21",
     x"24",
     x"F9",
     x"96",
     x"8A",
     x"DB",
     x"25",
     x"24",
     x"06",
     x"0F",
     x"B6",
     x"26",
     x"00",
     x"00",
     x"00",
     x"00",
     x"27",
     x"00",
     x"00",
     x"00",
     x"00",
     x"28",
     x"00",
     x"00",
     x"00",
     x"00",
     x"29",
     x"00",
     x"00",
     x"00",
     x"00",
     x"2A",
     x"00",
     x"00",
     x"00",
     x"00",
     x"2B",
     x"00",
     x"00",
     x"00",
     x"00",
     x"2C",
     x"00",
     x"12",
     x"73",
     x"05",
     x"2D",
     x"36",
     x"B4",
     x"80",
     x"00",
     x"2E",
     x"41",
     x"20",
     x"08",
     x"04",
     x"81",
     x"20",
     x"CF",
     x"F7",
     x"FE",
     x"FF",
     x"FF",
     x"24",
     x"FF",
     x"96",
     x"8A",
     x"DB",
     x"24",
     x"F9",
     x"96",
     x"8A",
     x"DB",
     x"07",
     x"00",
     x"50",
     x"53",
     x"E1",
     x"00",
     x"07",
     x"00",
     x"27",
     x"0E",
     x"00",
     x"00",
     x"20",
     x"0C",
     x"20",
     x"0C",
     x"20",
     x"0E",
     x"A0",
     x"F9",
     x"96",
     x"8A",
     x"DB",
     x"81",
     x"20",
     x"CF",
     x"F7",
     x"FE",
     x"FF",
     x"FF",
     x"00",
     x"00",
     x"00",
     x"00",
     x"00",
     x"25",
     x"4B",
     x"E1",
     x"00",
     x"A0",
     x"A2",
     x"00",
     x"05",
     x"30",
     x"FF",
     x"AA",
     x"AA",
     x"AA",
     x"00",
     x"17",
     x"00"
    );
    constant msg_delay_c : msg_delay_t :=  
    (x"00_0C_0E",
      x"00_10_70",
      x"00_0C_0E",
      x"00_12_42",
      x"00_0C_0D",
      x"00_10_45",
      x"00_0C_70",
      x"00_13_88",
      x"00_0C_59",
      x"00_0C_3C",
      x"00_0C_72",
      x"00_0C_69",
      x"00_0C_3C",
      x"00_0C_72",
      x"00_0C_72",
      x"00_0C_72",
      x"00_0C_3C",
      x"00_0C_72",
      x"05_3E_F5"
    );
    variable idle_msg_data_c : msg_data_t :=  
    (x"07",
     x"00",
     x"27",
     x"2E",
     x"25",
     x"4B",
     x"E1",
     x"00",
     x"A0",
     x"A2",
     x"00",
     x"05",
     x"30",
     x"FF",
     x"AA",
     x"AA",
     x"AA",
     x"00",
     x"17"
    );
    constant binding_delay_c : binding_delay_t :=  
    (x"00_0C_5C",
      x"00_0C_75",
      x"00_0C_74",
      x"00_0C_74",
      x"00_0C_74",
      x"02_F7_39"
    );
-- To be reevaluated: only 5?
    constant binding_data_c : binding_data_t :=  
    (x"30",
     x"FF",
     x"30",
     x"05",
     x"00",
     x"A2"
    );
    variable flying_data_c : msg_data_t :=  
    (x"07",
     x"00",
     x"27",
     x"2E",
     x"25",
     x"39",
     x"E1",
     x"00",
     x"A0",
     x"00",
     x"00",
     x"00",
     x"00",
     x"00",
     x"4C",
     x"00",
     x"00",
     x"00",
     x"95"
    );


  begin
    if(rising_edge(clk)) then
      case state is
        when idle =>
          axi_data <= init_spi_data_c(txn_idx);
          axi_addr <= init_spi_addr_c(txn_idx);
          cnt_val := x"FF_FF_FF";
          trigger_nbr <= 0;
          axi_sample_nbr := 0;
          ss_init <= '1';

          if slave_cr(0) = '1' then
            state <= init_spi;
            cnt_val := init_spi_delay_c(delay_idx);      -- set counter to next value
            ss_init <= '1';
          end if;
  
        when init_spi =>
          ss_init <= '1';
          -- address and data assignment
          if axi_done_sample = "01" then        -- rising edge -> increment transmission index
            txn_idx := txn_idx+1;
            axi_sample_nbr := axi_sample_nbr+1;
          end if;
          if txn_idx < init_spi_nbr_c then
            axi_data <= init_spi_data_c(txn_idx);   -- new data
            axi_addr <= init_spi_addr_c(txn_idx);   -- new address
          else 
            txn_idx := 0;
            axi_data <= init_transmit_data_c(txn_idx);   -- new data
            axi_addr <= transmitt_addr_c;   -- Spi transmit register, stays until reset
          end if;
          -- timing assignment
          if (cnt_trigger = '1') then
            cnt_trigger := '0';
            delay_idx := delay_idx+1;                     -- increase index
            trigger_nbr <= trigger_nbr + 1;               -- initiate next transmission
            if delay_idx < init_spi_nbr_c then            -- counter ran down
              cnt_val := init_spi_delay_c(delay_idx);  -- set counter to next vale
            end if;
          end if;
          --Spi init done, go to next state          
          if axi_sample_nbr >= init_spi_nbr_c then
            state <= init_transmit;
            delay_idx := 0;
            cnt_val := init_transmit_delay_c(delay_idx);  -- set counter to next value
            ss_init <= '0';                             -- ss init is done
          end if;
  
        when init_transmit =>
          ss_init <= '0'; 
          -- address and data assignment
          if axi_done_sample = "01" then        -- rising edge -> increment transmission index
            txn_idx := txn_idx+1;
          end if;
          if (txn_idx < init_transmit_nbr_c) then
            axi_data <= init_transmit_data_c(txn_idx);   -- new data
          else 
            txn_idx := 0;
            axi_data <= idle_msg_data_c(txn_idx);   -- new data
          end if;
          -- timing assignment
          if (cnt_trigger = '1') then
            cnt_trigger := '0';
            delay_idx := delay_idx+1;                     -- increase index
            trigger_nbr <= trigger_nbr + 1;               -- initiate next transmission
            if delay_idx < init_transmit_nbr_c then       -- counter ran down
              cnt_val := init_transmit_delay_c(delay_idx);  -- set counter to next vale
          -- init_transmit is done, go to idle_message
            else
              state <= send_idle_msg;
              delay_idx := 0;
              cnt_val := msg_delay_c(delay_idx);  -- set counter to next value
            end if;
          end if;
  
        when send_idle_msg =>
          -- address and data assignment
          if axi_done_sample = "01" then        -- rising edge -> increment transmission index
            txn_idx := txn_idx+1;
          end if;
          if txn_idx = 5 then
            axi_data <= idle_msg_ctr(msg_ctr_idx);
            if msg_ctr_idx = 7 then
              msg_ctr_idx := 0;
            else
              msg_ctr_idx := msg_ctr_idx + 1;
            end if;
          elsif txn_idx < msg_nbr_c then
            axi_data <= idle_msg_data_c(txn_idx);   -- new data
          else 
            txn_idx := 0;
            axi_data <= idle_msg_data_c(txn_idx);   -- new data
          end if;
          -- timing assignment
          if (cnt_trigger = '1') then
            cnt_trigger := '0';
            delay_idx := delay_idx+1;                         -- increase index
            trigger_nbr <= trigger_nbr + 1;                   -- initiate next transmission
            if delay_idx < msg_nbr_c then                     -- counter ran down
              cnt_val := msg_delay_c(delay_idx);  -- set counter to next vale
            elsif slave_cr(3) = '1' then   -- idle message sent and binding was requestet
              state <= binding;
              delay_idx := 0;
              cnt_val := binding_delay_c(delay_idx);  -- set counter to next value
          -- idle message was sent, send next one
            else
              delay_idx := 0;
              cnt_val := msg_delay_c(delay_idx);  -- set counter to next value
            end if;
          end if;
  
        when binding =>
          -- address and data assignment
          if axi_done_sample = "01" then        -- rising edge -> increment transmission index
            txn_idx := txn_idx+1;
          end if;
          if txn_idx < binding_nbr_c then
            axi_data <= binding_data_c(txn_idx);   -- new data
          else 
            txn_idx := 0;
            axi_data <= idle_msg_data_c(txn_idx);   -- new data
          end if;
          -- timing assignment
          if (cnt_trigger = '1') then
            cnt_trigger := '0';
            delay_idx := delay_idx+1;                             -- increase index
            trigger_nbr <= trigger_nbr + 1;                     -- initiate next transmission
            if delay_idx < binding_nbr_c then                     -- counter ran down
              cnt_val := binding_delay_c(delay_idx);  -- set counter to next vale
            else   -- binding is done, go to next state
              state <= flying;
              delay_idx := 0;
              cnt_val := msg_delay_c(delay_idx);  -- set counter to next value
            end if;
          end if;
  
        when flying =>
          -- address and data assignment
          if axi_done_sample = "01" then        -- rising edge -> increment transmission index
            txn_idx := txn_idx+1;
          end if;
          -- calculate new data
          if txn_idx = 0 then
            flying_data_c(9) := slave_flight(31 downto 24);
            flying_data_c(10) := slave_flight(23 downto 16);
            flying_data_c(11) := slave_flight(15 downto 8);
            flying_data_c(12) := slave_flight(7 downto 0);
            flying_data_c(18) :=
              flying_data_c(9) xor flying_data_c(10) xor 
              flying_data_c(11) xor flying_data_c(12) xor 
              flying_data_c(13) xor flying_data_c(14) xor 
              flying_data_c(15) xor flying_data_c(16) xor 
              flying_data_c(17); 
            flying_data_c(18) := std_logic_vector( unsigned(flying_data_c(18)) + 85);
            flying_data_c(5) := msg_ctr(msg_ctr_idx);
            if msg_ctr_idx = 7 then
              msg_ctr_idx := 0;
            else
              msg_ctr_idx := msg_ctr_idx + 1;
            end if;
          end if;
          if txn_idx >= msg_nbr_c then
            txn_idx := 0;
          end if;
          axi_data <= flying_data_c(txn_idx);   -- new data
          -- timing assignment
          if (cnt_trigger = '1') then
            cnt_trigger := '0';
            delay_idx := delay_idx+1;                         -- increase index
            trigger_nbr <= trigger_nbr + 1;                   -- initiate next transmission
            if delay_idx < msg_nbr_c then                     -- counter ran down
              cnt_val := msg_delay_c(delay_idx);  -- set counter to next vale
            else                                              -- control message is sent, send next one
              delay_idx := 0;
              cnt_val := msg_delay_c(delay_idx);  -- set counter to next value
            end if;
          end if;
  
        when others =>
          state <= idle;
  
      end case;
      
     case cnt_val is
        when x"00_00_00" =>         -- counter ran down to 0
          cnt_trigger :='1';        -- trigger next transmission
          cnt_val := x"FF_FF_FF";   -- stop timer
        when x"FF_FF_FF" =>
          cnt_trigger := '0';       -- do nothing, the counter is stopped
          cnt_val := x"FF_FF_FF";   -- keep timer stopped
        when others =>
          cnt_val := cnt_val-1;     -- decrement counter value
          cnt_trigger := '0';
      end case;
      
      if axi_start_buf = '1' then
        trigger_nbr <= trigger_nbr-1;
      end if;
    end if;
  end process;
  
  sample_axi_done_p: process (clk)
  begin
    if rising_edge(clk) then
      axi_done_sample(1) <= axi_done_sample(0);   -- record last ppm signal level in ppm_sample(1)
      axi_done_sample(0) <= axi_done;             -- record current ppm signal level in ppm_sample(0)
    end if;
  end process;
  
  -- here the axi-transmissions are triggered, so that the new transmission only is triggered when the last one is finished 
  trigger_axi_p: process (clk)
  variable init_flag : std_logic := '1';
  begin
    if rising_edge(clk) then
      if  trigger_nbr > 0 and axi_done = '1' and axi_start_buf = '0' then
        axi_start_buf <= '1';
      elsif trigger_nbr > 0 and init_flag = '1' and axi_start_buf = '0' then
        axi_start_buf <= '1';
        init_flag := '0';
      else
        axi_start_buf <= '0';
      end if;
    end if;
  end process;

  -- Genaral Logic
  -- and axi_done;
  axi_start <= axi_start_buf;

end spi_timer_behavioral;
