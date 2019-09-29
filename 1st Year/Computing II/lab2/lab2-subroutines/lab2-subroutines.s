;
; CS1022 Introduction to Computing II 2018/2019
; Lab 2 - Subroutines
;

N	EQU	4
BUFLEN	EQU	32

PINSEL0	EQU	0xE002C000
U0RBR	EQU	0xE000C000
U0THR	EQU	0xE000C000
U0LCR	EQU	0xE000C00C
U0LSR	EQU	0xE000C014


	AREA	globals, DATA, READWRITE

; char buffer
BUFFER	SPACE	BUFLEN		; BUFLEN bytes

; result array
ARR_R	SPACE	N*4		; N words (4 bytes each)


	AREA	RESET, CODE, READONLY
	ENTRY

	BL	inithw

	;
	; invoke your max subroutine to test it
	;
	
	;LDR R0, =16
	;LDR R1, =-5
	;BL max

	;
	; invoke your gets subroutine to test it
	;
	
	;LDR R0, =BUFFER
	;BL gets

	;
	; invoke your matmul subroutine to test it
	;
	
	LDR R0, =ARR_A
	LDR R1, =ARR_B
	LDR R2, =ARR_R
	LDR R3, =N
	BL matmul


STOP	B	STOP


; Subroutine max (returns the largest of 2 passed integers)
; Parameters:
; 	R0 = (signed word) Number 1
; 	R1 = (signed word) Number 2
; Returns:
; 	R0 = (signed word) Larger Number
max
	CMP R0, R1
	BGE max1
	MOV R0, R1
max1
	BX LR

; Subroutine gets (reads and stores a string of chars (until return is pressed) in buffer and returns number of chars read) 
; Parameters:
; 	R0 = Start address of memory location
; Returns:
; 	R0 = (unsigned word) number of characters
gets
	STMFD SP!, {R4-R5, LR}
	MOV R4, R0
	LDR R5, =0
gets1	
	BL get
	BL put
	CMP R0, #0xD
	BEQ gets2
	STRB R0, [R4], #1
	ADD R5, R5, #1
	B gets1
gets2
	LDR R0, =0
	STRB R0, [R4]
	MOV R0, R5
	LDMFD SP!, {R4-R5, PC}
	
; Subroutine matmul (Takes two NxN matrices and returns their product)
; Parameters:
; 	R0 = Start address of matrix A
; 	R1 = Start address of matrix B
; 	R2 = Start address of result matrix
; 	R3 = N = Matrix size
; Returns:
; 	R0 = Start address of result matrix
matmul
	STMFD SP!, {R4-R9 ,LR}
	LDR R4, =0	;R4 = i
matmul0
	CMP R4, R3
	BHS	matmul1
	LDR R5, =0	;R5 = j
matmul2
	CMP R5, R3
	BHS matmul3
	LDR R6, =0	;R6 = r
	LDR R7, =0	;R7 = k
matmul4
	CMP R7, R3
	BHS	matmul5
	MUL R8, R7, R3	;Locate row
	ADD R8, R8, R4	;Locate index
	LDR R8, [R0, R8, LSL #2] ;R8 = A[i,k]
	MUL R9, R5, R3
	ADD R9, R9, R7
	LDR R9, [R1, R9, LSL #2] ;R9 = B[k,j]
	MUL R8, R9, R8
	ADD R6, R6, R8
	ADD R7, R7, #1
	B	matmul4
matmul5
	MUL	R8, R5, R3
	ADD R8, R8, R4
	STR R6, [R2, R8, LSL #2] ;r -> R[i,j]
	ADD R5, R5, #1
	B	matmul2
matmul3
	ADD R4, R4, #1
	B	matmul0
matmul1
	LDMFD SP!, {R4-R9, PC}

;
; inithw subroutines
; performs hardware initialisation, including console
; parameters:
;	none
; return value:
;	none
;
inithw
	LDR	R0, =PINSEL0		; enable UART0 TxD and RxD signals
	MOV	R1, #0x50
	STRB	R1, [R0]
	LDR	R0, =U0LCR		; 7 data bits + parity
	LDR	R1, =0x02
	STRB	R1, [R0]
	BX	LR

;
; get subroutine
; returns the ASCII code of the next character read on the console
; parameters:
;	none
; return value:
;	R0 - ASCII code of the character read on teh console (byte)
;
get	LDR	R1, =U0LSR		; R1 -> U0LSR (Line Status Register)
get0	LDR	R0, [R1]		; wait until
	ANDS	R0, #0x01		; receiver data
	BEQ	get0			; ready
	LDR	R1, =U0RBR		; R1 -> U0RBR (Receiver Buffer Register)
	LDRB	R0, [R1]		; get received data
	BX	LR			; return

;
; put subroutine
; writes a character to the console
; parameters:
;	R0 - ASCII code of the character to write
; return value:
;	none
;
put	LDR	R1, =U0LSR		; R1 -> U0LSR (Line Status Register)
	LDRB	R1, [R1]		; wait until transmit
	ANDS	R1, R1, #0x20		; holding register
	BEQ	put			; empty
	LDR	R1, =U0THR		; R1 -> U0THR
	STRB	R0, [R1]		; output charcter
put0	LDR	R1, =U0LSR		; R1 -> U0LSR
	LDRB	R1, [R1]		; wait until
	ANDS	R1, R1, #0x40		; transmitter
	BEQ	put0			; empty (data flushed)
	BX	LR			; return

;
; puts subroutine
; writes the sequence of characters in a NULL-terminated string to the console
; parameters:
;	R0 - address of NULL-terminated ASCII string
; return value:
;	R0 - ASCII code of the character read on teh console (byte)
;
puts	STMFD	SP!, {R4, LR} 		; push R4 and LR
	MOV	R4, R0			; copy R0
puts0	LDRB	R0, [R4], #1		; get character + increment R4
	CMP	R0, #0			; 0?
	BEQ	puts1			; return
	BL	put			; put character
	B	puts0			; next character
puts1	LDMFD	SP!, {R4, PC} 		; pop R4 and PC


;
; test arrays
;

ARR_A	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

ARR_B	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

	END
