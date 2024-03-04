CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash

CFLAGS = -mthumb -mcpu=cortex-m4

all: baremetal.bin

crt.o: crt.s
	$(AS) -o crt.o crt.s

baremetal.o: baremetal.c
	$(CC) $(CFLAGS) -c -o baremetal.o baremetal.c

baremetal.elf: linker.ld crt.o baremetal.o
	$(LD) -T linker.ld -o baremetal.elf crt.o baremetal.o

baremetal.bin: baremetal.elf
	$(BIN) -O binary baremetal.elf baremetal.bin 

flash: baremetal.bin
	$(STL) write baremetal.bin 0x8000000

clean:
	@rm -vf *.o *.elf *.bin 

.PHONY: all flash clean
