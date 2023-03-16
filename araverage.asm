data segment
msg db "Enter the array elements$"
msg1 db "Enter the limit$"
msg2 db "Sum is$"
arr db 20 dup(?)
count db ?
sum1 db ?
carry db 00h
data ends

code segment
assume ds:data,cs:code
start:
    mov ax,data
    mov ds,ax

    lea dx,msg1;print message
    mov ah,09h
    int 21h

    call input
    mov count,al

    mov dl,10
    mov ah,02h
    int 21h
    
    lea dx,msg;print message
    mov ah,09h
    int 21h

    mov si,offset arr
    mov bl,count;count
    
read:
    call input
    mov [si],al
    inc si
    
    ;space ASCII 32
    mov ah,02h
    mov dl,32
    int 21h
    
    dec bl
    jnz read

    mov si,offset arr
    mov bl,count
    mov al,00h;clear garbage values

sum:
    mov ah,[si]
    add al,ah
    daa
    jnc skip3
    inc carry
skip3:
    inc si
    dec bl
    jnz sum

    mov sum1,al

    lea dx,msg2;sum is message
    mov ah,09h
    int 21h

    ;print carry first
    mov al,carry
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h


    mov si,offset sum1
    call output


    mov ah,4ch
    int 21h

input proc near
    mov ah,01h
    int 21h

    sub al,30h
    cmp al,09h
    jle skip
    sub al,07h
skip:
    mov cl,04h
    rol al,cl
    mov ch,al
 
    mov ah,01h
    int 21h

    sub al,30h
    cmp al,09h
    jle skip2
    sub al,07h
skip2:
    add al,ch
    
    ret
input endp

output proc near
    mov al,[si]

    and al,0f0H;mask lsb
    mov cl,04h
    rol al,cl

    add al,30h
    cmp al,39h
    jle skip4
    add al,07h
skip4:    
    mov dl,al
    mov ah,02h;msb print
    int 21h

    mov al,[si]

    and al,0fh;mask msb
    add al,30h
    cmp al,39h
    jle skip5
    add al,07h
skip5:    
    mov dl,al
    mov ah,02h;lsb print
    int 21h
    ret
output endp



code ends
end start