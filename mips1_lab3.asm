.data
    prompt_a: .asciiz "Please insert a: "
    prompt_b: .asciiz "Please insert b: "
    prompt_c: .asciiz "Please insert c: "
    msg_2sol: .asciiz "x1="
    msg_2sol_2: .asciiz " and x2="
    msg_1sol: .asciiz "There is one solution, x="
    msg_nosol: .asciiz "There is no real solution\n"
    
    four: .float 4.0
    two:  .float 2.0
    zero: .float 0.0

.text
.globl main
main:
    # Nhập a
    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 6
    syscall
    mov.s $f12, $f0     # $f12 = a

    # Nhập b
    li $v0, 4
    la $a0, prompt_b
    syscall
    li $v0, 6
    syscall
    mov.s $f14, $f0     # $f14 = b

    # Nhập c
    li $v0, 4
    la $a0, prompt_c
    syscall
    li $v0, 6
    syscall
    mov.s $f16, $f0     # $f16 = c

    # Tính Delta = b^2 - 4ac
    mul.s $f4, $f14, $f14   # $f4 = b^2
    l.s $f6, four           
    mul.s $f6, $f6, $f12    # 4*a
    mul.s $f6, $f6, $f16    # 4*a*c
    sub.s $f4, $f4, $f6     # $f4 = Delta

    l.s $f6, zero
    c.lt.s $f4, $f6         # If Delta < 0
    bc1t no_solution

    c.eq.s $f4, $f6         # If Delta == 0
    bc1t one_solution

    # Tính 2 nghiệm khi Delta > 0
    sqrt.s $f4, $f4         # $f4 = sqrt(Delta)
    neg.s $f14, $f14        # $f14 = -b
    l.s $f8, two
    mul.s $f8, $f8, $f12    # $f8 = 2a

    # x1 = (-b - sqrt(Delta)) / 2a
    sub.s $f10, $f14, $f4   
    div.s $f10, $f10, $f8   

    # x2 = (-b + sqrt(Delta)) / 2a
    add.s $f18, $f14, $f4
    div.s $f18, $f18, $f8

    # In x1 và x2
    li $v0, 4
    la $a0, msg_2sol
    syscall
    mov.s $f12, $f10
    li $v0, 2
    syscall
    
    li $v0, 4
    la $a0, msg_2sol_2
    syscall
    mov.s $f12, $f18
    li $v0, 2
    syscall
    j exit

one_solution:
    neg.s $f14, $f14        # -b
    l.s $f8, two
    mul.s $f8, $f8, $f12    # 2a
    div.s $f10, $f14, $f8   # x = -b/2a
    
    li $v0, 4
    la $a0, msg_1sol
    syscall
    mov.s $f12, $f10
    li $v0, 2
    syscall
    j exit

no_solution:
    li $v0, 4
    la $a0, msg_nosol
    syscall

exit:
    li $v0, 10
    syscall
