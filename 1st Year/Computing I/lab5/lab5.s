;
; CS1021 2018/2019	Lab 5
;
; RAM @ 0x4000000 sz = 0x10000 (64K)
;

;
; hardware registers
;

PINSEL0	EQU	0xE002C000
	
U0RBR	EQU	0xE000C000
U0THR	EQU	0xE000C000
U0LCR	EQU	0xE000C00C
U0LSR	EQU	0xE000C014
	
	
	AREA	RESET, CODE, READONLY
	ENTRY	
	
;	
; hardware initialisation
;
	LDR	R13, =0x40010000; initialse SP
	LDR	R0, =PINSEL0	; enable UART0 TxD and RxD signals
	MOV	R1, #0x50		;
	STRB R1, [R0]		;
	LDR	R0, =U0LCR		; R0 - > U0LCR (line control register)
	LDR	R1, =0x02		; 7 data bits + parity
	STRB R1, [R0]		;

;
; MY CODE
;
	LDR	R0, =STR0		; R0 -> "Input String"
	BL	PUTS			; Print "Input String
	
	LDR R5, =0x40000000	; s0 = 0x40000000
	LDR R6, =0x40000200	; Duplicate of s0
	LDR R7, =0x40000400	; s1 = 0x40000400


Gs0	BL	GET				; Get s0		
	CMP R0, #0x0D		; Compare to enter key
	BEQ NEL				; If (enter key) branch to NEL (NExt Line)	
	STRB R0, [R5]		; Store s0 into memory	
	STRB R0, [R6]		; Store dupOfs0 into memory
	ADD R5, R5, #1		; Go to next memory slot (s0)
	ADD R6, R6, #1		; Go to next memory slot (dupOfs0)				
	BL	PUT				; Print character
	B	Gs0				; Branch Gs0 (Get s0) 


NEL	MOV R0, #0x0A		; If its an enter, go next line
	BL 	PUT				; Print next line
Gs1	BL	GET				; Get s1
	CMP R0, #0x0D		; Compare to enter key
	BEQ	CAL				; If (enter key) branch CAL (CALculate if "Y" or "N")
	STRB R0, [R7]		; Stores s1 into memory		
	ADD R7, R7, #1		; Go to next memory slot (s1)	
	ADD R10, R10, #1	; Counter1++																											
	BL	PUT				; Print character							
	B 	Gs1				; Branch Gs1 (Get s1)
	

CAL	LDR R5, =0x40000000	; Load MEM(s0)
	LDR R7, =0x40000400	; Load MEM(s1)
	
CIA	LDRB R8, [R5]		; Load s0 to R8
	LDRB R9, [R7]		; Load s1 to R9

	CMP R8, R9			; Compare s0 to s1
	BNE	Ns0				; Branch (if not equal) to Ns0 (Next s0)
	ADD R11, R11, #1	; Counter2++
	MOV R8, #0x30		; Move 0 to R8
	STRB R8, [R5]		; Store 0 to s0
	ADD R5, R5, #1		; Next character in s0
	CMP R10, R11		; Compare counter1 to counter2
	BEQ	Y				; Branch (if equal) to Y
	B	Ns1				; Branch Ns1 (Next s1)
	
Ns0	CMP R9, #0			; Compare s1 to 0
	BEQ	N				; Branch (if equal) to N
	CMP R8, #0			; Compare s0 to 0
	BEQ	Ns1				; Branch (if equal) to Ns1 (Next s1)
	ADD R5, R5, #1		; Next character in s0
	B	CIA				; Branch CIA (Check If Anagram)
	
Ns1	ADD R7, R7, #1		; Next character in s1
	LDR R5, =0x40000000	; Load MEM(s0) to R5
	B	CIA				; Branch CIA (Check If Anagram)
	
Y	LDR R0, =YES		; Load String
	BL	PUTS			; Print "Y"
	B	REC				; Branch REC (REset Counters)
	
N	LDR R0, =NO			; Load String
	BL	PUTS			; Print "N"
	B	REC				; Branch REC (REset Counters)
	

REC	MOV R10, #0			; Reset counter1
	MOV R11, #0			; Reset counter2
	
	LDR R7, =0x40000400	; Load MEM(s1) to R7
Rs1	LDRB R12, [R7]		; Load s1 to R12
	CMP R12, #0			; Compare s1 to 0
	BEQ LMR				; Branch (if equal) to LMR (Load Memory Registers)
	MOV R12, #0x00		; Move 0 into R12
	STRB R12, [R7]		; Store 0 into s1
	ADD R7, R7, #1		; Next character in s1
	B	Rs1				; Branch Rs1 (Reset s1)


LMR	LDR R5, =0x40000000	; Load MEM(s0) to R5
	LDR R6, =0x40000200	; Load MEM(dupOfs0) to R6
	LDR R7, =0x40000400	; Load MEM(s1) to R7
	
Rs0	LDRB R8, [R5]		; Load s0 to R8
	LDRB R9, [R6]		; Load dupOfs0 to R9
	CMP R8, #0			; Compare s0 to 0
	BEQ	Gs1				; Branch (if equal) to Gs1
	CMP R8, R9			; Compare s0 to dupOfs0
	BEQ	NEC				; Branch (if equal) to NEC (NExt Character)
	STRB R9, [R5]		; Replace s0 with the duplicate of s0
NEC	ADD R5, R5, #1		; Next character in s0
	ADD R6, R6, #1		; Next character in dupOfs0
	B	Rs0				; Branch Rs0 (Reset s0 to dupOfs0)	
	
	
	
STR0	DCB	"Input String\n", 0
YES		DCB	"\nY\n", 0
NO		DCB	"\nN\n", 0
	
;
; Subroutines
;	

; GET
;
; Leaf function which returns ASCII character typed in UART #1 window in R0
;
GET	LDR	R1, =U0LSR			; R1 -> U0LSR (Line Status Register)
GET0	LDR	R0, [R1]		; wait until
	ANDS R0, #0x01			; receiver data
	BEQ	GET0				; ready
	LDR	R1, =U0RBR			; R1 -> U0RBR (Receiver Buffer Register)
	LDRB R0, [R1]			; get received data
	BX	LR					; return

;	
; PUT
;
; Leaf function which sends ASCII character in R0 to UART #1 window
;
PUT		LDR	R1, =U0LSR		; R1 -> U0LSR (Line Status Register)
	LDRB R1, [R1]			; wait until transmit
	ANDS R1, R1, #0x20		; holding register
	BEQ	PUT					; empty
	LDR	R1, =U0THR			; R1 -> U0THR
	STRB R0, [R1]			; output charcter
PUT0	LDR	R1, =U0LSR		; R1 -> U0LSR
	LDRB R1, [R1]			; wait until 
	ANDS R1, R1, #0x40		; transmitter
	BEQ	PUT0				; empty (data flushed)
	BX	LR					; return

;	
; PUTS
;
; Sends NUL terminated ASCII string (address in R0) to UART #1 window
;
PUTS	PUSH {R4, LR} 		; push R4 and LR
	MOV	R4, R0				; copy R0
PUTS0	LDRB R0, [R4], #1	; get character + increment R4
	CMP	R0, #0				; 0?
	BEQ	PUTS1				; return
	BL	PUT					; put character
	B	PUTS0				; next character
PUTS1	POP	{R4, PC} 		; pop R4 and PC
	
	END