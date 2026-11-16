.text

main:
    lui $a0, 0x8000 
    lui $a1, 0xffff
    lui $a2, 0x8000
    lui $a3, 0x8000 
    lui $t0, 0x8000
    addi $v0,$zero, 10
    syscall
