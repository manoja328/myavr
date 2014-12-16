#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

void init(void)
{
	//PORT configuration
	DDRC = 0X00;
	DDRD=0xFF;
	DDRB=0XFF;

}


void adc_Init(void) 
{ 

	ADMUX = ADCSRA = 0X00;
	ADCSRA|=(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);//Choosing a prescalar of 128 for 62.5kHz sample rate @ 8MHz (optimal sampling rate is 50 to 150 kHz)
	ADMUX|=(1<<REFS0);//Setting ADC vcc  

	ADMUX&=~(1<<ADLAR);//turning our 10 bit ADC measurement into an 8 bit one(as 0 to 255 will do for us) i.e. left adjust the result
	ADCSRA|=(1<<ADFR)|(1<<ADEN);//enable the adc */


	
	
}

unsigned char highvalue,lowvalue;
unsigned char READadc() 
{
	
	ADCSRA|=(1<<ADSC);			//start a2d conversion 
	while(!(ADCSRA&(1<<ADIF)));	//waiting for the conversion to complete
	ADCSRA|=(1<<ADIF);			//clearing the ADIF flag 
	//return(ADCH);				//return the adch value 
	lowvalue=ADCL;
	highvalue=ADCH;
	//sendval=highvalue+ (ADCH & 0x03)*256 ;
	return (lowvalue);

}
 
int main(void)
{

init();
adc_Init();
unsigned char get;

while(1)
{

get=READadc();
PORTD=get;

}
return 0;
}


