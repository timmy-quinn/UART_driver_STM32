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
    GPIOA->MODER |= GPIO_MODER_MODER5; // Set the gpio pin to output
    GPIOA->OTYPER |= GPIO_OTYPER_OT_5; // Set the gpio pin output to high
}

void toggle_LED() {
    GPIOA->ODR ^= GPIO_ODR_ODR_5;
}

int main(void) {
    uint16_t timer = 0;
    setLED();
    while(1){
        // set GPIOA_ODR to output
        if(timer == 10000)
        {
            toggle_LED();
            i = 0;
        }
        i++; 
    }
}
