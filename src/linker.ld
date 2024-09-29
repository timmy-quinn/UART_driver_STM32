/* Label the program's entry point */
ENTRY(reset_handler)

/* Define the end of ram and the limit of stack memory
 * (128KB SRAM on the STM32F446RE 
 * (RAM starts at address 0x20000000, length of 0x20000)
 * (Flash starts at 0x8000000, length of 0x800000)
 */
_estack = 0x20020000; /* First address outside of ram: 0x20000000 + 0x20000 */

_Min_Leftover_RAM = 0x400;

MEMORY
{
	FLASH ( rx )	: ORIGIN = 0x8000000, LENGTH = 512K
	RAM ( rxw )	: ORIGIN = 0x20000000, LENGTH = 128K
}

/* The following section uses the special linker variable dot '.', 
 * which always contains the current output location counter.
 * Since the . always refers to a location in an output section, 
 * it may only appear in an expression within a SECTIONS command. 
 * The . symbol may appear anywhere that an ordinary symbol is allowed
 * in an expression. 
 * 
 * Assigning a value to . will cause the location counter to be moved.
 * This may be used to create holes in the output section.
 * The location counter may not be moved backwards inside an output section, 
 * and may not be moved backwards outside of an output section if 
 * doing so creates aread with overlapping LMAs (Load Memory Address)
 * https://sourceware.org/binutils/docs/ld/Location-Counter.html
 * */
SECTIONS
{
	/* The vector table goes at the start of flash */
	.vector_table :
	{
		. = ALIGN(4);
		/* KEEP Instructs the assembler to retain named local labels 
		 * in the symbol table in the object file */
		KEEP (*(.vector_table)) 
		. = ALIGN(4);
	} >FLASH

	/* The 'text' section contains the main program code. */
	.text : 
	{
		. = ALIGN(4);
		/* *(.text) Indicates all section names matching .text */
		/* *(.text*) Indiates sections matching .text with addition of a wildcard value
		 * so for example .textTEST*/
		*(.text) 
		*(.text*) 
		. = ALIGN(4);
	} >FLASH
	
	/* The 'rodata' section contains read-only data,
	 * constants, strings, information that won't change. */
	.rodata :
	{
		. = ALIGN(4);
		*(.rodata)
		*(.rodata*)
		. = ALIGN(4);
	} >FLASH

	/* The 'data' section is space set aside in RAM for 
	 * things like variables, which can change. */
	_sidata = .;
	.data : AT(_sidata)
	{
		. = ALIGN(4);
		/* Mark start/end locations for the 'data section' */
		_sdata = .;
		*(.data)
		*(.data*)
		_edata = .;
		. = ALIGN(4);
	} >RAM

	/* The 'bss' section is similar to the 'data' section, 
	 * but its space is initialized to all 0s at the start
	 * of the program */
	.bss :
	{
		. = ALIGN(4);
		/* Mark the start/end of the BSS section */
		_sbss = .;
		*(.bss)
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
	} >RAM

	/* Space set aside for the application's heap/stack */
	.dynamic_allocations : 
	{
		. = ALIGN(4);
		_ssystem_ram = .;
		. = . + _Min_Leftover_RAM;
		. = ALIGN(4);
		_esystem_ram = .;
	}
}

