CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash

CFLAGS = -mthumb -mcpu=cortex-m4

BUILD_DIR = build


baremetal_SRC := baremetal.c 
baremetal_OBJ := $(patsubst %,$(BUILD_DIR)/%.o,$(baremetal_SRC))
baremetal_INC := 
baremetal_LIB := 
baremetal_CPPFLAGS := 
baremetal_LDFLAGS := -L$(BUILD_DIR) 


all: $(BUILD_DIR)/flashtarget.bin

$(BUILD_DIR)/crt.o: crt.s | $(BUILD_DIR)
	$(AS) -o $(BUILD_DIR)/crt.o crt.s

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD_DIR)/%.elf: linker.ld $(BUILD_DIR)/crt.o $(baremetal_OBJ) | $(BUILD_DIR)
	$(LD) -T linker.ld -o $@ $(BUILD_DIR)/crt.o $(baremetal_OBJ)


$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) -O binary $< $@ 

flash: $(BUILD_DIR)/flashtarget.bin
	$(STL) write $< 0x8000000

$(BUILD_DIR):
	@mkdir -pv $@

clean:
	@rm -rvf *.o *.elf *.bin $(BUILD_DIR)

.PHONY: all flash clean
