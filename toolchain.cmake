# the name of the target operating system
set(CMAKE_SYSTEM_NAME Generic)

# the name of the system processor
set(CMAKE_SYSTEM_PROCESSOR arm)

# native to system
#set(CMAKE_SYSROOT /home/sam/toolchains/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER   /home/sam/toolchains/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER /home/sam/toolchains/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-g++)

# where is the target environment located
#set(CMAKE_FIND_ROOT_PATH  /usr/i586-mingw32msvc
#/home/sam/develop/MANTIS-STM32FreeRTOS)

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

