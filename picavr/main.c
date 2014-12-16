#include <avr/io.h>
#include<util/delay.h>
#define VDD PC5
#define VSS PC4
#define VPP PC3
#define PGD PC2
#define PGC PC1
#define PGMPORT PORTC

#define loadconfig  0x00        // Load Configuration
#define loadpmdata  0x02        // Load Data for Program Memory
#define loaddmdata  0x03        // Load Data for Data Memory
#define readpmdata  0x04        // Read Data from Program Memory
#define readdmdata  0x05        // Read Data from Data Memory
#define incradd     0x06        // Increment Address
#define bgpgmit     0x08        // Begin Programming (Internally Timed) -->Begin Erase/Programming Cycle
#define bgpgmet     0x18        // Begin Programming (Externally Timed) -->Begin Programming Only Cycle
#define endpgm      0x17        // End Programming
#define bulkerpm    0x09        // Bulk Erase Program Memory
#define bulkerdm    0x0B        // Bulk Erase Data Memory



void SendCmdCode(unsigned char data){
unsigned char i;
PGMPORT |=(PGMPORT << PGC);  //RISING EDGE
for(i=0;i<6;i++){
PGMPORT &=~(PGMPORT << PGC); //FALLING EDGE
(data & 0x01)?(PGMPORT |=(PGMPORT<<PGD)):(PGMPORT &=~(PGMPORT<<PGD));
PGMPORT |=(PGMPORT << PGC);  //RISING EDGE
data=data >> 1;
}
PGMPORT &=~(PGMPORT << PGC); //FALLING EDGE
_delay_us(1);

}




void SendDataCode(short data){
int i;
PGMPORT |=(PGMPORT << PGC);  //RISING EDGE
for(i=0;i<16;i++){
PGMPORT &=~(PGMPORT << PGC); //FALLING EDGE
(data & 0x0001)?(PGMPORT |=(PGMPORT<<PGD)):(PGMPORT &=~(PGMPORT<<PGD));
PGMPORT |=(PGMPORT << PGC);  //RISING EDGE
data=data >> 1;
}
_delay_us(1);
}




void Write(const char data[], long length)
{
	long i;
	short val;
	for (i = 0; i < length;i+=2)
	{
			if (i != 0)
	    		SendCmdCode(incradd);
			
			val  = (data[i] << 8) + data[i+1];
			SendCmdCode(loadpmdata);
			SendDataCode(val);	
					
	
	}
			SendCmdCode(bgpgmet);
			_delay_ms(2);
			SendCmdCode(endpgm);
			_delay_us(100);
			SendCmdCode(incradd);

}

void EraseProgram(void)
{
    SendCmdCode(bulkerpm);
    _delay_ms(10);               // delay at least 10 ms for 10F parts
}

void EndProgCycle(void)
{
    SendCmdCode(endpgm);
    _delay_us(100);               // delay at least 100 us
}


int main(void)
{

DDRC=0XFF; //ALL OUTPUT
PGMPORT =0xFF;
PGMPORT |=(PGMPORT << VPP);
char data[6]={0x0A,0x12,0x8A,0x11,0xEF,0x2F};

Write(data, 6);
return 0;
}


