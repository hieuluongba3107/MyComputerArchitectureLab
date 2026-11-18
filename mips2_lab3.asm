.data
    prompt_u: .asciiz "Please insert u: "
    prompt_v: .asciiz "Please insert v: "
    prompt_a: .asciiz "Please insert a: "
    prompt_b: .asciiz "Please insert b: "
    prompt_c: .asciiz "Please insert c: "
    prompt_d: .asciiz "Please insert d: "
    prompt_e: .asciiz "Please insert e: "
    
    c7: .float 7.0
    c6: .float 6.0
    c2: .float 2.0

.text
.globl main
main:
    
    li $v0, 4
    la $a0, prompt_u
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0

    # Nhập v -> lưu vào $f2
    li $v0, 4
    la $a0, prompt_v
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0

    # Nhập a -> lưu vào $f3
    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 6
    syscall
    mov.s $f3, $f0

    # Nhập b -> lưu vào $f4
    li $v0, 4
    la $a0, prompt_b
    syscall
    li $v0, 6
    syscall
    mov.s $f4, $f0

    # Nhập c -> lưu vào $f5
    li $v0, 4
    la $a0, prompt_c
    syscall
    li $v0, 6
    syscall
    mov.s $f5, $f0

    # Nhập d -> lưu vào $f6
    li $v0, 4
    la $a0, prompt_d
    syscall
    li $v0, 6
    syscall
    mov.s $f6, $f0

    # Nhập e -> lưu vào $f7
    li $v0, 4
    la $a0, prompt_e
    syscall
    li $v0, 6
    syscall
    mov.s $f7, $f0
    # Tính mẫu số Denom = d^4 + e^3
    mul.s $f8, $f6, $f6    # d^2
    mul.s $f8, $f8, $f8    # d^4
    mul.s $f9, $f7, $f7    # e^2
    mul.s $f9, $f9, $f7    # e^3
    add.s $f10, $f8, $f9   # Denom = d^4 + e^3
    
    # Tính F(u)
    mov.s $f12, $f1        # Đưa u vào biến x
    jal calc_F
    mov.s $f20, $f0        # $f20 = F(u)
    
    # Tính F(v)
    mov.s $f12, $f2        # Đưa v vào biến x
    jal calc_F
    
    # Kết quả = F(u) - F(v)
    sub.s $f12, $f20, $f0
    li $v0, 2              # In kết quả
    syscall
    
    li $v0, 10
    syscall

# tính F(x) = [ (a/7)x^7 + (b/6)x^6 + (c/2)x^2 ] / Denom
# Input: $f12 (x), $f3 (a), $f4 (b), $f5 (c), $f10 (Denom)
# Output: $f0
calc_F:
    # Tính các lũy thừa của x
    mul.s $f13, $f12, $f12 # x^2
    mul.s $f14, $f13, $f13 # x^4
    mul.s $f15, $f14, $f13 # x^6
    mul.s $f16, $f15, $f12 # x^7
    
    # Tính từng cụm hệ số
    l.s $f17, c7
    div.s $f18, $f3, $f17  # a/7
    mul.s $f18, $f18, $f16 # (a/7)x^7
    
    l.s $f17, c6
    div.s $f19, $f4, $f17  # b/6
    mul.s $f19, $f19, $f15 # (b/6)x^6
    
    l.s $f17, c2
    div.s $f21, $f5, $f17  # c/2
    mul.s $f21, $f21, $f13 # (c/2)x^2
    
    # Tổng các cụm và chia cho mẫu
    add.s $f0, $f18, $f19
    add.s $f0, $f0, $f21
    div.s $f0, $f0, $f10
    jr $ra