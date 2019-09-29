;
; CS1022 Introduction to Computing II 2018/2019
; Lab 3 - Floating-Point Addition
;

	AREA	RESET, CODE, READONLY
	ENTRY

;
; Test Data
;
FP_A	EQU	0x41C40000
FP_B	EQU	0x41960000
FP_C    EQU 0xF1200000

	; initialize system stack pointer (SP)

	LDR	SP, =0x40010000

	LDR	r0, =FP_B		; test value A
	LDR	r1, =FP_A		; test value B
	BL	fpadd

stop	B	stop


;
; fpdecode
; decodes an IEEE 754 floating point value to the signed (2's complement)
; fraction and a signed 2's complement (unbiased) exponent
; parameters:
;	r0 - ieee 754 float
; return:
;	r0 - fraction (signed 2's complement word)
;	r1 - exponent (signed 2's complement word)
;
fpdecode

		PUSH{R4-R9}
		MOV R4,R0,LSR#23	;Clears fraction
		MOV R4,R4,LSL#23	;clears fraction
		BIC R5,R0,R4		;Bit clear the exponent
		MOV R4,R0,LSL#9		;Clear exponent
		MOV R4,R4,LSR#9		;Clear exponent
		BIC R4,R0,R4		;exponent
		MOV R7,#0x80000000	;last bit
		AND R8,R7,R4		;check last bit
		CMP R8,#0x80000000	;If negative
		BEQ TWO_COMPLEMENT
		
NORMALIZE	
		MOV R4,R4,LSR#23	;normalise exponent
		SUB R4,R4,#127		;take bias away
		MOV R0,R5			;return fraction 
		MOV R6,#1			;one bit
		MOV R6,R6,LSL#24	;
		ORR R0,R0,R6		;add extra bit
		MOV R1,R4			;return exponent
		POP{R4-R9}
		BX LR
		
TWO_COMPLEMENT
		MOV R9,#0xFFFFFFFF			
		EOR R5,R5,R9		;Change all bits
		ADD R5,R5,#1		;2's complement
		B NORMALIZE
;
; fpencode
; encodes an IEEE 754 value using a specified fraction and exponent
; parameters:
;	r0 - fraction (signed 2's complement word)
;	r1 - exponent (signed 2's complement word)
; result:
;	r0 - ieee 754 float
;
	
fpencode

		PUSH{R4,R5}
		ADD R1,R1,#127		;add bias
		MOV R1,R1,LSL#23	;return to position
		MOV R5,#1			
		MOV R5,R5,LSL#25	;check if >
		CMP R0,R5
		BLE	TWO_COMPLEMENT1
NEXT1	
		MOV R4,#1			;one bit
		MOV R4,R4,LSL#24	;Move to 24th bit
		BIC R0,R0,R4		;Clear 24th bit
		ORR R0,R0,R1		;Combine bits
		POP{R4,R5}
		BX LR
		
TWO_COMPLEMENT1
		MOV R5,#0xFFFFFFFF
		EOR R0,R0,R5		;change bits
		ADD R0,R0,#1		;2's complement
		B NEXT1


;
; fpadd
; adds two IEEE 754 values
; parameters:
;	r0 - ieee 754 float A
;	r1 - ieee 754 float B
; return:
;	r0 - ieee 754 float A+B
;
fpadd

		PUSH {R4-R11,LR}
		MOV R2,R0		;change postion of values
		MOV R3,R1		;change postion of values
		BL fpdecode
		
		MOV R4,R0		;temp fraction
		MOV R5,R1		;temp exponent
		MOV R0,R3		;value to change
		BL fpdecode
		
		MOV R6,R0		;temp fraction
		MOV R7,R1		;temp exponent
		CMP R7,R5		;if (exponent1 > exponent2>)
		BGE exp1BIG
		
		SUB R8,R5,R7	;else sub greater exponent1
		MOV R6,R6,LSR R8 ;bring fraction to larger exponent	
		MOV R10,R5		;temp exponent
return	
		ADD R9,R6,R4	;add fractions
		MOV R0,R9		;fraction		
		MOV R1,R10		;exponent
		BL fpencode
		POP {R4-R11,PC}
exp1BIG
		SUB R8,R7,R5 	;sub greater exponent
		MOV R4,R4,LSR R8 ;bring fraction to larger exponent	
		MOV R10,R7		;temp exponent
		B return
	
	END
