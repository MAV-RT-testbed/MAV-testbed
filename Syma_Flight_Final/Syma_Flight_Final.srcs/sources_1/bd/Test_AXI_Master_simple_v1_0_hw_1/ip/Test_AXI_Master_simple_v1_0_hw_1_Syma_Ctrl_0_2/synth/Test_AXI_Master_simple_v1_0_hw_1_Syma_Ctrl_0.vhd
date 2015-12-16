-- (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: rcs.ei.tum.de:user:Syma_Ctrl_core:1.2
-- IP Revision: 18

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0 IS
  PORT (
    l_ss_init : OUT STD_LOGIC;
    ppm_signal_in : IN STD_LOGIC;
    sample_clk : IN STD_LOGIC;
    ppm_irq_single : OUT STD_LOGIC;
    ppm_irq_complete : OUT STD_LOGIC;
    s00_axi_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_awvalid : IN STD_LOGIC;
    s00_axi_awready : OUT STD_LOGIC;
    s00_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_wvalid : IN STD_LOGIC;
    s00_axi_wready : OUT STD_LOGIC;
    s00_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_bvalid : OUT STD_LOGIC;
    s00_axi_bready : IN STD_LOGIC;
    s00_axi_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_arvalid : IN STD_LOGIC;
    s00_axi_arready : OUT STD_LOGIC;
    s00_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_rvalid : OUT STD_LOGIC;
    s00_axi_rready : IN STD_LOGIC;
    s00_axi_aclk : IN STD_LOGIC;
    s00_axi_aresetn : IN STD_LOGIC;
    s01_axi_awaddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    s01_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s01_axi_awvalid : IN STD_LOGIC;
    s01_axi_awready : OUT STD_LOGIC;
    s01_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s01_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s01_axi_wvalid : IN STD_LOGIC;
    s01_axi_wready : OUT STD_LOGIC;
    s01_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s01_axi_bvalid : OUT STD_LOGIC;
    s01_axi_bready : IN STD_LOGIC;
    s01_axi_araddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    s01_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s01_axi_arvalid : IN STD_LOGIC;
    s01_axi_arready : OUT STD_LOGIC;
    s01_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s01_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s01_axi_rvalid : OUT STD_LOGIC;
    s01_axi_rready : IN STD_LOGIC;
    s01_axi_aclk : IN STD_LOGIC;
    s01_axi_aresetn : IN STD_LOGIC;
    m01_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m01_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m01_axi_awvalid : OUT STD_LOGIC;
    m01_axi_awready : IN STD_LOGIC;
    m01_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m01_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m01_axi_wvalid : OUT STD_LOGIC;
    m01_axi_wready : IN STD_LOGIC;
    m01_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m01_axi_bvalid : IN STD_LOGIC;
    m01_axi_bready : OUT STD_LOGIC;
    m01_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m01_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m01_axi_arvalid : OUT STD_LOGIC;
    m01_axi_arready : IN STD_LOGIC;
    m01_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m01_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m01_axi_rvalid : IN STD_LOGIC;
    m01_axi_rready : OUT STD_LOGIC;
    m01_axi_aclk : IN STD_LOGIC;
    m01_axi_aresetn : IN STD_LOGIC
  );
END Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0;

ARCHITECTURE Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0_arch OF Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0_arch: ARCHITECTURE IS "yes";

  COMPONENT Syma_Ctrl_core_v1_1 IS
    GENERIC (
      C_S00_AXI_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_S00_AXI_ADDR_WIDTH : INTEGER; -- Width of S_AXI address bus
      C_S01_AXI_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_S01_AXI_ADDR_WIDTH : INTEGER; -- Width of S_AXI address bus
      C_M01_AXI_START_DATA_VALUE : STD_LOGIC_VECTOR; -- The master will start generating data from the C_M_START_DATA_VALUE value
      C_M01_AXI_TARGET_SLAVE_BASE_ADDR : STD_LOGIC_VECTOR; -- The master requires a target slave base address.
    -- The master will initiate read and write transactions on the slave with base address specified here as a parameter.
      C_M01_AXI_ADDR_WIDTH : INTEGER; -- Width of M_AXI address bus. 
    -- The master generates the read and write addresses of width specified as C_M_AXI_ADDR_WIDTH.
      C_M01_AXI_DATA_WIDTH : INTEGER; -- Width of M_AXI data bus. 
    -- The master issues write data and accept read data where the width of the data bus is C_M_AXI_DATA_WIDTH
      C_M01_AXI_TRANSACTIONS_NUM : INTEGER; -- Transaction number is the number of write 
    -- and read transactions the master will perform as a part of this example memory test.
      DEBUG : INTEGER
    );
    PORT (
      l_ss_init : OUT STD_LOGIC;
      ppm_signal_in : IN STD_LOGIC;
      sample_clk : IN STD_LOGIC;
      ppm_irq_single : OUT STD_LOGIC;
      ppm_irq_complete : OUT STD_LOGIC;
      d_axi_done : OUT STD_LOGIC;
      d_axi_start : OUT STD_LOGIC;
      d_axi_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      d_axi_addr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      d_slave_cr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      d_slave_sr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      d_slave_flight : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_awvalid : IN STD_LOGIC;
      s00_axi_awready : OUT STD_LOGIC;
      s00_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_wvalid : IN STD_LOGIC;
      s00_axi_wready : OUT STD_LOGIC;
      s00_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_bvalid : OUT STD_LOGIC;
      s00_axi_bready : IN STD_LOGIC;
      s00_axi_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_arvalid : IN STD_LOGIC;
      s00_axi_arready : OUT STD_LOGIC;
      s00_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_rvalid : OUT STD_LOGIC;
      s00_axi_rready : IN STD_LOGIC;
      s00_axi_aclk : IN STD_LOGIC;
      s00_axi_aresetn : IN STD_LOGIC;
      s01_axi_awaddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      s01_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s01_axi_awvalid : IN STD_LOGIC;
      s01_axi_awready : OUT STD_LOGIC;
      s01_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s01_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s01_axi_wvalid : IN STD_LOGIC;
      s01_axi_wready : OUT STD_LOGIC;
      s01_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s01_axi_bvalid : OUT STD_LOGIC;
      s01_axi_bready : IN STD_LOGIC;
      s01_axi_araddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      s01_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s01_axi_arvalid : IN STD_LOGIC;
      s01_axi_arready : OUT STD_LOGIC;
      s01_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s01_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s01_axi_rvalid : OUT STD_LOGIC;
      s01_axi_rready : IN STD_LOGIC;
      s01_axi_aclk : IN STD_LOGIC;
      s01_axi_aresetn : IN STD_LOGIC;
      m01_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      m01_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      m01_axi_awvalid : OUT STD_LOGIC;
      m01_axi_awready : IN STD_LOGIC;
      m01_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      m01_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      m01_axi_wvalid : OUT STD_LOGIC;
      m01_axi_wready : IN STD_LOGIC;
      m01_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      m01_axi_bvalid : IN STD_LOGIC;
      m01_axi_bready : OUT STD_LOGIC;
      m01_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      m01_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      m01_axi_arvalid : OUT STD_LOGIC;
      m01_axi_arready : IN STD_LOGIC;
      m01_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      m01_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      m01_axi_rvalid : IN STD_LOGIC;
      m01_axi_rready : OUT STD_LOGIC;
      m01_axi_aclk : IN STD_LOGIC;
      m01_axi_aresetn : IN STD_LOGIC
    );
  END COMPONENT Syma_Ctrl_core_v1_1;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0_arch: ARCHITECTURE IS "Syma_Ctrl_core_v1_1,Vivado 2014.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0_arch : ARCHITECTURE IS "Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0,Syma_Ctrl_core_v1_1,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 S00_AXI_RST RST";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S01_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 S01_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF s01_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 S01_AXI_RST RST";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M01_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 M01_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF m01_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 M01_AXI_RST RST";
BEGIN
  U0 : Syma_Ctrl_core_v1_1
    GENERIC MAP (
      C_S00_AXI_DATA_WIDTH => 32,
      C_S00_AXI_ADDR_WIDTH => 4,
      C_S01_AXI_DATA_WIDTH => 32,
      C_S01_AXI_ADDR_WIDTH => 5,
      C_M01_AXI_START_DATA_VALUE => X"AA000000",
      C_M01_AXI_TARGET_SLAVE_BASE_ADDR => X"44A00000",
      C_M01_AXI_ADDR_WIDTH => 32,
      C_M01_AXI_DATA_WIDTH => 32,
      C_M01_AXI_TRANSACTIONS_NUM => 1,
      DEBUG => 0
    )
    PORT MAP (
      l_ss_init => l_ss_init,
      ppm_signal_in => ppm_signal_in,
      sample_clk => sample_clk,
      ppm_irq_single => ppm_irq_single,
      ppm_irq_complete => ppm_irq_complete,
      s00_axi_awaddr => s00_axi_awaddr,
      s00_axi_awprot => s00_axi_awprot,
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_awready => s00_axi_awready,
      s00_axi_wdata => s00_axi_wdata,
      s00_axi_wstrb => s00_axi_wstrb,
      s00_axi_wvalid => s00_axi_wvalid,
      s00_axi_wready => s00_axi_wready,
      s00_axi_bresp => s00_axi_bresp,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_araddr => s00_axi_araddr,
      s00_axi_arprot => s00_axi_arprot,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_arready => s00_axi_arready,
      s00_axi_rdata => s00_axi_rdata,
      s00_axi_rresp => s00_axi_rresp,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_rready => s00_axi_rready,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_aresetn => s00_axi_aresetn,
      s01_axi_awaddr => s01_axi_awaddr,
      s01_axi_awprot => s01_axi_awprot,
      s01_axi_awvalid => s01_axi_awvalid,
      s01_axi_awready => s01_axi_awready,
      s01_axi_wdata => s01_axi_wdata,
      s01_axi_wstrb => s01_axi_wstrb,
      s01_axi_wvalid => s01_axi_wvalid,
      s01_axi_wready => s01_axi_wready,
      s01_axi_bresp => s01_axi_bresp,
      s01_axi_bvalid => s01_axi_bvalid,
      s01_axi_bready => s01_axi_bready,
      s01_axi_araddr => s01_axi_araddr,
      s01_axi_arprot => s01_axi_arprot,
      s01_axi_arvalid => s01_axi_arvalid,
      s01_axi_arready => s01_axi_arready,
      s01_axi_rdata => s01_axi_rdata,
      s01_axi_rresp => s01_axi_rresp,
      s01_axi_rvalid => s01_axi_rvalid,
      s01_axi_rready => s01_axi_rready,
      s01_axi_aclk => s01_axi_aclk,
      s01_axi_aresetn => s01_axi_aresetn,
      m01_axi_awaddr => m01_axi_awaddr,
      m01_axi_awprot => m01_axi_awprot,
      m01_axi_awvalid => m01_axi_awvalid,
      m01_axi_awready => m01_axi_awready,
      m01_axi_wdata => m01_axi_wdata,
      m01_axi_wstrb => m01_axi_wstrb,
      m01_axi_wvalid => m01_axi_wvalid,
      m01_axi_wready => m01_axi_wready,
      m01_axi_bresp => m01_axi_bresp,
      m01_axi_bvalid => m01_axi_bvalid,
      m01_axi_bready => m01_axi_bready,
      m01_axi_araddr => m01_axi_araddr,
      m01_axi_arprot => m01_axi_arprot,
      m01_axi_arvalid => m01_axi_arvalid,
      m01_axi_arready => m01_axi_arready,
      m01_axi_rdata => m01_axi_rdata,
      m01_axi_rresp => m01_axi_rresp,
      m01_axi_rvalid => m01_axi_rvalid,
      m01_axi_rready => m01_axi_rready,
      m01_axi_aclk => m01_axi_aclk,
      m01_axi_aresetn => m01_axi_aresetn
    );
END Test_AXI_Master_simple_v1_0_hw_1_Syma_Ctrl_0_arch;
