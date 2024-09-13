def fixed_point_conversion(fp):
    div_fraction = fp%1 
    mantissa = 

clock_freq = 16000000
baud_rates = {
    '9600': 9600,
    '19200': 19200,
    '38400': 38400,
    '57600': 57600,
    '115200': 115200
}
usart_div = {}
usart_brr = {}

# Baud rates
for baud_rate in baud_rates.items():
    usart_div[baud_rate[0]] = clock_freq / (baud_rate[1] * 16)

# Fixed point conversion

def baud_to_brr(baud_rate):
    usart_div = clock_freq / (baud_rate * 16)
    div_fraction = (usart_div%1) * 16
