# test_srl.asm
# Instrucciones que cubre: srl (usa ademas li -> addiu, y syscall 11 y 10)
# Casos de la tabla 3 que cubre:
#   srl con shamt = 0
#   srl con shamt != 0 (shamt = 26)
#   srl sobre un valor negativo (deben entrar ceros por la izquierda)
# Salida esperada en el TTY: una sola letra  ?
#   (0xFFFFFFFF >> 0 = 0xFFFFFFFF ; 0xFFFFFFFF >> 26 = 0x3F = 63 = '?')
# Total: 7 instrucciones reales.

.text
        li   $v0, 11          # 1) servicio 11: imprimir caracter
        li   $t0, -1          # 2) $t0 = 0xFFFFFFFF (negativo)
        srl  $t1, $t0, 0      # 3) shamt = 0  -> $t1 debe seguir siendo 0xFFFFFFFF
        srl  $a0, $t1, 26     # 4) shamt = 26 -> $a0 = 0x3F = 63 = '?'
        syscall               # 5) imprime '?'
        li   $v0, 10          # 6) servicio 10: terminar
        syscall               # 7) HALT = 1
