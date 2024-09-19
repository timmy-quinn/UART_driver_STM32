# Define the linker script location and chip architecture.
LD_SCRIPT = linker.ld
MCU_SPEC  = cortex-m4

BUILDDIR = build
TARGET = $(BUILDDIR)/main


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

AS_SRC   =core.S
AS_SRC 	 +=vector_table.S

C_SRC   =main.c
C_SRC	+=drivers/usart.c	
C_SRC 	+=drivers/rcc.c


# Correctly define object files by applying the directory prefix and substitution
OBJS += $(patsubst %.S, $(BUILDDIR)/%.o, $(AS_SRC))
OBJS += $(patsubst %.c, $(BUILDDIR)/%.o, $(C_SRC))

OBJDIRS = $(sort $(dir $(OBJS)))


INCLUDE = -I./
INCLUDE += -I/CMIS_core
INCLUDE += -I/drivers


.PHONY: all
all: $(BUILDDIR) | $(TARGET).bin 

$(BUILDDIR)/%.o: %.S 
	$(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@

$(BUILDDIR)/%.o: %.c 
	$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

$(TARGET).elf: $(OBJS)
	$(CC) $^ $(LFLAGS) -o $@

# Object copy
$(TARGET).bin: $(TARGET).elf
	$(OC) -S -O binary $< $@  
	$(OS) $< 


.PHONY: $(BUILDDIR)
$(BUILDDIR): $(OBJDIRS)

$(OBJDIRS): 
	mkdir -p $@


.PHONY: ec
ec: 
	echo $(OBJS)
	echo $(OBJDIRS)


.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).elf
	rm -f $(TARGET).bin