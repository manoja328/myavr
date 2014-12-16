#include <htc.h>
#define data PORTB
#define RW RD2
#define RS RD0
#define EN RD1


__CONFIG(HS & WDTDIS & PWRTEN & BORDIS & LVPDIS);


void delay_ms(int n )
{
   	TMR1H=0xEC;	
	TMR1L=0x77;
	T1CKPS1=0;
	T1CKPS0=0;
	TMR1CS=0;
	TMR1IF=0;
	TMR1ON=1;
   	while(n>0)
  	 {
		while(!TMR1IF)  { }
		TMR1IF=0;
		TMR1H=0xEC;	
		TMR1L=0x77;
		n--;
	}
}
void lcd_wait(){
TRISB7 = 0x1;
     EN   = 1;           
     RS   = 0;           
     RW   = 1;           
     while(RB7){         
           EN   = 0; delay_ms(1);EN   = 1;        
   
 }
TRISB7 = 0x0;RW=0;
}

	
void LCD_Write(unsigned char value,int rs)
{
	RW=0;
	data = value; 
	RS = rs;				//if rs=0; command is sent to LCD otherwise data to be displayed is sent
	EN = 1; 
	delay_ms(1); 
	EN = 0; 
PORTB=data<<4;
	RS = rs;				//if rs=0; command is sent to LCD otherwise data to be displayed is sent
	EN = 1; 
	delay_ms(1); 
	EN = 0; 
//	lcd_wait()  ;	 
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
void wrcgchar(char *arrayptr, char pos)
 { 

	LCD_Write(0x40+pos*8,0);   
   while (*arrayptr != '\n') {   
	 LCD_Write (*arrayptr++,1);	
			}
 }

void initLCD(void)
{
	
	LCD_Write(0x20,0);
	EN=1;
	delay_ms(1);
 	EN = 0;

	LCD_Write(0x28,0);    
	delay_ms(1);

	LCD_Write(0x06,0);    
	delay_ms(1);
	


	LCD_Write(0x0c,0);    
	delay_ms(1);

	LCD_clear();delay_ms(1);



	
}


void main(void)
{
char *text = "4-BIT LCD CHAR";
	TRISB = 0x00;
	TRISD=0x00;
	initLCD();
	LCD_goto(1,0);	delay_ms(1);	
char bell[9] = {0x04,0x0E,0x0E,0x0E,0x1F,0x1F,0x04,0x00,'\n'};
char smiley[9] = {0x04,0x04,0x04,0x04,0x15,0x0e,0x04,0x00,'\n'}; 
wrcgchar(bell, 0);
wrcgchar(smiley, 1);
LCD_clear();delay_ms(1);

LCD_goto(2,0);	
	LCD_Write(0x01,1);    
	delay_ms(1);

  	LCD_goto(2,2);	
	LCD_Write(0x00,1);    
	delay_ms(1);

  	
LCD_goto(1,0);
while (*text != '\0')             
       {
		 LCD_Write(*text++,1);
         delay_ms(100);lcd_wait()  ;

       }
while(1);	
}


