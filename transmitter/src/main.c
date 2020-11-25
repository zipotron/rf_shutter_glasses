#include "lcd/lcd.h"//Just debugging

#include "gd32vf103.h"
#include "pin.h"
#include "systick.h"

int main(void)
{
	uint16_t c=0, min=4095, max=0, avr=4020, count=0, resistence=5;
	uint16_t samples[4096];
	uint32_t aux;
	//uint16_t analog_read = 0;
	
	lcd_init();
    led_init();
    signal_pin_init();
    init_ADC();
    
    LCD_Clear(BLACK);
    
    for(;;){
		samples[count] = ADC_RDATA(ADC0);
		
		if(c)
			c = samples[count] > avr - resistence? 1 : 0;
		else
			c = samples[count] > avr + resistence? 1 : 0;
		//c = samples[count] > min + ((max - min) / 2)? 1 : 0;
		//c= c? 0:1;//For check sample rate in the osciloscope
		
		led_set(c);
		pin_set(c);
		
		delay_1ms(1);
		
		if(samples[count] < min)
			min = samples[count];
		
		if(samples[count] > max)
			max = samples[count];
		
		if(count == 4095){
			aux = 0;
			for(count=0;count<4096;count++)
				aux=aux+((uint32_t)samples[count]);
			avr=(uint16_t)(aux/4096);
			count=0;
			
			LCD_ShowString8(0, (1 << 3), (u8 *)" Lectura: ", YELLOW);//Just debugging
			LCD_ShowNum(90, (1 << 3), (u16)samples[count], 6,YELLOW);//Debugging
			LCD_ShowString8(0, (4 << 3), (u8 *)" Minimo: ", GREEN);//Just debugging
			LCD_ShowNum(90, (4 << 3), (u16)min, 6,GREEN);//Debugging
			LCD_ShowString8(0, (6 << 3), (u8 *)" Maximo: ", RED);//Just debugging
			LCD_ShowNum(90, (6 << 3), (u16)max, 6,RED);//Debugging
			LCD_ShowString8(0, (8 << 3), (u8 *)" Media: ", YELLOW);//Just debugging
			LCD_ShowNum(90, (8 << 3), (u16)avr, 6,YELLOW);//Debugging
			max=0;
			min=4095;
		} else
			count++;
	}
}
