# test_jal_isolate.asm
# Salida esperada: A1B2C3OK

        .text
main:
        # ----- Caso 1: dos jal seguidos sin nada en medio -----
        addi $a0, $zero, 65         # 'A'
        jal  imprimir
        addi $a0, $zero, 49         # '1'
        jal  imprimir

        # ----- Caso 2: jal + addi a registro + jal -----
        addi $a0, $zero, 66         # 'B'
        jal  imprimir
        addi $s0, $zero, 2          # escribimos $s0
        addi $a0, $s0, 48           # '2' (usa el $s0 que acabamos de escribir)
        jal  imprimir

        # ----- Caso 3: jal + bne (el patrón del bucle) -----
        addi $a0, $zero, 67         # 'C'
        jal  imprimir
        addi $t0, $zero, 1
        bne  $t0, $zero, sigue      # branch tomado
        addi $a0, $zero, 88         # 'X' (no debe ejecutarse)
        jal  imprimir
sigue:
        addi $a0, $zero, 51         # '3'
        jal  imprimir

        # Final
        addi $a0, $zero, 79         # 'O'
        jal  imprimir
        addi $a0, $zero, 75         # 'K'
        jal  imprimir

        addi $v0, $zero, 10
        syscall

imprimir:
        addi $v0, $zero, 11
        syscall
        jr   $ra
