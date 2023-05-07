DATA		SEGMENT  PARA  'DATA'				

char1  	 	DB  100 dup(20H)
bufsize		DB	100
messageLEN	db	?
message1 	db 'Please input char : ','$'
message2	db 'Data that copied  : ','$'
cr_lf    	db 0ah,0dh,'$'
DATA		ENDS

STSEG       SEGMENT PARA STACK 'STACK'
			DB	256	DUP('#')
STSEG 		ENDS

EDATA		SEGMENT PARA 'DATA'
			DB 	200H DUP('s')
EDATA		ENDS

CODE		SEGMENT PARA	'CODE'
            ASSUME CS:CODE,DS:DATA,SS:STSEG,ES:EDATA

MAIN		PROC	FAR
			;push ds
			;xor ax,ax
			;push ax
			MOV	AX,DATA
			MOV	DS,AX
			MOV	AX,EDATA
			MOV	ES,AX

			clc

			cld


		
			call disp_letter				
			

            call copy_data		

			
			
			LEA DX,message2
			MOV AH,9
			INT 21h
			
			
			;xor cx, cx
			;mov cl, messageLEN
			
			LEA dx, char1
			mov bx, dx	
		    mov cx,12
			add bx, cx
			mov byte PTR [bx], '$'
			lea dx, char1 + 2
			MOV AH,9
			INT 21h

			MOV	AH, 4CH
			INT	21H
MAIN		ENDP



disp_letter	proc near
    		lea dx,message1	
			mov ah,9
			int 21h
			
			;lea dx, bufsize
			lea dx,char1		 
			mov ah,0ah
			int 21h	
			
			;mov cl, messageLEN
			;

			lea dx, cr_lf 	
			mov ah,9
			int 21h
					
			;lea bx,char1
			;inc bx		
            ;mov cl,[bx]
            ;mov ch,0  
            ;inc bx 
			;BUFFER BUG
            
 			ret
disp_letter	endp



copy_data	proc near
			
			mov bx,0
			mov cx,12
 
copy:		mov dl,ds:[bx]
			mov es:[bx],dl
			inc bx
			loop copy


			ret						
copy_data	endp
CODE		ENDS
			END	MAIN		


