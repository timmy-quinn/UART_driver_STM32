// USART Driver
#include ".\..\CMSIS_core\stm32f4xx.h"
#include "usart.h"
#include "gpio.h"
#include <stdbool.h>

void USART_enable(USART_TypeDef * USART){
    USART->CR1 |= USART_CR1_UE;
    USART->CR1 &= ~USART_CR1_M; // Set data bits to 8

    USART->CR2 &= ~USART_STOP_BIT_MASK;
    USART->CR2 &= ~USART_CR2_STOP_0; // Set USART stop bits 
    USART->CR2 &= ~USART_CR2_STOP_1; 

    USART->BRR = BAUD_RATE_16MHZ_38400; // Set baud rate 
    USART->CR1 |= USART_CR1_TE; // Set transmit enable
    USART->CR1 |= USART_CR1_RE; // Set receive enable
}

void USART_set_DMA(USART_TypeDef * USART, bool enable) {
    if(enable) {
        USART->CR3 |= USART_CR3_DMAT;
        USART->CR3 |= USART_CR3_DMAR;
    } else {
        USART->CR3 &= ~USART_CR3_DMAT;
        USART->CR3 &= ~USART_CR3_DMAR;
    } 
}

// Using PA9 for TX and PA10 for RX, after checking the  
//TODO: Move this to gpio driver or whatever
void USART_set_pin(GPIO_TypeDef * GPIO, uint8_t usart_pin) {
    // Set USART1_TX pin as alternate function mode
    GPIO->MODER &= ~(MODER_PIN_MASK << (usart_pin * MODER_BITS_PER_PIN));
    GPIO->MODER |= (MODER_AF << (usart_pin * MODER_BITS_PER_PIN)); 

    GPIO->OSPEEDR &= ~(OSPEEDR_PIN_MASK << (usart_pin * OSPEEDR_BITS_PER_PIN));
    GPIO->OSPEEDR |= (OSPEEDR_HIGH_SPEED << (usart_pin * OSPEEDR_BITS_PER_PIN));

    uint8_t afrIndex = (AFR_BITS_PER_PIN * usart_pin)/32;
    GPIO->AFR[afrIndex] &= ~(AFR_PIN_MASK << ((usart_pin - afrIndex * 8) * AFR_BITS_PER_PIN));
    GPIO->AFR[afrIndex] |= (AF7 << ((usart_pin - afrIndex * 8) * AFR_BITS_PER_PIN));
}


void USART_transmit_byte(uint8_t* data, uint8_t length, USART_TypeDef * USART) {
    for(uint8_t i = 0; i < length; i++) {
       USART->DR = data[i]; 
        while((USART->SR & USART_SR_TC) == 0){
        }
    }
}


bool USART_is_received(USART_TypeDef *USART) {
    if(USART-> SR & USART_SR_RXNE) {
        return true;
    }
    else { return false;}
}

uint8_t USART_read_byte(USART_TypeDef *USART) { 
    return (uint8_t)USART->DR;
}