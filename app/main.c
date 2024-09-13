#include <stdint.h>
#include "include/CMSIS_core/system_stm32f4xx.h"
#include "include/CMSIS_core/stm32f4xx.h"
#include "include/drivers/usart.h"
#include "include/drivers/rcc.h"

// PA5 is the LED pin
#define LED_PIN
 

void setLED(){
    // SET GPIOAEN to 1
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
    // Set GPIOA_MODER to output
    GPIOA->MODER |= GPIO_MODER_MODER5_0; // Set the gpio pin to output
    GPIOA->MODER &= ~GPIO_MODER_MODER5_1; 
    GPIOA->OTYPER |= ~GPIO_OTYPER_OT_5; // Set the output type to pull-up, pull down 
 }

void toggle_LED() {
    GPIOA->ODR ^= GPIO_ODR_ODR_5;
}

void test_transmit() {
    uint8_t test_char = '1';
    uint8_t newline = '\n';

    // uint8_t helloworld[11] = "hello world\n";
    // setLED();
    while(1) {
        for(uint32_t i = 0; i < 8000000/100; i++) {}
        
        USART_transmit_byte(&test_char, sizeof(test_char), USART1);
        USART_transmit_byte(&newline, sizeof(newline), USART1); 
        // USART_transmit_byte(helloworld, sizeof(helloworld), USART1); 
    }
}

void test_transmit_multi_byte() {

    uint8_t test_string[3] = "12";
    while(1) {
        for(uint32_t i = 0; i < 8000000/100; i++) {}
        
        USART_transmit_byte(&(test_string[0]), 2, USART1); 
    }
}


void echo() {
    uint8_t received_char = 'r';
    uint8_t echo_char = ' ';
    uint8_t newline = '\n';
    while(1) {
        if (USART_is_received(USART1))
        {
            // USART_transmit_byte(&received_char, sizeof(received_char), USART1);
            echo_char = USART_read_byte(USART1);
            USART_transmit_byte(&echo_char, sizeof(echo_char), USART1);
            USART_transmit_byte(&received_char, sizeof(received_char), USART1);
            USART_transmit_byte(&newline, sizeof(newline), USART1);
        }
    }
}


int main(void) {
    set_clock();

    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;

    USART_enable(USART1);
    USART_set_pin(GPIOA, 9);
    USART_set_pin(GPIOA, 10);

    test_transmit_multi_byte();
    // echo();
}
