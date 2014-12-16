#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

void init(void)
{
	//PORT configuration
	DDRC = 0XFF;
	GICR|=(1<<INT0);
	MCUCR|=(1<<ISC01)|(1<<ISC00);
	PORTC=0x00;

}


int main(void)
{
init();
sei();
while(1){
	
}
return 0;
}



ISR (INT0_vect)		
{
	PORTC=~PORTC;
	
}

