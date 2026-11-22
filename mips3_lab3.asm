.data
    filein:  .asciiz "raw_input.txt"
    fileout: .asciiz "formatted_result.txt"
    
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
    # Cấp phát động 256 bytes trên Heap
    li $v0, 9
    li $a0, 256
    syscall
    move $s0, $v0       # $s0 trỏ đến đầu vùng nhớ

    # Mở file
    li $v0, 13
    la $a0, filein
    li $a1, 0           # cờ read
    li $a2, 0
    syscall
    move $s1, $v0       

    # Đọc từ file vào heap
    li $v0, 14
    move $a0, $s1
    move $a1, $s0       # Ghi vào vùng nhớ Heap
    li $a2, 255
    syscall
    add $t0, $s0, $v0   # $v0 chứa số byte thực tế đọc được
    sb $zero, 0($t0)    # Chèn ký tự '\0' ở cuối dữ liệu vừa đọc

    # Đóng file
    li $v0, 16
    move $a0, $s1
    syscall

    # Duyệt chuỗi
    # Lặp qua từng byte, đổi ',', '\n', '\r' thành '\0'
    move $t0, $s0       # Con trỏ duyệt chuỗi
parse_loop:
    lb $t1, 0($t0)
    beqz $t1, parse_done
    beq $t1, 44, replace_comma  # 44 : ','
    beq $t1, 10, replace_comma  # 10 : '\n'
    beq $t1, 13, replace_comma  # 12 : '\r'
    j parse_next
replace_comma:
    sb $zero, 0($t0)    # Ghi đè dấu phẩy bằng null
parse_next:
    addi $t0, $t0, 1
    j parse_loop
parse_done:

    # Mở file để ghi
    li $v0, 13
    la $a0, fileout
    li $a1, 1           # cờ write
    li $a2, 0
    syscall
    move $s2, $v0       # $s2 = file descriptor (out)

    # Xuất tiêu đề và các trường thông tin ra màn hình + ghi vào fileout
    la $a0, title
    jal print_and_write

    move $s3, $s0       # $s3 trỏ đến trường dữ liệu hiện tại

    # Name
    la $a0, L1
    jal print_and_write
    move $a0, $s3
    jal print_and_write
    la $a0, nl
    jal print_and_write

    # ID
    jal next_field
    la $a0, L2
    jal print_and_write
    move $a0, $s3
    jal print_and_write
    la $a0, nl
    jal print_and_write

    # Address
    jal next_field
    la $a0, L3
    jal print_and_write
    move $a0, $s3
    jal print_and_write
    la $a0, nl
    jal print_and_write

    # Age
    jal next_field
    la $a0, L4
    jal print_and_write
    move $a0, $s3
    jal print_and_write
    la $a0, nl
    jal print_and_write

    # Religion
    jal next_field
    la $a0, L5
    jal print_and_write
    move $a0, $s3
    jal print_and_write
    la $a0, nl
    jal print_and_write
    
    # 7. Đóng file ghi
    li $v0, 16
    move $a0, $s2
    syscall

    li $v0, 10
    syscall

#In chuỗi ở $a0 ra Terminal và ghi vào file $s2
print_and_write:
    move $t0, $a0       # Lưu địa chỉ đầu chuỗi
    li $v0, 4           # In ra màn hình (syscall 4)
    syscall

    move $t1, $t0       # Đếm độ dài chuỗi cho syscall 15
    li $t2, 0
len_loop:
    lb $t3, 0($t1)
    beqz $t3, len_done
    addi $t1, $t1, 1
    addi $t2, $t2, 1
    j len_loop
len_done:
    li $v0, 15          # Ghi ra file (syscall 15)
    move $a0, $s2
    move $a1, $t0
    move $a2, $t2
    syscall
    jr $ra

# Dịch con trỏ $s3 sang trường kế tiếp và bỏ dấu cách đầu
next_field:
skip_curr:
    lb $t0, 0($s3)
    addi $s3, $s3, 1
    bnez $t0, skip_curr     # Đi qua hết chuỗi hiện tại và '\0'
skip_space:
    lb $t0, 0($s3)
    bne $t0, 32, next_done  # Bỏ qua dấu cách (ASCII 32) sau dấu phẩy
    addi $s3, $s3, 1
    j skip_space
next_done:
    jr $ra
