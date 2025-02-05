//Check time of day 
        .data
Prompt:
        .asciiz "Please enter a time 1-24:  "
Morning:
        .asciiz "It's Morning\n"
Noon:
        .asciiz "It's Noon\n"
Afternoon:
        .asciiz "It's Afternoon\n"

        .text

        .globl main
main:
        li $t1, 12

        la $a0, Prompt
        li $v0, 4
        syscall

        li $v0, 5
        syscall
        move $t0, $v0

       slt $t5, $t0, $t1
       beq $t5, 1, ResultMorn
       seq $t5, $t0, $t1
       beq $t5, 1, ResultNoon
       sgt $t5, $t0, $t1
       beq $t5, 1, ResultAftern


Exit:
        li $v0, 10
        syscall

ResultMorn:
        la $a0, Morning
        li $v0, 4
        syscall
        j Exit
ResultNoon:
        la $a0, Noon
        li $v0, 4
        syscall
        j Exit
ResultAftern:
        la $a0, Afternoon
        li $v0, 4
        syscall
        j Exit

        
    
