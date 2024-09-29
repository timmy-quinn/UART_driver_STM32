# UART Driver  
This project was largely an excersise in stubborness. If you're like me and want to forgo the immense convenience of IDE's and SDK's you're in the right place. Hopefully this project can serve as a helpful example, in addition to the resources linked below, all of which were immensely helpful throughout the course of the project, especially in writing the linker scripts and startup code.  
   
Despite the amount of time it took compared to doing the same thing with an SDK, I found writing code for an MCU completely from scratch to be incredibly educational. It taught me things I would never have otherwise learned about the fundamentals of processor and peripheral hardware and I recommend all embedded  engineers try this at least once.  
  
The only thing I didn't write are the file in the src/CMSIS_core folder, which I just used for the addresses of relevant UART registers, and bit masks for configuring those registers. If you want to avoid using even that, you can just find the relevant registers in the datasheet. But at that point it becomes even too tedious for me, so I would recommend getting the files in the CMSIS_core from the [STM32 Standard Peripheral Libraries](https://www.st.com/en/embedded-software/stm32-standard-peripheral-libraries.html). 

### Requirements
- [ARM-GNU Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)  
- [make](https://gnuwin32.sourceforge.net/packages/make.htm)  
- [St-Link tools](https://github.com/stlink-org/stlink) (If using st-link)

### Build Process
```
make all
st-flash ./main.bin
```


### Debugging
```
make all 
st-util
```
You should see `st-util` open a debugging port on `localhost:4242`. Following this, open (in a separate terminal) a gdb instance like this.  
```
arm-none-eabi-gdb build/main.elf  
(gdb) target extended-remote :4242  
(gdb) load  
``` 
From here you can simply debug using [gdb](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_chapter/gdb_toc.html). 


### Resources
https://vivonomicon.com/2018/04/02/bare-metal-stm32-programming-part-1-hello-arm/

https://community.silabs.com/s/article/understand-the-gnu-assembler-startup-file-of-cortex-m4?language=en_US

https://allthingsembedded.com/post/2019-01-03-arm-cortex-m-startup-code-for-c-and-c/