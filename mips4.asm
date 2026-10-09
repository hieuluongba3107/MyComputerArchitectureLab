.data
	string: .asciiz "Please enter a positive integer less than 16:"
	string1: .asciiz "Its binary form is:"
	
.text
.globl main

main: 
	li $v0, 4
	la $a0, string 
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	

	srl $t3, $s0, 3
	andi $t3, $t3, 1
	
	srl $t2, $s0, 2
	andi $t2, $t2, 1
	
	srl $t1, $s0, 1
	andi $t1, $t1, 1
	
	andi $t0, $s0, 1
	
	#in
	li $v0, 4
	la $a0,string1
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall