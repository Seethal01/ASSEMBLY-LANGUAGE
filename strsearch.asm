data segment
msg1 db "enter the string:$"
msg2 db 10,13,"Enter the character to search :$"
msg3 db 10,13,"character found $"
msg4 db 10,13,"character not found $"
str1 db 80 dup(?)

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
    mov ah,01h
    int 21h
    mov dl,al

    lea si,str1 
    mov al,dl
    repeat1:cmp al,[si]
    je skip1
    inc si
    jmp repeat1
    lea dx,msg4
    mov ah,09h
    int 21h
    jmp exitfrom

    skip1:lea dx,msg3
    mov ah,09h
    int 21h

    exitfrom:mov ah,4ch
    int 21h
code ends
end start


