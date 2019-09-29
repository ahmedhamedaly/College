;
; CS1021 2018/2019	Lab 2
; 


	AREA	RESET, CODE, READONLY
	ENTRY

;
; add your code for Q1 here PART (A) (0x000003DB or 987)
;
	MOV	R2, #16  	; n = 16
	MOV R0, #0		; Fa = 0
	MOV R1, #1		; Fb = 1
ST	CMP R2, #1		; n > 1
	BLT EN			; END code
	MOV R10, R1		; temp = Fb	
	ADD R1, R0, R1	; Fb = Fa + Fb
	MOV R0, R10		; Fa = temp
	SUB R2, R2, #1	; n = n - 1
	B	ST			; repeat until n < 1
EN	
;
;  add your code for Q1 here PART (B) (0x00213D05 or 2,178,309)
;
	MOV	R2, #32  	; n = 32
	MOV R0, #0		; Fa = 0
	MOV R1, #1		; Fb = 1
ST2	CMP R2, #1		; n > 1
	BLT EN2			; END code
	MOV R10, R1		; temp = Fb
	ADD R1, R0, R1	; Fb = Fa + Fb
	MOV R0, R10		; Fa = temp
	SUB R2, R2, #1	; n = n - 1
	B	ST2			; repeat until n < 1
EN2	
;
; add your code for Q2 here part (i) UNSIGNED (n = 0x2F or 47)
;
	MOV	R1, #1			; n = 1		
	MOV R2, #0			; Fa = 0
	MOV R3, #1			; Fb = 0
	MOV R5, #0xFFFFFFFF	; R5 = MAX
ST3	ADD R1, R1, #1		; n = n + 1
	MOV R4, R3			; temp = Fb
	ADD R3, R3, R2		; Fb = Fb + Fa
	MOV R2, R4			; Fa = temp
	SUB R6, R5, R3		; R6 = Max - Fb
	CMP R6, R2			; Max - Fb > Fa
	BHI ST3				; repeat if Max - Fb < Fa
	MOV R0, R1			; Put answer in R0	
	
;
; add your code for Q2 here part (ii) SIGNED (n = 0x2E or 46)
;
	MOV	R1, #1			; n = 1		
	MOV R2, #0			; Fa = 0
	MOV R3, #1			; Fb = 0
	MOV R5, #2147483647	; R5 = MAX
ST4	ADD R1, R1, #1		; n = n + 1
	MOV R4, R3			; temp = Fb
	ADD R3, R3, R2		; Fb = Fb + Fa
	MOV R2, R4			; Fa = temp
	SUB R6, R5, R3		; R6 = Max - Fb
	CMP R6, R2			; Max - Fb > Fa
	BHI ST4				; repeat if Max - Fb < Fa
	MOV R0, R1			; Put answer in R0	
					
	
STOP	B	STOP		; infinite loop to end

        END
