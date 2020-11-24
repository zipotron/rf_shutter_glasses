#ifndef __LED_H__
#define __LED_H__

#define ANALOG_PORT              GPIOA
#define ANALOG_PIN               GPIO_PIN_3
#define ANALOG_CHANNEL           ADC_CHANNEL_3

#define RED_LED_PIN    GPIO_PIN_13
#define SIGNAL_PIN    GPIO_PIN_0
#define RED_LED_PORT    GPIOC
#define SIGNAL_PIN_PORT    GPIOB

// ------------------------------------------------------------------------

void led_init();
void signal_pin_init();
void init_ADC();
void led_set(int c);
void pin_set(int c);

// ------------------------------------------------------------------------

#endif // __LED_H__
