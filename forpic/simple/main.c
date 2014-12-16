#define _LEGACY_HEADERS
#include <htc.h>
__CONFIG(HS & WDTDIS & PWRTEN & BORDIS & LVPDIS);

void main(void)
{
//char b=0x23;
TRISB=0X00;
PORTB=0X00;
while(1){
RB0=1;
}
}