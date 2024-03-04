#include <stdint.h>
#include <stddef.h>

#define F_CPU 8000000L
#define GPIOA_BASE 0x40020000
#define RCC_BASE 0x40023800

#define DDR_OFFSET 0x0
#define PUPD_OFFSET 0x0C
#define INPUT_OFFSET 0x10
#define OUTPUT_OFFSET 0x14

#define RCC_AHB1ENR_OFFSET 0x30

#define DDRA *((volatile uint32_t *) (GPIOA_BASE + DDR_OFFSET))
#define PINA *((volatile uint32_t *) (GPIOA_BASE + INPUT_OFFSET))
#define PORTA *((volatile uint32_t *) (GPIOA_BASE + OUTPUT_OFFSET))

#define RCC_AHB1ENR *((volatile uint32_t *) (RCC_BASE + RCC_AHB1ENR_OFFSET))

#define PA2 (1 << 2)
#define PA3 (1 << 3)
#define PA5 ((uint32_t) (1 << 5))
#define PA6 (1 << 6)
#define PA7 (1 << 7)
#define PA8 (1 << 8)
#define PA9 (1 << 9)
#define PA10 (1 << 10)
#define PA11 (1 << 11)
#define PA12 (1 << 12)

#define GPIOAEN (1 << 0)

#define LED_PIN PA5

static void setup(void);
static void loop(void);

static void setup(void) {
        RCC_AHB1ENR |= GPIOAEN;
        DDRA |= LED_PIN;
}

static void loop(void) {
        size_t x;

        PORTA |= LED_PIN;
        for(x = 0; x < F_CPU; x++);
        PORTA &= ~(LED_PIN);
        for(x = 0; x < F_CPU; x++);
}

int main(void) {
        setup();
        for(;;) {
               loop(); 
        }
        return 0;
}

__attribute__((naked, noreturn)) void _reset(void) {
        extern long _sbss, _ebss, _sdata, _edata, _sidata;
        for(long *dst = &_sbss; dst < &_ebss; dst++) *dst = 0;
        for(long *dst = &_sdata, *src = &_sidata; dst < &_edata;) *dst++ = *src++;

        main();
        for(;;) (void) 0;
}

extern void _estack(void);

__attribute__((section(".vectors"))) void (*const tab[16 + 91])(void) = {
        _estack, _reset
};
