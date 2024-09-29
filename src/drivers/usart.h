#include <stdint.h>
#include <stdbool.h>


#define BAUD_RATE_16MHZ_9600 0x683
#define BAUD_RATE_16MHZ_19200 0x341
#define BAUD_RATE_16MHZ_38400 0x1a1
#define BAUD_RATE_16MHZ_57600 0x116
#define BAUD_RATE_16MHZ_115200 0x8b
#define USART_STOP_BIT_MASK            (USART_CR2_STOP_1 | USART_CR2_STOP_0)  
#define HALF_STOP_BIT                      USART_CR2_STOP_0
#define TWO_STOP_BIT                       USART_CR2_STOP_1
#define ONE_AND_A_HALF_STOP_BIT            (USART_CR2_STOP_1 | USART_CR2_STOP_0)  

void USART_enable(USART_TypeDef *USART);
void USART_set_DMA(USART_TypeDef * USART, bool enable);
void USART_transmit_byte(uint8_t* data, uint8_t length, USART_TypeDef* USART); 
void USART_set_pin(GPIO_TypeDef * GPIO, uint8_t usart_pin); 
bool USART_is_received(USART_TypeDef *USART); 
uint8_t USART_read_byte(USART_TypeDef *USART);