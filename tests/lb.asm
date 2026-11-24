# i17_lb_simple: prueba básica de lb con extensión de signo
# Instrucciones usadas (3 distintas): addi, lb, syscall
# Caso: byte 0xFF = -1 → se corrige a 11 y se imprime 'A'
# Si lb NO hace extensión de signo, $v0 no valdrá 11 y no saldrá nada

        .data
        .byte -1                # 0xFF

        .text
        addi $a0, $zero, 65     # 'A'
        lb   $t0, 8192($zero)   # carga el byte -1
        addi $v0, $t0, 12       # -1 + 12 = 11
        syscall                 # imprime 'A' solo si $v0 == 11

        addi $v0, $zero, 10     # exit
        syscall
