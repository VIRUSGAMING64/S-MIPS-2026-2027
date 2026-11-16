# i17_lb_simple: prueba básica de lb con extensión de signo
# Instrucciones usadas (3 distintas): addi, lb, syscall
# Caso: byte 0xFF = -1 → se corrige a 11 y se imprime 'A'
# Si lb NO hace extensión de signo, $v0 no valdrá 11 y no saldrá nada

        .data
        .byte 65                # 0xFF

        .text
        lb   $a0, 8192($zero)   # carga el byte 'A'
        addi $v0,$zero, 11    
        syscall                 # imprime 'A' solo si $v0 == 11
        addi $a0, $a0, 1 #ahora a0 tiene una B
        sb $a0, 8192($zero) # guarda b en la ram
        lb $a1, 8192($zero) #la carga en a1
        addi $a1, $a1, 1 #combierte a1 en una C
        add $a0, $zero, $a1 #mete la C en a0
        addi $v0, $zero, 11
        syscall #la muestra
        addi $v0, $zero, 10
        syscall
