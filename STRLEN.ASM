data segment
msg1 db "Enter str:$"
msg2 db 10,13,"Length of str: $"
str db 80 dup(?)
data ends
code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax

        lea dx,msg1
        mov ah,09h
        int 21h

        mov bl,0
        lea si,str
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

       
        mov dl,bl
        mov ah,02h
        add dl,48
        int 21h

        mov ah,4ch
        int 21h
code ends
end start


