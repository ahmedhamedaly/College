;
; CS1022 Introduction to Computing II 2018/2019
; Mid-Term Assignment - Connect 4 - SOLUTION
;
; get, put and puts subroutines provided by jones@scss.tcd.ie
;

PINSEL0	EQU	0xE002C000
U0RBR	EQU	0xE000C000
U0THR	EQU	0xE000C000
U0LCR	EQU	0xE000C00C
U0LSR	EQU	0xE000C014


		AREA	globals, DATA, READWRITE
BOARD	DCB	0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0


	AREA	RESET, CODE, READONLY
	ENTRY

	; initialise SP to top of RAM
		LDR	R13, =0x40010000		; initialse SP

	; initialise the console
		BL	inithw

	;
	; your program goes here
	;
		
		LDR R0, =str_go
		BL 	puts
		MOV R2, #1
		BL 	initialiseBoard

repeat	BL 	drawBoard		
		BL  checkWinner
		BL 	makeMove
		b  	repeat


stop	B	stop


;
; your subroutines go here
;

;
; initialiseBoard subroutine
; initialises the connect 4 board 
;
initialiseBoard	
		PUSH {R4-R7, lr}				; PUSH
		
		LDR R4, =0x400000B0				; MEM[BOARD]
		LDR R5, =BOARD					; BOARD
		
inBoard	CMP R6, #42						; while (counter < 42) {
		BHS	enBoard						; 
		LDR R7, [R5, R6, LSL #2]		; load = BOARD[row][column]; 
		STR R7, [R4, R6, LSL #2]		; store = BOARD[row][column];
		ADD R6, R6, #1					; counter++;
		B	inBoard						; }
		
enBoard	POP {R4-R7, pc}					; POP

;
; drawBoard subroutine
; draws the connect 4 board
;
drawBoard
		PUSH {R4-R8, lr}				; PUSH
		
		LDR R0, =Rows					; loads start of the rows into register
		BL 	puts						; prints the text

		LDR R4, =0x400000B0				; loads mem for board
		
drBoard	CMP R5, #42						; while (counter < 42) {
		BHS	noDraw						; 
		MOV	R7, #7						; numberOfRows = 7;
		MUL R8, R7, R6					; column = counter2 * numberOfRows;
		CMP R5, R8						; if (counter > column) {
		BLO	nxCol						; else {Next column}
		LDR R0, =NewLine				; [newLine]
		BL	puts						; 
		ADD R6, R6, #1					; counter2++;
		MOV R1, R6						; columnNumber = counter2;
		
		CMP R1, #1						; if (columnNumber == 1) {
		BNE	col2						; else {col2}
		LDR R0, =column1				; [column1]
		BL 	puts						;
		B	nxCol						; }
		
col2	CMP R1, #2						; if (columnNumber == 2) {
		BNE col3						; else {col3}
		LDR R0, =column2				; [column2]
		BL  puts						;
		B	nxCol						; }
		
col3	CMP R1, #3						; if (columnNumber == 3) {
		BNE col4						; else {col4}
		LDR R0, =column3				; [column3]
		BL	puts						;
		B	nxCol						; }
		
col4	CMP R1, #4						; if (columnNumber == 4) {
		BNE col5						; else {col5}
		LDR R0, =column4				; [column4]
		BL	puts						;
		B	nxCol						; }
		
col5	CMP R1, #5						; if (columnNumber == 5) {
		BNE col6						; else {col6}
		LDR R0, =column5				; [column5]
		BL	puts						;
		B	nxCol						; }
		
col6	LDR R0, =column6				; [column6]
		BL	puts						; 

nxCol	LDR R0, [R4, R5, LSL #2]		; load = BOARD[row][column]
		CMP R0, #0						; if (blank) {
		BNE	redMove						; else {RedsTurn}
		LDR R0, =Blank					; [Blank]
		BL	puts						; 
		B	count						; }
		
redMove	CMP R0, #1						; if (RedsTurn) {
		BNE	yelMove						; else {YellowsTurn}
		LDR R0, =Red					; [Red]
		BL 	puts						; 
		B	count						; }
		
yelMove	LDR R0, =Yellow					; [Yellow]
		BL	puts						;
		
count	ADD R5, R5, #1					; counter++
		B	drBoard						; }
		
noDraw	LDR R0, =NewLine				; [newLine]
		BL  puts						; 
		LDR R0, =NewLine				; [newLine]
		BL  puts						; 
		
		POP {R4-R8, pc}					; POP
	
;
; makeMove subroutine
; Makes a move according to which players turn it is
;

makeMove	
		PUSH {R4-R6, lr}				; PUSH
		
		LDR R4, =0x4000013C				; MEM[BOARD]
		LDR R5, =6						; columns = 6
		
		CMP R2, #1						; if (RedsTurn) {
		BNE yelTurn						; else {yelTurn}
		LDR R0, =RedsTurn				; [RedsTurn]
		BL  puts						; 
		B	sk							; }
		
yelTurn	LDR R0, =YellowsTurn			; [YellowsTurn]
		BL	puts						; 
		
sk		BL 	get							; userInput.get();
		
		BL  put							;
		
		CMP R0, #0x71					; if (userInput == 'q') {
		BEQ quit						; }
		
		SUB R0, R0, #0x30				; ASCII (Numbers go from 1 - 7) [fix]
		
		CMP R0, #0						; if (userInput < 1) {
		BLS noInput						; }
		
		CMP R0, #7						; if (userInput > 7) {
		BHI noInput						; }
		
		SUB R0, R0, #1					; index starts at 0 [fix]
		
		LDR R6, =4						; offset = 4;
		MUL R6, R0, R6					; userInput * offset;
		ADD R4, R6, R4					; MEM[BOARD] += offset;
		
rep		LDR R3, [R4]					; placeIsAvail = currentAddress;
		CMP R3, #0						; if (placeIsAvail) {
		BEQ place						; }
		SUB R5, R5, #1					; column--;
		SUB R4, R4, #28					; MEM[BOARD] - 28
		
		CMP R5, #0						; if (column == 0) {
		BEQ noInput						; }
		B	rep							; 

		
noInput	LDR R0, =NewLine				; [NewLine]
		BL 	puts						;
		LDR R0, =NewLine				; [NewLine]
		BL  puts						; 
		LDR	R0, =InvalidInput			; [InvalidInput]
		BL  puts						;
		B	re							; 
		
place	STR R2, [R4]					; currentPlayer = place;
		MOV R3, R4						; savePos;
		
		CMP R2, #1						; if (redsTurn) {
		BNE	yt							; else {yellowsTurn}
		LDR R2, =2						; currentTurn = yellow;
		B	re							;
yt		LDR R2, =1						; currentTurn = red;

re		LDR R0, =NewLine				; [NewLine]
		BL  puts						; 
		LDR R0, =NewLine				; [NewLine]
		BL  puts						;

		
		POP {R4-R6, pc}					; POP
		
;
; checkWinner subroutine
; Makes a move according to which players turn it is
;	
checkWinner
		PUSH {lr}
		
		BL	checkHorizontal
		BL 	checkVertical
		BL 	checkDiagonalForward
		BL	checkDiagonalBackward
		
		BL  checkBoardFull
		POP	{pc}

;
;
;
checkBoardFull
		PUSH {R4 - R12, lr}
		
		LDR R4, =0x400000B0
		
boardF	CMP R5, #42
		BEQ noSpace
		LDR R0, [R4, R5, LSL #2]
		CMP R0, #0
		BEQ enFull
		ADD R5, R5, #1
		B	boardF
		
enFull	POP {R4 - R12, pc}
;
;
;
checkHorizontal
		PUSH {R4 - R12, lr}				; PUSH
		
		LDR R4, =0x400000B0				; MEM[BOARD]
		
ckBoard	CMP R5, #42						; if (counter < 42) {
		BHS	noCheck						; else {noCheck}
		LDR R0, [R4, R5, LSL #2]		; load = BOARD[row][column];
		
		MOV	R9, #7						; numberOfRows = 7;
		MUL R10, R9, R11				; counter2 * numberOfRows = columnNumber;
		CMP R5, R10						; if (counter > columnNumber) {
		BLO	cont						; else {continue}
		ADD R11, R11, #1				; counter2++
		MOV R7, #0						; redStreak = 0;
		MOV R8, #0						; yellowStreak = 0;
		
cont	CMP R0, #0						; if (blank) {
		BNE	red							; else {red}
		MOV R6, R0						; prevNumber = 0;
		B	loopCk						; }
		
red		CMP R0, #1						; if (redMove) {
		BNE	yel							; else {yellow}
		CMP R6, R0						; if (prevNumber == redPlayer) {
		BEQ	winRed						; else {redCounter++}
		MOV R7, #0						; redCounter = 0;
winRed	ADD R7, R7, #1					; redCounter++
		MOV R6, R0						; prevNumber = 1;
		B	loopCk						; }
		
yel		CMP R0, #2						; if (yellowMove) {
		BNE noCheck						; else {noCheck}
		CMP R6, R0						; if (prevNumber == yellowPlayer) {
		BEQ winYel						; else {yellowCounter++}
		MOV R8, #0						; yellowCounter = 0;
winYel	ADD R8, R8, #1					; yellowCounter++;
		MOV R6, R0						; prevNumber = 2;
		B	loopCk						; }
		
loopCk	CMP R7, #4						; if (redCounter >= 4) {
		BHS redWin						; }
		CMP R8, #4						; if (yellowCounter >= 4) {
		BHS	yelWin						; }
		ADD R5, R5, #1					; counter++
		B	ckBoard						; }
	

noCheck	POP {R4 - R12, PC}				; POP

;
;
;
checkVertical
		PUSH {R4 - R12, lr}				; PUSH
		
		LDR R4, =0x400000B0				; MEM[BOARD];
		
CkV		CMP R5, #42						; if (counter > 42) {
		BHS noV							; }
		LDR R0, [R4, R12, LSL #2]		; load = BOARD[row][column];
		ADD R12, R12, #7				; offSet = 7;
				
		CMP R0, #0						; if (blank) {
		BNE	vred						; else {red}
		MOV R6, R0						; prevNumber = 0;
		B	vch							; }
		
vred	CMP R0, #1						; if (redMove) {
		BNE	vyel						; else {yellowMove}
		CMP R6, R0						; if (prevNumber == 1) {
		BEQ	winRedV						; else {redCounter++}
		MOV R7, #0						; redCounter = 0;
winRedV	ADD R7, R7, #1					; redCounter++;
		MOV R6, R0						; prevNumber = 1;
		B	vch							; }
		
vyel	CMP R0, #2						; if (yellowMove) {
		BNE noV							; else {noCheck}
		CMP R6, R0						; if (prevNumber == 2) {
		BEQ winYelV						; else {yellowCounter++}
		MOV R8, #0						; yellowCounter = 0;
winYelV	ADD R8, R8, #1					; yellowCounter++;
		MOV R6, R0						; prevNumber = 2;
		
vch		ADD R5, R5, #1					; }

		CMP R7, #4						; if (redCounter >= 4) {
		BHS redWin						; }
		CMP R8, #4						; if (yellowCounter >= 4) {
		BHS	yelWin						; }
		
		CMP R5, #6						; if (counter == 6) {
		BEQ	load						; }
		CMP R5, #12						; if (counter == 12) {
		BEQ load						; }
		CMP R5, #18						; if (counter == 18) {
		BEQ load						; }
		CMP R5, #24						; if (counter == 24) {
		BEQ load						; }
		CMP R5, #30						; if (counter == 30) {
		BEQ load						; }
		CMP R5, #36						; if (counter == 36) {
		BEQ load						; }
		
		B 	CkV							; }
		
load	ADD R4, R4, #4					; MEM[BOARD] += 4;
		MOV R7, #0						; yellowCounter = 0;
		MOV R8, #0						; redCounter = 0;
		MOV R12, #0						; offSet = 0;
		B	CkV							; }
		
noV		POP {R4 - R12, pc}				; POP

;
;
;
checkDiagonalForward
		PUSH {R4 - R12, lr}				; PUSH
		
		LDR R4, =0x400000B0				; BOARD[row][column]
		
ff		CMP R5, #6						; if (counter > 6) {
		BHS	fs							; }
		LDR R0, [R4, R12, LSL #2]		; load = BOARD[1][column]
		ADD R12, R12, #8				; offSet += 8;
		ADD R5, R5, #1					; counter++;
		
		CMP R5, #6						; if (counter != 6) {
		BNE	aga							; }
		ADD R10, R10, #4				; offSet2 += 4;
		CMP R10, #16					; if (offSet2 == 16) {
		BEQ	fasd						; }
		
aga		CMP R0, #0						; if (blank) {
		BNE	fred						; else {red}
		MOV R6, R0						; prevNumber = 0;
		B	ff							; }
		
fred	CMP R0, #1						; if (red) {
		BNE	fyel						; else {yellow}
		CMP R6, R0						; if (prevNumber == 1) {
		BEQ	winRedf						; else {redCounter++}
		MOV R7, #0						; redCounter = 0;
winRedf	ADD R7, R7, #1					; redCounter++;
		MOV R6, R0						; prevNumber = 1;
		B	ff							; }
		
fyel	CMP R0, #2						; if (yellow) {
		BNE nof							; else {no}
		CMP R6, R0						; if (prevNumber == 2) {
		BEQ winYelf						; }
		MOV R8, #0						; yellowCounter = 0;
winYelf	ADD R8, R8, #1					; yellowCounter++;
		MOV R6, R0						; prevNumber = 2;
		
		CMP R7, #4						; if (redCounter >= 4) {
		BHS redWin						; }
		CMP R8, #4						; if (yellowCounter >= 4) {
		BHS	yelWin						; }	
		B	ff							; }
		
fasd	MOV R10, #0						; offSet2 = 0;
		ADD R11, R11, #1				; counter2++;
		B	aga							; }

fs		CMP R11, #0						; if (counter2 == 0) {
		BEQ first						; }
		CMP R11, #1						; if (counter2 == 1) {
		BEQ second						; }
		CMP R11, #2						; if (counter2 == 2) {
		BEQ third						; }
		CMP R11, #3						; if (counter2 == 3) {
		BEQ	nof							; }
first	LDR R4, =0x400000B0				; BOARD[1][column]
		B	ass							; }
second	LDR R4, =0x400000CC				; BOARD[2][column]
		B	ass							; }
third   LDR R4, =0x400000E8				; BOARD[3][column]
ass		ADD R4, R4, R10					; MEM[BOARD] += offSet2;
		MOV R5, #0						; counter = 0;
		MOV R12, #0						; offSet = 0;
		B	ff							; } 
		
nof		POP {R4 - R12, pc}				; POP
		
;
;
;
checkDiagonalBackward
		PUSH {R4 - R12, lr}				; PUSH
		
		LDR R4, =0x40000104				; BOARD[row][column]
		
bf		CMP R5, #6						; if (counter > 6) {
		BHS	bs							; }
		LDR R0, [R4, R12, LSL #2]		; load = BOARD[row][column];
		SUB R12, R12, #6				; offSet -= 6;
		ADD R5, R5, #1					; counter++
		
		CMP R5, #6						; if (counter == 6) {
		BNE	bab							; }
		ADD R10, R10, #4				; offSet2 += 4;
		CMP R10, #16					; if (offSet2 == 16) {
		BEQ	basd						; }
		
bab		CMP R0, #0						; if (blank) {
		BNE	bred						; }
		MOV R6, R0						; prevNumber = 0;
		B	bck							; }
		
bred	CMP R0, #1						; if (red) {
		BNE	byel						; else {yellow}
		CMP R6, R0						; if (prevNumber == 1) {
		BEQ	winRedb						; }
		MOV R7, #0						; redCounter = 0;
winRedb	ADD R7, R7, #1					; redCounter++;
		MOV R6, R0						; prevNumber = 1;
		B	bck							; }
		
byel	CMP R0, #2						; if (yellow) {
		BNE nob							; else {noCheck}
		CMP R6, R0						; if (prevNumber == 2) { 
		BEQ winYelb						; }
		MOV R8, #0						; yellowCounter = 0;
winYelb	ADD R8, R8, #1					; yellowCounter++;
		MOV R6, R0						; prevNumber = 2;
		
bck		CMP R7, #4						; if (redCounter >= 4) {
		BHS redWin						; }
		CMP R8, #4						; if (yellowCounter >= 4) {
		BHS	yelWin						; }	
		B	bf							; }
		
basd   	MOV R10, #0						; offSet2 = 0;
		ADD R11, R11, #1				; counter2++;
		B	bab							; }

bs		CMP R11, #0						; if (counter2 == 0) {
		BEQ bfirst						; }
		CMP R11, #1						; if (counter2 == 1) {
		BEQ bsecond						; }
		CMP R11, #2						; if (counter2 == 2) {
		BEQ bthird						; }
		CMP R11, #3						; if (counter2 == 3) {
		BEQ	nob							; }
bfirst	LDR R4, =0x40000104				; BOARD[4][column]
		B	as							; }
bsecond	LDR R4, =0x40000120				; BOARD[5][column]
		B	as							; }
bthird  LDR R4, =0x4000013C				; BOARD[6][column]
as		ADD R4, R4, R10					; MEM[BOARD] += offSet2;
		MOV R5, #0						; counter = 0;
		MOV R12, #0						; offSet = 0;
		B	bf							; }
		
nob		POP {R4 - R12, pc}				; POP
;
;	End Messages
;
noSpace	LDR R0, =BoardFull				; [BoardFull]
		BL  puts						;
		B	stop						; stop
		
quit	LDR R0, =Quit					; [quit]
		BL	puts						;
		B 	stop						; stop
		
redWin	LDR R0, =RedWins				; [RedWins]
		BL 	puts						;
		B	stop						; stop
		
yelWin	LDR R0, =YellowWins				; [YellowWins]
		BL  puts						;
		B	stop						; stop
		
;
; inithw subroutines
; performs hardware initialisation, including console
;
inithw
		LDR		R0, =PINSEL0			; enable UART0 TxD and RxD signals
		MOV		R1, #0x50
		STRB	R1, [R0]
		LDR		R0, =U0LCR				; 7 data bits + parity
		LDR		R1, =0x02
		STRB	R1, [R0]
		BX		LR

;
; get subroutine
; returns the ASCII code of the next character read on the console
;
get		LDR		R1, =U0LSR				; R1 -> U0LSR (Line Status Register)
get0	LDR		R0, [R1]				; wait until
		ANDS	R0, #0x01				; receiver data
		BEQ		get0					; ready
		LDR		R1, =U0RBR				; R1 -> U0RBR (Receiver Buffer Register)
		LDRB	R0, [R1]				; get received data
		BX		LR						; return

;
; put subroutine
; writes a character to the console
;
put		LDR		R1, =U0LSR				; R1 -> U0LSR (Line Status Register)
		LDRB	R1, [R1]				; wait until transmit
		ANDS	R1, R1, #0x20			; holding register
		BEQ		put						; empty
		LDR		R1, =U0THR				; R1 -> U0THR
		STRB	R0, [R1]				; output charcter
put0	LDR		R1, =U0LSR				; R1 -> U0LSR
		LDRB	R1, [R1]				; wait until
		ANDS	R1, R1, #0x40			; transmitter
		BEQ		put0					; empty (data flushed)
		BX		LR						; return

;
; puts subroutine
; writes the sequence of characters in a NULL-terminated string to the console
;
puts	STMFD	SP!, {R4, LR} 			; push R4 and LR
		MOV		R4, R0					; copy R0
puts0	LDRB	R0, [R4], #1			; get character + increment R4
		CMP		R0, #0					; 0?
		BEQ		puts1					; return
		BL		put						; put character
		B		puts0					; next character
puts1	LDMFD	SP!, {R4, PC} 			; pop R4 and PC


;
; hint! put the strings used by your program here ...
;

str_go
	DCB	"Let's play Connect4!!",0xA, 0xD, 0xA, 0xD, 0x0

NewLine
	DCB	0xA, 0xD, 0x0
	
RedsTurn
	DCB "RED: choose a column for your next move (1-7, q to restart): ", 0

YellowsTurn
	DCB "YELLOW: choose a column for your next move (1-7, q to restart): ", 0

InvalidInput
	DCB "Invalid Input! Please try again.", 0
	
Quit
	DCB "\nThank you for playing Connect Four!", 0

Rows
	DCB "  1 2 3 4 5 6 7", 0
	
Red
	DCB "R ", 0
	
Yellow
	DCB "Y ", 0
	
Blank
	DCB "0 ", 0
	
column1
	DCB "1 ", 0
	
column2
	DCB "2 ", 0

column3
	DCB "3 ", 0
	
column4
	DCB "4 ", 0
	
column5
	DCB "5 ", 0

column6
	DCB "6 ", 0
	
RedWins
	DCB "RED PLAYER HAS WON!", 0
	
YellowWins
	DCB "YELLOW PLAYER HAS WON!", 0
	
BoardFull
	DCB "THE GAME ENDED IN A DRAW!", 0

	END
