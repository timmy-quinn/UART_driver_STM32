// USART Driver
#include ".\..\include\CMSIS_core\stm32f4xx.h"
#include ".\..\include\drivers\usart.h"
#include ".\..\include\drivers\gpio.h"
#include <stdbool.h>

#define CLOCK_SPEED 8000000
#define BAUD_RATE 19200
#define OVER8 0


/*
 * USAART DIV calculation
 * usartdiv = (clock)/(16 * (2 - OVER8) * baudrate)
 * clock = 8000000, OVER8 = 0, baudrate = 0
 * usartdiv = 26.0416666666668
 * div_fraction = 16 * 0d.041666666 = 0.66666 = 1
 * div_mantissa = 26 = 0x1A
*/
#define USARTDIV_19200 0x01A1 // This is somehow actually the baud rate generator for 38400. Maybe clock is actually 38400?

// UART Transmitter Procedure:
// 1.Enable the USART by writing the UE bit in USART_CR1 register to 1.
// 2.Program the M bit in USART_CR1 to define the word length.
// 3.Program the number of stop bits in USART_CR2.
// 4.Select DMA enable (DMAT) in USART_CR3 if Multi buffer Communication is to take
// place. Configure the DMA register as explained in multibuffer communication.
// 5.Select the desired baud rate using the USART_BRR register.
// 6.Set the TE bit in USART_CR1 to send an idle frame as first transmission.
// 7.Write the data to send in the USART_DR register (this clears the TXE bit). Repeat this
// for each data to be transmitted in case of single buffer.
// 8.After writing the last data into the USART_DR register, wait until TC=1. This indicates
// that the transmission of the last frame is complete. This is required for instance when
// the USART is disabled or enters the Halt mode to avoid corrupting the last
// transmission.
void USART_enable(USART_TypeDef * USART){
    // Move this to appropriate driver
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;

    // USART->CR1 = 0;
    USART->CR1 |= USART_CR1_UE;
    USART->CR1 &= ~USART_CR1_M; // Set data bits to 8

    // Set USART to 1 stop bits
    USART->CR2 &= ~USART_CR2_STOP_0;
    USART->CR2 &= ~USART_CR2_STOP_1; 
    // USART1->CR3 |= USART_CR3
    USART->BRR = USARTDIV_19200; 
    USART->CR1 |= USART_CR1_TE;
    USART->CR1 |= USART_CR1_RE;
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
       USART->DR = *data; 
        while((USART->SR & USART_SR_TC) == 0){
        }
    }
}


bool USART_is_received(USART_TypeDef *USART) {
    if(USART-> SR & USART_SR_RXNE) {
        return true;
    }
}

uint8_t USART_read_byte(USART_TypeDef *USART) { 
    return (uint8_t)USART->DR;
}
// UART Receiver Procedure:
// 1.Enable the USART by writing the UE bit in USART_CR1 register to 1.
// 2.Program the M bit in USART_CR1 to define the word length.
// 3.Program the number of stop bits in USART_CR2.
// 4.Select DMA enable (DMAR) in USART_CR3 if multibuffer communication is to take
// place. Configure the DMA register as explained in multibuffer communication. STEP 3
// 5.Select the desired baud rate using the baud rate register USART_BRR
// 6.Set the RE bit USART_CR1. This enables the receiver that begins searching for a start
// bit.