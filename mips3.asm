.data
    a:   .asciiz "Insert a: "
    b:   .asciiz "Insert b: "
    c:   .asciiz "Insert c: "
    d:   .asciiz "Insert d: "
    
    string: .asciiz "F = "
    sodu: .asciiz ", remainder "
    
.text
.globl main

main: 
	li $v0, 4
	la $a0, a
	syscall
	li $v0, 5 #read integer
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, b
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 4
	la $a0, c
	syscall
	li $v0, 5
	syscall
	move $s2, $v0
	
	li $v0, 4
	la $a0, d
	syscall
	li $v0, 5
	syscall
	move $s3, $v0
	
	addi $t0, $s0, 10
	sub $t1, $s1, $s3
	add $t2, $s0 ,$s0 #lấy cộng thay nhân
	sub $t3, $s2, $t2
	
	mult $t0,$t1
	mflo $t4
	
	mult $t4, $t3
	mflo $t4
	
	#tim mau so
	add $t5, $s0, $s1
	add $t5, $s2, $t5
	
	div $t4, $t5
	mflo $t6
	mfhi $t7
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 1
	move $a0, $t6
	syscall
	
	li $v0, 4
	la $a0, sodu
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	li $v0, 10
	syscall
	
	