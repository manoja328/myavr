#include <avr/io.h>
#include<util/delay.h>
#define RS PC4 
#define EN PC5 
#define sbi(x,y) x|=_BV(y)
#define cbi(x,y) x&=~(_BV(y))



	
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

void wrcgchar(char arrayptr[], char pos)
 { 

	LCD_Write(0x40+pos*8,0);
  
	unsigned char i;
   for (i=0;i<8;i++)   
	 LCD_Write (arrayptr[i],1);	
			
 }




int main(void)
{
	initLCD();	
	
LCD_goto(1,0);
lcd_puts("AVRLCD 4bit mode");


char bell[] = {0x04,0x0E,0x0E,0x0E,0x1F,0x1F,0x04,0x00};
char smiley1[] = {0x07, 0x08, 0x13, 0x14, 0x14, 0x13, 0x08, 0x07}; 
char smiley2[] = {0x00, 0x10, 0x08, 0x08, 0x08, 0x08, 0x10, 0x00};
char pana[] = {0x0A,0X15, 0x15, 0x0A, 0x04, 0x00, 0x00, 0x00};
wrcgchar(bell, 0);
wrcgchar(smiley1, 1);
wrcgchar(smiley2, 2);
wrcgchar(pana, 3);
LCD_goto(2,0);
	LCD_Write(0x01,1); 

	LCD_Write(0x02,1);

	LCD_Write(0x00,1); 
	LCD_Write(0x03,1);
	
while(1);
return 0;
}


