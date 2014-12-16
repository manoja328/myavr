#include <avr/io.h>

#define DDR_SPI DDRB
#define DD_MOSI  PB3
#define DD_SCK	 PB5


void SPI_MasterInit(void)
{
/* Set MOSI and SCK output, all others input */
DDR_SPI = (1<<DD_MOSI)|(1<<DD_SCK)| (1<<PB2) ;
/* Enable SPI, Master, set clock rate fck/16 */
SPCR = (1<<SPE)|(1<<MSTR)|(1<<SPR0);
}



void SPI_MasterTransmit(char cData)
{
/* Start transmission */
SPDR = cData;
/* Wait for transmission complete */
while(!(SPSR & (1<<SPIF)))
;
}





int main(void)
{

SPI_MasterInit();	
DDRC=0XFF;
while(1==1){
PORTC &= ~(1<<PC0);
SPI_MasterTransmit('a');
PORTC |= (1<<PC0);

PORTC &= ~(1<<PC0);
SPI_MasterTransmit('b');
PORTC |= (1<<PC0);
}

return 0;
}

