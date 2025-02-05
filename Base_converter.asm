//Decimal to hexadecimal converter
        .data
hexLookup: 
        .byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
Prompt1:
        .asciiz "Please enter an integer 0-15 > "
Prompt2:
        .asciiz "That integer represented in hexadecimal is > "

        .text

        .globl main
main:
        li $v0, 4
        la $a0, Prompt1
        syscall

        li $v0, 5
        syscall
        move $t0, $v0

        la $t1, hexLookup

        add $t2, $t1, $t0

        lb $t3, 0($t2)

        li $v0, 4
        la $a0, Prompt2
        syscall

        li $v0, 11
        move $a0, $t3
        syscall

        li $v0, 10
        syscall
    
