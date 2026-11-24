# test_sll.asm
# Instrucciones que cubre: sll (usa ademas li -> addiu, y syscall 11 y 10)
# Casos de la tabla 3 que cubre:
#   sll con shamt = 0
#   sll con shamt != 0 (shamt = 5)
# Salida esperada en el TTY: una sola letra  @
#   (2 << 0 = 2 ; 2 << 5 = 64 = 0x40 = '@')
# Total: 7 instrucciones reales.

.text
        li   $v0, 11          # 1) servicio 11: imprimir caracter
        li   $t0, 2           # 2) $t0 = 2
        sll  $t1, $t0, 0      # 3) shamt = 0  -> $t1 debe seguir siendo 2
        sll  $a0, $t1, 5      # 4) shamt = 5  -> $a0 = 64 = '@'
        syscall               # 5) imprime '@'
        li   $v0, 10          # 6) servicio 10: terminar
        syscall               # 7) HALT = 1
