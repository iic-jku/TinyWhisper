cmake_minimum_required (VERSION 3.30.0)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/toolchain.cmake)

project ("TinyRV-Radio")
enable_language(C ASM)

add_compile_definitions("__riscv32__")

add_executable("demo.elf")
add_executable("display.elf")
add_executable("hardware_test.elf")

target_compile_options("demo.elf" PUBLIC
  -fno-exceptions
  -nostdlib
  -march=rv32e_zicsr
  -mabi=ilp32e
  -Os
  -Bstatic
)
target_compile_options("display.elf" PUBLIC
  -fno-exceptions
  -nostdlib
  -march=rv32e_zicsr
  -mabi=ilp32e
  # -Os
  -Bstatic
)
target_compile_options("hardware_test.elf" PUBLIC
  -fno-exceptions
  -nostdlib
  -march=rv32e_zicsr
  -mabi=ilp32e
  # -Os
  -Bstatic
)

target_link_options("demo.elf" PRIVATE -Wl,--gc-sections)
target_link_options("display.elf" PRIVATE -Wl,--gc-sections)
target_link_options("hardware_test.elf" PRIVATE -Wl,--gc-sections)

target_link_options("demo.elf" PUBLIC
  -T ${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
  -Bstatic
  -nostdlib
  -nostartfiles
  -march=rv32e
)

target_link_options("display.elf" PUBLIC
  -T ${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
  -Bstatic
  -nostdlib
  -nostartfiles
  -march=rv32e
)
target_link_options("hardware_test.elf" PUBLIC
  -T ${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
  -Bstatic
  -nostdlib
  -nostartfiles
  -march=rv32e
)

target_include_directories(demo.elf
 PUBLIC ${CMAKE_SOURCE_DIR}/printf
)
target_include_directories(display.elf
 PUBLIC ${CMAKE_SOURCE_DIR}/printf
 PUBLIC ${CMAKE_SOURCE_DIR}/oled_96
 PUBLIC ${CMAKE_SOURCE_DIR}
)
target_include_directories(hardware_test.elf
 PUBLIC ${CMAKE_SOURCE_DIR}/printf
 PUBLIC ${CMAKE_SOURCE_DIR}
)

target_link_libraries(demo.elf
  gcc
)
target_link_libraries(display.elf
  gcc
)
target_link_libraries(hardware_test.elf
  gcc
)

target_sources("demo.elf" PUBLIC
  "start.s"
  "demo.c"
  "interrupts.c"
  "csr.c"
  "mmio.c"
  "wspr.c"
  "printf/printf.c"
)
target_sources("display.elf" PUBLIC
  "start.s"
  "oled_96/oled96.c"
  "oled_96/sample.c"
  "oled_96/fonts.c"
  "interrupts.c"
  "csr.c"
  "mmio.c"
  "wspr.c"
  "printf/printf.c"
)
target_sources("hardware_test.elf" PUBLIC
  "start.s"
  "hardware_test.c"
  "interrupts.c"
  "csr.c"
  "mmio.c"
  "wspr.c"
  "printf/printf.c"
)

add_custom_target(demo.bin
  DEPENDS demo.elf
  COMMAND objcopy -O binary "demo.elf" --set-start 0 demo.bin
)
add_custom_target(display.bin
  DEPENDS display.elf
  COMMAND objcopy -O binary "display.elf" --set-start 0 display.bin
)
add_custom_target(hardware_test.bin
  DEPENDS hardware_test.elf
  COMMAND objcopy -O binary "hardware_test.elf" --set-start 0 hardware_test.bin
)

add_custom_target(demo.txt
  DEPENDS demo.bin
  COMMAND sh ${CMAKE_SOURCE_DIR}/readable.sh
)
add_custom_target(display.txt
  DEPENDS display.bin
  COMMAND sh ${CMAKE_SOURCE_DIR}/readable.sh
)
add_custom_target(hardware_test.txt
  DEPENDS hardware_test.bin
  COMMAND sh ${CMAKE_SOURCE_DIR}/readable.sh
)

add_custom_target(program_sram
  DEPENDS demo.bin
  COMMAND python3 ${CMAKE_SOURCE_DIR}/program_sram.py ARGS /dev/ttyACM0 ${CMAKE_CURRENT_BINARY_DIR}/demo.bin
)
