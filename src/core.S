.syntax unified
.cpu cortex-m4
.thumb

.global reset_handler

/*
 * Reset handler. Called on reset
 */
.type reset_handler, %function // set the symbol reset handler to a function
reset_handler:
	// Set the stack pointer to the end of the stack.
	// The '_estack' value is defined in the linker script
	LDR r0, =_estack //store end of stack in r0. LDR is a pseudo instruction
	MOV sp, r0 // move the stack pointer to the end of stack

	// Copy data from flash to RAM data init section.
	// R2 wil store our progress along with the sidata section.
	MOVS r0, #0
	// Load the start/end addresses of the data section,
	// and the start of the data init section.
	LDR r1, = _sdata
	LDR r2, = _edata
	LDR r3, = _sidata
	B	copy_sidata_loop

	copy_sidata:
		// Offset the data init section by our copy progress.
		LDR r4, [r3, r0] // load the value in r3 plus r0 into r4
		STR r4, [r1, r0] // store value r4 into address pointed at by r1 + r0
		ADDS r0, r0, #4 // r0 +=4
	copy_sidata_loop:
		// Unless the whole data section has been copied, 
		// copy the next word from sidata to data.
		// We're copying this section from program memory to RAM
		// start at r1 = sidata start, 
		// increment r0 from 0 until r0 + r1 is equal to r2 = _edata
		ADDS r4, r0, r1 
		CMP r4, r2      
		BCC copy_sidata
	
	// Once we are done copying the data section into RAM, 
	// move on to filling the BSS section with 0s
	// The bss stores unintialized global and static variables
	MOVS r0, #0
	LDR r1, =_sbss
	LDR r2, =_ebss
	B reset_bss_loop

	// Fill the BSS segment with 0's
	reset_bss:
		// Store a 0 and increment by a word
		STR r0, [r1]
		ADDS r1, r1, #4
	reset_bss_loop:
		// We'll use r1 to count progress here. 
		// reset the next word and increment
		CMP r1, r2
		BCC reset_bss
	
	// Branch to the main method.
	B main	
.size reset_handler, .-reset_handler // Mark the end of the reset handler
