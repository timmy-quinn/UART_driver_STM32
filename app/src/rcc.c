#include "../include/CMSIS_core/stm32f4xx.h"
#include "../include/drivers/rcc.h"

void set_clock() {
    RCC->CR |=  ( RCC_CR_HSION );
    while ( !( RCC->CR & RCC_CR_HSIRDY ) ) {};
    RCC->CFGR &= ~( RCC_CFGR_SW );
    RCC->CFGR |=  ( RCC_CFGR_SW_HSI );
    while ( ( RCC->CFGR & RCC_CFGR_SWS ) != RCC_CFGR_SWS_HSI ) {};
}