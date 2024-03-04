CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash

CFLAGS = -mthumb -mcpu=cortex-m4

all: baremetal.bin

baremetal.o: baremetal.c
	$(CC) $(CFLAGS) -c -o baremetal.o baremetal.c

baremetal.elf: linker.ld baremetal.o
	$(LD) -T linker.ld -o baremetal.elf baremetal.o

baremetal.bin: baremetal.elf
	$(BIN) -O binary baremetal.elf baremetal.bin 

flash: baremetal.bin
	$(STL) write baremetal.bin 0x8000000

clean:
	@rm -vf *.o *.elf *.bin 

.PHONY: all flash clean
