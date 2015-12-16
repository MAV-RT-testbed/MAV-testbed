set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports ppm_signal_in]
set_property IOSTANDARD LVCMOS33 [get_ports mosi_o]
set_property IOSTANDARD LVCMOS33 [get_ports sck_o]
set_property PACKAGE_PIN T11 [get_ports sck_o]
set_property PACKAGE_PIN V13 [get_ports ppm_signal_in]
set_property PACKAGE_PIN U13 [get_ports mosi_o]
set_property PACKAGE_PIN R19 [get_ports {ss_o[0]}]
create_interface PTP_ETHERNET_0_11892
set_property INTERFACE PTP_ETHERNET_0_11892 [get_ports { PTP_ETHERNET_0_delay_req_rx PTP_ETHERNET_0_delay_req_tx PTP_ETHERNET_0_pdelay_req_rx PTP_ETHERNET_0_pdelay_req_tx PTP_ETHERNET_0_pdelay_resp_rx PTP_ETHERNET_0_pdelay_resp_tx PTP_ETHERNET_0_sof_rx PTP_ETHERNET_0_sof_tx PTP_ETHERNET_0_sync_frame_rx PTP_ETHERNET_0_sync_frame_tx }]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
