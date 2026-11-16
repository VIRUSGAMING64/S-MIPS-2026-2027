# Test: ¿lw escribe en el registro correcto?
# Debe imprimir: A
        .data
val:    .word 0x00000041        # 65 = 'A'

        .text
main:
        la   $t0, val
        lw   $a0, 0($t0)         # debe cargar 65 en $a0
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall
