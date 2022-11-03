.MODEL SMALL
.STACK
.DATA
M1 DB 10,13, "ENTER STRING 1: $"
M2 DB 10,13, "ENTER LENGTH OF STRING 1: $"
M3 DB 10,13, "DISPLAY STRING 1: $"
M4 DB 10,13, "ENTER STRING 2: $"
M5 DB 10,13, "ENTER LENGTH OF STRING 2: $"
M6 DB 10,13, "DISPLAY STRING 2: $"
M7 DB 10,13, "COMPARE STRINGS: $"
M8 DB 10,13, "STRING NOT EQUAL $"
M9 DB 10,13, "EQUAL STRING $"
M10 DB 10,13, "CONCATINATE STRINGS: $"

STR1 DB 50,?,50 DUP(?)
STR2 DB 50,?,50 DUP(?)
L1 DB ?
L2 DB ?

.CODE
DISP MACRO XX
MOV AH,09
LEA DX,XX
INT 21H
ENDM

.STARTUP

DISP M1     ;ENTER THE FIRST STRING

MOV AH,0AH ;Take Input of Whole string together
LEA DX,STR1
INT 21H

DISP M2     ;LENGTH OF THE FIRST STRING
LEA SI, STR1+1

MOV CL,[SI]
MOV L1,CL
ADD CL,30H
MOV DL,CL
MOV AH,02
INT 21H

DISP M3     ;DISPLAT STR2
LEA SI,STR1+2
MOV CL,L1

BACK1:
MOV DL,[SI]
MOV AH,02
INT 21H
INC SI
DEC CL
JNZ BACK1

DISP M4     ;ENTER THE FIRST STRING

MOV AH,0AH
LEA DX,STR2
INT 21H

DISP M5     ;LENGTH OF THE FIRST STRING
LEA DI, STR2+1

MOV CL,[DI]
MOV L2,CL
ADD CL,30H
MOV DL,CL
MOV AH,02
INT 21H

DISP M6     ;DISPLAT STR3
LEA DI,STR2+2
MOV CL,L2

BACK2:
MOV DL,[DI]
MOV AH,02
INT 21H
INC DI
DEC CL
JNZ BACK2

DISP M7

MOV CL,L1
MOV CH,L2
CMP CL,CH
JNZ N_EQUAL

LEA SI,STR1+2
LEA DI,STR2+2

BACK3:
MOV DL,[SI]
CMP DL,[DI]
JNZ N_EQUAL
INC SI
INC DI
DEC CL
JNZ BACK3
DISP M9

JMP CONCATE

N_EQUAL:
DISP M8

DISP M10

CONCATE:
MOV CL,L1
MOV BL,CL
MOV CH,L2
ADD BL,CH

LEA SI,STR1+2
LEA DI,STR2+2

BACK4:
INC SI 
DEC CL
JNZ BACK4

BACK5:
MOV DL,[DI]
MOV [SI],DL 
INC SI 
INC DI 
DEC CH 
JNZ BACK5

LEA SI,STR1+2
BACK6:
MOV DL,[SI]
MOV AH,02
INT 21H
INC SI 
DEC BL
JNZ BACK6

.EXIT
END