// These instructions define attributes of our chip
// and the assembly language we'll use

.syntax unified
.cpu cortex-m4
.thumb

// Global memory locations 
.global vtable
.global reset_handler

/*
 * The vector table
 * Only the size of RAM and 'reset' handler are included
*/

//Sets the symbol vtable to type object
//There are multiple syntaxes supported, including #, @, and %
.type vtable, %object 
vtable:
	.word _estack
	.word reset_handler
.size vtable, .-vtable 

// The .size directive can be used to tell the assembler how much space 
// The data that a symbol points to is using. This way the linker can 
// exclude the function if it is used. 

//The first few lines just tell the compiler what sort of syntax it should
//expect, and what sort of machine commands it can generate. Thumb is the 
//instruction set used by cortex-m processors. Not using the typical ARM
//instruction set


/*
 * Reset handler. Called on reset
 */
.type reset_handler, %function // set the symbol reset handler to a function
reset_handler:
	// Set the stack pointer to the end of the stack.
	// The '_estack' value is defined in the linker script
	LDR r0, =_estack //store end of stack in r0. LDR is a pseudo instruction
	MOV sp, r0 // move the stack pointer to the end of stack

	// Set dummy values to check with debugger
	LDR r7, =0xFEEDBEEF
	MOVS r0, #0 // Move the value 0 to register r0
	main_loop:
		// Add 1 to register r0
		ADDS r0, r0, #1
		// Loop back
		B main_loop
.size reset_handler, .-reset_handler

// THe MOVS and MOV commands can move a value from one register to another.
// We can also use # to set a register to a constant number, but only up to 
// 255. For larger values the LDR is used, which loads an entire 4 byte word
// from memory into a register. The = symbol in front of the hex values is
// shorthand which tells the compiler to place the given word nearby in 
// memory, then load that address into the register
// The ADDS command is simble addition. ADDS a, b, c -> a = b + c
// B command is of course branch



