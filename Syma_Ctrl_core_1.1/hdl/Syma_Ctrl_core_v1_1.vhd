library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Syma_Ctrl_core_v1_1 is
	generic (
		-- Users to add parameters here
		-- Determe´ins weather Debug Ports are available
        DEBUG   : integer := 1;
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface S01_AXI
		C_S01_AXI_DATA_WIDTH	: integer	:= 32;
		C_S01_AXI_ADDR_WIDTH	: integer	:= 5;

		-- Parameters of Axi Master Bus Interface M01_AXI
		C_M01_AXI_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M01_AXI_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M01_AXI_ADDR_WIDTH	: integer	:= 32;
		C_M01_AXI_DATA_WIDTH	: integer	:= 32;
		C_M01_AXI_TRANSACTIONS_NUM	: integer	:= 4

	);
	port (
		-- Users to add ports here
		--SPI Init Signal
        l_ss_init : out std_logic;
        ppm_signal_in : in std_logic;
        sample_clk : in std_logic;
        ppm_irq_single: out std_logic;
        ppm_irq_complete: out std_logic;
        -- Debug Ports
        d_axi_done : out std_logic;
        d_axi_start : out std_logic;
        d_axi_data : out std_logic_vector(7 downto 0);
        d_axi_addr : out std_logic_vector(7 downto 0);
        d_slave_cr : out std_logic_vector(7 downto 0);
        d_slave_sr : out std_logic_vector(7 downto 0);
        d_slave_flight : out std_logic_vector(31 downto 0);
--        d_ppm_sample : inout std_logic_vector (1 downto 0) := "00";
--        d_counter  : inout unsigned (31 downto 0) := x"00_00_00_00";
--        d_reg_nr : inout unsigned (3 downto 0) := "0000";

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S01_AXI
		s01_axi_aclk	: in std_logic;
		s01_axi_aresetn	: in std_logic;
		s01_axi_awaddr	: in std_logic_vector(C_S01_AXI_ADDR_WIDTH-1 downto 0);
		s01_axi_awprot	: in std_logic_vector(2 downto 0);
		s01_axi_awvalid	: in std_logic;
		s01_axi_awready	: out std_logic;
		s01_axi_wdata	: in std_logic_vector(C_S01_AXI_DATA_WIDTH-1 downto 0);
		s01_axi_wstrb	: in std_logic_vector((C_S01_AXI_DATA_WIDTH/8)-1 downto 0);
		s01_axi_wvalid	: in std_logic;
		s01_axi_wready	: out std_logic;
		s01_axi_bresp	: out std_logic_vector(1 downto 0);
		s01_axi_bvalid	: out std_logic;
		s01_axi_bready	: in std_logic;
		s01_axi_araddr	: in std_logic_vector(C_S01_AXI_ADDR_WIDTH-1 downto 0);
		s01_axi_arprot	: in std_logic_vector(2 downto 0);
		s01_axi_arvalid	: in std_logic;
		s01_axi_arready	: out std_logic;
		s01_axi_rdata	: out std_logic_vector(C_S01_AXI_DATA_WIDTH-1 downto 0);
		s01_axi_rresp	: out std_logic_vector(1 downto 0);
		s01_axi_rvalid	: out std_logic;
		s01_axi_rready	: in std_logic;

		-- Ports of Axi Master Bus Interface M01_AXI
--		m01_axi_init_axi_txn	: in std_logic;
--		m01_axi_error	: out std_logic;
--		m01_axi_txn_done	: out std_logic;
		m01_axi_aclk	: in std_logic;
		m01_axi_aresetn	: in std_logic;
		m01_axi_awaddr	: out std_logic_vector(C_M01_AXI_ADDR_WIDTH-1 downto 0);
		m01_axi_awprot	: out std_logic_vector(2 downto 0);
		m01_axi_awvalid	: out std_logic;
		m01_axi_awready	: in std_logic;
		m01_axi_wdata	: out std_logic_vector(C_M01_AXI_DATA_WIDTH-1 downto 0);
		m01_axi_wstrb	: out std_logic_vector(C_M01_AXI_DATA_WIDTH/8-1 downto 0);
		m01_axi_wvalid	: out std_logic;
		m01_axi_wready	: in std_logic;
		m01_axi_bresp	: in std_logic_vector(1 downto 0);
		m01_axi_bvalid	: in std_logic;
		m01_axi_bready	: out std_logic;
		m01_axi_araddr	: out std_logic_vector(C_M01_AXI_ADDR_WIDTH-1 downto 0);
		m01_axi_arprot	: out std_logic_vector(2 downto 0);
		m01_axi_arvalid	: out std_logic;
		m01_axi_arready	: in std_logic;
		m01_axi_rdata	: in std_logic_vector(C_M01_AXI_DATA_WIDTH-1 downto 0);
		m01_axi_rresp	: in std_logic_vector(1 downto 0);
		m01_axi_rvalid	: in std_logic;
		m01_axi_rready	: out std_logic

	);
end Syma_Ctrl_core_v1_1;

architecture arch_imp of Syma_Ctrl_core_v1_1 is
signal m01_axi_init_axi_txn : std_logic;
signal m01_axi_txn_done : std_logic;
signal m01_axi_spi_data : std_logic_vector(7 downto 0);
signal m01_axi_spi_addr : std_logic_vector(7 downto 0);
signal m01_axi_error : std_logic;
signal s00_axi_cr       : std_logic_vector(7 downto 0);
signal s00_axi_sr       : std_logic_vector(7 downto 0);
signal s00_axi_flight   : std_logic_vector(31 downto 0);

	-- component declaration
	component Syma_Ctrl_core_v1_1_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_CR        : out std_logic_vector(7 downto 0);
        S_AXI_SR        : in std_logic_vector(7 downto 0);
        S_AXI_FLIGHT    : out std_logic_vector(31 downto 0);
 		
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component Syma_Ctrl_core_v1_1_S00_AXI;

	component Syma_Ctrl_core_v1_1_S01_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 5
		);
		port (		
		PPM_INPUT       : in std_logic;
        SAMPLE_CLOCK : in std_logic;
        INTR_SINGLE : out std_logic;
        INTR_COMPLETE: out std_logic;       
        
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component Syma_Ctrl_core_v1_1_S01_AXI;

	component Syma_Ctrl_core_v1_1_M01_AXI is
		generic (
		C_M_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M_AXI_ADDR_WIDTH	: integer	:= 32;
		C_M_AXI_DATA_WIDTH	: integer	:= 32;
		C_M_TRANSACTIONS_NUM	: integer	:= 4
		);
		port (
		INIT_AXI_TXN	: in std_logic;
		ERROR	: out std_logic;
		TXN_DONE	: out std_logic;
		M_AXI_ACLK	: in std_logic;
		M_AXI_ARESETN	: in std_logic;
		M_AXI_AWADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		M_AXI_AWVALID	: out std_logic;
		M_AXI_AWREADY	: in std_logic;
		M_AXI_WDATA	: out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_WSTRB	: out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
		M_AXI_WVALID	: out std_logic;
		M_AXI_WREADY	: in std_logic;
		M_AXI_BRESP	: in std_logic_vector(1 downto 0);
		M_AXI_BVALID	: in std_logic;
		M_AXI_BREADY	: out std_logic;
		M_AXI_ARADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		M_AXI_ARVALID	: out std_logic;
		M_AXI_ARREADY	: in std_logic;
		M_AXI_RDATA	: in std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_RRESP	: in std_logic_vector(1 downto 0);
		M_AXI_RVALID	: in std_logic;
		M_AXI_RREADY	: out std_logic;
		
		M_AXI_SPI_DATA  : in std_logic_vector(7 downto 0);
        M_AXI_SPI_ADDR  : in std_logic_vector(7 downto 0)
		);
	end component Syma_Ctrl_core_v1_1_M01_AXI;

    component spi_timer is
      Port ( 
        clk : in std_logic;
        axi_done : std_logic;
        axi_start : out std_logic;
        axi_data : out std_logic_vector (7 downto 0);
        axi_addr : out std_logic_vector (7 downto 0);
        slave_cr : in std_logic_vector (7 downto 0);
        slave_sr : out std_logic_vector (7 downto 0);
        slave_flight : in std_logic_vector (31 downto 0);
        ss_init : out std_logic := '0');  -- ss init signal needed by transmitter module, logical or with ss in board design
    end component;
begin

-- Instantiation of Axi Bus Interface S00_AXI
Syma_Ctrl_core_v1_1_S00_AXI_inst : Syma_Ctrl_core_v1_1_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
		S_AXI_CR        => s00_axi_cr,
        S_AXI_SR        => s00_axi_sr,
        S_AXI_FLIGHT    => s00_axi_flight,

        S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

-- Instantiation of Axi Bus Interface S01_AXI
Syma_Ctrl_core_v1_1_S01_AXI_inst : Syma_Ctrl_core_v1_1_S01_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S01_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S01_AXI_ADDR_WIDTH
	)
	port map (		
	    PPM_INPUT => ppm_signal_in,
        SAMPLE_CLOCK => sample_clk,
        INTR_SINGLE => ppm_irq_single,        
        INTR_COMPLETE => ppm_irq_complete,
		S_AXI_ACLK	=> s01_axi_aclk,
		S_AXI_ARESETN	=> s01_axi_aresetn,
		S_AXI_AWADDR	=> s01_axi_awaddr,
		S_AXI_AWPROT	=> s01_axi_awprot,
		S_AXI_AWVALID	=> s01_axi_awvalid,
		S_AXI_AWREADY	=> s01_axi_awready,
		S_AXI_WDATA	=> s01_axi_wdata,
		S_AXI_WSTRB	=> s01_axi_wstrb,
		S_AXI_WVALID	=> s01_axi_wvalid,
		S_AXI_WREADY	=> s01_axi_wready,
		S_AXI_BRESP	=> s01_axi_bresp,
		S_AXI_BVALID	=> s01_axi_bvalid,
		S_AXI_BREADY	=> s01_axi_bready,
		S_AXI_ARADDR	=> s01_axi_araddr,
		S_AXI_ARPROT	=> s01_axi_arprot,
		S_AXI_ARVALID	=> s01_axi_arvalid,
		S_AXI_ARREADY	=> s01_axi_arready,
		S_AXI_RDATA	=> s01_axi_rdata,
		S_AXI_RRESP	=> s01_axi_rresp,
		S_AXI_RVALID	=> s01_axi_rvalid,
		S_AXI_RREADY	=> s01_axi_rready
	);

-- Instantiation of Axi Bus Interface M01_AXI
Syma_Ctrl_core_v1_1_M01_AXI_inst : Syma_Ctrl_core_v1_1_M01_AXI
	generic map (
		C_M_START_DATA_VALUE	=> C_M01_AXI_START_DATA_VALUE,
		C_M_TARGET_SLAVE_BASE_ADDR	=> C_M01_AXI_TARGET_SLAVE_BASE_ADDR,
		C_M_AXI_ADDR_WIDTH	=> C_M01_AXI_ADDR_WIDTH,
		C_M_AXI_DATA_WIDTH	=> C_M01_AXI_DATA_WIDTH,
		C_M_TRANSACTIONS_NUM	=> C_M01_AXI_TRANSACTIONS_NUM
	)
	port map (        
	    M_AXI_SPI_DATA  => m01_axi_spi_data,
        M_AXI_SPI_ADDR  => m01_axi_spi_addr,
        
		INIT_AXI_TXN	=> m01_axi_init_axi_txn,
		ERROR	=> m01_axi_error,
		TXN_DONE	=> m01_axi_txn_done,
		M_AXI_ACLK	=> m01_axi_aclk,
		M_AXI_ARESETN	=> m01_axi_aresetn,
		M_AXI_AWADDR	=> m01_axi_awaddr,
		M_AXI_AWPROT	=> m01_axi_awprot,
		M_AXI_AWVALID	=> m01_axi_awvalid,
		M_AXI_AWREADY	=> m01_axi_awready,
		M_AXI_WDATA	=> m01_axi_wdata,
		M_AXI_WSTRB	=> m01_axi_wstrb,
		M_AXI_WVALID	=> m01_axi_wvalid,
		M_AXI_WREADY	=> m01_axi_wready,
		M_AXI_BRESP	=> m01_axi_bresp,
		M_AXI_BVALID	=> m01_axi_bvalid,
		M_AXI_BREADY	=> m01_axi_bready,
		M_AXI_ARADDR	=> m01_axi_araddr,
		M_AXI_ARPROT	=> m01_axi_arprot,
		M_AXI_ARVALID	=> m01_axi_arvalid,
		M_AXI_ARREADY	=> m01_axi_arready,
		M_AXI_RDATA	=> m01_axi_rdata,
		M_AXI_RRESP	=> m01_axi_rresp,
		M_AXI_RVALID	=> m01_axi_rvalid,
		M_AXI_RREADY	=> m01_axi_rready
	);


	-- Add user logic here
    spi_timer_0 : spi_timer
    port map (
      clk => m01_axi_aclk,
      axi_done => m01_axi_txn_done,
      axi_start => m01_axi_init_axi_txn,
      axi_data => m01_axi_spi_data,
      axi_addr => m01_axi_spi_addr,
      slave_cr => s00_axi_cr,
      slave_sr => s00_axi_sr,
      slave_flight => s00_axi_flight,
      ss_init => l_ss_init
      );
      
    d_axi_done <= m01_axi_txn_done;
    d_axi_start <= m01_axi_init_axi_txn;
    d_axi_data <= m01_axi_spi_data;
    d_axi_addr <= m01_axi_spi_addr;
    d_slave_cr <= s00_axi_cr;
    d_slave_sr <= s00_axi_sr;
    d_slave_flight <= s00_axi_flight;
	-- User logic ends

end arch_imp;
