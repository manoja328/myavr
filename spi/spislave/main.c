#include <avr/io.h>
#include<util/delay.h>

#define DDR_SPI DDRB
#define DD_MISO  PB4
#define DD_SCK	 PB5
#define DD_SS	 PB2
void SPI_SlaveInit(void)
{
/* Set MISO output, all others input */
DDR_SPI = (1<<DD_MISO);
/* Enable SPI */
SPCR = (1<<SPE);
}


char SPI_SlaveReceive(void)
{
/* Wait for reception complete */
while(!(SPSR & (1<<SPIF)));
/* Return data register */
return SPDR;

}


int main(void)
{

SPI_SlaveInit();
char rec;	
DDRB &=~(1<<DD_SS);
while(1==1){
rec=SPI_SlaveReceive();
}
return 0;
}

