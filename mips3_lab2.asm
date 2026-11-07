.data 
	array: .space 40
	input: .asciiz "Please insert a element "
	res: .asciiz "Second largest value is "
	comma: .asciiz ","
	idx: .asciiz ", found in index"
	dot: .asciiz "."

.text	
.globl main
main:
	
	la $s0, array		#base address = $s0
	move $t0, $0
	li $t3, 10
Loop1:
	beq $t0, $t3, Exit 
	li $v0, 4
	la $a0, input
	syscall 
	li $v0, 5
	syscall
	sll $t2, $t0, 2
	add $s1, $s0, $t2
	sw $v0, 0($s1)
	addi $t0, $t0, 1
	j Loop1
Exit:
	
max1:
	lw $s3, 0($s0) #s3 = array[0]
	li $t1, 1	
LoopMax:
	beq $t1, 10, secondMax
  	sll $t0, $t1, 2
    	add $t2, $s0, $t0
    	lw $t3, 0($t2) 	# $t3 = array[i] 	
	
	ble $t3, $s3, skip #array[i] < max
	move $s3, $t3
skip:
	addi $t1, $t1, 1
	j LoopMax
	
	
secondMax:
    li $t0, 0
    li $s2, -2147483648 # second_max = INTMIN
LoopMax2:
    beq $t0, 10, print_result
    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $t3, 0($t2)
    
    bge $t3, $s3, skip_sec # nếu >= max
    ble $t3, $s2, skip_sec # nếu <= second_max
    move $s2, $t3          # Cập nhật second_max
skip_sec:
    addi $t0, $t0, 1
    j LoopMax2

#tìm Index
print_result:
    li $v0, 4
    la $a0, res
    syscall
    li $v0, 1
    move $a0, $s2       # In second_max
    syscall
    li $v0, 4
    la $a0, idx
    syscall

    li $t0, 0           # i = 0
    li $t4, 0           # flag (0: chưa in số nào)
    
print_index_loop:
    beq $t0, 10, exit
    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $t3, 0($t2)
    
    bne $t3, $s2, skip_print # Nếu không bằng second_max thì bỏ qua
    
    beqz $t4, print_idx # Nếu là số đầu tiên được in, không in phẩy
    li $v0, 4
    la $a0, comma
    syscall
print_idx:
    li $v0, 1
    move $a0, $t0       # In index
    syscall
    li $t4, 1           # đã in 1 số (flag)
    
skip_print:
    addi $t0, $t0, 1
    j print_index_loop

exit:
    li $v0, 10
    syscall
	
	

