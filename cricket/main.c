 
// DDS output thru PWM on timer0 OC1A (pin B.1)
// Mega8 version
// Produces a 15 mSec sine wave burst every 50 mSec.

#include <inttypes.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <math.h> 		// for sine


#define countMS 62  //ticks/mSec

// The DDS variables 
volatile unsigned long accumulator ;
unsigned char highbyte ;
unsigned long increment;			
char sineTable[256] ;

// Time variables
// the volitile is needed because the time is only set in the ISR
volatile unsigned int time ;
char  count;

// index for sine table build
unsigned int i;

ISR (TIMER0_OVF_vect)
{ 
	//the actual DDR 
	accumulator = accumulator + increment ;
	highbyte = accumulator >> 24 ;
	OCR1A = 128 + sineTable[highbyte]  ;  
	
	// generate time base for MAIN
	// 62 counts is about 1 mSec
	count--;
	if (0 == count )
	{
		count=countMS;
		time++;    //in mSec
	}  
} 
 
int main(void)
{ 
   
   // make B.3 an output
   DDRB = (1<<PB1) ;
   
   // init the sine table
   for (i=0; i<256; i++)
   {
   		sineTable[i] = (char)(127.0 * sin(6.283*((float)i)/256.0)) ;
   }  
   
   // init the DDS phase increment
   // for a 32-bit DDS accumulator, running at 16e6/256 Hz:
   // increment = 2^32*256*Fout/16e6 = 68719 * Fout
   // Fout=1000 Hz, increment= 68719000 
  // increment = 68719000L ;
  increment = 68719000L ;

   // init the time counter
   time=0;

   // timer 0 runs at full rate
  TCCR1B = _BV(WGM12) | _BV(CS10); 
   
   //turn on timer 0 overflow ISR
      TCCR0|=(1<<CS00);
    TCNT0=0;
    TIMSK|=(1<<TOIE0);


   // turn on all ISRs
   sei() ;
   
   while(1) 
   {  
   
     if (time==50) 
     {
	     // start a new 50 mSec cycle 
         time=0;
		 
         // phase lock the sine generator DDS
         accumulator = 0 ;
         
         //turn on pwm 
		 // turn on fast PWM and OC0A output
		 // at full clock rate, toggle OC0A (pin B3) 
   		 // 16 microsec per PWM cycle sample time
		  TCCR1A = _BV(COM1A1) | _BV(WGM10); 	  
     } //if 

	 // after 15 milliSec turn off PWM
     if (time==15) TCCR1A = 0 ;
     
	 
   } // } while 
}  //} main
      