.data	
    string:     .asciiz "Please enter your name: "
    hello:      .asciiz "Hello, "
    excl:       .asciiz "!"
    name:       .space 64          # Cấp phát 64 bytes để chứa chuỗi tên

.text
.globl main

main:
     	#input
    li $v0, 4
    la $a0, string
    syscall

	#print
    li $v0, 8
    la $a0, name
    li $a1, 64                  
    syscall
	
	
	la $t0, name
    remove:
    	lb $t1, 0($t0)
    	beq $t1, 10, found
    	addi $t0, $t0, 1
    	j remove
    found: 
    	sb $0, 0($t0)
     
    
    li $v0, 4
    la $a0, hello
    syscall

    li $v0, 4
    la $a0, name
    syscall

    li $v0, 4
    la $a0, excl
    syscall
    
	#return
    li $v0, 10
    syscall