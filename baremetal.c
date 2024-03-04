#include <stdint.h>


static void setup(void);
static void loop(void);

static void setup(void) {
}

static void loop(void) {
        uint32_t x;
}

int main(void) {
        setup();
        for(;;) {
               loop(); 
        }
        return 0;
}
