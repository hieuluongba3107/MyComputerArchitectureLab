.data
    A: .asciiz "a="
    B: .asciiz "b="
    strGCD: .asciiz "GCD="
    strLCM: .asciiz ", LCM="
    errStr: .asciiz "Vui long nhap so nguyen duong!\n"

.text
.globl main
main:
    # Nhập a
    li $v0, 4
    la $a0, A
    syscall
    li $v0, 5
    syscall
    move $s0, $v0       # a-> $s0
    blez $s0, error     # a > 0?

    # Nhập b
    li $v0, 4
    la $a0, B
    syscall
    li $v0, 5
    syscall
    move $s1, $v0       # b -> $s1
    blez $s1, error     # b > 0?
	#nếu input a < b thì sẽ phải chạy thêm 1 bước
	
    # GCD
    move $a0, $s0
    move $a1, $s1
    jal gcd
    move $s2, $v0       # $s2 = GCD

    #LCM = (a * b) / GCD
    mul $t0, $s0, $s1
    div $t0, $s2
    mflo $s3            # $s3 = LCM
    
    # print
    li $v0, 4
    la $a0, strGCD
    syscall
    li $v0, 1
    move $a0, $s2
    syscall

    li $v0, 4
    la $a0, strLCM
    syscall
    li $v0, 1
    move $a0, $s3
    syscall

    j exit

error:
    li $v0, 4
    la $a0, errStr
    syscall
    j main

exit:
    li $v0, 10
    syscall

gcd:
    addi $sp, $sp, -12  # call Stack
    sw $ra, 8($sp)      # return adderss
    sw $a0, 4($sp)      # $a0 = a
    sw $a1, 0($sp)      # $a1 = b

    beqz $a1, gcd_base  # Nếu b == 0, base case
    
    div $a0, $a1
    mfhi $t0            # $t0 = a % b
    
    #gcd(b, a % b)
    move $a0, $a1
    move $a1, $t0
    jal gcd        
    
    j gcd_end

gcd_base:
    move $v0, $a0       # return a khi b == 0

gcd_end:
    lw $ra, 8($sp)      # trả
    lw $a0, 4($sp)
    lw $a1, 0($sp)
    addi $sp, $sp, 12
    jr $ra             
