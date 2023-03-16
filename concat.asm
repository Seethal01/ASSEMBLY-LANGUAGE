data segment
msg1 db "Enter str1:$"
msg2 db "Enter str2:$"
msg3 db "concated string:$"
str1 db 80 dup("$")
str2 db 80 dup("$")
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
    repeat:mov ah,01h
        int 21h
        cmp al,13
        je next
        mov [si],al
        inc si
        jmp repeat

    next:mov ah,09h
        lea dx,msg2
        int 21h
        lea si,str2
    repeat1:mov ah,01h
        int 21h
        cmp al,13
        je next1
        mov [si],al
        inc si
        jmp repeat1

    next1:call concat
        mov ah,04h
        int 21h

concat proc near
        lea si,str1
        lea di,str2
        mov al,'$'
        next2:cmp al,[si]
        je nxt
        inc si
        jmp next2
        nxt:cmp al,[di]
        jz haaa
        mov bl,[di]
        mov [si],bl
        inc si
        inc di
        jmp nxt

        haaa:lea dx,msg3
        mov ah,09h
        int 21h
        lea dx,str1
        mov ah,09h
        int 21h
        ret
concat endp
code ends
end start