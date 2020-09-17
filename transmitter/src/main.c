#include "gd32vf103.h"
#include "led.h"
#include "systick.h"

int main(void)
{
	int c=0;
	
    led_init();
    for(;;){
		led_set(c);
		pin_set(c);
		delay_1ms(50);
		c++;
		if(c==2)
			c=0;
	}
}
