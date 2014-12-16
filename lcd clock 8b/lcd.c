#include <avr/io.h>
#include<util/delay.h>


#define data PORTB
#define RS PD0
#define EN PD1
#define sbi(x,y) x|=_BV(y)
#define cbi(x,y) x&=~(_BV(y))

int sec=0;	
int min=9;
int hour=0;




//for both 8bit and 4 bit
	
void LCD_Write(unsigned char value,int rs)
{
	rs?(PORTD|=(1<<RS)):(PORTD&=~(1<<RS));
	
	data = value;
	sbi(PORTD,EN);
	_delay_ms(1);
	cbi(PORTD,EN);
	
	// for 8 bit mode yaha bhnada tala comment garne
	
	value=value<<4;
	data = value;
	sbi(PORTD,EN);
	_delay_ms(1);
	cbi(PORTD,EN);
	
	
 
}


void LCD_clear(void)
{
	LCD_Write(0x01,0);		//this clears LCD
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


void lcd_puts(unsigned char *str){

while(*str!='\0'){
LCD_Write(*str++,1);

}


}


void initLCD(void)
{
	//PORT configuration
	DDRB = 0XFF;
	DDRD=0xFF;
	
	PORTD=0Xff;
	
	LCD_Write(0x20,0);	
	sbi(PORTD,EN);
	_delay_ms(1);
	cbi(PORTD,EN);
	
	LCD_Write(0x28,0);    
	_delay_ms(1);

	//for 8 bit mode talako uncommet garne
	//LCD_Write(0x38,0);    
	//_delay_ms(1);

	LCD_Write(0x0c,0);    //dispaly on , cursor blinking
	_delay_ms(1);

	LCD_clear();
	LCD_goto(1,0);	
	
	unsigned char *message="lcdavr 4bit mode";
	lcd_puts(message);
	//LCD_Write('C',1);_delay_ms(100);LCD_Write('l',1);_delay_ms(100);
	//LCD_Write('o',1);_delay_ms(100);LCD_Write('c',1);_delay_ms(100);
	//LCD_Write('k',1);_delay_ms(100);
	
}


int main(void)
{
	initLCD();
	while(1==1)
	{
LCD_goto(2,0);
LCD_num(hour);
LCD_goto(2,2);
	LCD_Write(':',1);_delay_ms(100);
LCD_goto(2,3);
LCD_num(min);
LCD_goto(2,5);
	LCD_Write(':',1);_delay_ms(100);
		LCD_goto(2,6);
	LCD_num(sec);
		sec++;
	
		LCD_Write(0x10,0);
		LCD_Write(0x10,0);
		LCD_Write(0x10,0);
		_delay_ms(500);
		if(sec==10){
			sec=00;
			min++;
		if (min==10)
	{min=0;
hour++;
}

}




	}
	return 0;
}



