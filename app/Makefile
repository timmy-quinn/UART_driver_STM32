TARGET = main
# Define the linker script location and chip architecture.
LD_SCRIPT = linker.ld
MCU_SPEC  = cortex-m4

BUILDDIR = ./build #TODO: Add build directory

# Toolchain definitions (ARM bare metal defaults)
TOOLCHAIN = ~/toolchains
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OC = arm-none-eabi-objcopy
OD = arm-none-eabi-objdump
OS = arm-none-eabi-size

# Assembly directives.
ASFLAGS += -c
ASFLAGS += -O0
ASFLAGS += -mcpu=$(MCU_SPEC)
ASFLAGS += -mthumb
ASFLAGS += -Wall
# (Set error messages to appear on a single line.)
ASFLAGS += -fmessage-length=0

# C compilation directives
CFLAGS += -mcpu=$(MCU_SPEC)
CFLAGS += -mthumb
CFLAGS += -Wall
CFLAGS += -g
# (Set error messages to appear on a single line.)
CFLAGS += -fmessage-length=0
# (Set system to ignore semihosted junk)
CFLAGS += --specs=nosys.specs

# Linker directives.
LSCRIPT = ./$(LD_SCRIPT)
LFLAGS += -mcpu=$(MCU_SPEC)
LFLAGS += -mthumb
LFLAGS += -Wall
LFLAGS += --specs=nosys.specs
LFLAGS += -nostdlib
LFLAGS += -lgcc
LFLAGS += -T$(LSCRIPT)

VECT_TBL = ./vector_table.S

AS_SRC   = ./core.S

C_SRC    = ./main.c

OBJS =  $(VECT_TBL:.S=.o)
OBJS += $(AS_SRC:.S=.o)
OBJS += $(C_SRC:.c=.o)

INCLUDE = -I./
INCLUDE += -I/CMIS_core

.PHONY: all
all: $(TARGET).bin
%.o: %.S
	$(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@
%.o: %.c
	$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@
$(TARGET).elf: $(OBJS)
	$(CC) $^ $(LFLAGS) -o $@
$(TARGET).bin: $(TARGET).elf
	$(OC) -S -O binary $< $@ # Object copy 
	$(OS) $< 
.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).elf
