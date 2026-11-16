        .data
msg:    .asciiz "Jose el fisico es un tanque"
        .text
main:   la   $s0, msg
bucle:  lbu  $a0, 0($s0)
        beq  $a0, $zero, fin
        addi $v0, $zero, 11      # imprimir caracter
        syscall
        addi $s0, $s0, 1
        j    bucle
fin:    addi $v0, $zero, 10      # terminar
        syscall
