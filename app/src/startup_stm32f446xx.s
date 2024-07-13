@ ******************** (C) COPYRIGHT 2016 STMicroelectronics ********************
@* File Name          : startup_stm32f446xx.s
@* Author             : MCD Application Team
@* @version           : V1.8.1
@* @date              : 27-January-2022
@* Description        : STM32F446x devices vector table for MDK-ARM toolchain. 
@*                      This module performs:
@*                      - Set the initial SP
@*                      - Set the initial PC == Reset_Handler
@*                      - Set the vector table entries with the exceptions ISR address
@*                      After Reset the CortexM4 processor is in Thread mode,
@*                      priority is Privileged, and the Stack is set to Main.
@* <<< Use Configuration Wizard in Context Menu >>>   
@******************************************************************************
@* @attention
@*
@* Copyright (c) 2016 STMicroelectronics.
@* All rights reserved.
@*
@* This software is licensed under terms that can be found in the LICENSE file
@* in the root directory of this software component.
@* If no LICENSE file comes with this software, it is provided AS-IS.
@*
@******************************************************************************

@ Amount of memory (in bytes) allocated for Stack
@ Tailor this value to your application needs
@ <h> Stack Configuration
@   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
@ </h>

Stack_Size      = 0x00000400

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


@ <h> Heap Configuration
@   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
@ </h>

Heap_Size       = 0x00000200

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit

                PRESERVE8
                THUMB


@ Vector Table Mapped to Address 0 at Reset
                AREA    RESET, DATA, READONLY
                .global  __Vectors
                .global  __Vectors_End
                .global  __Vectors_Size

__Vectors       DCD     __initial_sp               @ Top of Stack
                DCD     Reset_Handler              @ Reset Handler
                DCD     NMI_Handler                @ NMI Handler
                DCD     HardFault_Handler          @ Hard Fault Handler
                DCD     MemManage_Handler          @ MPU Fault Handler
                DCD     BusFault_Handler           @ Bus Fault Handler
                DCD     UsageFault_Handler         @ Usage Fault Handler
                DCD     0                          @ Reserved
                DCD     0                          @ Reserved
                DCD     0                          @ Reserved
                DCD     0                          @ Reserved
                DCD     SVC_Handler                @ SVCall Handler
                DCD     DebugMon_Handler           @ Debug Monitor Handler
                DCD     0                          @ Reserved
                DCD     PendSV_Handler             @ PendSV Handler
                DCD     SysTick_Handler            @ SysTick Handler

                @ External Interrupts
                DCD     WWDG_IRQHandler                   @ Window WatchDog
                DCD     PVD_IRQHandler                    @ PVD through EXTI Line detection
                DCD     TAMP_STAMP_IRQHandler             @ Tamper and TimeStamps through the EXTI line
                DCD     RTC_WKUP_IRQHandler               @ RTC Wakeup through the EXTI line
                DCD     FLASH_IRQHandler                  @ FLASH
                DCD     RCC_IRQHandler                    @ RCC
                DCD     EXTI0_IRQHandler                  @ EXTI Line0
                DCD     EXTI1_IRQHandler                  @ EXTI Line1
                DCD     EXTI2_IRQHandler                  @ EXTI Line2
                DCD     EXTI3_IRQHandler                  @ EXTI Line3
                DCD     EXTI4_IRQHandler                  @ EXTI Line4
                DCD     DMA1_Stream0_IRQHandler           @ DMA1 Stream 0
                DCD     DMA1_Stream1_IRQHandler           @ DMA1 Stream 1
                DCD     DMA1_Stream2_IRQHandler           @ DMA1 Stream 2
                DCD     DMA1_Stream3_IRQHandler           @ DMA1 Stream 3
                DCD     DMA1_Stream4_IRQHandler           @ DMA1 Stream 4
                DCD     DMA1_Stream5_IRQHandler           @ DMA1 Stream 5
                DCD     DMA1_Stream6_IRQHandler           @ DMA1 Stream 6
                DCD     ADC_IRQHandler                    @ ADC1, ADC2 and ADC3s
                DCD     CAN1_TX_IRQHandler                @ CAN1 TX
                DCD     CAN1_RX0_IRQHandler               @ CAN1 RX0
                DCD     CAN1_RX1_IRQHandler               @ CAN1 RX1
                DCD     CAN1_SCE_IRQHandler               @ CAN1 SCE
                DCD     EXTI9_5_IRQHandler                @ External Line[9:5]s
                DCD     TIM1_BRK_TIM9_IRQHandler          @ TIM1 Break and TIM9
                DCD     TIM1_UP_TIM10_IRQHandler          @ TIM1 Update and TIM10
                DCD     TIM1_TRG_COM_TIM11_IRQHandler     @ TIM1 Trigger and Commutation and TIM11
                DCD     TIM1_CC_IRQHandler                @ TIM1 Capture Compare
                DCD     TIM2_IRQHandler                   @ TIM2
                DCD     TIM3_IRQHandler                   @ TIM3
                DCD     TIM4_IRQHandler                   @ TIM4
                DCD     I2C1_EV_IRQHandler                @ I2C1 Event
                DCD     I2C1_ER_IRQHandler                @ I2C1 Error
                DCD     I2C2_EV_IRQHandler                @ I2C2 Event
                DCD     I2C2_ER_IRQHandler                @ I2C2 Error
                DCD     SPI1_IRQHandler                   @ SPI1
                DCD     SPI2_IRQHandler                   @ SPI2
                DCD     USART1_IRQHandler                 @ USART1
                DCD     USART2_IRQHandler                 @ USART2
                DCD     USART3_IRQHandler                 @ USART3
                DCD     EXTI15_10_IRQHandler              @ External Line[15:10]s
                DCD     RTC_Alarm_IRQHandler              @ RTC Alarm (A and B) through EXTI Line
                DCD     OTG_FS_WKUP_IRQHandler            @ USB OTG FS Wakeup through EXTI line
                DCD     TIM8_BRK_TIM12_IRQHandler         @ TIM8 Break and TIM12
                DCD     TIM8_UP_TIM13_IRQHandler          @ TIM8 Update and TIM13
                DCD     TIM8_TRG_COM_TIM14_IRQHandler     @ TIM8 Trigger and Commutation and TIM14
                DCD     TIM8_CC_IRQHandler                @ TIM8 Capture Compare
                DCD     DMA1_Stream7_IRQHandler           @ DMA1 Stream7
                DCD     FMC_IRQHandler                    @ FMC
                DCD     SDIO_IRQHandler                   @ SDIO
                DCD     TIM5_IRQHandler                   @ TIM5
                DCD     SPI3_IRQHandler                   @ SPI3
                DCD     UART4_IRQHandler                  @ UART4
                DCD     UART5_IRQHandler                  @ UART5
                DCD     TIM6_DAC_IRQHandler               @ TIM6 and DAC1&2 underrun errors
                DCD     TIM7_IRQHandler                   @ TIM7
                DCD     DMA2_Stream0_IRQHandler           @ DMA2 Stream 0
                DCD     DMA2_Stream1_IRQHandler           @ DMA2 Stream 1
                DCD     DMA2_Stream2_IRQHandler           @ DMA2 Stream 2
                DCD     DMA2_Stream3_IRQHandler           @ DMA2 Stream 3
                DCD     DMA2_Stream4_IRQHandler           @ DMA2 Stream 4
                DCD     0                                 @ Reserved
                DCD     0                                 @ Reserved
                DCD     CAN2_TX_IRQHandler                @ CAN2 TX
                DCD     CAN2_RX0_IRQHandler               @ CAN2 RX0
                DCD     CAN2_RX1_IRQHandler               @ CAN2 RX1
                DCD     CAN2_SCE_IRQHandler               @ CAN2 SCE
                DCD     OTG_FS_IRQHandler                 @ USB OTG FS
                DCD     DMA2_Stream5_IRQHandler           @ DMA2 Stream 5
                DCD     DMA2_Stream6_IRQHandler           @ DMA2 Stream 6
                DCD     DMA2_Stream7_IRQHandler           @ DMA2 Stream 7
                DCD     USART6_IRQHandler                 @ USART6
                DCD     I2C3_EV_IRQHandler                @ I2C3 event
                DCD     I2C3_ER_IRQHandler                @ I2C3 error
                DCD     OTG_HS_EP1_OUT_IRQHandler         @ USB OTG HS End Point 1 Out
                DCD     OTG_HS_EP1_IN_IRQHandler          @ USB OTG HS End Point 1 In
                DCD     OTG_HS_WKUP_IRQHandler            @ USB OTG HS Wakeup through EXTI
                DCD     OTG_HS_IRQHandler                 @ USB OTG HS
                DCD     DCMI_IRQHandler                   @ DCMI
                DCD     0                                 @ Reserved
                DCD     0                                 @ Reserved
                DCD     FPU_IRQHandler                    @ FPU
                DCD     0                                 @ Reserved
                DCD     0                                 @ Reserved
                DCD     SPI4_IRQHandler                   @ SPI4
                DCD     0                                 @ Reserved
                DCD     0                                 @ Reserved
                DCD     SAI1_IRQHandler                   @ SAI1
                DCD     0                                 @ Reserved
                DCD     0                                 @ Reserved
                DCD     0                                 @ Reserved
                DCD     SAI2_IRQHandler                   @ SAI2
                DCD     QuadSPI_IRQHandler                @ QuadSPI
                DCD     CEC_IRQHandler                    @ CEC
                DCD     SPDIF_RX_IRQHandler               @ SPDIF RX
                DCD     FMPI2C1_Event_IRQHandler             @ I2C 4 Event
                DCD     FMPI2C1_Error_IRQHandler             @ I2C 4 Error
__Vectors_End

__Vectors_Size  =  __Vectors_End - __Vectors

                AREA    |.text|, CODE, READONLY

@ Reset handler
Reset_Handler    PROC
                .weak Reset_Handler
                .global  Reset_Handler             
        IMPORT  SystemInit
        IMPORT  __main

                 LDR     R0, =SystemInit
                 BLX     R0
                 LDR     R0, =__main
                 BX      R0
                 ENDP

@ Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                .weak  NMI_Handler
                .global  NMI_Handler               
                B       .
                ENDP
HardFault_Handler\
                PROC
                .weak  HardFault_Handler
                .global  HardFault_Handler
                B       .
                ENDP
MemManage_Handler\
                PROC
                .weak  MemManage_Handler
                .global  MemManage_Handler
                B       .
                ENDP
BusFault_Handler\
                PROC
                .weak  BusFault_Handler
                .global  BusFault_Handler
                B       .
                ENDP
UsageFault_Handler\
                PROC
                .weak  UsageFault_Handler
                .global  UsageFault_Handler @         [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                .weak  SVC_Handler
                .global  SVC_Handler
                B       .
                ENDP
DebugMon_Handler
                PROC
                .weak DebugMon_Handler
                .global DebugMon_Handler          
                B       .
                ENDP
PendSV_Handler  PROC
                .weak  PendSV_Handler
                .global  PendSV_Handler             
                B       .
                ENDP
SysTick_Handler PROC
                .weak  SysTick_Handler                            
                .global  SysTick_Handler            
                B       .
                ENDP

Default_Handler PROC

                .weak  fWWDG_IRQHandler                   
                .global  fWWDG_IRQHandler                   
                .weak PVD_IRQHandler
                .global  PVD_IRQHandler                   
                .weak  TAMP_STAMP_IRQHandler
                .global  TAMP_STAMP_IRQHandler
                .weak  RTC_WKUP_IRQHandler            
                .global  RTC_WKUP_IRQHandler
                .weak    FLASH_IRQHandler
                .global  FLASH_IRQHandler
                .weak    RCC_IRQHandler
                .global  RCC_IRQHandler
                .weak    EXTI0_IRQHandler
                .global  EXTI0_IRQHandler
                .weak    EXTI1_IRQHandler
                .global  EXTI1_IRQHandler
                .weak    EXTI2_IRQHandler
                .global  EXTI2_IRQHandler
                .weak    EXTI3_IRQHandler
                .global  EXTI3_IRQHandler
                .weak    EXTI4_IRQHandler
                .global  EXTI4_IRQHandler
                .weak    DMA1_Stream0_IRQHandler
                .global  DMA1_Stream0_IRQHandler
                .weak    DMA1_Stream1_IRQHandler
                .global  DMA1_Stream1_IRQHandler
                .weak    DMA1_Stream2_IRQHandler
                .global  DMA1_Stream2_IRQHandler
                .weak    DMA1_Stream3_IRQHandler
                .global  DMA1_Stream3_IRQHandler
                .weak    DMA1_Stream4_IRQHandler
                .global  DMA1_Stream4_IRQHandler
                .weak    DMA1_Stream5_IRQHandler
                .global  DMA1_Stream5_IRQHandler
                .weak    DMA1_Stream6_IRQHandler
                .global  DMA1_Stream6_IRQHandler
                .weak    ADC_IRQHandler
                .global  ADC_IRQHandler
                .weak    CAN1_TX_IRQHandler
                .global  CAN1_TX_IRQHandler
                .weak    CAN1_RX0_IRQHandler
                .global  CAN1_RX0_IRQHandler
                .weak    CAN1_RX1_IRQHandler
                .global  CAN1_RX1_IRQHandler
                .weak    CAN1_SCE_IRQHandler
                .global  CAN1_SCE_IRQHandler
                .weak    EXTI9_5_IRQHandler
                .global  EXTI9_5_IRQHandler
                .weak    TIM1_BRK_TIM9_IRQHandler
                .global  TIM1_BRK_TIM9_IRQHandler
                .weak    TIM1_UP_TIM10_IRQHandler
                .global  TIM1_UP_TIM10_IRQHandler
                .weak    TIM1_TRG_COM_TIM11_IRQHandler
                .global  TIM1_TRG_COM_TIM11_IRQHandler
                .weak    TIM1_CC_IRQHandler
                .global  TIM1_CC_IRQHandler
                .weak    TIM2_IRQHandler
                .global  TIM2_IRQHandler
                .weak    TIM3_IRQHandler
                .global  TIM3_IRQHandler
                .weak    TIM4_IRQHandler
                .global  TIM4_IRQHandler
                .weak    I2C1_EV_IRQHandler
                .global  I2C1_EV_IRQHandler
                .weak    I2C1_ER_IRQHandler
                .global  I2C1_ER_IRQHandler
                .weak    I2C2_EV_IRQHandler
                .global  I2C2_EV_IRQHandler
                .weak    I2C2_ER_IRQHandler
                .global  I2C2_ER_IRQHandler
                .weak    SPI1_IRQHandler
                .global  SPI1_IRQHandler
                .weak    SPI2_IRQHandler
                .global  SPI2_IRQHandler
                .weak    USART1_IRQHandler
                .global  USART1_IRQHandler
                .weak    USART2_IRQHandler
                .global  USART2_IRQHandler
                .weak    USART3_IRQHandler
                .global  USART3_IRQHandler
                .weak    EXTI15_10_IRQHandler
                .global  EXTI15_10_IRQHandler
                .weak    RTC_Alarm_IRQHandler
                .global  RTC_Alarm_IRQHandler
                .weak    OTG_FS_WKUP_IRQHandler
                .global  OTG_FS_WKUP_IRQHandler
                .weak    TIM8_BRK_TIM12_IRQHandler
                .global  TIM8_BRK_TIM12_IRQHandler
                .weak    TIM8_UP_TIM13_IRQHandler
                .global  TIM8_UP_TIM13_IRQHandler
                .weak    TIM8_TRG_COM_TIM14_IRQHandler
                .global  TIM8_TRG_COM_TIM14_IRQHandler
                .weak    TIM8_CC_IRQHandler
                .global  TIM8_CC_IRQHandler
                .weak    DMA1_Stream7_IRQHandler
                .global  DMA1_Stream7_IRQHandler
                .weak    FMC_IRQHandler
                .global  FMC_IRQHandler
                .weak    SDIO_IRQHandler
                .global  SDIO_IRQHandler
                .weak    TIM5_IRQHandler
                .global  TIM5_IRQHandler
                .weak    SPI3_IRQHandler
                .global  SPI3_IRQHandler
                .weak    UART4_IRQHandler
                .global  UART4_IRQHandler
                .weak    UART5_IRQHandler
                .global  UART5_IRQHandler
                .weak    TIM6_DAC_IRQHandler
                .global  TIM6_DAC_IRQHandler
                .weak    TIM7_IRQHandler
                .global  TIM7_IRQHandler
                .weak    DMA2_Stream0_IRQHandler
                .global  DMA2_Stream0_IRQHandler
                .weak    DMA2_Stream1_IRQHandler
                .global  DMA2_Stream1_IRQHandler
                .weak    DMA2_Stream2_IRQHandler
                .global  DMA2_Stream2_IRQHandler
                .weak    DMA2_Stream3_IRQHandler
                .global  DMA2_Stream3_IRQHandler
                .weak    DMA2_Stream4_IRQHandler
                .global  DMA2_Stream4_IRQHandler
                .weak    CAN2_TX_IRQHandler
                .global  CAN2_TX_IRQHandler
                .weak    CAN2_RX0_IRQHandler
                .global  CAN2_RX0_IRQHandler
                .weak    CAN2_RX1_IRQHandler
                .global  CAN2_RX1_IRQHandler
                .weak    CAN2_SCE_IRQHandler
                .global  CAN2_SCE_IRQHandler
                .weak    OTG_FS_IRQHandler
                .global  OTG_FS_IRQHandler
                .weak    DMA2_Stream5_IRQHandler
                .global  DMA2_Stream5_IRQHandler
                .weak    DMA2_Stream6_IRQHandler
                .global  DMA2_Stream6_IRQHandler
                .weak    DMA2_Stream7_IRQHandler
                .global  DMA2_Stream7_IRQHandler
                .weak    USART6_IRQHandler
                .global  USART6_IRQHandler
                .weak    I2C3_EV_IRQHandler
                .global  I2C3_EV_IRQHandler
                .weak    I2C3_ER_IRQHandler
                .global  I2C3_ER_IRQHandler
                .weak    OTG_HS_EP1_OUT_IRQHandler
                .global  OTG_HS_EP1_OUT_IRQHandler
                .weak    OTG_HS_EP1_IN_IRQHandler
                .global  OTG_HS_EP1_IN_IRQHandler
                .weak    OTG_HS_WKUP_IRQHandler
                .global  OTG_HS_WKUP_IRQHandler
                .weak    OTG_HS_IRQHandler
                .global  OTG_HS_IRQHandler
                .weak    DCMI_IRQHandler
                .global  DCMI_IRQHandler
                .weak    FPU_IRQHandler
                .global  FPU_IRQHandler
                .weak    SPI4_IRQHandler
                .global  SPI4_IRQHandler
                .weak    SAI1_IRQHandler
                .global  SAI1_IRQHandler
                .weak    SAI2_IRQHandler
                .global  SAI2_IRQHandler
                .weak    QuadSPI_IRQHandler
                .global  QuadSPI_IRQHandler
                .weak    CEC_IRQHandler
                .global  CEC_IRQHandler
                .weak    SPDIF_RX_IRQHandler
                .global  SPDIF_RX_IRQHandler
                .weak    FMPI2C1_Event_IRQHandler
                .global  FMPI2C1_Event_IRQHandler
                .weak    FMPI2C1_Error_IRQHandler
                .global  FMPI2C1_Error_IRQHandler

WWDG_IRQHandler
PVD_IRQHandler
TAMP_STAMP_IRQHandler
RTC_WKUP_IRQHandler
FLASH_IRQHandler
RCC_IRQHandler
EXTI0_IRQHandler
EXTI1_IRQHandler
EXTI2_IRQHandler
EXTI3_IRQHandler
EXTI4_IRQHandler
DMA1_Stream0_IRQHandler
DMA1_Stream1_IRQHandler
DMA1_Stream2_IRQHandler
DMA1_Stream3_IRQHandler
DMA1_Stream4_IRQHandler
DMA1_Stream5_IRQHandler
DMA1_Stream6_IRQHandler
ADC_IRQHandler
CAN1_TX_IRQHandler
CAN1_RX0_IRQHandler
CAN1_RX1_IRQHandler
CAN1_SCE_IRQHandler
EXTI9_5_IRQHandler
TIM1_BRK_TIM9_IRQHandler
TIM1_UP_TIM10_IRQHandler
TIM1_TRG_COM_TIM11_IRQHandler
TIM1_CC_IRQHandler
TIM2_IRQHandler
TIM3_IRQHandler
TIM4_IRQHandler
I2C1_EV_IRQHandler
I2C1_ER_IRQHandler
I2C2_EV_IRQHandler
I2C2_ER_IRQHandler
SPI1_IRQHandler
SPI2_IRQHandler
USART1_IRQHandler
USART2_IRQHandler
USART3_IRQHandler
EXTI15_10_IRQHandler
RTC_Alarm_IRQHandler
OTG_FS_WKUP_IRQHandler
TIM8_BRK_TIM12_IRQHandler
TIM8_UP_TIM13_IRQHandler
TIM8_TRG_COM_TIM14_IRQHandler
TIM8_CC_IRQHandler
DMA1_Stream7_IRQHandler
FMC_IRQHandler
SDIO_IRQHandler
TIM5_IRQHandler
SPI3_IRQHandler
UART4_IRQHandler
UART5_IRQHandler
TIM6_DAC_IRQHandler
TIM7_IRQHandler
DMA2_Stream0_IRQHandler
DMA2_Stream1_IRQHandler
DMA2_Stream2_IRQHandler
DMA2_Stream3_IRQHandler
DMA2_Stream4_IRQHandler
CAN2_TX_IRQHandler
CAN2_RX0_IRQHandler
CAN2_RX1_IRQHandler
CAN2_SCE_IRQHandler
OTG_FS_IRQHandler
DMA2_Stream5_IRQHandler
DMA2_Stream6_IRQHandler
DMA2_Stream7_IRQHandler
USART6_IRQHandler
I2C3_EV_IRQHandler
I2C3_ER_IRQHandler
OTG_HS_EP1_OUT_IRQHandler
OTG_HS_EP1_IN_IRQHandler
OTG_HS_WKUP_IRQHandler
OTG_HS_IRQHandler
DCMI_IRQHandler
FPU_IRQHandler
SPI4_IRQHandler
SAI1_IRQHandler
SAI2_IRQHandler
QuadSPI_IRQHandler
CEC_IRQHandler
SPDIF_RX_IRQHandler
FMPI2C1_Event_IRQHandler
FMPI2C1_Error_IRQHandler
                B       .

                ENDP

                ALIGN

@*******************************************************************************
@ User Stack and Heap initialization
@*******************************************************************************
                 IF      :DEF:__MICROLIB
                
                 .global  __initial_sp
                 .global  __heap_base
                 .global  __heap_limit
                
                 ELSE
                
                 IMPORT  __use_two_region_memory
                 .global  __user_initial_stackheap
                 
__user_initial_stackheap

                 LDR     R0, =  Heap_Mem
                 LDR     R1, =(Stack_Mem + Stack_Size)
                 LDR     R2, = (Heap_Mem +  Heap_Size)
                 LDR     R3, = Stack_Mem
                 BX      LR

                 ALIGN

                 ENDIF

                 END

