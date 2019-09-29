;
; CS1021 2018/2019	Lab 1
; 

	AREA	RESET, CODE, READONLY
	ENTRY

;
; start of code
;
	LDR	R1, =5   	; x = 5
	LDR	R2, =6		; y = 6
	LDR R3, =2		; Z = 2
;
; part (a) compute 3x^2 + 5x (100 OR 0x64)
;
	MUL 	R0, R1, R1		; R0 = x^2
	MOV   	R4, #3			; R4 = 3
	MUL		R0, R4, R0		; R0 = 3x^2
	MOV  	R5, #5			; R5 = 5
	MUL     R6, R1, R5		; R4 = 5x
	ADD 	R0, R6, R0		; R0 = 3x^2 + 5x
	
;
; part (b) compute 2x^2 + 6xy + 3y^2 (338 OR 0x152)
;
	MUL 	R0, R1, R1		; R0 = x^2
	MOV 	R4, #2			; R4 = 2
	MUL 	R0, R4, R0		; R0 = 2x^2
	MOV 	R5, #6			; R5 = 6
	MUL 	R6, R2, R1		; R6 = xy
	MUL		R6, R5, R6		; R6 = 6xy
	MOV 	R7, #3			; R7 = 3
	MUL 	R8, R2, R2		; R8 = y^2
	MUL		R8, R7, R8		; R8 = 3y^2
	ADD		R0, R0, R6		; R0 = 2x^2 + 6xy
	ADD		R0, R0, R8		; R0 = 2x^2 + 6xy + 3y^2
	
;
; part (c) compute x^3 - 4x^2 + 3x + 8 (48 OR 0x30)
;
	MUL 	R4, R1, R1		; R4 = x^2
	MUL 	R0, R1, R4		; R0 = x^3
	MOV 	R5, #4			; R5 = 4
	MUL 	R6, R5, R4		; R6 = 4x^2
	MOV 	R7, #3			; R7 = 3
	MUL 	R8, R7, R1		; R8 = 3x
	SUB 	R9, R0, R6		; R9 = x^3 - 4x^2
	ADD 	R10, R9, R8		; R10 = x^3 - 4x^2 + 3x 
	ADD 	R0, R10, #8		; R0 = x^3 - 4x^2 + 3x + 8	
	
;
; part (d) compute 3x^4 - 5x - 16y^4z^4 (-329926 OR 0xFFFAF73A)
;
	MUL 	R4, R1, R1		; R4 = x^2
	MUL 	R0, R4, R4		; R0 = x^4
	MOV 	R5, #3			; R5 = 3
	MUL 	R0, R5, R0		; R0 = 3x^4
	MOV 	R6, #5			; R6 = 5
	MUL 	R7, R1, R6		; R7 = 5x
	MUL 	R8, R2, R2		; R8 = y^2
	MUL 	R9, R8, R8		; R9 = y^4
	MUL 	R10, R3, R3		; R10 = z^2
	MUL 	R11, R10, R10	; R11 = z^4
	MOV 	R12, #16		; R12 = 16
	SUB 	R0, R0, R7		; R0 = 3x^4 - 5x
	MUL 	R8, R9, R11		; R8 = y^4z^4
	MUL 	R10, R12, R8	; R10 = 16y^4z^4
	SUB 	R0, R0, R10		; R0 = 3x^4 - 5x - 16y^4z^4
	

L	B	L		; infinite loop to end programme

        END
