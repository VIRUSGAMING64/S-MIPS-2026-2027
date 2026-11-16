# ¿El lw $zero modifica la memoria?
# Debe imprimir: A
        .data
val:    .word 0x12345678

        .text
main:
        la   $t0, val
        lw   $zero, 0($t0)
        lw   $t1, 0($t0)
        andi $a0, $t1, 0xFF
        addi $a0, $a0, -55 
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall
