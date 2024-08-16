/* Define the end of ram and the limit of stack memory
 * (128KB SRAM on the STM32F446RE 
 * (RAM starts at address 0x20000000, length of 0x20000)
 * (Flash starts at 0x8000000, length of 0x800000)
 */
_estack = 0x20020000; /* First address outside of ram: 0x20000000 + 0x20000 */

MEMORY
{
	FLASH ( rx )	: ORIGIN = 0x8000000, LENGTH = 512K
	RAM ( rxw )	: ORIGIN = 0x20000000, LENGTH = 128K
}
