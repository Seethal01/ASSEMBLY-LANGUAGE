data segment
msg1 db 10,13,"Enter first no:$"
msg2 db 10,13,"Enter second no:$"
msg3 db 10,13,"Difference is:$"
msg4 db 10,13,"Difference is negative:$"
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax

    lea dx,msg1
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h
    mov bh,al
    mov ah,01h
    int 21h
    mov bl,al

    lea dx,msg2
    mov ah,09h
    int 21h
    mov ah,01h
    int 21h
    mov ch,al
    mov ah,01h
    int 21h
    mov cl,al

    cmp cx,bx
    jz zero       ;if zero
    jnc negative    ;if negative
    clc
    
    mov al,bl
    mov ah,00h
    sub al,cl
    aas
    mov cl,ah
    add al,30h
    mov bl,al

    mov ah,00
    sub bh,ch
    mov al,ah
    aas
    add al,cl
    add al,30h
    mov bh,al
    jmp dispo

    zero:lea dx,msg3
    mov ah,09h
    int 21h
    mov ax,bx
    sub ax,cx
    mov bh,ah
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h
    add bh,30h
    mov dl,bh
    mov ah,02h
    int 21h

    negative:mov al,cl
    mov ah,00h
    sub al,bl
    aas
    mov bl,ah
    add al,30h
    mov cl,al
    mov ah,00h
    sub ch,bh
    mov al,ch
    aas
    add al,bl
    add al,30h
    mov ch,al

    lea dx,msg4
    mov ah,09h
    int 21h

    mov dl,ch
    mov ah,02h
    int 21h
    mov dl,cl
    mov ah,02h
    int 21h
    jmp full

    dispo:lea dx,msg3
    mov ah,09h
    int 21h
    mov dl,bh
    mov ah,02h
    int 21h
    mov dl,bl
    mov ah,02h
    int 21h

    full:mov ah,4ch
    int 21h

code ends
end start


