#include <avr/io.h>
#include<util/delay.h>
#define SLIDER1 PC5
#define SLDSTOP PC4
#define SLIDER2 PC2
#define  CDHEAD PC3






int main(void)
{

DDRC =(1<< SLIDER1) | (1<< CDHEAD) | (1<< SLIDER2);
unsigned char done=0;
	
while(1==1){
PORTC|=(1 <<  CDHEAD);

if (PINC & (1<<SLDSTOP)) done=1;
else done=0;


if (done==0){

{
     PORTC&=~(1 <<  SLIDER1);   //forward
     PORTC|=(1 <<  SLIDER2);     
	 _delay_ms(600);
	 

}

{
	 PORTC|=(1 <<  SLIDER1);   //back
     PORTC&=~(1 <<  SLIDER2);     
	 _delay_ms(600);
	 

}
}

if (done==1){

   PORTC&=~(1 <<  SLIDER1);   
     PORTC&=~(1 <<  SLIDER2); 
}


	}
	return 0;
}


