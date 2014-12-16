#include <avr/io.h>
#include<util/delay.h> 



int main(void)
{   


	DDRD=0xff;
	DDRC=0xff;
	DDRB=0xff;
	
	while (1){
	PORTD=0XFF;
	PORTC=0xff;
	PORTB=0xff;

	_delay_ms(100);
		PORTD=0X00;
		PORTC=0x00;
		PORTB=0x00;

	_delay_ms(100);
	

	    
}
    
    return(0);
}


