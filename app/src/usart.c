// USART Driver
#include ".\..\include\CMSIS_core\stm32f4xx.h"
#include ".\..\include\drivers\usart.h"

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
#define USARTDIV_19200 0x01A1

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
void USART1_enable(){
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;


    USART1->CR1 |= USART_CR1_UE;
    USART1->CR1 |= USART_CR1_M;
    USART1->CR2 |= USART_CR2_STOP_0;
    USART1->CR2 |= USART_CR2_STOP_1;
    // USART1->CR3 |= USART_CR3
    USART1->BRR = USARTDIV_19200; 
    USART1->CR1 |= USART_CR1_TE;
}

// Use PA2 and PA3 for rx and tx registers 
//TODO: Move this to gpio driver or whatever
void USART1_set_tx_pin() {

    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    // Set USART1_TX pin as alternate function mode
    GPIOA->MODER &= ~GPIO_MODER_MODER2_0; // Set the gpio pin to alternate function
    GPIOA->MODER |= GPIO_MODER_MODER2_1; 

   GPIOA->OTYPER |= GPIO_OTYPER_2;
}

void USART_transmit_byte(uint8_t* data, uint8_t length) {
    for(uint8_t i = 0; i < length; i++) {
       USART1->DR = *data; 
    }
    while((USART1->SR & USART_SR_TC) == 0){
    }
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