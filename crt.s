.cpu cortex-m4
.thumb

.word 0x20020000 @ SRAM MEM END
.word _reset     @ Reset Vector
.thumb_func      @ Generate thumb executable
_reset:          @ Reset method
        bl main  @ Jump to main
        b .      @ Loop again
