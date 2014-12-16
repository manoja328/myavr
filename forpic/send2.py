#!/usr/bin/python
import time,sys,os
SERIALPORT = "COM1"
HEX = "main.hex"
BAUD = 9600
IF_FUSE_LOW = 0
IF_FUSE_HIGH = 0

if not sys.argv[1:]:
    print "usage: ./avrisp.py [hex file] [fuse bits low] [fuse bits high]"
    print "example: ./avrisp.py led.hex 225 133"
    print "note: use fuse bits only if it is necessary"
if sys.argv[1:]:
    HEX = sys.argv[1]
if sys.argv[2:]:
    FUSE_LOW = sys.argv[2]
    IF_FUSE_LOW = 1
if sys.argv[3:]:
    FUSE_HIGH = sys.argv[3]
    IF_FUSE_HIGH = 1




f = open(HEX)
hex = f.read()
list = hex.split("\n")
for line in list:
    if line=='':
        break
    print "----------------------------------"
    lt = len(line)
    count=1
    while count < lt :
        value = int(line[count] + line[count + 1],16)
        print value,
        count +=2
    print "\n",line
    
    print "no of bytes:",int(line[1] + line[2],16)
    print "address:",int(line[3] + line[4],16),int(line[5] + line[6],16)
    print "type:",int(line[7]+line[8],16)
    print "data:",line[9:]
    line=line[9:]
    count=0
    while count < len(line)-2:
        value = int(line[count] + line[count + 1],16)
        print value,",",
        count +=2
    print "\ncheksum:",int(line[count]+line[count+1],16)

