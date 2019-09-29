;
; CS1021 2018/2019	Lab 6
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

LDR		R13, =0x40010000		; initialse SP
	LDR		R0, =PINSEL0			; enable UART0 TxD and RxD signals
	MOV		R1, #0x50
	STRB	R1, [R0]
	LDR		R0, =U0LCR				; 7 data bits + parity
	LDR		R1, =0x02
	STRB	R1, [R0]

;
; Sieve of Eratosthenes
;
	LDR 	R0, =0x40000000			; Load MEM(Sieve)
	MOV 	R12, R0					; Move begining to MEM(R12)
	LDR 	R1, =1000000			; Load number of integer
	MOV 	R11, R1					; Move duplicate of the number of integers
	
	MOV 	R0, R11					; Move MEM(Sieve) to R11
	MOV 	R1, #0x10				; Move 16 to Divisor
	BL 		DV						; Branch-Link DV (DiVide)
	
	ADD 	R0, R0, #1				; Add 1 to the quotient
	MOV 	R2, R12					; Move begining of MEM into R2
	ADD 	R2, R0, R2				; Add MEM needed -> MEM address
	MOV 	R0, R12					; Move the begining of MEM address
	
	MOV 	R3, #0xFF				; Move 0xFF to R3
SB1	CMP 	R2, R0					; Compare MEM to MEM needed
	BEQ 	IN						; Branch (if equal) to IN (INitialisation)
	STRB 	R3, [R0], #1			; Store byte 0xFF into MEM needed and incremement by 1
	B 		SB1						; Branch to SB1 (Set Bits to 1)
	 
IN	MOV 	R0, R12					; Move to beginging of MEM address
	MOV 	R2, #3					; Move 3 to p
	
OD	CMP 	R2, R11					; Compare p to N
	BGT 	PR						; Branch (if greater) to PR (PRint end)
	MOV 	R8, R2					; Move p into R8
	B 		NB						; Branch NB (Next Byte)
	
CP	CMP 	R2, #0x01				; Compare p to 0x01
	BNE 	MP						; Branch (if not equal) to MP (Move P)
	ADD 	R5, R5, #1				; Add 1 to prime counter
	MOV 	R2, R8					; Move p to into R2 (from duplicate)
	MOV 	R10, #0x02				; Move 2 into R10 to multiply
	MUL 	R10, R2, R10			; Multiply p by 2 and stoer in k
KTN	CMP 	R10, R11				; Compare k to N
	BGT 	MP						; Branch (if greater) to MP (Move P)
	
	MOV 	R7, R10					; Move k to R7 to store
	AND 	R10, R10, #1			; And k to check if odd
	CMP 	R10, #1					; Compare k to 1
	BNE		FR2						; Branch (if not equal) to FR2 (FOr loop 2)
	
	MOV 	R10, R7					; Move dup of k to R10
	MOV 	R3, R10					; Move k to R3
	B 		CHK						; Branch to CHK (CHeck k)
	 
FR2	MOV 	R10, R7					; Move dup of k to R10
	MOV 	R2, R8					; Move p to R2
	ADD 	R10, R10, R2			; Add k to p 
	B		KTN						; Branch to KTN (compare K to N)
	
MP	MOV 	R2, R8					; Move p to R2
	ADD 	R2, R2, #2				; Add 2 to p
	B		OD						; Branch to OD (ODd vs even)
	
NB	LDRB 	R2, [R12, R8, LSR #4]	; Load byte where p is stored
	AND 	R4, R8, #0x0F			; And R4, the remainder of p by 16
	CMP 	R4, #0x08				; Compare until remainder is lower than 8
	BLO 	RE1						; Branch (if lower) to RE1 (REmainder is 1?)
	
	CMP 	R4, #0x09				; Compare remainder to 9
	BNE		RE2						; Branch (if not equal) to RE2 (REmainder is 11?)
	 
	MOV 	R4, R4, LSL #1			; Move R4 so MSB is in 4th bit
	AND 	R2, R2, #0x10			; And R2 so it clears all bits but 4th bit
	MOV 	R2, R2, LSR #4			; Move 4th but into 0 bit
	B		CP						; Branch to CP (Check Prime)
	
RE2	CMP 	R4, #0x0B				; Compare remainder to 11
	BNE 	RE3						; Branch (if not equal) to RE3 (REmainder is 13?)
	
	MOV 	R4, R4, LSL #2			; Move remainder so MSB is 5th bit
	AND 	R2, R2, #0x20			; And all bits except 5th bit
	MOV 	R2, R2, LSR #5			; Move remainder so 5th bit is the LSB
	B		CP						; Branch to CP (Check Prime)
	
RE3	CMP 	R4, #0x0D				; Compare remainder to 13
	BNE 	BC7						; Branch (if not equal) to BC7 (Bit Clear except 7th)
	 
	MOV 	R4, R4, LSL #3			; Move remainder so 6th bit is the MSB
	AND 	R2, R2, #0x40			; And all bits except 6th bit
	MOV 	R2, R2, LSR #6			; Move remainder so 6th bit is the LSB
	B		CP						; Branch to CP (Check Prime)
	
BC7	MOV 	R4, R4, LSL #4			; Move remainder so MSB is 7th bit
	AND 	R2, R2, #0x80			; And all bits except 7th bit
	MOV 	R2, R2, LSR #7			; Move remainder so 7th bit is the LSB
	B		CP						; Branch to CP (Check Prime)
	
RE1	CMP 	R4, #0x01				; Compare remainder to 1
	BNE		RE4						; Branch (if not equal) to RE4 (REmainder is not 3?)
	
	AND 	R2, R2, #0x01			; And all bits except LSB
	B		CP						; Branch to CP (Check Prime)
	
RE4	CMP 	R4, #0x03				; Compare remainder to 3
	BNE 	RE5						; Branch (if not equal) to RE5 (REmainder is not 5?)
	
	AND 	R2, R2, #0x02			; And all bits except first bit
	MOV 	R2, R2, LSR #1			; Move 1st to LSB
	B		CP						; Branch to CP (Check Prime)

RE5 CMP 	R4, #0x05				; Compare remainder to 5
	BNE 	BC3						; Branch (if not equal) to BC3 (Bit Clear except 3rd bit)
	AND 	R2, R2, #0x04			; And all bits except 2nd bit
	MOV 	R2, R2, LSR #2			; Move 2nd bit into LSB 
	B		CP						; Branch to CP (Check Prime)
	
BC3 AND 	R2, R2, #0x08			; And all bits except 3rd bit
	MOV 	R2, R2, LSR #3			; Move all bits except 3rd bit
	B		CP						; Branch to CP (Check Prime)
		 
CHK MOV		R9, #1					; Move 1 to R9
	AND 	R3, R3, #0x0F			; And remainder of k by 16
	CMP 	R3, #0x08				; Compare k by 8 if remainder is equal
	BGT 	K9						; Branch (if greater) to K9 (K is greater than 9)
	
	CMP 	R3, #0x01				; Compare k to 1
	BEQ 	K1						; Branch (if equal) to K1 (K is equal to 1)
	
	CMP 	R3, #0x03				; Compare k to 3
	BEQ 	K3						; Branch (if equal) to K3 (K is equal to 3)
	
	CMP 	R3, #0x05				; Compare k to 5
	BEQ 	K5						; Branch (if equal) to K5 (K is equal to 5)
	
	B		MK3						; Branch to MK3 (MasK 3rd bit)
	
K9	CMP 	R3, #0x09				; Compare k to 9
	BNE 	KG9						; Branch (if not equal) to KG9 (K is Greater than 9)
	
	MOV 	R3, R3, LSL #1			; Move remainder to get 4th but
	MOV 	R9, R9, LSL #4			; Move mask to 4th bit to clear
	B		K1						; Branch to K1 (K is equal to 1)
	 
KG9	CMP 	R3, #0x0B				; Compare remainder to 11
	BNE 	RE6						; Branch (if not equal) to RE6 (REmainder is 13?)
	
	MOV 	R3, R3, LSL #2			; Move remainder to get the 5th bit
	MOV 	R9, R9, LSL #5			; Move mask to 5th bit
	B		K1						; Branch to K1 (K is equal to 1)
		 
RE6 CMP 	R3, #0x0D				; Compare remainder to 13 
	BNE 	B7						; Branch (if not equal) to B7 (Bit clear 7th bit)
	
	MOV 	R3, R3, LSL #3			; Move remainder to get 6th bit
	MOV 	R9, R9, LSL #6			; Move mask to 6th bit
	B		K1						; Branch to K1 (K is equal to 1)
	 
B7  MOV 	R3, R3, LSL #4			; Move remainder to get 7th bit
	MOV 	R9, R9, LSL #7			; Move mask to get 7th bit
	B		K1						; Branch to K1 (K is equal to 1)
	
K3 MOV 	R9, R9, LSL #1				; Move mask into 1st bit
	B		K1						; Branch to K1 (K is equal to 1)
	
K5 MOV 	R9, R9, LSL #2				; Move mask into 2nd bit
	B		K1						; Branch to K1 (K is equal to 1)
	
MK3 MOV 	R9, R9, LSL #3			; Move mask into 3rd bit
	B		K1						; Branch to K1 (K is equal to 1)
	
K1 LDRB 	R6, [R0, R7, LSR #4]	; Load byte to MEM address
	BIC 	R3, R6, R9				; Bit clear R9
	STRB 	R3, [R0, R7, LSR #4]	; Store byte of the cleared bits
	B		FR2						; Branch to FR2 (FOr loop 2)

PR	LDR 	R0, =one				; Load "There are "
	BL		PUTS					; Branch-Link PUTS
	
	ADD 	R5, R5, #1				; Add the number 2 to number of prime numbers
	MOV		R1, R5					; Move counter to R1
	BL		PP						; Branch-Link PP (Print Prime)
	
	BL		PI						; Branch-Link PI (Print Integers)
	
	LDR 	R0, =two				; Load " primes in the first "
	BL 		PUTS					; Branch-Link PUTS
	
	MOV 	R1, R11					; Move N into R1
	BL 		PP						; Branch-Link PP (Print Prime)
	
	BL 		PI						; Branch-Link PI (Print Integers)
	 
	LDR 	R0, =thr				; Load " integers."
	
	BL 		PUTS					; Branch-Link PUTS
		
one DCB "There are ", 0	
two DCB " primes in the first ", 0
thr DCB " integers.", 0
	

STOP	B	STOP

;;
;; subroutines
;;

;
; DV
;
; DiVide 
;

DV 	PUSH 	{R4, R5, R6, LR}
	MOV 	R2, R0					; Move N to R2
	MOV 	R3, R1					; Move D to R1
	MOV		R0, #0					; Move Q to 0
	MOV		R1, #0					; Move R to 0
	MOV 	R4, #31					; Move 31 to n
	MOV 	R5, #1					; Move 1 to mask
	 
DV0 CMP 	R4, #0					; Compare n to 0
	BLT 	DV2						; Branch (if less than) to DV2 (DiVide 2)
	 
	MOV 	R1, R1, LSL #1			; Move Remaider by 1 to left
	AND 	R6, R5, R2, LSR R4		; And R[0] to N[i]
	ORR		R1, R1, R6				; Or remainder to R[0]
	CMP 	R1, R3					; Compare remainder to D
	BLT 	DV1						; Branch (if less than) to DV1 (DiVide 1)
	  
	SUB 	R1, R1, R3				; Subtract remainder by D
	ORR 	R0, R0, R5, LSL R4		; Or Q[i] to R4
	 
DV1 SUB 	R4, R4, #1				; Subtract n by 1
	B 		DV0						; Branch DV0 (DiVide 0)
	 
DV2 POP 	{R4, R5, R6, PC}


;
; PP
;
; Print Prime
;

PP	PUSH 	{R9, LR}
	LDR 	R0, =0x3B9ACA00			; Load max power to 10
	MOV 	R9, R1					; Move input number to R9
			 
PP0 CMP 	R0, R9					; Compare max power to 10 to number
	BLS 	PP1						; Branch (if less) to PP1 (Print Prime 1)
			 
	MOV 	R1, #0x0A				; Move 10 to R1
	BL 		DV						; Branch-Link to DV (DiVide)
			 
	B 		PP0						; Branch to PP0 (Print Prime 0)
PP1 MOV 	R1, R9					; Move R9 to input number
	POP 	{R9, PC}
			  
;
; PI
;
; Print Integers 
;

PI 	PUSH 	{R8, R9, LR}
	MOV 	R9, R0					; Move power of 10 to R0
	MOV 	R0, R1					; Move R0 to R1
	MOV 	R1, R9					; Move R1 to R9
	 
PI1 BL 		DV						; Branch-Link to DV (DiVide)

	MOV 	R8, R1					; Move remainder to R1
	ADD 	R0, R0, #0x30			; Add 30 to mask
	BL 		PUT						; Branch-Link to PUT
	 
	MOV 	R0, R9					; Move power of 10 to R0
	MOV 	R1, #0x0A				; Move 10 to D
	BL		DV						; Branch-Link to DV (DiVide)
	 
	MOV 	R1, R0					; Move new power of 10 to D
	MOV 	R9, R0					; Move new power of 10 to R9
	MOV 	R0, R8					; Move remainder to R0
	CMP 	R2, #1					; Compare new power of 10 to 1
	BEQ 	PI3						; Branch (if equal) to PI3 (Print Integers 3)
	 
    CMP 	R1, #0x0A				; Compare power of 10 to 10
	BLO 	PI2						; Branch (if lower) to PI2 (Print Integers 2)
	 
	B		PI1						; Branch PI1 (Print Integers 1)
	 
PI2 ADD 	R0, R0, #0x30			; Add 30 to mask
	BL 		PUT						; Branch-Link to PUT
	
PI3 POP 	{R8, R9, PC}

;
; GET
;
; leaf function which returns ASCII character typed in UART #1 window in R0
;

GET	LDR		R1, =U0LSR				; R1 -> U0LSR (Line Status Register)
GET0 LDR	R0, [R1]				; wait until
	ANDS	R0, #0x01				; receiver data
	BEQ		GET0					; ready
	LDR		R1, =U0RBR				; R1 -> U0RBR (Receiver Buffer Register)
	LDRB	R0, [R1]				; get received data
	BX		LR						; return

;	
; PUT
;
; leaf function which sends ASCII character in R0 to UART #1 window
;

PUT	LDR		R1, =U0LSR				; R1 -> U0LSR (Line Status Register)
	LDRB	R1, [R1]				; wait until transmit
	ANDS	R1, R1, #0x20			; holding register
	BEQ		PUT						; empty
	LDR		R1, =U0THR				; R1 -> U0THR
	STRB	R0, [R1]				; output charcter
PUT0 LDR	R1, =U0LSR				; R1 -> U0LSR
	LDRB	R1, [R1]				; wait until 
	ANDS	R1, R1, #0x40			; transmitter
	BEQ		PUT0					; empty (data flushed)
	BX		LR						; return

;	
; PUTS
;
; sends NUL terminated ASCII string (address in R0) to UART #1 window
;

PUTS PUSH	{R4, LR} 				; push R4 and LR
	MOV		R4, R0					; copy R0
PUTS0 LDRB	R0, [R4], #1			; get character + increment R4
	CMP		R0, #0					; 0?
	BEQ		PUTS1					; return
	BL		PUT						; put character
	B		PUTS0					; next character
PUTS1 POP	{R4, PC} 				; pop R4 and PC
	
	END