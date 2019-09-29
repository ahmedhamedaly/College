;
; CS1022 Introduction to Computing II 2018/2019
; Lab 2 - Recursion
;

N	EQU	10

	AREA	globals, DATA, READWRITE

; N word-size values

SORTED	SPACE	N*4		; N words (4 bytes each)


	AREA	RESET, CODE, READONLY
	ENTRY

	;
	; copy the test data into RAM
	;

	LDR	R4, =SORTED
	LDR	R5, =UNSORT
	LDR	R6, =0
whInit	CMP	R6, #N
	BHS	eWhInit
	LDR	R7, [R5, R6, LSL #2]
	STR	R7, [R4, R6, LSL #2]
	ADD	R6, R6, #1
	B	whInit
eWhInit


	;
	; call your sort subroutine to test it
	;
	
	LDR R0, =SORTED
	LDR R1, =N
	BL sort

STOP	B	STOP


	; Subroutine swap (Takes an array with 2 positional arguments and swaps the elements at those locations)
	; Parameters:
	; 	R0 = Start address of 1D array (of words)
	; 	R1 = Position i
	; 	R2 = Position j
swap
	STMFD SP!, {R4, LR}
	LDR R3, [R0, R1, LSL #2] 
	LDR R4, [R0, R2, LSL #2]
	STR R3, [R0, R2, LSL #2]
	STR R4, [R0, R1, LSL #2]
	LDMFD SP!, {R4, PC}

	; Subroutine sort (Takes an array and its length, sorting it from lowest to highest)
	; Parameters:
	;	R0 = Start address of 1D array (words)
	;	R1 = N = Length of array
sort
	STMFD SP!, {R4-R5, LR}
sort1
	LDR R2, =0 ; R2 = Boolean swapped
	LDR R3, =0 ; R3 = Index
sort2
	ADD R3, R3, #1
	CMP R3, R1
	BHS sort0
	SUB R3, R3, #1
	LDR R4, [R0, R3, LSL #2]
	ADD R3, R3, #1
	LDR R5, [R0, R3, LSL #2]
	CMP R4, R5
	BLS sort2
	STMFD SP!, {R1-R3}
	MOV R1, R3
	SUB R2, R3, #1
	BL swap
	LDMFD SP!, {R1-R3}
	LDR R2, =1
	B sort2
sort0
	CMP R2, #1
	BEQ sort1
	LDMFD SP!, {R4-R5, PC}


UNSORT	DCD	9,3,0,1,6,2,4,7,8,5

	END
