.data
	array: .word  1,2,5,8,12,44,3,9,0,10
	comma: .asciiz ", "
.text
.globl main
main:
	la $s0, array
	
	li $v0, 1
	lw $a0, 36($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 32($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 28($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 24($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 20($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 16($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 12($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 8($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 4($s0)
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 0($s0)
	syscall
	
	li $v0, 10
	syscall
	
	
	