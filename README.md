# Ronald OS – A Simple Bootable Operating System in Assembly

This is a minimal operating system written in x86 Assembly that prints a custom welcome message when booted.

> **Output when booted:**
>
> hello, welcome Ronald OS

---

## Step-by-Step: Create "Ronald OS"

---

### What You Need (Install First)

If you're using **Linux** or **WSL (Windows Subsystem for Linux)**, install these tools:

```bash
sudo apt update
sudo apt install nasm qemu
```

---

### Step 1: Create Your Project Folder

```bash
mkdir ronald-os
cd ronald-os
```

---

### Step 2: Write the Bootloader in Assembly

Create the assembly file:

```bash
nano bootloader.asm
```

Paste the following code:

```asm
; bootloader.asm
[org 0x7c00]         ; BIOS loads boot sector to 0x7C00

start:
    mov si, message  ; SI points to the start of the message

print_loop:
    lodsb            ; Load byte at DS:SI into AL, then increment SI
    cmp al, 0        ; End of string?
    je hang          ; If yes, jump to end
    mov ah, 0x0E     ; BIOS teletype function
    int 0x10         ; Call BIOS interrupt to print AL
    jmp print_loop   ; Repeat for next character

hang:
    jmp $            ; Infinite loop to stop execution

message db 'hello, welcome Ronald OS', 0

; Padding to fill up 512 bytes
times 510 - ($ - $$) db 0
dw 0xAA55            ; Boot signature (required)
```

Save and exit:
Press `Ctrl + O`, `Enter`, then `Ctrl + X`.

---

### Step 3: Assemble the Code

Use NASM to convert your code into a bootable binary:

```bash
nasm -f bin bootloader.asm -o bootloader.bin
```

---

### Step 4: Run It in QEMU

Launch QEMU to boot the OS:

```bash
qemu-system-x86_64 -drive format=raw,file=bootloader.bin
```

---

## Result

You will see:

```
hello, welcome Ronald OS
```

That’s it — you’ve built a basic bootable operating system!

---

## How It Works

* BIOS loads the first 512 bytes of the disk (bootloader) into memory at address `0x7C00`.
* The bootloader loops through each character in the `message` and prints it using BIOS interrupt `int 0x10`.
* Ends with a `jmp $` to halt the CPU in an infinite loop.

---

## Next Steps

Here are some enhancements you could try:

* Add color to your message using text attributes
* Handle keyboard input using BIOS `int 16h`
* Load a second-stage kernel
* Read files from disk sectors (e.g. FAT12)

---

## Author

**\[Ronald OS]**
Created in July 2025

---

## License

This project is open-source under the [MIT License](LICENSE).

---

## Feedback / Ideas?

Feel free to open an Issue or submit a Pull Request!

---

If you'd like me to prepare a zip file with the full project or a GitHub repo structure, just let me know.
