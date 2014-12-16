#include <avr/io.h> 
#include <avr/interrupt.h> 

int main (void) 
{ 
	DDRD=0XFF;
   DDRB |= (1 << PB0); // Set LED1 as output 
   DDRB |= (1 << PB1); // Set LED2 as output 

   ADCSRA |= (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); // Set ADC prescaler to 128 - 125KHz sample rate @ 16MHz 

   ADMUX |= (1 << REFS0); // Set ADC reference to AVCC 
   ADMUX |= (1 << ADLAR); // Left adjust ADC result to allow easy 8 bit reading 

   // No MUX values needed to be changed to use ADC0 

   ADCSRA |= (1 << ADFR);  // Set ADC to Free-Running Mode 
   ADCSRA |= (1 << ADEN);  // Enable ADC 

   ADCSRA |= (1 << ADIE);  // Enable ADC Interrupt 
   sei();   // Enable Global Interrupts 

   ADCSRA |= (1 << ADSC);  // Start A2D Conversions 

   for(;;)  // Loop Forever 
   { 
   } 
} 

ISR(ADC_vect) 
{ 
	PORTD=ADCH;
   if(ADCH < 128) 
   { 
      PORTB |= (1 << PB0); // Turn on LED1 
      PORTB &= ~(1 << PB1); // Turn off LED2 
   } 
       
   else 
   { 
      PORTB &= ~(1 << PB0); // Turn off LED1 
      PORTB |= (1 << PB1); // Turn on LED2 
   } 
} 