#include "gd32vf103.h"
#include "pin.h"
#include "systick.h"

int main(void)
{
	int c=0;
	uint16_t analog_read = 0;
	
    led_init();
    signal_pin_init();
    
    for(;;){
		analog_read = ADC_RDATA(ADC0);
		led_set(c);
		pin_set(c);
		//delay_1ms(50);
		delay_1ms(analog_read+50);
		c++;
		if(c==2)
			c=0;
	}
}
