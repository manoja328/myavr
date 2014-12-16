#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <util/delay.h>
#include "usbdrv.h"
#define RS PC4 
#define EN PC5 
#define sbi(x,y) x|=_BV(y)
#define cbi(x,y) x&=~(_BV(y))


#define USB_LED_OFF 0
#define USB_LED_ON  1
#define USB_DATA_OUT 2
#define USB_DATA_WRITE 3
#define USB_DATA_IN 4
static uchar dataReceived = 0, dataLength = 0; // for USB_DATA_IN
static uchar replyBuf[16] = "Hello, USB!";

void LCD_Write(unsigned char values,int rs)
{
	rs?(PORTC|=(1<<RS)):(PORTC&=~(1<<RS));
	_delay_us(50);
	
	
	//first nibble
	(values & 0x10)?(PORTC|=(1<<PC0)):(PORTC&=~(1<<PC0));
	(values & 0x20)?(PORTC|=(1<<PC1)):(PORTC&=~(1<<PC1));
	(values & 0x40)?(PORTC|=(1<<PC2)):(PORTC&=~(1<<PC2));
	(values & 0x80)?(PORTC|=(1<<PC3)):(PORTC&=~(1<<PC3));
	
	
	sbi(PORTC,EN);
	_delay_us(1);
	cbi(PORTC,EN);
	
	// second nibble
	
	

	
	values=values<<4;
	(values & 0x10)?(PORTC|=(1<<PC0)):(PORTC&=~(1<<PC0));
	(values & 0x20)?(PORTC|=(1<<PC1)):(PORTC&=~(1<<PC1));
	(values & 0x40)?(PORTC|=(1<<PC2)):(PORTC&=~(1<<PC2));
	(values & 0x80)?(PORTC|=(1<<PC3)):(PORTC&=~(1<<PC3));
	
	
	sbi(PORTC,EN);
	_delay_us(1);
	cbi(PORTC,EN);
	

	
	
 
}






void LCD_clear(void)
{
	LCD_Write(0x01,0);		//this clears LCD
	_delay_ms(5);
}

void LCD_goto(unsigned char row,unsigned char column)
{
	if(row==1){
		LCD_Write(0x80+column,0);	
	}
	else if(row==2){
		LCD_Write(0xC0+column,0);
	}
}

void LCD_num(int n)
{
	
	
    if(n<=9)
    {
		LCD_Write(48,1);
	    LCD_Write(48+n,1);
	 }
	 else if(n<=99)
	 {
		 LCD_Write((n/10)+48,1);
		 LCD_Write((n%10)+48,1);
	}
	else if(n<=999)
	{
		LCD_Write((n/100)+48,1);
		LCD_Write(((n%100)/10)+48,1);
		LCD_Write((n%10)+48,1);
	}
}



void lcd_puts(const char *str){
while(*str!='\0'){
LCD_Write(*str++,1);

}


}


void initLCD(void)
{
	//PORT configuration
	DDRC = 0xFF;
	_delay_ms(15);
		
	LCD_Write(0x20,0);	
	sbi(PORTC,EN);
	_delay_ms(1);
	cbi(PORTC,EN);	
	LCD_Write(0x28,0);    
	_delay_ms(1);

	LCD_clear();
	LCD_Write(0x0c,0);    //dispaly on , cursor blinking
	_delay_ms(1);

	
		
	
}


USB_PUBLIC uchar usbFunctionWrite(uchar *data, uchar len) { 
   uchar i;
 for(i = 0; dataReceived < dataLength && i < len; i++, dataReceived++) 
      replyBuf[dataReceived] = data[i]; 
	 //replyBuf[dataReceived]='\0';
			LCD_goto(2,0);
		lcd_puts(replyBuf); 
		//lcd_puts("ho hai yaha aa");
      return (dataReceived == dataLength); // 1 if we received it all, 0 if not
				   }






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
		LCD_goto(2,0);
		lcd_puts(replyBuf);
        return sizeof(replyBuf);
		
		
	  case USB_DATA_WRITE: // modify reply buffer
        replyBuf[7] = rq->wValue.bytes[0];
        replyBuf[8] = rq->wValue.bytes[1];
        replyBuf[9] = rq->wIndex.bytes[0];
        replyBuf[10] = rq->wIndex.bytes[1];
				LCD_goto(2,0);
		lcd_puts(replyBuf);
        return 0;
	
	case USB_DATA_IN: // receive data from PC   
     dataLength = (uchar)rq->wLength.word;  
      dataReceived = 0;      
     if(dataLength > sizeof(replyBuf)) // limit to buffer size  
       dataLength = sizeof(replyBuf);         
      return USB_NO_MSG; // usbFunctionWrite will be called now


	
		}
    return 0; // should not get here
}



int main() {
	initLCD();
	LCD_goto(1,0);
	lcd_puts("AVRLCD 4bit mode");
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