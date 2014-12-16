#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#define BAUD 9600
#define MYUBRR F_CPU/16/BAUD-1

void USART_Transmit( unsigned char data )
{
/* Wait for empty transmit buffer */
while ( !( UCSRA & (1<<UDRE)) )
;
/* Put data into buffer, sends the data */
UDR = data;
}

void USART_Init( unsigned int ubrr)
{
/* Set baud rate */
UBRRH = (unsigned char)(ubrr>>8);
UBRRL = (unsigned char)ubrr;
/* Enable receiver and transmitter */
UCSRB |= (1<<TXEN);
/* Set frame format: 8 bits data, 2stop bit */
UCSRC = (1<<URSEL)|(3<<UCSZ0);

}

void init(void)
{
	//PORT configuration
	DDRC = 0X00;  //input
	DDRD=0xFF;    //output

}


int main(void)
{

init();


const unsigned char *mydata="hello this is my first serial\n";
USART_Init ( MYUBRR );

	while(1)
	{



USART_Transmit('a');


}


	return 0;
}


