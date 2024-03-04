CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash

CFLAGS = -W -Wall -Wextra -Werror -Wundef -Wshadow -Wdouble-promotion \
	    -Wformat-truncation -fno-common -Wconversion \
	    -g3 -Os -ffunction-sections -fdata-sections -I. \
	    -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 $(EXTRA_CFLAGS)

LDFLAGS = -Tlinker.ld -nostartfiles -nostdlib --specs nano.specs -lc -lgcc -Wl,--gc-sections -Wl,-Map=$@.map

all: baremetal.bin

# baremetal.o: baremetal.c
# 	$(CC) $(CFLAGS) -c -o baremetal.o baremetal.c
# 
# baremetal.elf: linker.ld baremetal.o
# 	$(LD) $(LDFLAGS) -o baremetal.elf baremetal.o
# 
baremetal.bin: baremetal.elf
	$(BIN) -O binary baremetal.elf baremetal.bin 

baremetal.elf: baremetal.c
	$(CC) baremetal.c $(CFLAGS) $(LDFLAGS) -o $@

flash: baremetal.bin
	$(STL) write baremetal.bin 0x8000000

clean:
	@rm -vf *.o *.elf *.bin 

.PHONY: all flash clean
