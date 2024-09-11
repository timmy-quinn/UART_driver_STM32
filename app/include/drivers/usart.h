#include <stdint.h>
#include <stdbool.h>

void USART_enable(USART_TypeDef *USART);
void USART_transmit_byte(uint8_t* data, uint8_t length, USART_TypeDef* USART); 
void USART_set_pin(GPIO_TypeDef * GPIO, uint8_t usart_pin); 
bool USART_is_received(USART_TypeDef *USART); 
uint8_t USART_read_byte(USART_TypeDef *USART);