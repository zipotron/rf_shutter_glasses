#include "led.h"
#include "gd32vf103.h"

void led_init()
{
    rcu_periph_clock_enable(RCU_GPIOA);
    
    gpio_init(GPIOA, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, GPIO_PIN_1 | GPIO_PIN_3);
    
    GPIO_BOP(GPIOA) = GPIO_PIN_1 | GPIO_PIN_3;
    
}

void led_set(int c)
{
    
    if (c & 1) GPIO_BC (GPIOA) = GPIO_PIN_1;  // green
    else       GPIO_BOP(GPIOA) = GPIO_PIN_1;
    
}

void pin_set(int c)
{
    
    if (c & 1) GPIO_BC (GPIOA) = GPIO_PIN_3;
    else       GPIO_BOP(GPIOA) = GPIO_PIN_3;
}
