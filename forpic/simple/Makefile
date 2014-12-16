# Target file name (without extension).
TARGET = main


# MCU name
MCU = 16F877A

CC = C:\Program Files\HI-TECH Software\PICC\9.83\bin\picc.exe
REMOVE = rm -f

all: 
	$(CC) --chip=$(MCU) -m --opt=all -g $(TARGET).c

program:
	@echo "make program ... to flash fuses and firmware"

clean:
	@echo "cleaning objects and hex file......."
	$(REMOVE) $(TARGET).hex
	$(REMOVE) $(TARGET).eep
	$(REMOVE) $(TARGET).cof
	$(REMOVE) $(TARGET).elf
	$(REMOVE) $(TARGET).map
	$(REMOVE) $(TARGET).sym
	$(REMOVE) $(TARGET).lst
	$(REMOVE) $(TARGET).pre
	$(REMOVE) $(TARGET).sdb
	$(REMOVE) $(TARGET).hxl
	$(REMOVE) $(TARGET).p1
	$(REMOVE) $(TARGET).as
	$(REMOVE) startup.*
	$(REMOVE) funclist