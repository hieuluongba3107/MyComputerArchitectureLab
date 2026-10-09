.data	
	array:	.space 20
	ele0: .asciiz "Please input element 0:"
	ele1: .asciiz "Please input element 1:"
	ele2: .asciiz "Please input element 2:"
	ele3: .asciiz "Please input element 3:"
	ele4: .asciiz "Please input element 4:"
	index: .asciiz "Please enter index:"

.text
.globl main

main:
#lay dia chi mang
    la $s0, array
    
#nap phan tu
    li $v0, 4 #4 tuc la in chuoi
    la $a0, ele0
    syscall
    li $v0, 5# 5 la read integer
    syscall
    sw $v0 ,0($s0) #a[0]
    
    li $v0, 4 
    la $a0, ele1
    syscall
    li $v0, 5
    syscall
    sw $v0 ,4($s0)
   
    li $v0, 4 
    la $a0, ele2
    syscall
    li $v0, 5
    syscall
    sw $v0 ,8($s0)
    
    li $v0, 4 
    la $a0, ele3
    syscall
    li $v0, 5
    syscall
    sw $v0 ,12($s0) 
    
    li $v0, 4 
    la $a0, ele4
    syscall
    li $v0, 5
    syscall
    sw $v0 ,16($s0)
    
    #nhap index
    li $v0, 4
    la $a0, index
    syscall
    li $v0, 5
    syscall
    
    move $t0, $v0
    sll $t1, $t0, 2
    add $t2, $s0, $t1 #tìm address tại i
    lw $t3, 0($t2)
    
    li $v0, 1 # 1 is print integer
    move $a0, $t3
    syscall
    
    li $v0, 10
    syscall
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    