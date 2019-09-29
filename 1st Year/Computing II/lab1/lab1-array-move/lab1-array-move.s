;
; CS1022 Introduction to Computing II 2018/2019
; Lab 1 - Array Move
;

N	EQU	16		; number of elements

	AREA	globals, DATA, READWRITE

; N word-size values

ARRAY	SPACE	N*4		; N words


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

		LDR	R0, =ARRAY
		LDR	R1, =3				; n starting index
		LDR	R2, =9				; m destination index
		LDR	R3, =N

	; your program goes here
		LDR	R4, [R0,R1,LSL #2]	; R4 = A[n]
		CMP	R1, R2				; Which way do we move
		BLO	MoveRight			; moving from left to right
		MOV R5, R1				; r5 = n
		SUB	R5, R5, #1			; pointing to A[n-1]
Fori	CMP	R5, R2				; for(i=n-1;i>=m;i--)
		BLO	eFori
		LDR	R6, [R0,R5,LSL #2]	; load A[i]
		ADD	R5, R5, #1			;
		STR R6, [R0,R5,LSL #2]	; store at A[i+1]
		SUB	R5, R5, #2			; i--
		B	Fori
eFori	B	Finish
MoveRight
		MOV R5, R1				; r5 = n
		ADD	R5,	R5, #1			; Pointing to A[n+1]
Forj	CMP	R5, R2				; for(j=n+1;j<=m;j++)
		BHI	eForj
		LDR	R6, [R0,R5,LSL #2]	; load A[j]
		SUB	R5, R5, #1			
		STR R6, [R0,R5,LSL #2]	; store at A[j-1]
		ADD	R5, R5, #2			; j++
		B	Forj
eForj					
Finish							; End of the algorithm
		STR	R4, [R0,R2,LSL#2]	; A[m] = A[n]
STOP	B	STOP

	END
