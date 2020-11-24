#include "lcd/lcd.h"//Just debugging

#include "gd32vf103.h"
#include "pin.h"
#include "systick.h"

int main(void)
{
	int c=0;
	uint16_t analog_read = 0;
	
	lcd_init();
    led_init();
    signal_pin_init();
    init_ADC();
    
    LCD_Clear(BLACK);
    
    for(;;){
		analog_read = ADC_RDATA(ADC0);
		
		LCD_ShowString8(0, (1 << 3), (u8 *)" Lectura: ", YELLOW);//Just debugging
		LCD_ShowNum(90, (1 << 3), (u16)analog_read, 6,YELLOW);//Debugging
		
		led_set(c);
		pin_set(c);
		delay_1ms(30);
		
		c++;
		if(c==2)
			c=0;
	}
}
