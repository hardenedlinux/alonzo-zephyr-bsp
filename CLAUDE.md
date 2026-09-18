# CLAUDE.md

Guidance for working in this repository.

## What this repo is

A Zephyr **board support package (BSP)** for the Animula **Alonzo** board
(STM32F411CE). It is a Zephyr **module** — it only provides an out-of-tree
board under `boards/`. It does **not** contain the Zephyr tree, the STM32
SoC, or the HAL; those come from upstream Zephyr 4.4.

- Target: **Zephyr 4.4.x** (current hardware model / HWMv2).
- Board identifier: `animula_alonzo`.
- Vendor: `animula`.

## Where the dependencies live

- Zephyr source: `~/Project/zephyr-rtos/zephyr` (v4.4, branch `main`).
- West workspace topdir: `~/Project/zephyr-rtos` (west v1.5.0, `.venv`).
- STM32 HAL: `~/Project/zephyr-rtos/modules/hal/stm32`.
- MCUboot: `~/Project/zephyr-rtos/bootloader/mcuboot`.

**Never modify anything inside `~/Project/zephyr-rtos`** — treat it as a
read-only dependency. Use its `.venv/bin/west`.

The previous, historical BSP lives at `~/Project/animula-zephyr-bsp`
(Zephyr 2.7 era). Treat it as a hardware reference only; do not copy its
architecture.

## Hardware facts (extracted from the old BSP, verified against Zephyr 4.4)

- MCU: STM32F411CE (UFQFPN48), Cortex-M4F, 512 KB flash, 128 KB SRAM.
  SoC symbol `SOC_STM32F411XE`; DTS `stm32f411Xe.dtsi`.
- Clock: HSE 24 MHz -> PLL (M=12, N=96, P=2, Q=4) -> SYSCLK 96 MHz;
  AHB 96 MHz, APB1 48 MHz, APB2 96 MHz, USB (PLL Q) 48 MHz.
- Console: USART1 PA9/PA10 @ 115200.
- UART2 PA2/PA3 (BLE); I2C1 PB8/PB9, I2C2 PB10/PB3, I2C3 PA8/PB4;
  SPI1 PA4..PA7 (Micro-SD via `zephyr,sdhc-spi-slot`), SPI2 PB12..PB15;
  USB OTG FS PA11/PA12; RTC (LSI source).
- LEDs PC15/PC14/PC13/PA15 (active low); user button PA1 (active low);
  BLE enable PB2 (active high).

## Build / validate

The board is discovered through `zephyr/module.yml` (`board_root: .`).
To validate against the local Zephyr workspace:

```sh
cd ~/Project/zephyr-rtos
export ZEPHYR_EXTRA_MODULES=~/Project/alonzo-zephyr-bsp
./.venv/bin/west boards | grep animula_alonzo
./.venv/bin/west build -b animula_alonzo samples/hello_world
./.venv/bin/west build -b animula_alonzo samples/basic/blinky
```

`west flash` / `west debug` target a J-Link (`STM32F411CE`) or ST-Link
(OpenOCD); they need physical hardware attached.

## Conventions for this repo

- All source files carry a license header:
  `Copyright (c) 2026 HardenedLinux Animula` /
  `Author: Nala Ginrut <roy@hardenedlinux.org>` / `SPDX-License-Identifier: GPL-3.0-or-later`.
- Do not add SoC/HAL code — reuse upstream STM32F411 support.
- Keep the devicetree and Kconfig minimal; no deprecated bindings or
  properties (`label` on nodes, `fixed-partitions`, `mmc-spi-slot`,
  `CONFIG_PINMUX`, `CONFIG_CLOCK_STM32_HSE_CLOCK`, `SPI_STM32_INTERRUPT`
  defaults, etc.).
- No MCUboot / A-B slots / scratch partition. A single Maker Bootloader sits
  at the flash base; the application is linked at
  `FLASH_BASE + ALONZO_BOOTLOADER_SIZE` (default 0x20000). See
  `bootloader/include/memory_layout.h`.
