.data
    fin:  .asciiz "raw_input.txt"
    fout: .asciiz "formatted_result.txt"
    
    title: .asciiz "-Student personal information-\n"
    L1:    .asciiz "Name: "
    L2:    .asciiz "ID: "
    L3:    .asciiz "Address: "
    L4:    .asciiz "Age: "
    L5:    .asciiz "Religion: "
    nl:    .asciiz "\n"

.text
.globl main
main:
    # 1. Cấp phát động 256 bytes trên Heap
    li $v0, 9
    li $a0, 256
    syscall
    move $s0, $v0       # $s0 trỏ đến đầu vùng nhớ

    #Mở file
    li $v0, 13
    la $a0, fin
    li $a1, 0           # cờ read
    li $a2, 0
    syscall
    move $s1, $v0       

    #Đọc từ file vào heap
    li $v0, 14
    move $a0, $s1
    move $a1, $s0       # Ghi vào vùng nhớ Heap
    li $a2, 256
    syscall

    #Đóng file
    li $v0, 16
    move $a0, $s1
    syscall

    # 5. Phân tích chuỗi (Parse CSV)
    # Lặp qua từng byte, đổi ',' thành '\0'
    move $t0, $s0       # Con trỏ duyệt chuỗi
parse_loop:
    lb $t1, 0($t0)
    beqz $t1, parse_done
    beq $t1, 44, replace_comma  # 44 là mã ASCII của ','
    j parse_next
replace_comma:
    sb $zero, 0($t0)    # Ghi đè dấu phẩy bằng null
parse_next:
    addi $t0, $t0, 1
    j parse_loop
parse_done:

    # 6. Mở file để ghi
    li $v0, 13
    la $a0, fout
    li $a1, 1           # cờ write
    li $a2, 0
    syscall
    move $s2, $v0       # $s2 = file descriptor (out)
    
    # 7. Đóng file ghi
    li $v0, 16
    move $a0, $s2
    syscall

    li $v0, 10
    syscall
