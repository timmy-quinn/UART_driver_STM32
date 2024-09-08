#include <stdint.h>
#include "include/CMSIS_core/system_stm32f4xx.h"
#include "include/CMSIS_core/stm32f4xx.h"
#include "include/drivers/usart.h"

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
    GPIOA->MODER |= GPIO_MODER_MODER5_0; // Set the gpio pin to output
    GPIOA->MODER &= ~GPIO_MODER_MODER5_1; 
                                       //
    GPIOA->OTYPER |= ~GPIO_OTYPER_OT_5; // Set the output type to pull-up, pull down 
 }

void toggle_LED() {
    GPIOA->ODR ^= GPIO_ODR_ODR_5;
}

int main(void) {
    uint8_t test_char = 'h';
    USART_enable(USART1);

    while(1) {
        USART_transmit_byte(&test_char, sizeof(test_char), USART1);
    }
}
