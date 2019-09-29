;
; CS1022 Introduction to Computing II 2018/2019
; Lab 1 - Addressing Modes
;

N	EQU	10

	AREA	globals, DATA, READWRITE

; N word-size values

ARRAY	SPACE	N*4		; N words (4 bytes each)


	AREA	RESET, CODE, READONLY
	ENTRY

	; for convenience, let's initialise test array [0, 1, 2, ... , N-1]

	LDR	R0, =ARRAY
	LDR	R1, =0
L1	CMP	R1, #N
	BHS	L2
	STR	R1, [R0, R1, LSL #2]
	ADD	R1, R1, #1
	B	L1
L2

	; initialise registers for your program

	LDR	R0, =ARRAY			; array start address
	LDR	R1, =N				; size of array (half-words)

;		your program goes here


;		PART (i)


;		MOV	R2,#0				; i = 0
;		MOV	R3,R0				; r3 = address of the array
;Fori	CMP	R2,R1				; i < n
;		BHS	eFori
;		LDR	R4,[R3]				; load A[i]
;		MUL	R5,R4,R4			; R5 = A[i]^2
;		STR	R5,[R3]				; A[i] = A[i]^2
;		ADD	R3,R3,#4			; R3 --> A[i+1]
;		ADD	R2,R2,#1			; i++
;		B	Fori
;eFori


;		PART (ii)


;		MOV	R2,#0				; i = 0
;		MOV	R3,#0				; r3 = offset
;Fori	CMP	R2,R1				; i < n
;		BHS	eFori
;		LDR	R4,[R0,R3]			; load A[i]
;		MUL	R5,R4,R4			; R5 = A[i]^2
;		STR	R5,[R0,R3]			; A[i] = A[i]^2
;		ADD	R3,R3,#4			; R3 --> A[i+1]
;		ADD	R2,R2,#1			; i++
;		B	Fori
;eFori


;		PART (iii)


;73 calls t=03375

;		MOV	R2,#0				; i = 0
;Fori	CMP	R2,R1				; i < n
;		BHS	eFori
;		LDR	R4,[R0,R2,LSL#2]	; load A[i]
;		MUL	R5,R4,R4			; R5 = A[i]^2
;		STR	R5,[R0,R2,LSL#2]	; A[i] = A[i]^2
;		ADD	R2,R2,#1			; i++
;		B	Fori
;eFori


;		PART (iv)


;74 calls 0.000057 sec

		MOV	R2,#0				; i = 0
		MOV	R3,R0				; r3 = address of array
Fori	CMP	R2,R1				; i < n
		BHS	eFori
		LDR	R4,[R3]				; load A[i]
		MUL	R5,R4,R4			; R5 = A[i]^2
		STR	R5,[R3],#4			; A[i] = A[i]^2 and r3-->A[i+1]
		ADD	R2,R2,#1			; i++
		B	Fori		
eFori
STOP	B	STOP

	END
