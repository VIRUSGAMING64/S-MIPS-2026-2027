# Test directo de $zero
# Debe imprimir: 0
        .text
main:
        addi $zero, $zero, 5     # intentar escribir 5 en $zero
        add  $a0, $zero, $zero   # a0 = $zero (debe seguir siendo 0)
        addi $a0, $a0, 48        # '0'
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall
