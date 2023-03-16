data segment
msg1 db "Enter str1:$"
msg2 db 10,13,"Enter str2:$"
msg3 db 10,13,"equal$"
msg4 db 10,13,"not equal$"
str1 db 80 dup(?)
str2 db 80 dup(?)
data ends
code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax

        lea dx,msg1
        mov ah,09h
        int 21h
        lea si,str1
        mov bl,0
        repeat:mov ah,01h
        int 21h
        cmp al,13
        je skip
        mov [si],al
        inc si
        inc bl
        jmp repeat

        skip:lea dx,msg2
        mov ah,09h
        int 21h
        lea di,str2
        mov cl,0
        repeat1:mov ah,01h
        int 21h
        cmp al,13
        je skip2
        mov [di],al
        inc di
        inc cl
        jmp repeat1

        skip2:cmp bl,cl
        je skip3
        go:lea dx,msg4
        mov ah,09h
        int 21h
        jmp exit

        skip3:
        lea si,str1
        lea di,str2
        goto:mov al,[si]
        cmp al,[di]
        jne go
        inc si
        inc di
        jnz goto
        lea dx,msg3
        mov ah,09h
        int 21h



        exit:mov ah,4ch
        int 21h
 code ends
 end start