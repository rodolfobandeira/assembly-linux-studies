section .data
    msg db 'Rodolfo Bandeira', 0xA  ; our string
    len equ $ - msg                 ; length of our string

section .text
    global _start
; -----------------------------------------
; 64 bit registers:
; -----------------------------------------
; rax, rbx, rcx, rdx,
; rsi, rdi,
; rsp,
; r8, r9, r10, r11, r12, r13, r14, r15, r16
; -----------------------------------------
;
; We're going to use the system call above:
; ssize_t sys_write(unsigned int fd, const char * buf, size_t count)
;
; This is the registers used for the parameters
; -------------------------------------------------------------------------------
; System Call    |          rdi        |         rsi         |        rdx       |
; -------------------------------------------------------------------------------
; sys_write (1)  |   unsigned int fd   |   const char *buf   |   size_t count   |
; sys_exit (60)  |   int error_code    |                     |                  |
; -------------------------------------------------------------------------------
_start:
    mov     rax, 0x01              ; system call number (sys_write)
    mov     rdi, 0x01              ; file descriptor
    mov     rsi, msg               ; message
    mov     rdx, len               ; message length
    syscall                        ; call kernel

    mov     rax, 0x3C              ; system call (sys_exit) 60 = 0x3C
    mov     rdi, 0x00              ; 0 means no error
    syscall                        ; call kernel


; To compile:
;
; nasm -f elf64 -o nasm_64_bits_hello_world.o nasm_64_bits_hello_world.asm
; ld -o nasm_64_bits_hello_world nasm_64_bits_hello_world.o
; ./nasm_64_bits_hello_world

