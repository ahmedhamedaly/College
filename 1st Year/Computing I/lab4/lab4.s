;
; CS1021 2018/2019	Lab 4
; 

	AREA	RESET, CODE, READONLY
	ENTRY
;
;	Question 1(i)	
;
	MOV R0, #0			; Even or Odd
	LDR R1, =0x12345678	; R1 = number
	MOV R2, #0			; Counter = 0
L1	CMP R1, #0			; number != 0
	BEQ EN				; if number = 0 go to EN
	MOVS R1, R1, LSR #1	; Shift number by 1 to the right and store in number
	BCC L1				; branch the carry to L1 if ends in 0
	BCS L2				; branch the carry to L2 if ends in 1
L2	ADD R2, R2, #1		; counter + 1
	B	L1				; branch to L1
EN	AND R0, R2, #1		; check if its even or odd and put into R0

;
;	Question 1(ii)	
;
	MOV R0, #0			; Even or Odd
	LDR R1, =0xF0F0F0F0	; R1 = number
	MOV R2, #0			; Counter = 0
L3	CMP R1, #0			; number != 0
	BEQ EN2				; if number = 0 go to EN
	MOVS R1, R1, LSR #1	; Shift number by 1 to the right and store in number
	BCC L3				; branch the carry to L1 if ends in 0
	BCS L4				; branch the carry to L2 if ends in 1
L4	ADD R2, R2, #1		; counter + 1
	B	L3				; branch to L1
EN2	AND R0, R2, #1		; check if its even or odd and put into R0

;
;	Question 1(iii)	
;
	MOV R0, #0			; Even or Odd
	LDR R1, =42			; R1 = number
	MOV R2, #0			; Counter = 0
L5	CMP R1, #0			; number != 0
	BEQ EN3				; if number = 0 go to EN
	MOVS R1, R1, LSR #1	; Shift number by 1 to the right and store in number
	BCC L5				; branch the carry to L1 if ends in 0
	BCS L6				; branch the carry to L2 if ends in 1
L6	ADD R2, R2, #1		; counter + 1
	B	L5				; branch to L1
EN3	AND R0, R2, #1		; check if its even or odd and put into R0

;
;	Question 2	-	Algorithm 1 
;
	LDR R0, =27			; N = 27
	LDR R1, =7			; D = 7
	LDR R2, =27		 	; R := N
	LDR R3, =0			; Q := 0
L7	CMP R2, R1			; R >= D
	BLO EN4				; Branch low
	ADD R3, R3, #1		; Q := Q + 1
	SUB R2, R2, R1		; R := R - 1
	B	L7				; Branch L7
EN4	MOV R0, R3			; Move Q to N
	MOV R1, R2			; Move R to D
	

;
;	Question 2	-	Algorithm 2
;
	LDR R0, =27			; N = 27
	LDR R1, =7			; D = 7
	LDR R2, =0		 	; R := 0
	LDR R3, =0			; Q := 0
	LDR R4, =32			; I = 0
L8	SUB R4, R4, #1		; n = Number of bits
	MOV R2, R2, LSL #1	; R := R << 1
	MOV R5, R0, LSR R4	; R5 = N >> I
	AND R5, R5, #1		; ANDING R5 BY 1
	ADD R2, R2, R5		; R = R + R5
	CMP R2, R1			; R >= D
	BLO L8				; R < D
	SUB R2, R2, R1		; R := R - D
	MOV R3, R3, LSR R4	; Q(i) := 1
	ORR R3, R3, #1		; ORRING Q by 1
	MOV R3, R3, LSL R4	; Q = Q << I
	CMP R4, #0	 		; i < number of bits
	BEQ EN5				; i = number of bits
	B 	L8				; Branch L8
EN5	MOV R0, R3			; Move Q to N
	MOV R1, R2			; Move R to D 
	
L	B	L		; infinite loop to end

        END
