#include <avr/io.h>
#include<util/delay.h> 

int main(void)
{   


	DDRC|=(1<<PC0);
	DDRC&=~(1<<PC1);
	PORTC|=(1<<PC1);
	

	while (1){
	
	
	if (PINC & (1<<PC1)){
	PORTC|=(1<<PC0);

	_delay_ms(100);
	
	PORTC&=~(1<<PC0);
	
	_delay_ms(100);
	}

else
PORTC&=~(1<<PC0);


	    
}
    
    return(0);
}


