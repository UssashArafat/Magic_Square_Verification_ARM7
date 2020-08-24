;			 		Magic Square Checker
;			 	    	(This ARM assembly program checks whether an N × N matrix is a magic square. 
;			  		 A magic square is an N × N matrix in which the sum of the numbers in every row, column, or diagonal is: N(N2 + 1)/2.)
					
;	Author: Ussash Arafat
;	Date:	August, 2020
					
					GLOBAL MAGIC_SQUARE_CODE
					
					AREA MAGIC_SQUARE, CODE, READONLY
					ENTRY
					
MAGIC_SQUARE_CODE
					ADR r0, N
					LDR r11, [r0]							;r11 holds the value of N
					;calculation of diagonal 1
					ADR r0, NUMBERS							;r0 holds the 1st element of the array
					MOV r1, r11
					MOV r2, #4
					MUL r3, r1, r2
					ADD r3, r3, #4
LOOP_DIAGONAL_1				SUBS r1, r1,#1
					LDR r4, [r0], r3
					ADD r5, r5, r4							;r5 holds the sum value of diagonal
					BNE LOOP_DIAGONAL_1	
					
					;calculation of diagonal 2
					ADR r0, NUMBERS
					MOV r1, r11
					MOV r6, #0
					MUL r3, r1, r2
					SUB r3, r3, #4
					ADD r0, r0, r3
LOOP_DIAGONAL_2				SUBS r1, r1,#1
					LDR r4, [r0], r3
					ADD r6, r6, r4							;r6 holds the sum value of diagonal
					BNE LOOP_DIAGONAL_2
					CMP r6, r5							;Comparing the value
					BNE NOT_MAGIC
					MOV r6, #0

					;calculation of columns
					MOV r8, r11
COLUMN					ADR r0, NUMBERS
					ADD r0, r0, r10
					MOV r1, r11						
					MOV r2, #4
					MUL r3, r1, r2				
LOOP_COLUMN				SUBS r1, r1, #1
					LDR r4, [r0], r3
					ADD r6, r6, r4
					BNE LOOP_COLUMN							;r6 holds the sum value of column
					CMP r6, r5							;Comparing the value
					BNE NOT_MAGIC
					SUBS r8, r8, #1
					ADD r10, r10, #4
					MOV r6, #0
					BNE COLUMN

					;calculation of rows
					MOV r8, r11
					MOV r10, #0
ROW					ADR r0, NUMBERS
					ADD r0, r0, r10
					MOV r1, r11						
					MOV r2, #4
					MUL r3, r1, r2				
LOOP_ROW				SUBS r1, r1, #1
					LDR r4, [r0], r2
					ADD r6, r6, r4
					BNE LOOP_ROW							;r6 holds the sum value of row
					CMP r6, r5							;Comparing the value
					BNE NOT_MAGIC
					SUBS r8, r8, #1
					ADD r10, r10, r3
					MOV r6, #0
					BNE ROW

MAGIC					MOV r9, #1							;indicating magic square
			        	B STOP
					
NOT_MAGIC				MOV r9, #0 							;indicating non magic square

													;r9 is set => the square is a magic square
													;r9 is not set => the square is not a magic square
STOP					B STOP
					
NUMBERS					DCD 2, 16, 13, 3, 11, 5, 8, 10, 7, 9, 12, 6, 14, 4, 1, 15
N					DCD 4	
					
					END
						