.data
    input: .asciiz "Please insert an element: "
    err: .asciiz "A factorial for your number can not be found."
    
.text
.globl main
main:
    li $v0, 4
    la $a0, input
    syscall
    
    li $v0, 5
    syscall
    move $a0, $v0    #a0 = n
    
    bltz $a0, error # n<0

    jal factorial
    
    move $a0, $v0
    li $v0, 1
    syscall
    
    j exit

error:
    li $v0, 4
    la $a0, err
    syscall

exit:
    li $v0, 10
    syscall


factorial:
    addi $sp, $sp, -8  
    sw $ra, 4($sp)    
    sw $a0, 0($sp) # a0 = n

    bgtz $a0, recursive_step # n > 0, đệ qui
    
    li $v0, 1           # basecase: 0! = 1
    j fact_end          

recursive_step:
    addi $a0, $a0, -1   
    jal factorial       # Gọi lại chính nó. Kết quả factorial(n-1) sẽ lưu ở $v0
    
    lw $a0, 0($sp)      # n của tầng trước
    mul $v0, $v0, $a0   # $v0 = factorial(n-1) * n

fact_end:
    lw $ra, 4($sp)      # trả
    addi $sp, $sp, 8    
    jr $ra             