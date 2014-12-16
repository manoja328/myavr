#include "lcd.h"


#define one 0x16 
#define two 0x1E 
#define three 0x26 
#define aaa 0x1c 
#define bbb 0x32
#define ccc 0x21



volatile unsigned char count;


void keyboardInit( void )
{
	DDRD=(1<<PD4);	//int1(pd3--5) and pd4(6) pin for clock and data 
	MCUCR = (1<<ISC11)| (1<<ISC10);		// Setup INT1 for the falling edge.
	GICR=(1<<INT1);   //enable int1 pin

}



ISR( INT1_vect )
{
	
	count++;
	
		
	
}




int main( void )
{
	initLCD();
	
	keyboardInit( );
	
	
	LCD_goto(1,0);
	lcd_puts("START KEYBOARD!");
	LCD_goto(2,0);
	lcd_puts("ONE");	
	
	sei();

	while( 1 )
	{
		
				
					LCD_goto(2,8);
					LCD_num(count);		
		
			
		
	}
	return 0;
}
