;
; CS1021 2018/2019	Lab 3
; 

	AREA	RESET, CODE, READONLY
	ENTRY

;
; 	Question 1 (i) (0x8 or 8)
;
	LDR R0, =24		; a = 24
	LDR R1, =32		; b = 32
L2	CMP R0, R1		; a != b
	BEQ EN1			; if a = b then END
	CMP R0, R1		; a != b
	BLE L1			; a < b then branch to L1
	SUB R0, R0, R1	; a = a - b
	B	L2			; Branch to L2
L1	SUB R1, R1, R0	; b = b - a
	B	L2			; Branch to L2
EN1

;
; 	Question 1 (ii) (0x17 or 23)
;
	LDR R0, =2415	; a = 2415
	LDR R1, =3289	; b = 3289
L4	CMP R0, R1		; a != b
	BEQ EN2			; if a = b then END
	CMP R0, R1		; a != b
	BLE L3			; a < b then branch to L3
	SUB R0, R0, R1	; a = a - b
	B	L4			; Branch to L4
L3	SUB R1, R1, R0	; b = b - a
	B	L4			; Branch to L4
EN2

;
; 	Question 1 (iii) (0x2E or 46)
;
	LDR R0, =4278	; a = 4278
	LDR R1, =8602	; b = 8602
L6	CMP R0, R1		; a != b
	BEQ EN3			; if a = b then END
	CMP R0, R1		; a != b
	BLE L5			; Branch to L5
	SUB R0, R0, R1	; a = a - b
	B	L6			; Branch to L6
L5	SUB R1, R1, R0	; b = b - a
	B	L6			; Branch to L6
EN3

;
; 	Question 1 (iv) (0x1 or 1)
;
	LDR R0, =406	; a = 406
	LDR R1, =555	; b = 555
L8	CMP R0, R1		; a != b
	BEQ EN4			; if a = b then END
	CMP R0, R1		; a != b
	BLE L7			; Branch to L7
	SUB R0, R0, R1	; a = a - b
	B	L8			; Branch to L8
L7	SUB R1, R1, R0	; b = b - a
	B	L8			; Branch to L8
EN4

;
;	Question 2 (i) (R0 = 0xB11924E1; R1 = 0x1E8D0A40)
;
	MOV R6, #48		; n = 48
	MOV R0, #0		; Fa = 0 (LS)
	MOV R1, #1		; Fb = 1 (LS)
	MOV R2, #0		; Fa = 0 (MS)
	MOV R3, #0		; Fb = 0 (MS)
ST1	CMP R6, #1		; n > 1
	BLE EN5			; if n < 1 then END
	MOV R5, R3		; temp = Fb (MS)
	MOV R4, R1		; temp = Fb (LS)
	ADDS R1, R0, R1	; Fb = Fb (LS) + Fa (LS)
	ADC R3, R2, R3	; Fb = Fa (MS) + Fb (MS)
	MOV R2, R5		; Fa (LS) = temp
	MOV R0, R4		; Fa (LS) = temp
	SUB R6, R6, #1	; n = n - 1
	B	ST1			; Branch to ST1
EN5

;
;	Question 2 (ii) (R0 = 0xC7B064E2; R1 = 0x61CA20BB)
;
	MOV R6, #64		; n = 64
	MOV R0, #0		; Fa = 0 (LS)
	MOV R1, #1		; Fb = 1 (LS)
	MOV R2, #0		; Fa = 0 (MS)
	MOV R3, #0		; Fb = 0 (MS)
ST2	CMP R6, #1		; n > 1
	BLE EN6			; if n < 1 then END
	MOV R5, R3		; temp = Fb (MS)
	MOV R4, R1		; temp = Fb (LS)
	ADDS R1, R0, R1	; Fb = Fb (LS) + Fa (LS)
	ADC R3, R2, R3	; Fb = Fa (MS) + Fb (MS)
	MOV R2, R5		; Fa (LS) = temp
	MOV R0, R4		; Fa (LS) = temp
	SUB R6, R6, #1	; n = n - 1
	B	ST2			; Branch to ST1
EN6

;
;	Question 3 SIGNED (Fn (MS) = 0x68A3DD8E; Fn (LS) = 0x61ECCFBD)
;

	MOV	R6, #0			; n = 0		
	MOV R0, #0			; Fn (MS)
	MOV R1, #0			; Fn (LS)
	MOV R2, #0			; Fn - 1 (MS)
	MOV R3, #0			; Fn - 1 (LS)
	MOV R4, #0			; Fn - 2 (MS)
	MOV R5, #1			; Fn - 2 (LS)
	MOV R7, #0xFFFFFFFF	; R7 = MAX (LS)
	MOV R8, #0x7FFFFFFF	; R8 = MAX (MS)
ST3	ADD R6, R6, #1		; n = n + 1
	ADDS R1, R3, R5		; Fn (LS) = [Fn - 1 (LS)] - [Fn - 2 (LS)]
	ADC R0, R2, R4		; Fn (MS) = [Fn - 1 (MS)] - [Fn - 2 (MS)]
	MOV R4, R2			; Fn - 2 (MS) = Fn - 1 (MS)
	MOV R5, R3			; Fn - 2 (LS) = Fn - 1 (LS)
	MOV R2, R0			; Fn - 1 (MS) = Fn (MS)
	MOV R3, R1			; Fn - 1 (LS) = Fn (LS)
	SUBS R9, R7, R3		; R9 = MAX (LS) - [Fn - 1 (LS)]
	SBC R10, R8, R2		; R10 = MAX (MS) - [Fn - 1 (MS)]
	CMP R4, R10			; Max - [Fn - 1] < Fn - 2
	BLT ST3				; 
	
;
;	Question 3 UNSIGNED (Fn (MS) = 0x68A3DD8E; Fn (LS) = 0x61ECCFBD)
;

	MOV	R6, #0			; n = 0		
	MOV R0, #0			; Fn (MS)
	MOV R1, #0			; Fn (LS)
	MOV R2, #0			; Fn - 1 (MS)
	MOV R3, #0			; Fn - 1 (LS)
	MOV R4, #0			; Fn - 2 (MS)
	MOV R5, #1			; Fn - 2 (LS)
	LDR R7, =4294967295	; R7 = MAX (LS)
	LDR R8, =2147483647	; R8 = MAX (MS)
ST4	ADD R6, R6, #1		; n = n + 1
	ADDS R1, R3, R5		; Fn (LS) = [Fn - 1 (LS)] - [Fn - 2 (LS)]
	ADC R0, R2, R4		; Fn (MS) = [Fn - 1 (MS)] - [Fn - 2 (MS)]
	MOV R4, R2			; Fn - 2 (MS) = Fn - 1 (MS)
	MOV R5, R3			; Fn - 2 (LS) = Fn - 1 (LS)
	MOV R2, R0			; Fn - 1 (MS) = Fn (MS)
	MOV R3, R1			; Fn - 1 (LS) = Fn (LS)
	SUBS R9, R7, R3		; R9 = MAX (LS) - [Fn - 1 (LS)]
	SBC R10, R8, R2		; R10 = MAX (MS) - [Fn - 1 (MS)]
	CMP R4, R10			; Max - [Fn - 1] < Fn - 2
	BLT ST4				; 

STOP	B	STOP		; infinite loop to end

        END
