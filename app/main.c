#include <stdint.h>
#include "Includes/system_stm32f4xx.h"
#include "Includes/stm32f4xx.h"

// PA5 is the LED pin
#define LED_PIN
 
// Each IO pin has four configuration registers.
// GPIOx_MODER, GPIOx_OTYPER, GPIOx_OSPEEDR and GPIOs_PUDR
// Two data register GPIOx_IDR and GPIOx_ODR: which store either output data or input data
// Two 32 bit alternate function selection registers GPIOx_AFRH and GPIOx_AFRL 

void setLED(){

    // SET GPIOAEN to 1
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
    // Set GPIOA_MODER to output
    GPIOA->MODER
}

int main(void) {

    while(1){
        // set GPIOA_ODR to output
        
    }
}
