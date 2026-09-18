.. _animula_alonzo_board:

Animula Alonzo
##############

Overview
********

The Animula Alonzo board features an ARM Cortex-M4 based STM32F411CE MCU
with a wide range of connectivity support. Highlights of the board:

- STM32F411CE microcontroller in UFQFPN48 package
- On-board resources:
  - 2.54 mm header connectors
  - Bluetooth 4.0 BLE
- Four user LEDs
- User button (plus BOOT0 and RESET)
- Micro-SD card slot on SPI1

More information about the board can be found at the
`animula website/alonzo`_.

Hardware
********

Animula Alonzo provides the following hardware components:

- STM32F411CE in UFQFPN48 package
- ARM |reg| 32-bit Cortex |reg|-M4 CPU with FPU
- 512 KB Flash
- 128 KB SRAM
- GPIO with external interrupt capability
- USART/UART (3), I2C (3), SPI (5)
- USB 2.0 OTG FS
- SDIO
- DMA controller, CRC calculation unit
- RTC with backup registers

More information about the STM32F411CE can be found here:

- `STM32F411 on www.st.com`_
- `STM32F411 reference manual`_

Supported Features
==================

The ``animula_alonzo`` board configuration supports the following
hardware features:

+-----------+------------+-------------------------------------+
| Interface | Controller | Driver/Component                    |
+===========+============+=====================================+
| NVIC      | on-chip    | nested vector interrupt controller  |
+-----------+------------+-------------------------------------+
| UART      | on-chip    | serial port                         |
+-----------+------------+-------------------------------------+
| GPIO      | on-chip    | gpio                                |
+-----------+------------+-------------------------------------+
| I2C       | on-chip    | i2c                                 |
+-----------+------------+-------------------------------------+
| SPI       | on-chip    | spi                                 |
+-----------+------------+-------------------------------------+
| RTC       | on-chip    | counter / real-time clock           |
+-----------+------------+-------------------------------------+
| USB       | on-chip    | usb device                          |
+-----------+------------+-------------------------------------+

Other hardware features are not yet supported on this Zephyr port.

Default Zephyr Peripheral Mapping
=================================

- UART_1 TX/RX : PA9/PA10 (console)
- UART_2 TX/RX : PA2/PA3 (BLE)
- I2C1 SCL/SDA : PB8/PB9 (Arduino I2C)
- I2C2 SCL/SDA : PB10/PB3
- I2C3 SCL/SDA : PA8/PB4
- SPI1 CS/SCK/MISO/MOSI : PA4/PA5/PA6/PA7 (Arduino SPI + Micro-SD)
- SPI2 CS/SCK/MISO/MOSI : PB12/PB13/PB14/PB15
- USB DM/DP : PA11/PA12

Board GPIO
----------

- User LED0..LED3 : PC15, PC14, PC13, PA15 (active low)
- User button : PA1 (active low)
- BLE enable/disable : PB2 (active high)

System Clock
============

The Alonzo system clock is driven by the main PLL, clocked by a 24 MHz
high-speed external (HSE) oscillator. By default the system clock runs at
96 MHz:

- HSE = 24 MHz
- PLL: M = 12, N = 96, P = 2, Q = 4
- SYSCLK = 96 MHz
- AHB = 96 MHz, APB1 = 48 MHz, APB2 = 96 MHz
- USB clock (PLL Q) = 48 MHz

Serial Port
===========

The Zephyr console is assigned to UART1 (PA9/PA10). Default settings are
115200 8N1.

Programming and Debugging
*************************

Applications for the ``animula_alonzo`` board can be built and flashed in
the usual way (see :ref:`build_an_application` and
:ref:`application_run` for more details).

Flashing
========

The board is flashed over SWD. Both J-Link and ST-Link (OpenOCD) are
supported:

.. code-block:: console

   west flash            # J-Link or OpenOCD, depending on runner
   west debug            # attach a debugger

Debugging
=========

You can debug an application in the usual way. Here is an example for the
:ref:`hello_world` application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: animula_alonzo
   :maybe-skip-config:
   :goals: debug

.. _animula website/alonzo:
   https://github.com/hardenedlinux/animula-docs

.. _STM32F411 on www.st.com:
   https://www.st.com/en/microcontrollers-microprocessors/stm32f411.html

.. _STM32F411 reference manual:
   https://www.st.com/resource/en/reference_manual/dm00119316-stm32f411xc-e-advanced-arm-based-32-bit-mcus-stmicroelectronics.pdf
