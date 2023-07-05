#include <stdio.h>
#include <stdbool.h>
#include "Device_header.h"
#include "sys_common.h"

#include "gio.h"

#define PORT_PIN0      0x01
#define PORT_PIN1      0x02
#define PORT_PIN2      0x04
#define PORT_PIN3      0x08
#define PORT_PIN4      0x10
#define PORT_PIN5      0x12
#define PORT_PIN6      0x14
#define PORT_PIN7      0x16

#define PORT_BIT_MASK   PORT_PIN1 | PORT_PIN2

static inline void dummy_delay( uint32 counts ){
    while( counts-- ){}
}

/**
 * hello.c
 */
int main(void)
{
    gioInit();
    gioPORTB->DIR = PORT_BIT_MASK;
    gioPORTB->DOUT = PORT_PIN2;
	while( true ){
	    printf("Hello World!\n");
	    gioPORTB->DOUT ^= PORT_BIT_MASK;
	    dummy_delay( 18000000 );
	}
	return 0;
}
