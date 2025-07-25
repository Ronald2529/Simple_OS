; bootloader.asm
[org 0x7c00]         ; BIOS loads boot sector here

start:
    mov si, message  ; SI points to message start

print_loop:
    lodsb            ; Load byte at DS:SI into AL, increment SI
    cmp al, 0        ; Check for null terminator
    je hang          ; Jump to hang if end of string
    mov ah, 0x0E     ; BIOS teletype print function
    int 0x10         ; Call BIOS interrupt to print character
    jmp print_loop   ; Loop to print next character

hang:
    jmp $            ; Infinite loop, stop execution

message db 'hello, welcome Ronald OS', 0

times 510 - ($ - $$) db 0 ; Pad bootloader to 512 bytes
dw 0xAA55                 ; Boot signature (must be at the end)
