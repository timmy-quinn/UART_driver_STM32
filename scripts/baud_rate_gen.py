clock_freq = 16000000
baud_rates = [
    9600,
    19200,
    38400,
    57600,
    115200
]

# Fixed point conversion
def baud_to_brr(baud_rate):
    bit_mask_16 = 0xffff
    bit_mask_mantissa = 0xfff0
    bit_mask_fraction = ~bit_mask_mantissa & bit_mask_16
    usart_div = clock_freq / (baud_rate * 16)
    div_fraction = round((usart_div%1) * 16)
    div_mantissa = usart_div // 1
    div_fraction = int(div_fraction)
    div_mantissa = int(div_mantissa)
    brr = ((div_mantissa << 4) & bit_mask_mantissa) | (div_fraction & bit_mask_fraction)
    return brr 

def main():
    define_str = '#define BAUD_RATE_'
    define_str += f'{str(int(clock_freq/1000000))}MHZ'
    for baud_rate in baud_rates:
        print(f'{define_str}_{baud_rate} {hex(baud_to_brr(baud_rate))}') 

if __name__ == '__main__': main() 