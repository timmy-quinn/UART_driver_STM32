# Define the linker script location and chip architecture.
LD_SCRIPT = linker.ld
MCU_SPEC  = cortex-m4

BUILDDIR = build
TARGET = main


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

VECT_TBL =vector_table.S

AS_SRC   = core.S

C_SRC   = main.c
C_SRC	+= drivers/usart.c	
C_SRC 	+= drivers/rcc.c

# OBJS =  build/asm/$(VECT_TBL:.S=.o)
# OBJS += build/asm/$(AS_SRC:.S=.o)
# OBJS += build/c/$(C_SRC:.c=.o)

# Correctly define object files by applying the directory prefix and substitution
OBJS = $(addprefix build/asm/, $(notdir $(VECT_TBL:.S=.o)))
OBJS += $(addprefix build/asm/, $(notdir $(AS_SRC:.S=.o)))
OBJS += $(addprefix build/c/, $(notdir $(C_SRC:.c=.o)))

INCLUDE = -I./
INCLUDE += -I/CMIS_core
INCLUDE += -I/drivers


#.PHONY: $(BUILDDIR)

#$(BUILDDIR)/asm:
#	mkdir -p $(BUILDDIR)/asm

#$(BUILDDIR)/c:
#	mkdir -p $(BUILDDIR)/c


.PHONY: all
all: build/$(TARGET).bin | $(BUILDDIR)

build/asm/%.o: %.S 
	mkdir -p ./$(BUILDDIR)/asm
	$(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@

build/c/%.o: %.c 
	mkdir -p ./$(BUILDDIR)/c
	$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

build/$(TARGET).elf: $(OBJS)
	$(CC) $^ $(LFLAGS) -o $@

# Object copy
build/$(TARGET).bin: build/$(TARGET).elf
	$(OC) -S -O binary $< $@  
	$(OS) $< 


.PHONY: $(BUILDDIR)

.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).elf
	rm -f $(TARGET).bin