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
UCSRC = (1<<URSEL)|(1<<USBS)|(3<<UCSZ0);

}

void init(void)
{
	//PORT configuration
	DDRC = 0X00;  //input
	DDRD=0xFF;    //output

}


void adc_Init(void) 
{ 
	ADMUX = ADCSRA = 0X00;
	ADCSRA|=(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);//Choosing a prescalar of 128 for 62.5kHz sample rate @ 8MHz (optimal sampling rate is 50 to 150 kHz)
	ADMUX|=(1<<REFS0)|(1<<REFS1);//Setting ADC internal 2.56v reference  

	ADMUX|=(1<<ADLAR);//turning our 10 bit ADC measurement into an 8 bit one(as 0 to 255 will do for us) i.e. left adjust the result
	ADCSRA|=(1<<ADEN);//enable the adc 

	
	
}

unsigned char READadc() 
{
	
	ADCSRA|=(1<<ADSC);			//start a2d conversion 
	while(!(ADCSRA&(1<<ADIF)));	//waiting for the conversion to complete
	ADCSRA|=(1<<ADIF);			//clearing the ADIF flag 
	return(ADCH);				//return the adch value 
}
 
int main(void)
{

init();
adc_Init();
unsigned char mydata;
const unsigned char *mydata1="hello this is my first serial\n";
USART_Init ( MYUBRR );

	while(1)
	{

mydata=READadc();
USART_Transmit(mydata);
USART_Transmit('a');


}


	return 0;
}


