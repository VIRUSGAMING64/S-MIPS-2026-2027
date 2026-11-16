.text
main:
    addi $v0, $zero, 11     # Servicio syscall 11: print_character
    addi $t0, $zero, 12     # Operando base 1
    addi $t1, $zero, 5      # Operando base 2

    # 1. ADD: 12 + 5 = 17. 
    # Queremos imprimir 'A' (ASCII 65). 17 + 48 = 65.
    add  $t2, $t0, $t1      # $t2 = 17
    addi $a0, $t2, 48       # $a0 = 17 + 48 = 65 ('A')
    syscall                 # Imprime 'A' si add = 17

    # 2. SUB: 17 - 5 = 12. 
    # Queremos imprimir 'B' (ASCII 66). 12 + 54 = 66.
    sub  $t2, $t2, $t1      # $t2 = 12
    addi $a0, $t2, 54       # $a0 = 12 + 54 = 66 ('B')
    syscall                 # Imprime 'B' si sub = 12

    # 3. ADDU: 12 + 5 = 17. 
    # Queremos imprimir 'C' (ASCII 67). 17 + 50 = 67.
    addu $t2, $t2, $t1      # $t2 = 17
    addi $a0, $t2, 50       # $a0 = 17 + 50 = 67 ('C')
    syscall                 # Imprime 'C' si addu = 17

    # 4. SUB: 17 - 5 = 12. 
    # Queremos imprimir 'D' (ASCII 68). 12 + 56 = 68.
    sub  $t2, $t2, $t1      # $t2 = 12
    addi $a0, $t2, 56       # $a0 = 12 + 56 = 68 ('D')
    syscall                 # Imprime 'D' si sub = 12

    # 5. AND: 12 & 5 = 4. 
    # Queremos imprimir 'E' (ASCII 69). 4 + 65 = 69.
    and  $t2, $t2, $t1      # $t2 = 4
    addi $a0, $t2, 65       # $a0 = 4 + 65 = 69 ('E')
    syscall                 # Imprime 'E' si and = 4

    # 6. OR: 4 | 5 = 5. 
    # Queremos imprimir 'F' (ASCII 70). 5 + 65 = 70.
    or   $t2, $t2, $t1      # $t2 = 5
    addi $a0, $t2, 65       # $a0 = 5 + 65 = 70 ('F')
    syscall                 # Imprime 'F' si or = 5

    # 7. SLL: 5 << 1 = 10. 
    # Queremos imprimir 'G' (ASCII 71). 10 + 61 = 71.
    sll  $t2, $t2, 1        # $t2 = 10
    addi $a0, $t2, 61       # $a0 = 10 + 61 = 71 ('G')
    syscall                 # Imprime 'G' si sll = 10

    # 8. SRL: 10 >> 1 = 5. 
    # Queremos imprimir 'H' (ASCII 72). 5 + 67 = 72.
    srl  $t2, $t2, 1        # $t2 = 5
    addi $a0, $t2, 67       # $a0 = 5 + 67 = 72 ('H')
    syscall                 # Imprime 'H' si srl = 5

    # 9. SLT: (5 < 12) = 1. 
    # Queremos imprimir 'I' (ASCII 73). 1 + 72 = 73.
    slt  $t2, $t2, $t0      # $t2 = 1
    addi $a0, $t2, 72       # $a0 = 1 + 72 = 73 ('I')
    syscall                 # Imprime 'I' si slt = 1

    # 10. JR (Salto indirecto por registro)
    jal  final_r            
    j    fin                

final_r:
    # Verificación de que el flujo de salto funcionó y regresó correctamente
    addi $a0, $zero, 74     # ASCII 74 = 'J'
    syscall                 # Imprime 'J'
    jr   $ra                # Retorno de tipo R

fin:
    addi $a0, $zero, 10     # Salto de línea (\n) para limpieza visual
    syscall
    addi $v0, $zero, 10     # Exit code
    syscall
