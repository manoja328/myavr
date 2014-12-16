#include <avr/io.h>
#include<util/delay.h>
#include <avr/interrupt.h>

#define RS PD0
#define EN PD1 
#define sbi(x,y) x|=_BV(y)
#define cbi(x,y) x&=~(_BV(y))



	
void LCD_Write(unsigned char values,unsigned char rs)
{
	rs?(PORTD|=(1<<RS)):(PORTD&=~(1<<RS));
	_delay_us(50);
	
	
	//first nibble
	(values & 0x10)?(PORTC|=(1<<PC0)):(PORTC&=~(1<<PC0));
	(values & 0x20)?(PORTC|=(1<<PC1)):(PORTC&=~(1<<PC1));
	(values & 0x40)?(PORTC|=(1<<PC2)):(PORTC&=~(1<<PC2));
	(values & 0x80)?(PORTC|=(1<<PC3)):(PORTC&=~(1<<PC3));
	
	
	sbi(PORTD,EN);
	_delay_us(1);
	cbi(PORTD,EN);
	
	// second nibble	

	
	values=values<<4;
	(values & 0x10)?(PORTC|=(1<<PC0)):(PORTC&=~(1<<PC0));
	(values & 0x20)?(PORTC|=(1<<PC1)):(PORTC&=~(1<<PC1));
	(values & 0x40)?(PORTC|=(1<<PC2)):(PORTC&=~(1<<PC2));
	(values & 0x80)?(PORTC|=(1<<PC3)):(PORTC&=~(1<<PC3));
	
	
	sbi(PORTD,EN);
	_delay_us(1);
	cbi(PORTD,EN);	
 
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

void LCD_num(long n)
{
	if (n<0){
		n=-n;
		LCD_Write('-',1);
		}
	else
		LCD_Write(' ',1);
	

	
    if(n>=0 && n<=9)
    {
		LCD_Write(48,1);
		LCD_Write(48,1);
	    LCD_Write(48+n,1);
	 }
	 else if(n<=99)
	 {
		 LCD_Write(48,1);
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
	DDRC = (1<<PC0)  | (1<<PC1)|(1<<PC2)  | (1<<PC3);
	DDRD =(1<<RS)  | (1<<EN);
	_delay_ms(15);
		
	LCD_Write(0x20,0);	
	sbi(PORTD,EN);
	_delay_ms(1);
	cbi(PORTD,EN);	
	LCD_Write(0x28,0);    
	_delay_ms(1);

	LCD_clear();
	LCD_Write(0x0c,0);    //dispaly on , cursor blinking
	_delay_ms(1);

	
		
	
}

void adc_Init(void) 
{ 


	ADMUX = ADCSRA = 0X00;
	ADCSRA|=(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);//Choosing a prescalar of 128 for 62.5kHz sample rate @ 8MHz (optimal sampling rate is 50 to 150 kHz)
	ADMUX|=(1<<REFS0);//Setting ADC internal 2.56v reference  

	ADMUX&=~(1<<ADLAR);//turning our 10 bit ADC measurement into an 8 bit one(as 0 to 255 will do for us) i.e. left adjust the result
	ADCSRA|=(1<<ADFR)|(1<<ADEN);//enable the adc */


	
	
}

long READadc() 
{
	
	ADCSRA|=(1<<ADSC);			//start a2d conversion 
	while(!(ADCSRA&(1<<ADIF)));	//waiting for the conversion to complete
	ADCSRA|=(1<<ADIF);			//clearing the ADIF flag 
	return ADC;

}
 



int main(void)
{

initLCD();		
LCD_goto(1,0);
lcd_puts("Joystick Test !");
LCD_goto(2,0);
lcd_puts("X:");
LCD_goto(2,8);
lcd_puts("Y:");
adc_Init();

while(1)
{

LCD_goto(2,2);
ADMUX &=0xF0;
ADMUX |=0x05;  //channel 5
LCD_num(READadc()-512);

LCD_goto(2,10);
ADMUX &=0xF0;
ADMUX |=0x04;  //channel 4
LCD_num(READadc()-512);

//if code yesto chha bhane chai problem aunchha delay le garda
//ADMUX &=0xF0;
//ADMUX |=0x05;  //channel 5
//LCD_goto(2,2); //yaha delay le garda
//LCD_num(READadc()-512);


}
return 0;
}







