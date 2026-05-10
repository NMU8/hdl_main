###############################################################################
## Copyright (C) 2016-2025 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

set CACHE_COHERENCY true

# create board design
# default ports

create_bd_port -dir O -from 2 -to 0 spi0_csn
create_bd_port -dir O spi0_sclk
create_bd_port -dir O spi0_mosi
create_bd_port -dir I spi0_miso

create_bd_port -dir O -from 2 -to 0 spi1_csn
create_bd_port -dir O spi1_sclk
create_bd_port -dir O spi1_mosi
create_bd_port -dir I spi1_miso

create_bd_port -dir I -from 94 -to 0 gpio_i
create_bd_port -dir O -from 94 -to 0 gpio_o
create_bd_port -dir O -from 94 -to 0 gpio_t

# instance: sys_ps8

ad_ip_instance zynq_ultra_ps_e sys_ps8
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e \
  -config {apply_board_preset 1}  [get_bd_cells sys_ps8]

ad_ip_parameter sys_ps8 CONFIG.PSU__PSS_REF_CLK__FREQMHZ 33.333333333
ad_ip_parameter sys_ps8 CONFIG.PSU__USE__M_AXI_GP0 0
ad_ip_parameter sys_ps8 CONFIG.PSU__USE__M_AXI_GP1 0
ad_ip_parameter sys_ps8 CONFIG.PSU__USE__M_AXI_GP2 1
ad_ip_parameter sys_ps8 CONFIG.PSU__MAXIGP2__DATA_WIDTH 32
ad_ip_parameter sys_ps8 CONFIG.PSU__FPGA_PL0_ENABLE 1
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL}
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ 100
ad_ip_parameter sys_ps8 CONFIG.PSU__FPGA_PL1_ENABLE 1
ad_ip_parameter sys_ps8 CONFIG.PSU__FPGA_PL2_ENABLE 1
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {IOPLL}
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ 250
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL2_REF_CTRL__SRCSEL {IOPLL}
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL2_REF_CTRL__FREQMHZ 500
ad_ip_parameter sys_ps8 CONFIG.PSU__USE__IRQ0 1
ad_ip_parameter sys_ps8 CONFIG.PSU__USE__IRQ1 1
ad_ip_parameter sys_ps8 CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE 1
ad_ip_parameter sys_ps8 CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1}
ad_ip_parameter sys_ps8 CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 6 .. 7}
ad_ip_parameter sys_ps8 CONFIG.PSU__UART0__BAUD_RATE 115200

set_property -dict [list \
  CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU__SPI0__PERIPHERAL__ENABLE 1 \
  CONFIG.PSU__SPI0__PERIPHERAL__IO {EMIO} \
  CONFIG.PSU__SPI0__GRP_SS1__ENABLE 1 \
  CONFIG.PSU__SPI0__GRP_SS2__ENABLE 1 \
  CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ 100 \
  CONFIG.PSU__SPI1__PERIPHERAL__ENABLE 1 \
  CONFIG.PSU__SPI1__PERIPHERAL__IO EMIO \
  CONFIG.PSU__SPI1__GRP_SS1__ENABLE 1 \
  CONFIG.PSU__SPI1__GRP_SS2__ENABLE 1 \
  CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__FREQMHZ 100 \
  CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1200} \
  CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
  CONFIG.PSU__DDRC__CL {16} \
  CONFIG.PSU__DDRC__CWL {16} \
  CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
  CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
  CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
  CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400P} \
  CONFIG.PSU__DDRC__T_RC {45.32} \
  CONFIG.PSU__DDRC__T_RCD {16} \
  CONFIG.PSU__DDRC__T_RP {16} \
  CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
  CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
  CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
  CONFIG.PSU__SD0__RESET__ENABLE {1} \
  CONFIG.PSU__SD0__CLK_50_SDR_OTAP_DLY {0x6} \
  CONFIG.PSU__SD0__CLK_50_SDR_ITAP_DLY {0x12} \
  CONFIG.PSU__SD0__CLK_50_DDR_OTAP_DLY {0x6} \
  CONFIG.PSU__SD0__CLK_200_SDR_OTAP_DLY {0x3} \
] [get_bd_cells sys_ps8]

# processor system reset instances for all the three system clocks

ad_ip_instance proc_sys_reset sys_rstgen
ad_ip_parameter sys_rstgen CONFIG.C_EXT_RST_WIDTH 1

# system reset/clock definitions

ad_connect  sys_cpu_clk sys_ps8/pl_clk0

ad_connect  sys_ps8/pl_resetn0 sys_rstgen/ext_reset_in
ad_connect  sys_cpu_clk sys_rstgen/slowest_sync_clk

ad_connect  sys_cpu_reset sys_rstgen/peripheral_reset
ad_connect  sys_cpu_resetn sys_rstgen/peripheral_aresetn

# generic system clocks&resets pointers

set sys_cpu_clk            [get_bd_nets sys_cpu_clk]

set  sys_cpu_reset         [get_bd_nets sys_cpu_reset]
set  sys_cpu_resetn        [get_bd_nets sys_cpu_resetn]

# gpio

ad_connect  gpio_i sys_ps8/emio_gpio_i
ad_connect  gpio_o sys_ps8/emio_gpio_o
ad_connect  gpio_t sys_ps8/emio_gpio_t

# spi

ad_ip_instance ilconcat spi0_csn_concat
ad_ip_parameter spi0_csn_concat CONFIG.NUM_PORTS 3
ad_connect  sys_ps8/emio_spi0_ss_o_n spi0_csn_concat/In0
ad_connect  sys_ps8/emio_spi0_ss1_o_n spi0_csn_concat/In1
ad_connect  sys_ps8/emio_spi0_ss2_o_n spi0_csn_concat/In2
ad_connect  spi0_csn_concat/dout spi0_csn
ad_connect  sys_ps8/emio_spi0_sclk_o spi0_sclk
ad_connect  sys_ps8/emio_spi0_m_o spi0_mosi
ad_connect  sys_ps8/emio_spi0_m_i spi0_miso
ad_connect  sys_ps8/emio_spi0_ss_i_n VCC
ad_connect  sys_ps8/emio_spi0_sclk_i GND
ad_connect  sys_ps8/emio_spi0_s_i GND

ad_ip_instance ilconcat spi1_csn_concat
ad_ip_parameter spi1_csn_concat CONFIG.NUM_PORTS 3
ad_connect  sys_ps8/emio_spi1_ss_o_n spi1_csn_concat/In0
ad_connect  sys_ps8/emio_spi1_ss1_o_n spi1_csn_concat/In1
ad_connect  sys_ps8/emio_spi1_ss2_o_n spi1_csn_concat/In2
ad_connect  spi1_csn_concat/dout spi1_csn
ad_connect  sys_ps8/emio_spi1_sclk_o spi1_sclk
ad_connect  sys_ps8/emio_spi1_m_o spi1_mosi
ad_connect  sys_ps8/emio_spi1_m_i spi1_miso
ad_connect  sys_ps8/emio_spi1_ss_i_n VCC
ad_connect  sys_ps8/emio_spi1_sclk_i GND
ad_connect  sys_ps8/emio_spi1_s_i GND

# interrupts

ad_ip_instance ilconcat sys_concat_intc_0
ad_ip_parameter sys_concat_intc_0 CONFIG.NUM_PORTS 8

ad_ip_instance ilconcat sys_concat_intc_1
ad_ip_parameter sys_concat_intc_1 CONFIG.NUM_PORTS 8

ad_connect  sys_concat_intc_0/dout sys_ps8/pl_ps_irq0
ad_connect  sys_concat_intc_1/dout sys_ps8/pl_ps_irq1

ad_connect  sys_concat_intc_1/In7 GND
ad_connect  sys_concat_intc_1/In6 GND
ad_connect  sys_concat_intc_1/In5 GND
ad_connect  sys_concat_intc_1/In4 GND
ad_connect  sys_concat_intc_1/In3 GND
ad_connect  sys_concat_intc_1/In2 GND
ad_connect  sys_concat_intc_1/In1 GND
ad_connect  sys_concat_intc_1/In0 GND
ad_connect  sys_concat_intc_0/In7 GND
ad_connect  sys_concat_intc_0/In6 GND
ad_connect  sys_concat_intc_0/In5 GND
ad_connect  sys_concat_intc_0/In4 GND
ad_connect  sys_concat_intc_0/In3 GND
ad_connect  sys_concat_intc_0/In2 GND
ad_connect  sys_concat_intc_0/In1 GND
ad_connect  sys_concat_intc_0/In0 GND
