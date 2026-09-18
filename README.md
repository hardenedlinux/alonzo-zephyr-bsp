# alonzo-zephyr-bsp

Zephyr board support package (BSP) for the **Animula Alonzo** board,
an STM32F411CE based development board from
[HardenedLinux](https://github.com/hardenedlinux).

This BSP targets **Zephyr 4.4** and follows the current Zephyr hardware
model (HWMv2, `board.yml`). It reuses the upstream STM32F411 SoC support —
no SoC code is duplicated here.

## Layout

```
alonzo-zephyr-bsp/
├── zephyr/
│   └── module.yml                    # registers this repo as a Zephyr module
└── boards/
    └── animula/
        └── animula_alonzo/
            ├── board.yml             # HWMv2 board metadata
            ├── animula_alonzo.dts    # devicetree
            ├── animula_alonzo_defconfig
            ├── animula_alonzo.yaml   # twister metadata
            ├── Kconfig.animula_alonzo
            ├── board.cmake           # flash/debug runners (J-Link + OpenOCD)
            ├── support/openocd.cfg
            └── doc/index.rst
```

## Hardware

- MCU: STM32F411CE (UFQFPN48), Cortex-M4F
- Flash: 512 KB, SRAM: 128 KB
- Clock: 24 MHz HSE -> PLL -> 96 MHz SYSCLK (48 MHz USB)
- Console: USART1 (PA9/PA10, 115200 8N1)
- UART2: PA2/PA3 (BLE), I2C1/I2C2/I2C3, SPI1 (Micro-SD) / SPI2, USB OTG FS,
  RTC
- 4 user LEDs, 1 user button, BLE enable/disable GPIO

See `boards/animula/animula_alonzo/doc/index.rst` for the full pin map.

## Usage

This repository is a Zephyr module. Point your Zephyr 4.4 workspace at it,
then build normally.

### Option A — via `ZEPHYR_EXTRA_MODULES`

```sh
export ZEPHYR_EXTRA_MODULES=/path/to/alonzo-zephyr-bsp
cd <zephyr-workspace>
west boards | grep animula
west build -b animula_alonzo samples/hello_world
```

### Option B — as a west project

Add it to your workspace manifest:

```yaml
manifest:
  projects:
    - name: alonzo-zephyr-bsp
      path: modules/alonzo-zephyr-bsp
      url: https://github.com/hardenedlinux/alonzo-zephyr-bsp.git
      revision: master
```

Then:

```sh
west update
west boards | grep animula
west build -b animula_alonzo samples/hello_world
```

## License

GPL-3.0-or-later. See `LICENSE`.

Copyright (c) 2026 HardenedLinux Animula.
Author: Nala Ginrut <roy@hardenedlinux.org>.

