#define _LEGACY_HEADERS
#include <htc.h>
__CONFIG(HS & WDTDIS & PWRTEN & BORDIS & LVPDIS);
#define data PORTB
#define RS RD0
#define EN RD1



int sec=0;        
int min=9;
int hour=0;


void delay_ms(int n )
{
        TMR1H=0xEC;        // EC77H=60535d
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

        
void LCD_Write(unsigned char value,int rs)
{
        data = value; 
        RS = rs;                                //if rs=0; command is sent to LCD otherwise data to be displayed is sent
        EN = 1; 
        delay_ms(1); 
        EN = 0;  

}

void LCD_clear(void)
{
        LCD_Write(0x01,0);                //this clears LCD
}

void LCD_goto(unsigned char row,unsigned char column)
{
        if(row==1){
                LCD_Write(0x80+column,0);        //
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

void initLCD(void)
{
        //PORT configuration
        TRISB = 0x00;
        TRISD=0x00;
        //////////////////
        
        LCD_Write(0x38,0);    
        delay_ms(1);
        LCD_Write(0x0c,0);    //dispaly on , cursor blinking
        delay_ms(1);
        LCD_Write(0x01,0);    // clear dispaly screen
        
        
        delay_ms(1);
        LCD_Write(0x06,0);
//        LCD_Write(0x0F,0);                //blinking cursor
        delay_ms(1);
        LCD_clear();
        LCD_goto(1,0);
        
        LCD_Write('C',1);delay_ms(100);LCD_Write('l',1);delay_ms(100);
        LCD_Write('o',1);delay_ms(100);LCD_Write('c',1);delay_ms(100);
        LCD_Write('k',1);delay_ms(100);
        

        
        
}


void main(void)
{
        initLCD();

        
        while(1)
        {
LCD_goto(2,0);
LCD_num(hour);
LCD_goto(2,2);
        LCD_Write(':',1);delay_ms(100);
LCD_goto(2,3);
LCD_num(min);
LCD_goto(2,5);
        LCD_Write(':',1);delay_ms(100);
                LCD_goto(2,6);
        LCD_num(sec);
                sec++;
        
                delay_ms(500);
                if(sec==10){
                        sec=00;
                        min++;
                if (min==10)
        {min=0;
hour++;
}

}




        }
}