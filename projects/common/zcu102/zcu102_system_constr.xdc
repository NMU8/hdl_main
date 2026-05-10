###############################################################################
## Copyright (C) 2016-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# constraints
# gpio (switches, leds and such)

set_property  -dict {PACKAGE_PIN  AC12  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[0]]           ; ## GPIO_DIP_SW0
set_property  -dict {PACKAGE_PIN  AD9   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[1]]           ; ## GPIO_DIP_SW1
set_property  -dict {PACKAGE_PIN  AD12  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[2]]           ; ## GPIO_DIP_SW2
set_property  -dict {PACKAGE_PIN  AD11  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[3]]           ; ## GPIO_DIP_SW3
set_property  -dict {PACKAGE_PIN  AD10  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[4]]           ; ## GPIO_DIP_SW4
set_property  -dict {PACKAGE_PIN  AB6   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[5]]           ; ## GPIO_DIP_SW5
set_property  -dict {PACKAGE_PIN  AA8   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[6]]           ; ## GPIO_DIP_SW6
set_property  -dict {PACKAGE_PIN  AB5   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[7]]           ; ## GPIO_DIP_SW7
set_property  -dict {PACKAGE_PIN  AB8   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[8]]           ; ## GPIO_SW_E
set_property  -dict {PACKAGE_PIN  AD7   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[9]]           ; ## GPIO_SW_S
set_property  -dict {PACKAGE_PIN  AC8   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[10]]          ; ## GPIO_SW_N
set_property  -dict {PACKAGE_PIN  AE7   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[11]]          ; ## GPIO_SW_W
set_property  -dict {PACKAGE_PIN  AC7   IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[12]]          ; ## GPIO_SW_C

set_property  -dict {PACKAGE_PIN  AC4   IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[0]]           ; ## GPIO_LED_0
set_property  -dict {PACKAGE_PIN  AC16  IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[1]]           ; ## GPIO_LED_1
set_property  -dict {PACKAGE_PIN  AB4   IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[2]]           ; ## GPIO_LED_2
set_property  -dict {PACKAGE_PIN  AD16  IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[3]]           ; ## GPIO_LED_3
set_property  -dict {PACKAGE_PIN  AE4   IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[4]]           ; ## GPIO_LED_4
set_property  -dict {PACKAGE_PIN  AA14  IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[5]]           ; ## GPIO_LED_5
set_property  -dict {PACKAGE_PIN  AD4   IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[6]]           ; ## GPIO_LED_6
set_property  -dict {PACKAGE_PIN  AB14  IOSTANDARD LVCMOS18} [get_ports gpio_bd_o[7]]           ; ## GPIO_LED_7

# Define SPI clock
create_clock -name spi0_clk      -period 40   [get_pins -hier */EMIOSPI0SCLKO]
create_clock -name spi1_clk      -period 40   [get_pins -hier */EMIOSPI1SCLKO]
