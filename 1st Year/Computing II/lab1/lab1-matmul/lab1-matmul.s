;
; CS1022 Introduction to Computing II 2018/2019
; Lab 1 - Matrix Multiplication
;

N	EQU	4

	AREA	globals, DATA, READWRITE

; result matrix R

ARR_R	SPACE	N*N*4		; 4 * 4 * word-size values


	AREA	RESET, CODE, READONLY
	ENTRY

	LDR	R0, =ARR_A
	LDR	R1, =ARR_B
	LDR	R2, =ARR_R
	LDR	R3, =N

		; your program goes here
		MOV R4, #0				; i = 0
Fori	CMP	R4, R3				; i < n?
		BHS	eFori				; end for loop
		MOV R5, #0				; j = 0
Forj	CMP	R5, R3				; j < n?
		BHS	eForj				; end j loop
		MOV	R7, #0				; r = 0
		MOV R6, #0				; k = 0
Fork	CMP	R6, R3				; k < n
		BHS	eFork				; end k loop
		MUL	R8, R4, R3			; R8 = i*N	
		ADD	R8, R8, R6			; R8 = 1D index of A[i,k]
		LDR	R9, [R0,R8,LSL#2]	; R9 = A[i,k]
		MUL	R8, R6, R3			; R8 = j*N
		ADD	R8, R8, R5			; R8 = 1D index of B[j,k]
		LDR	R10, [R1,R8,LSL#2]	; R10 = B[j,k]
		MUL	R9, R10, R9			; A[i,k] * B[k,j]
		ADD	R7, R7, R9			; r += A[i,k] * B[k,j]
		ADD	R6, R6, #1			; k++
		B	Fork				; go to for(k)
eFork	MUL	R8, R4, R3			; R8 = i*N
		ADD	R8, R8, R5			; R8 = 1D index of R[i,j]
		STR	R7, [R2,R8,LSL#2]	; R[i,j] = r
		ADD	R5, R5, #1			; j++
		B	Forj				; for(j)
eForj	ADD	R4, R4, #1			; i++
		B	Fori				; for(i)
eFori							

STOP	B	STOP

; two constant value matrices, A and B

ARR_A	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

ARR_B	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

	END
