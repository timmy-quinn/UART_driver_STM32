#include <stdint.h>

void USART_enable(USART_TypeDef *USART);
void USART_transmit_byte(uint8_t* data, uint8_t length, USART_TypeDef* USART); 
void USART_set_tx_pin(GPIO_TypeDef * GPIO, uint8_t usart_pin); 