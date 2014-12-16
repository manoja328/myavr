#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <util/delay.h>
#include "usbdrv.h"

#define USB_LED_OFF 0
#define USB_LED_ON  1
#define USB_DATA_OUT 2

static uchar replyBuf[16] = "Hello, USB!";


// this gets called when custom control message is received

USB_PUBLIC uchar usbFunctionSetup(uchar data[8]) {
    usbRequest_t *rq = (void *)data; // cast data to correct type
        
    switch(rq->bRequest) { // custom command is in the bRequest field
    case USB_LED_ON:
        PORTB |= 1; // turn LED on
        return 0;
    case USB_LED_OFF: 
        PORTB &= ~1; // turn LED off
        return 0;
    
      case USB_DATA_OUT: // send data to PC
        usbMsgPtr = replyBuf;
        return sizeof(replyBuf);
		}
    return 0; // should not get here
}






int main() {
        uchar i;
		  DDRB = 1; // PB0 as output
    wdt_enable(WDTO_1S); // enable 1s watchdog timer

    usbInit();
        
    usbDeviceDisconnect(); // enforce re-enumeration
    for(i = 0; i<250; i++) { // wait 500 ms
        wdt_reset(); // keep the watchdog happy
        _delay_ms(2);
    }
    usbDeviceConnect();
        
    sei(); // Enable interrupts after re-enumeration
        
    while(1) {
        wdt_reset(); // keep the watchdog happy
        usbPoll();
    }
        
    return 0;
}