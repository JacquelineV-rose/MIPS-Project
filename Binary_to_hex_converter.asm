//Decimal to Binary/Hex converter
        .data
Prompt1:
        .asciiz "Please enter an integer: "
Prompt2:
        .asciiz "The binary is: "
Prompt3:
        .asciiz "\nThe hexadecimal is: 0x"
Prompt4:
        .asciiz "\nWould you like to convert another integer? (0 or 1) "
binaryRep:
        .space 32
hexRep:
        .space 8
hexLookup: 
        .byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
        .text

        .globl main
main:

OuterLoop:
        la $t5, binaryRep
        li $t1, 0
        li $t2, 0
        li $t3, 32
BinaryResetLoop:
        sb $t2, 0($t5)
        addi $t5, $t5, 1
        addi $t1, $t1, 1

        blt $t1, $t3, BinaryResetLoop

        li $v0, 4
        la $a0, Prompt1
        syscall

        li $v0, 5
        syscall
        move $t0, $v0

        la $t5, binaryRep
        li $t7, 0

        li $t6, 2

BinaryCalc:
        div $t0, $t6
        mfhi $t3
        mflo $t0
        sb $t3, 0($t5)

        addi $t5, $t5, 1
        addi $t7, $t7, 1
        bnez $t0, BinaryCalc
        beqz $t0, PrintStart

PrintStart:
        li $v0, 4
        la $a0, Prompt2
        syscall
        addi $t5, $t5, -1
        move $t9, $t7

BinaryPrint:
        lb $t4, 0($t5)
        
        li $v0, 1
        move $a0, $t4
        syscall

        addi $t5, $t5, -1
        addi $t7, $t7, -1

        bnez $t7, BinaryPrint

HexPromptPrint:
        la $t5, binaryRep
        addi $t5, $t5, 31
        li $v0, 4
        la $a0, Prompt3
        syscall

        li $t3, 8
        la $t2, hexRep
        li $t1, 0
# Start of new code 
HexOuterLoop:
        
        li $t4, 0
        li $t6, 0
        li $t7, 0
        li $t8, 4
        la $t9, hexLookup

HexInnerLoop:
        lb $t4, 0($t5)
        or $t4, $t4, $zero
        or $t6, $t6, $t4
        sll $t6, $t6, 1

        addi $t7, $t7, 1
        addi $t5, $t5, -1
        li $t4, 0
        blt $t7, $t8, HexInnerLoop

        srl $t6, $t6, 1
        add $t9, $t9, $t6
        lb $t6, 0($t9)

        sb $t6 0($t2)
        addi $t2, $t2, 1
        addi $t1, $t1, 1
        blt $t1, $t3, HexOuterLoop

        la $t5, hexRep
        li $t1, 8

HexPrintLoop:
        lb $t4, 0($t5)
        
        li $v0, 11
        move $a0, $t4
        syscall

        addi $t5, $t5, 1
        addi $t1, $t1, -1

        bnez $t1, HexPrintLoop
        
# End of new code
UserContinue:
        li $v0, 4
        la $a0, Prompt4
        syscall

        li $v0, 5
        syscall
        li $t8, 1

        beq $v0, $t8, OuterLoop
        beqz $v0, Exit


Exit:
        li $v0, 10
        syscall
        


    
