opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 10920"

opt pagewidth 120

	opt lm

	processor	16F877A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 3 "lcd.c"
	psect config,class=CONFIG,delta=2 ;#
# 3 "lcd.c"
	dw 0x3FFE & 0x3FFB & 0x3FF7 & 0x3FBF & 0x3F7F ;#
	FNCALL	_main,_initLCD
	FNCALL	_main,_LCD_goto
	FNCALL	_main,_LCD_num
	FNCALL	_main,_LCD_Write
	FNCALL	_main,_delay_ms
	FNCALL	_initLCD,_LCD_Write
	FNCALL	_initLCD,_delay_ms
	FNCALL	_initLCD,_LCD_clear
	FNCALL	_initLCD,_LCD_goto
	FNCALL	_LCD_num,_LCD_Write
	FNCALL	_LCD_num,___awdiv
	FNCALL	_LCD_num,___awmod
	FNCALL	_LCD_goto,_LCD_Write
	FNCALL	_LCD_clear,_LCD_Write
	FNCALL	_LCD_Write,_delay_ms
	FNROOT	_main
	global	_min
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"lcd.c"
	line	11

;initializer for _min
	retlw	09h
	retlw	0

	global	_hour
	global	_sec
	global	_PORTB
_PORTB	set	6
	global	_TMR1H
_TMR1H	set	15
	global	_TMR1L
_TMR1L	set	14
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_RD0
_RD0	set	64
	global	_RD1
_RD1	set	65
	global	_T1CKPS0
_T1CKPS0	set	132
	global	_T1CKPS1
_T1CKPS1	set	133
	global	_TMR1CS
_TMR1CS	set	129
	global	_TMR1IF
_TMR1IF	set	96
	global	_TMR1ON
_TMR1ON	set	128
	global	_TRISB
_TRISB	set	134
	global	_TRISD
_TRISD	set	136
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
	file	"lcd.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_hour:
       ds      2

_sec:
       ds      2

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"lcd.c"
_min:
       ds      2

; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbssBANK0)+0)&07Fh
	clrf	((__pbssBANK0)+1)&07Fh
	clrf	((__pbssBANK0)+2)&07Fh
	clrf	((__pbssBANK0)+3)&07Fh
; Initialize objects allocated to BANK0
	global __pidataBANK0
psect cinit,class=CODE,delta=2
	fcall	__pidataBANK0+0		;fetch initializer
	movwf	__pdataBANK0+0&07fh		
	fcall	__pidataBANK0+1		;fetch initializer
	movwf	__pdataBANK0+1&07fh		
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_delay_ms
?_delay_ms:	; 0 bytes @ 0x0
	global	?_LCD_clear
?_LCD_clear:	; 0 bytes @ 0x0
	global	?_initLCD
?_initLCD:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?___awmod
?___awmod:	; 2 bytes @ 0x0
	global	delay_ms@n
delay_ms@n:	; 2 bytes @ 0x0
	global	___awmod@divisor
___awmod@divisor:	; 2 bytes @ 0x0
	ds	2
	global	??_delay_ms
??_delay_ms:	; 0 bytes @ 0x2
	global	___awmod@dividend
___awmod@dividend:	; 2 bytes @ 0x2
	ds	2
	global	??___awmod
??___awmod:	; 0 bytes @ 0x4
	ds	1
	global	___awmod@counter
___awmod@counter:	; 1 bytes @ 0x5
	ds	1
	global	___awmod@sign
___awmod@sign:	; 1 bytes @ 0x6
	ds	1
	global	?___awdiv
?___awdiv:	; 2 bytes @ 0x7
	global	___awdiv@divisor
___awdiv@divisor:	; 2 bytes @ 0x7
	ds	2
	global	___awdiv@dividend
___awdiv@dividend:	; 2 bytes @ 0x9
	ds	2
	global	??___awdiv
??___awdiv:	; 0 bytes @ 0xB
	ds	1
	global	??_LCD_Write
??_LCD_Write:	; 0 bytes @ 0xC
	global	LCD_Write@value
LCD_Write@value:	; 1 bytes @ 0xC
	ds	1
	global	??_LCD_clear
??_LCD_clear:	; 0 bytes @ 0xD
	global	??_LCD_goto
??_LCD_goto:	; 0 bytes @ 0xD
	global	??_LCD_num
??_LCD_num:	; 0 bytes @ 0xD
	global	LCD_goto@row
LCD_goto@row:	; 1 bytes @ 0xD
	ds	1
	global	??_initLCD
??_initLCD:	; 0 bytes @ 0xE
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	___awdiv@counter
___awdiv@counter:	; 1 bytes @ 0x0
	ds	1
	global	___awdiv@sign
___awdiv@sign:	; 1 bytes @ 0x1
	ds	1
	global	___awdiv@quotient
___awdiv@quotient:	; 2 bytes @ 0x2
	ds	2
	global	?_LCD_Write
?_LCD_Write:	; 0 bytes @ 0x4
	global	LCD_Write@rs
LCD_Write@rs:	; 2 bytes @ 0x4
	ds	2
	global	?_LCD_goto
?_LCD_goto:	; 0 bytes @ 0x6
	global	?_LCD_num
?_LCD_num:	; 0 bytes @ 0x6
	global	LCD_goto@column
LCD_goto@column:	; 1 bytes @ 0x6
	global	LCD_num@n
LCD_num@n:	; 2 bytes @ 0x6
	ds	2
	global	??_main
??_main:	; 0 bytes @ 0x8
	ds	1
;;Data sizes: Strings 0, constant 0, data 2, bss 4, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14     14      14
;; BANK0           80      9      15
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; ?___awmod	int  size(1) Largest target is 0
;;
;; ?___awdiv	int  size(1) Largest target is 0
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_LCD_goto
;;   _initLCD->_LCD_goto
;;   _LCD_num->_LCD_Write
;;   _LCD_goto->_LCD_Write
;;   _LCD_clear->_LCD_Write
;;   _LCD_Write->___awdiv
;;   ___awdiv->___awmod
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_LCD_num
;;   _initLCD->_LCD_goto
;;   _LCD_num->_LCD_Write
;;   _LCD_goto->_LCD_Write
;;   _LCD_clear->_LCD_Write
;;   _LCD_Write->___awdiv
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 1     1      0    1418
;;                                              8 BANK0      1     1      0
;;                            _initLCD
;;                           _LCD_goto
;;                            _LCD_num
;;                          _LCD_Write
;;                           _delay_ms
;; ---------------------------------------------------------------------------------
;; (1) _initLCD                                              0     0      0     312
;;                          _LCD_Write
;;                           _delay_ms
;;                          _LCD_clear
;;                           _LCD_goto
;; ---------------------------------------------------------------------------------
;; (1) _LCD_num                                              2     0      2     861
;;                                              6 BANK0      2     0      2
;;                          _LCD_Write
;;                            ___awdiv
;;                            ___awmod
;; ---------------------------------------------------------------------------------
;; (1) _LCD_goto                                             2     1      1     155
;;                                             13 COMMON     1     1      0
;;                                              6 BANK0      1     0      1
;;                          _LCD_Write
;; ---------------------------------------------------------------------------------
;; (2) _LCD_clear                                            0     0      0      67
;;                          _LCD_Write
;; ---------------------------------------------------------------------------------
;; (1) _LCD_Write                                            3     1      2      67
;;                                             12 COMMON     1     1      0
;;                                              4 BANK0      2     0      2
;;                           _delay_ms
;;                            ___awdiv (ARG)
;;                            ___awmod (ARG)
;; ---------------------------------------------------------------------------------
;; (2) ___awmod                                              7     3      4     296
;;                                              0 COMMON     7     3      4
;; ---------------------------------------------------------------------------------
;; (2) ___awdiv                                              9     5      4     300
;;                                              7 COMMON     5     1      4
;;                                              0 BANK0      4     4      0
;;                            ___awmod (ARG)
;; ---------------------------------------------------------------------------------
;; (1) _delay_ms                                             2     0      2      23
;;                                              0 COMMON     2     0      2
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _initLCD
;;     _LCD_Write
;;       _delay_ms
;;       ___awdiv (ARG)
;;         ___awmod (ARG)
;;       ___awmod (ARG)
;;     _delay_ms
;;     _LCD_clear
;;       _LCD_Write
;;         _delay_ms
;;         ___awdiv (ARG)
;;           ___awmod (ARG)
;;         ___awmod (ARG)
;;     _LCD_goto
;;       _LCD_Write
;;         _delay_ms
;;         ___awdiv (ARG)
;;           ___awmod (ARG)
;;         ___awmod (ARG)
;;   _LCD_goto
;;     _LCD_Write
;;       _delay_ms
;;       ___awdiv (ARG)
;;         ___awmod (ARG)
;;       ___awmod (ARG)
;;   _LCD_num
;;     _LCD_Write
;;       _delay_ms
;;       ___awdiv (ARG)
;;         ___awmod (ARG)
;;       ___awmod (ARG)
;;     ___awdiv
;;       ___awmod (ARG)
;;     ___awmod
;;   _LCD_Write
;;     _delay_ms
;;     ___awdiv (ARG)
;;       ___awmod (ARG)
;;     ___awmod (ARG)
;;   _delay_ms
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BANK3               60      0       0       9        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               60      0       0      11        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      21      12        0.0%
;;ABS                  0      0      1D       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       4       2        0.0%
;;BANK0               50      9       F       5       18.8%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      E       E       1      100.0%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 114 in file "lcd.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_initLCD
;;		_LCD_goto
;;		_LCD_num
;;		_LCD_Write
;;		_delay_ms
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"lcd.c"
	line	114
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 4
; Regs used in _main: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	115
	
l2877:	
	fcall	_initLCD
	line	118
	
l597:	
	line	120
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_LCD_goto)
	movlw	(02h)
	fcall	_LCD_goto
	line	121
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(_hour+1),w
	clrf	(?_LCD_num+1)
	addwf	(?_LCD_num+1)
	movf	(_hour),w
	clrf	(?_LCD_num)
	addwf	(?_LCD_num)

	fcall	_LCD_num
	line	122
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(?_LCD_goto)
	movlw	(02h)
	fcall	_LCD_goto
	line	123
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(03Ah)
	fcall	_LCD_Write
	movlw	low(064h)
	movwf	(?_delay_ms)
	movlw	high(064h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	124
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(?_LCD_goto)
	movlw	(02h)
	fcall	_LCD_goto
	line	125
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(_min+1),w
	clrf	(?_LCD_num+1)
	addwf	(?_LCD_num+1)
	movf	(_min),w
	clrf	(?_LCD_num)
	addwf	(?_LCD_num)

	fcall	_LCD_num
	line	126
	movlw	(05h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(?_LCD_goto)
	movlw	(02h)
	fcall	_LCD_goto
	line	127
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(03Ah)
	fcall	_LCD_Write
	movlw	low(064h)
	movwf	(?_delay_ms)
	movlw	high(064h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	128
	movlw	(06h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(?_LCD_goto)
	movlw	(02h)
	fcall	_LCD_goto
	line	129
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(_sec+1),w
	clrf	(?_LCD_num+1)
	addwf	(?_LCD_num+1)
	movf	(_sec),w
	clrf	(?_LCD_num)
	addwf	(?_LCD_num)

	fcall	_LCD_num
	line	130
	
l2879:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(_sec),f
	skipnc
	incf	(_sec+1),f
	movlw	high(01h)
	addwf	(_sec+1),f
	line	132
	
l2881:	
	movlw	low(01F4h)
	movwf	(?_delay_ms)
	movlw	high(01F4h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	133
	movlw	0Ah
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	xorwf	(_sec),w
	iorwf	(_sec+1),w
	skipz
	goto	u2611
	goto	u2610
u2611:
	goto	l597
u2610:
	line	134
	
l2883:	
	clrf	(_sec)
	clrf	(_sec+1)
	line	135
	
l2885:	
	movlw	low(01h)
	addwf	(_min),f
	skipnc
	incf	(_min+1),f
	movlw	high(01h)
	addwf	(_min+1),f
	line	136
	
l2887:	
	movlw	0Ah
	xorwf	(_min),w
	iorwf	(_min+1),w
	skipz
	goto	u2621
	goto	u2620
u2621:
	goto	l597
u2620:
	line	137
	
l2889:	
	clrf	(_min)
	clrf	(_min+1)
	line	138
	
l2891:	
	movlw	low(01h)
	addwf	(_hour),f
	skipnc
	incf	(_hour+1),f
	movlw	high(01h)
	addwf	(_hour+1),f
	goto	l597
	line	139
	
l599:	
	goto	l597
	line	141
	
l598:	
	goto	l597
	line	146
	
l600:	
	line	118
	goto	l597
	
l601:	
	line	147
	
l602:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_initLCD
psect	text219,local,class=CODE,delta=2
global __ptext219
__ptext219:

;; *************** function _initLCD *****************
;; Defined at:
;;		line 83 in file "lcd.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_LCD_Write
;;		_delay_ms
;;		_LCD_clear
;;		_LCD_goto
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text219
	file	"lcd.c"
	line	83
	global	__size_of_initLCD
	__size_of_initLCD	equ	__end_of_initLCD-_initLCD
	
_initLCD:	
	opt	stack 4
; Regs used in _initLCD: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	85
	
l2835:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(134)^080h	;volatile
	line	86
	clrf	(136)^080h	;volatile
	line	89
	
l2837:	
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(0)
	movwf	((?_LCD_Write))+1
	movlw	(038h)
	fcall	_LCD_Write
	line	90
	
l2839:	
	movlw	low(01h)
	movwf	(?_delay_ms)
	movlw	high(01h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	91
	
l2841:	
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(0)
	movwf	((?_LCD_Write))+1
	movlw	(0Ch)
	fcall	_LCD_Write
	line	92
	
l2843:	
	movlw	low(01h)
	movwf	(?_delay_ms)
	movlw	high(01h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	93
	
l2845:	
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(0)
	movwf	((?_LCD_Write))+1
	movlw	(01h)
	fcall	_LCD_Write
	line	96
	
l2847:	
	movlw	low(01h)
	movwf	(?_delay_ms)
	movlw	high(01h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	97
	
l2849:	
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(0)
	movwf	((?_LCD_Write))+1
	movlw	(06h)
	fcall	_LCD_Write
	line	99
	
l2851:	
	movlw	low(01h)
	movwf	(?_delay_ms)
	movlw	high(01h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	100
	
l2853:	
	fcall	_LCD_clear
	line	101
	
l2855:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_LCD_goto)
	movlw	(01h)
	fcall	_LCD_goto
	line	103
	
l2857:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(043h)
	fcall	_LCD_Write
	
l2859:	
	movlw	low(064h)
	movwf	(?_delay_ms)
	movlw	high(064h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	
l2861:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(06Ch)
	fcall	_LCD_Write
	
l2863:	
	movlw	low(064h)
	movwf	(?_delay_ms)
	movlw	high(064h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	104
	
l2865:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(06Fh)
	fcall	_LCD_Write
	
l2867:	
	movlw	low(064h)
	movwf	(?_delay_ms)
	movlw	high(064h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	
l2869:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(063h)
	fcall	_LCD_Write
	
l2871:	
	movlw	low(064h)
	movwf	(?_delay_ms)
	movlw	high(064h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	105
	
l2873:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(06Bh)
	fcall	_LCD_Write
	
l2875:	
	movlw	low(064h)
	movwf	(?_delay_ms)
	movlw	high(064h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	110
	
l594:	
	return
	opt stack 0
GLOBAL	__end_of_initLCD
	__end_of_initLCD:
;; =============== function _initLCD ends ============

	signat	_initLCD,88
	global	_LCD_num
psect	text220,local,class=CODE,delta=2
global __ptext220
__ptext220:

;; *************** function _LCD_num *****************
;; Defined at:
;;		line 61 in file "lcd.c"
;; Parameters:    Size  Location     Type
;;  n               2    6[BANK0 ] int 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       2       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_LCD_Write
;;		___awdiv
;;		___awmod
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text220
	file	"lcd.c"
	line	61
	global	__size_of_LCD_num
	__size_of_LCD_num	equ	__end_of_LCD_num-_LCD_num
	
_LCD_num:	
	opt	stack 5
; Regs used in _LCD_num: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	64
	
l2823:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(LCD_num@n+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(0Ah))^80h
	subwf	btemp+1,w
	skipz
	goto	u2585
	movlw	low(0Ah)
	subwf	(LCD_num@n),w
u2585:

	skipnc
	goto	u2581
	goto	u2580
u2581:
	goto	l2827
u2580:
	line	66
	
l2825:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	(030h)
	fcall	_LCD_Write
	line	67
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movf	(LCD_num@n),w
	addlw	030h
	fcall	_LCD_Write
	line	68
	goto	l591
	line	69
	
l586:	
	
l2827:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(LCD_num@n+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(064h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2595
	movlw	low(064h)
	subwf	(LCD_num@n),w
u2595:

	skipnc
	goto	u2591
	goto	u2590
u2591:
	goto	l2831
u2590:
	line	71
	
l2829:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	low(0Ah)
	movwf	(?___awdiv)
	movlw	high(0Ah)
	movwf	((?___awdiv))+1
	movf	(LCD_num@n+1),w
	clrf	1+(?___awdiv)+02h
	addwf	1+(?___awdiv)+02h
	movf	(LCD_num@n),w
	clrf	0+(?___awdiv)+02h
	addwf	0+(?___awdiv)+02h

	fcall	___awdiv
	movf	(0+(?___awdiv)),w
	addlw	030h
	fcall	_LCD_Write
	line	72
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	low(0Ah)
	movwf	(?___awmod)
	movlw	high(0Ah)
	movwf	((?___awmod))+1
	movf	(LCD_num@n+1),w
	clrf	1+(?___awmod)+02h
	addwf	1+(?___awmod)+02h
	movf	(LCD_num@n),w
	clrf	0+(?___awmod)+02h
	addwf	0+(?___awmod)+02h

	fcall	___awmod
	movf	(0+(?___awmod)),w
	addlw	030h
	fcall	_LCD_Write
	line	73
	goto	l591
	line	74
	
l588:	
	
l2831:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(LCD_num@n+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2605
	movlw	low(03E8h)
	subwf	(LCD_num@n),w
u2605:

	skipnc
	goto	u2601
	goto	u2600
u2601:
	goto	l591
u2600:
	line	76
	
l2833:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	low(064h)
	movwf	(?___awdiv)
	movlw	high(064h)
	movwf	((?___awdiv))+1
	movf	(LCD_num@n+1),w
	clrf	1+(?___awdiv)+02h
	addwf	1+(?___awdiv)+02h
	movf	(LCD_num@n),w
	clrf	0+(?___awdiv)+02h
	addwf	0+(?___awdiv)+02h

	fcall	___awdiv
	movf	(0+(?___awdiv)),w
	addlw	030h
	fcall	_LCD_Write
	line	77
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	low(0Ah)
	movwf	(?___awdiv)
	movlw	high(0Ah)
	movwf	((?___awdiv))+1
	movf	(LCD_num@n+1),w
	clrf	1+(?___awmod)+02h
	addwf	1+(?___awmod)+02h
	movf	(LCD_num@n),w
	clrf	0+(?___awmod)+02h
	addwf	0+(?___awmod)+02h

	movlw	low(064h)
	movwf	(?___awmod)
	movlw	high(064h)
	movwf	((?___awmod))+1
	fcall	___awmod
	movf	(1+(?___awmod)),w
	clrf	1+(?___awdiv)+02h
	addwf	1+(?___awdiv)+02h
	movf	(0+(?___awmod)),w
	clrf	0+(?___awdiv)+02h
	addwf	0+(?___awdiv)+02h

	fcall	___awdiv
	movf	(0+(?___awdiv)),w
	addlw	030h
	fcall	_LCD_Write
	line	78
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(01h)
	movwf	((?_LCD_Write))+1
	movlw	low(0Ah)
	movwf	(?___awmod)
	movlw	high(0Ah)
	movwf	((?___awmod))+1
	movf	(LCD_num@n+1),w
	clrf	1+(?___awmod)+02h
	addwf	1+(?___awmod)+02h
	movf	(LCD_num@n),w
	clrf	0+(?___awmod)+02h
	addwf	0+(?___awmod)+02h

	fcall	___awmod
	movf	(0+(?___awmod)),w
	addlw	030h
	fcall	_LCD_Write
	goto	l591
	line	79
	
l590:	
	goto	l591
	line	80
	
l589:	
	goto	l591
	
l587:	
	
l591:	
	return
	opt stack 0
GLOBAL	__end_of_LCD_num
	__end_of_LCD_num:
;; =============== function _LCD_num ends ============

	signat	_LCD_num,4216
	global	_LCD_goto
psect	text221,local,class=CODE,delta=2
global __ptext221
__ptext221:

;; *************** function _LCD_goto *****************
;; Defined at:
;;		line 51 in file "lcd.c"
;; Parameters:    Size  Location     Type
;;  row             1    wreg     unsigned char 
;;  column          1    6[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  row             1   13[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       1       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       1       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_LCD_Write
;; This function is called by:
;;		_initLCD
;;		_main
;; This function uses a non-reentrant model
;;
psect	text221
	file	"lcd.c"
	line	51
	global	__size_of_LCD_goto
	__size_of_LCD_goto	equ	__end_of_LCD_goto-_LCD_goto
	
_LCD_goto:	
	opt	stack 5
; Regs used in _LCD_goto: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	movwf	(LCD_goto@row)
	line	52
	
l2815:	
	movf	(LCD_goto@row),w
	xorlw	01h
	skipz
	goto	u2561
	goto	u2560
u2561:
	goto	l2819
u2560:
	line	53
	
l2817:	
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(0)
	movwf	((?_LCD_Write))+1
	movf	(LCD_goto@column),w
	addlw	080h
	fcall	_LCD_Write
	line	54
	goto	l583
	line	55
	
l580:	
	
l2819:	
	movf	(LCD_goto@row),w
	xorlw	02h
	skipz
	goto	u2571
	goto	u2570
u2571:
	goto	l583
u2570:
	line	56
	
l2821:	
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(0)
	movwf	((?_LCD_Write))+1
	movf	(LCD_goto@column),w
	addlw	0C0h
	fcall	_LCD_Write
	goto	l583
	line	57
	
l582:	
	goto	l583
	line	58
	
l581:	
	
l583:	
	return
	opt stack 0
GLOBAL	__end_of_LCD_goto
	__end_of_LCD_goto:
;; =============== function _LCD_goto ends ============

	signat	_LCD_goto,8312
	global	_LCD_clear
psect	text222,local,class=CODE,delta=2
global __ptext222
__ptext222:

;; *************** function _LCD_clear *****************
;; Defined at:
;;		line 46 in file "lcd.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_LCD_Write
;; This function is called by:
;;		_initLCD
;; This function uses a non-reentrant model
;;
psect	text222
	file	"lcd.c"
	line	46
	global	__size_of_LCD_clear
	__size_of_LCD_clear	equ	__end_of_LCD_clear-_LCD_clear
	
_LCD_clear:	
	opt	stack 4
; Regs used in _LCD_clear: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	47
	
l2813:	
	movlw	low(0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?_LCD_Write)
	movlw	high(0)
	movwf	((?_LCD_Write))+1
	movlw	(01h)
	fcall	_LCD_Write
	line	48
	
l577:	
	return
	opt stack 0
GLOBAL	__end_of_LCD_clear
	__end_of_LCD_clear:
;; =============== function _LCD_clear ends ============

	signat	_LCD_clear,88
	global	_LCD_Write
psect	text223,local,class=CODE,delta=2
global __ptext223
__ptext223:

;; *************** function _LCD_Write *****************
;; Defined at:
;;		line 36 in file "lcd.c"
;; Parameters:    Size  Location     Type
;;  value           1    wreg     unsigned char 
;;  rs              2    4[BANK0 ] int 
;; Auto vars:     Size  Location     Type
;;  value           1   12[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       2       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       2       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_delay_ms
;; This function is called by:
;;		_LCD_clear
;;		_LCD_goto
;;		_LCD_num
;;		_initLCD
;;		_main
;; This function uses a non-reentrant model
;;
psect	text223
	file	"lcd.c"
	line	36
	global	__size_of_LCD_Write
	__size_of_LCD_Write	equ	__end_of_LCD_Write-_LCD_Write
	
_LCD_Write:	
	opt	stack 6
; Regs used in _LCD_Write: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	movwf	(LCD_Write@value)
	line	37
	
l2803:	
	movf	(LCD_Write@value),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(6)	;volatile
	line	38
	
l2805:	
	btfsc	(LCD_Write@rs),0
	goto	u2541
	goto	u2540
	
u2541:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(64/8),(64)&7
	goto	u2554
u2540:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(64/8),(64)&7
u2554:
	line	39
	
l2807:	
	bsf	(65/8),(65)&7
	line	40
	
l2809:	
	movlw	low(01h)
	movwf	(?_delay_ms)
	movlw	high(01h)
	movwf	((?_delay_ms))+1
	fcall	_delay_ms
	line	41
	
l2811:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(65/8),(65)&7
	line	43
	
l574:	
	return
	opt stack 0
GLOBAL	__end_of_LCD_Write
	__end_of_LCD_Write:
;; =============== function _LCD_Write ends ============

	signat	_LCD_Write,8312
	global	___awmod
psect	text224,local,class=CODE,delta=2
global __ptext224
__ptext224:

;; *************** function ___awmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files\HI-TECH Software\PICC\9.83\sources\awmod.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    0[COMMON] int 
;;  dividend        2    2[COMMON] int 
;; Auto vars:     Size  Location     Type
;;  sign            1    6[COMMON] unsigned char 
;;  counter         1    5[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    0[COMMON] int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         4       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         7       0       0       0       0
;;Total ram usage:        7 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_LCD_num
;; This function uses a non-reentrant model
;;
psect	text224
	file	"C:\Program Files\HI-TECH Software\PICC\9.83\sources\awmod.c"
	line	5
	global	__size_of___awmod
	__size_of___awmod	equ	__end_of___awmod-___awmod
	
___awmod:	
	opt	stack 6
; Regs used in ___awmod: [wreg+status,2+status,0]
	line	8
	
l2769:	
	clrf	(___awmod@sign)
	line	9
	btfss	(___awmod@dividend+1),7
	goto	u2451
	goto	u2450
u2451:
	goto	l2773
u2450:
	line	10
	
l2771:	
	comf	(___awmod@dividend),f
	comf	(___awmod@dividend+1),f
	incf	(___awmod@dividend),f
	skipnz
	incf	(___awmod@dividend+1),f
	line	11
	clrf	(___awmod@sign)
	bsf	status,0
	rlf	(___awmod@sign),f
	goto	l2773
	line	12
	
l1493:	
	line	13
	
l2773:	
	btfss	(___awmod@divisor+1),7
	goto	u2461
	goto	u2460
u2461:
	goto	l2777
u2460:
	line	14
	
l2775:	
	comf	(___awmod@divisor),f
	comf	(___awmod@divisor+1),f
	incf	(___awmod@divisor),f
	skipnz
	incf	(___awmod@divisor+1),f
	goto	l2777
	
l1494:	
	line	15
	
l2777:	
	movf	(___awmod@divisor+1),w
	iorwf	(___awmod@divisor),w
	skipnz
	goto	u2471
	goto	u2470
u2471:
	goto	l2795
u2470:
	line	16
	
l2779:	
	clrf	(___awmod@counter)
	bsf	status,0
	rlf	(___awmod@counter),f
	line	17
	goto	l2785
	
l1497:	
	line	18
	
l2781:	
	movlw	01h
	
u2485:
	clrc
	rlf	(___awmod@divisor),f
	rlf	(___awmod@divisor+1),f
	addlw	-1
	skipz
	goto	u2485
	line	19
	
l2783:	
	movlw	(01h)
	movwf	(??___awmod+0)+0
	movf	(??___awmod+0)+0,w
	addwf	(___awmod@counter),f
	goto	l2785
	line	20
	
l1496:	
	line	17
	
l2785:	
	btfss	(___awmod@divisor+1),(15)&7
	goto	u2491
	goto	u2490
u2491:
	goto	l2781
u2490:
	goto	l2787
	
l1498:	
	goto	l2787
	line	21
	
l1499:	
	line	22
	
l2787:	
	movf	(___awmod@divisor+1),w
	subwf	(___awmod@dividend+1),w
	skipz
	goto	u2505
	movf	(___awmod@divisor),w
	subwf	(___awmod@dividend),w
u2505:
	skipc
	goto	u2501
	goto	u2500
u2501:
	goto	l2791
u2500:
	line	23
	
l2789:	
	movf	(___awmod@divisor),w
	subwf	(___awmod@dividend),f
	movf	(___awmod@divisor+1),w
	skipc
	decf	(___awmod@dividend+1),f
	subwf	(___awmod@dividend+1),f
	goto	l2791
	
l1500:	
	line	24
	
l2791:	
	movlw	01h
	
u2515:
	clrc
	rrf	(___awmod@divisor+1),f
	rrf	(___awmod@divisor),f
	addlw	-1
	skipz
	goto	u2515
	line	25
	
l2793:	
	movlw	low(01h)
	subwf	(___awmod@counter),f
	btfss	status,2
	goto	u2521
	goto	u2520
u2521:
	goto	l2787
u2520:
	goto	l2795
	
l1501:	
	goto	l2795
	line	26
	
l1495:	
	line	27
	
l2795:	
	movf	(___awmod@sign),w
	skipz
	goto	u2530
	goto	l2799
u2530:
	line	28
	
l2797:	
	comf	(___awmod@dividend),f
	comf	(___awmod@dividend+1),f
	incf	(___awmod@dividend),f
	skipnz
	incf	(___awmod@dividend+1),f
	goto	l2799
	
l1502:	
	line	29
	
l2799:	
	movf	(___awmod@dividend+1),w
	clrf	(?___awmod+1)
	addwf	(?___awmod+1)
	movf	(___awmod@dividend),w
	clrf	(?___awmod)
	addwf	(?___awmod)

	goto	l1503
	
l2801:	
	line	30
	
l1503:	
	return
	opt stack 0
GLOBAL	__end_of___awmod
	__end_of___awmod:
;; =============== function ___awmod ends ============

	signat	___awmod,8314
	global	___awdiv
psect	text225,local,class=CODE,delta=2
global __ptext225
__ptext225:

;; *************** function ___awdiv *****************
;; Defined at:
;;		line 5 in file "C:\Program Files\HI-TECH Software\PICC\9.83\sources\awdiv.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    7[COMMON] int 
;;  dividend        2    9[COMMON] int 
;; Auto vars:     Size  Location     Type
;;  quotient        2    2[BANK0 ] int 
;;  sign            1    1[BANK0 ] unsigned char 
;;  counter         1    0[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    7[COMMON] int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         4       0       0       0       0
;;      Locals:         0       4       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         5       4       0       0       0
;;Total ram usage:        9 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_LCD_num
;; This function uses a non-reentrant model
;;
psect	text225
	file	"C:\Program Files\HI-TECH Software\PICC\9.83\sources\awdiv.c"
	line	5
	global	__size_of___awdiv
	__size_of___awdiv	equ	__end_of___awdiv-___awdiv
	
___awdiv:	
	opt	stack 6
; Regs used in ___awdiv: [wreg+status,2+status,0]
	line	9
	
l2729:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(___awdiv@sign)
	line	10
	btfss	(___awdiv@divisor+1),7
	goto	u2351
	goto	u2350
u2351:
	goto	l2733
u2350:
	line	11
	
l2731:	
	comf	(___awdiv@divisor),f
	comf	(___awdiv@divisor+1),f
	incf	(___awdiv@divisor),f
	skipnz
	incf	(___awdiv@divisor+1),f
	line	12
	clrf	(___awdiv@sign)
	bsf	status,0
	rlf	(___awdiv@sign),f
	goto	l2733
	line	13
	
l1425:	
	line	14
	
l2733:	
	btfss	(___awdiv@dividend+1),7
	goto	u2361
	goto	u2360
u2361:
	goto	l2739
u2360:
	line	15
	
l2735:	
	comf	(___awdiv@dividend),f
	comf	(___awdiv@dividend+1),f
	incf	(___awdiv@dividend),f
	skipnz
	incf	(___awdiv@dividend+1),f
	line	16
	
l2737:	
	movlw	(01h)
	movwf	(??___awdiv+0)+0
	movf	(??___awdiv+0)+0,w
	xorwf	(___awdiv@sign),f
	goto	l2739
	line	17
	
l1426:	
	line	18
	
l2739:	
	clrf	(___awdiv@quotient)
	clrf	(___awdiv@quotient+1)
	line	19
	
l2741:	
	movf	(___awdiv@divisor+1),w
	iorwf	(___awdiv@divisor),w
	skipnz
	goto	u2371
	goto	u2370
u2371:
	goto	l2761
u2370:
	line	20
	
l2743:	
	clrf	(___awdiv@counter)
	bsf	status,0
	rlf	(___awdiv@counter),f
	line	21
	goto	l2749
	
l1429:	
	line	22
	
l2745:	
	movlw	01h
	
u2385:
	clrc
	rlf	(___awdiv@divisor),f
	rlf	(___awdiv@divisor+1),f
	addlw	-1
	skipz
	goto	u2385
	line	23
	
l2747:	
	movlw	(01h)
	movwf	(??___awdiv+0)+0
	movf	(??___awdiv+0)+0,w
	addwf	(___awdiv@counter),f
	goto	l2749
	line	24
	
l1428:	
	line	21
	
l2749:	
	btfss	(___awdiv@divisor+1),(15)&7
	goto	u2391
	goto	u2390
u2391:
	goto	l2745
u2390:
	goto	l2751
	
l1430:	
	goto	l2751
	line	25
	
l1431:	
	line	26
	
l2751:	
	movlw	01h
	
u2405:
	clrc
	rlf	(___awdiv@quotient),f
	rlf	(___awdiv@quotient+1),f
	addlw	-1
	skipz
	goto	u2405
	line	27
	movf	(___awdiv@divisor+1),w
	subwf	(___awdiv@dividend+1),w
	skipz
	goto	u2415
	movf	(___awdiv@divisor),w
	subwf	(___awdiv@dividend),w
u2415:
	skipc
	goto	u2411
	goto	u2410
u2411:
	goto	l2757
u2410:
	line	28
	
l2753:	
	movf	(___awdiv@divisor),w
	subwf	(___awdiv@dividend),f
	movf	(___awdiv@divisor+1),w
	skipc
	decf	(___awdiv@dividend+1),f
	subwf	(___awdiv@dividend+1),f
	line	29
	
l2755:	
	bsf	(___awdiv@quotient)+(0/8),(0)&7
	goto	l2757
	line	30
	
l1432:	
	line	31
	
l2757:	
	movlw	01h
	
u2425:
	clrc
	rrf	(___awdiv@divisor+1),f
	rrf	(___awdiv@divisor),f
	addlw	-1
	skipz
	goto	u2425
	line	32
	
l2759:	
	movlw	low(01h)
	subwf	(___awdiv@counter),f
	btfss	status,2
	goto	u2431
	goto	u2430
u2431:
	goto	l2751
u2430:
	goto	l2761
	
l1433:	
	goto	l2761
	line	33
	
l1427:	
	line	34
	
l2761:	
	movf	(___awdiv@sign),w
	skipz
	goto	u2440
	goto	l2765
u2440:
	line	35
	
l2763:	
	comf	(___awdiv@quotient),f
	comf	(___awdiv@quotient+1),f
	incf	(___awdiv@quotient),f
	skipnz
	incf	(___awdiv@quotient+1),f
	goto	l2765
	
l1434:	
	line	36
	
l2765:	
	movf	(___awdiv@quotient+1),w
	clrf	(?___awdiv+1)
	addwf	(?___awdiv+1)
	movf	(___awdiv@quotient),w
	clrf	(?___awdiv)
	addwf	(?___awdiv)

	goto	l1435
	
l2767:	
	line	37
	
l1435:	
	return
	opt stack 0
GLOBAL	__end_of___awdiv
	__end_of___awdiv:
;; =============== function ___awdiv ends ============

	signat	___awdiv,8314
	global	_delay_ms
psect	text226,local,class=CODE,delta=2
global __ptext226
__ptext226:

;; *************** function _delay_ms *****************
;; Defined at:
;;		line 16 in file "lcd.c"
;; Parameters:    Size  Location     Type
;;  n               2    0[COMMON] int 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         2       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_LCD_Write
;;		_initLCD
;;		_main
;; This function uses a non-reentrant model
;;
psect	text226
	file	"lcd.c"
	line	16
	global	__size_of_delay_ms
	__size_of_delay_ms	equ	__end_of_delay_ms-_delay_ms
	
_delay_ms:	
	opt	stack 7
; Regs used in _delay_ms: [wreg+btemp+1]
	line	17
	
l2713:	
	movlw	(0ECh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(15)	;volatile
	line	18
	movlw	(077h)
	movwf	(14)	;volatile
	line	19
	
l2715:	
	bcf	(133/8),(133)&7
	line	20
	
l2717:	
	bcf	(132/8),(132)&7
	line	21
	
l2719:	
	bcf	(129/8),(129)&7
	line	22
	
l2721:	
	bcf	(96/8),(96)&7
	line	23
	
l2723:	
	bsf	(128/8),(128)&7
	line	24
	goto	l2727
	
l566:	
	line	26
	goto	l567
	
l568:	
	
l567:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(96/8),(96)&7
	goto	u2331
	goto	u2330
u2331:
	goto	l567
u2330:
	
l569:	
	line	27
	bcf	(96/8),(96)&7
	line	28
	
l2725:	
	movlw	(0ECh)
	movwf	(15)	;volatile
	line	29
	movlw	(077h)
	movwf	(14)	;volatile
	line	30
	movlw	low(-1)
	addwf	(delay_ms@n),f
	skipnc
	incf	(delay_ms@n+1),f
	movlw	high(-1)
	addwf	(delay_ms@n+1),f
	goto	l2727
	line	31
	
l565:	
	line	24
	
l2727:	
	movf	(delay_ms@n+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(01h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2345
	movlw	low(01h)
	subwf	(delay_ms@n),w
u2345:

	skipnc
	goto	u2341
	goto	u2340
u2341:
	goto	l567
u2340:
	goto	l571
	
l570:	
	line	32
	
l571:	
	return
	opt stack 0
GLOBAL	__end_of_delay_ms
	__end_of_delay_ms:
;; =============== function _delay_ms ends ============

	signat	_delay_ms,4216
psect	text227,local,class=CODE,delta=2
global __ptext227
__ptext227:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
