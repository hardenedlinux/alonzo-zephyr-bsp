# Copyright (c) 2026 HardenedLinux Animula
# Author: Nala Ginrut <roy@hardenedlinux.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

board_runner_args(jlink "--device=STM32F411CE" "--speed=4000")

include(${ZEPHYR_BASE}/boards/common/openocd.board.cmake)
include(${ZEPHYR_BASE}/boards/common/jlink.board.cmake)
