.text
main:
    lui  $t0, 0xFFFF
    lui  $t1, 0xF0F0
    ori  $t1, $t1, 0xF0F0
    and  $t2, $t0, $t1      # 0xF0F00000
    srl  $t3, $t2, 28
    addi $a0, $t3, 55
    addi $v0, $zero, 11
    syscall
    addi $v0, $zero, 10
    syscall
