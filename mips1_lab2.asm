.data
    array: .space 20    
    prompt: .asciiz "Input element : "
    space: .asciiz " "
    newline: .asciiz "\nResult: "

.text
.globl main
main:
    li $t0, 0               # biến chạy t0 i = 0
    la $t1, array           # Load địa chỉ mảng

loop1:
    beq $t0, 5, process     # basecase

    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    
    # Lưu vào mảng
    sll $t2, $t0, 2         # offset 
    add $t3, $t1, $t2       # array[i]
    sw $v0, 0($t3)          # Lưu 
    
    addi $t0, $t0, 1       # i++
    j loop1

process:
    li $v0, 4
    la $a0, newline
    syscall

    li $t0, 0               # Khởi tạo lại i = 0

process_loop:
    beq $t0, 5, exit        # Nếu i == 5, thoát
    
    sll $t2, $t0, 2         # Offset (i * 4)
    add $t3, $t1, $t2       # Địa chỉ array[i]
    lw $t4, 0($t3)          # Load giá trị array[i] vào $t4
    
    # làm tròn: (x + 1) & -4
    addi $t4, $t4, 1        # x = x + 1
    li $t5, -4              # Load giá trị mask -4 (111...1100) 
    and $t4, $t4, $t5       # AND với -4, 
    #dư 0,1,2 -> bỏ 2 bit cuối
    #dư 3 + 1 
    
    # In phần tử
    li $v0, 1
    move $a0, $t4
    syscall
    
    # In khoảng trắng
    li $v0, 4
    la $a0, space
    syscall
    
    addi $t0, $t0, 1        # i++
    j process_loop

exit:
    li $v0, 10
    syscall
