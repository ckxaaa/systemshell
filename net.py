#!/usr/bin/env python
#coding=utf-8
import time
import sys
if len(sys.argv) > 1:
    interface = sys.argv[1]
else:
    interface = 'enp3s0'
STATS = []
print 'interface:',interface

def rx():
    with open('/proc/net/dev') as f:
        ifstat = f.readlines()
    for inter in ifstat:
        if interface in inter:
            stat = float(inter.split()[9])
            STATS[1:] = [stat]

def tx():
    with open('/proc/net/dev') as f:
        ifstat = f.readlines()
    for inter in ifstat:   
        if interface in inter:
            stat = float(inter.split()[9])
            STATS[1:] = [stat]
        
print 'In                            Out'

rx()
tx()

while True:
    time.sleep(1)
    rxstat_o = list(STATS)
    rx()
    tx()
    RX = float(STATS[0])
    RX_O = rxstat_o[0]
    TX = float(STATS[1])
    TX_O = rxstat_o[1]
    RX_RATE = round((RX - RX_O)/1024/1024,3)
    TX_RATE = round((TX - TX_O)/1024/1024,3)
    print RX_RATE, 'MB                ',TX_RATE,'MB'
