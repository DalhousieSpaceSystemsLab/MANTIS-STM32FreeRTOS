#include <stdint.h>

#define RCC_BASE 0x40023800
#define GPIOA_BASE 0x40020000

#define RCC_AHB1ENR *(volatile uint32_t *)(RCC_BASE    + 0x30)
#define GPIOA_MODER *(volatile uint32_t *)(GPIOA_BASE  + 0x00)
#define GPIOA_OTYPER *(volatile uint32_t *)(GPIOA_BASE + 0x04)
#define GPIOA_PUPDR *(volatile uint32_t *)(GPIOA_BASE  + 0x0C)
#define GPIOA_ODR *(volatile uint32_t *)(GPIOA_BASE    + 0x14)

#define GPIOAEN (1 << 0)
/* B...E + H */

#define MODER0_INPUT  (0 << 0)
#define MODER0_OUTPUT (1 << 0)
#define MODER0_ALT    (2 << 0)
#define MODER0_ANALOG (3 << 0)
/* 1...4 */
#define MODER5_INPUT  (0 << 2*5)
#define MODER5_OUTPUT (1 << 2*5)
#define MODER5_ALT    (2 << 2*5)
#define MODER5_ANALOG (3 << 2*5)
/* 6...15 */

#define OT0_PUSH_PULL  (0 << 0)
#define OT0_OPEN_DRAIN (1 << 0)
/* 1...4 */
#define OT5_PUSH_PULL  (0 << 5)
#define OT5_OPEN_DRAIN (1 << 5)
/* 6...15 */

#define PUPDR0_NONE     (0 << 0)
#define PUPDR0_PULLUP   (1 << 0)
#define PUPDR0_PULLDOWN (2 << 0)
/* 1...4 */
#define PUPDR5_NONE     (0 << 2*5)
#define PUPDR5_PULLUP   (1 << 2*5)
#define PUPDR5_PULLDOWN (2 << 2*5)
/* 6...15 */

#define ODR0 (1 << 0)
/* 1...4 */
#define ODR5 (1 << 5)
/* 6...15 */

static void setup(void);
static void loop(void);

static void setup(void) {
        /* Enable clock on PORT A */
        RCC_AHB1ENR |= GPIOAEN;

        /* Set PA5 to output mode */
        GPIOA_MODER |= MODER5_OUTPUT;

        /* Set PA5 to push-pull */
        GPIOA_OTYPER &= ~(OT5_PUSH_PULL);

        /* Set PA5 to pull-down */
        GPIOA_PUPDR |= PUPDR5_PULLDOWN;

        /* Set PA5 output to high */
        GPIOA_ODR |= ODR5;

        /* Get stuck here */
        for(;;) (void)0;
}

static void loop(void) {
        (void)0;
}

int main(void) {
        setup();
        for(;;) {
               loop(); 
        }
        return 0;
}
