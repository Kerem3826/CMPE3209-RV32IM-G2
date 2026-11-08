.data
SID:
        .word   1240012
R:
        .word   101
B:
        .space  4
arr:
        .space  144
bucket:
        .space  20
mean:
        .space  4
below_count:
        .space  4
pass_count:
        .space  4

.text
.globl main

main:
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        li      a5,1241088
        addi    a5,a5,-1076
        sw      a5,-20(s0)
        sw      zero,-24(s0)
        sw      zero,-28(s0)
        j       .L5
.L11:
        lw      a4,-20(s0)
        li      a5,1662976
        addi    a5,a5,1549
        mul     a4,a4,a5
        li      a5,1013903360
        addi    a5,a5,863
        add     a5,a4,a5
        sw      a5,-20(s0)
        lw      a5,-20(s0)
        srli    a4,a5,16
        li      a5,101
        remu    a5,a4,a5
        li      a4,0
        add     a5,a5,a4
        mv      a3,a5
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        sw      a3,0(a5)
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,49
        bgt     a4,a5,.L6
        la      a5,bucket
        lw      a5,0(a5)
        addi    a4,a5,1
        la      a5,bucket
        sw      a4,0(a5)
        j       .L7
.L6:
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,64
        bgt     a4,a5,.L8
        la      a5,bucket
        lw      a5,4(a5)
        addi    a4,a5,1
        la      a5,bucket
        sw      a4,4(a5)
        j       .L7
.L8:
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,74
        bgt     a4,a5,.L9
        la      a5,bucket
        lw      a5,8(a5)
        addi    a4,a5,1
        la      a5,bucket
        sw      a4,8(a5)
        j       .L7
.L9:
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a4,0(a5)
        li      a5,84
        bgt     a4,a5,.L10
        la      a5,bucket
        lw      a5,12(a5)
        addi    a4,a5,1
        la      a5,bucket
        sw      a4,12(a5)
        j       .L7
.L10:
        la      a5,bucket
        lw      a5,16(a5)
        addi    a4,a5,1
        la      a5,bucket
        sw      a4,16(a5)
.L7:
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a5,0(a5)
        mv      a4,a5
        lw      a5,-24(s0)
        add     a5,a5,a4
        sw      a5,-24(s0)
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L5:
        lw      a4,-28(s0)
        li      a5,35
        bleu    a4,a5,.L11
        sw      zero,-28(s0)
        j       .L12
.L13:
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a5,0(a5)
        mv      a0,a5
        call    passCheck
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L12:
        lw      a4,-28(s0)
        li      a5,35
        bleu    a4,a5,.L13
        lw      a4,-24(s0)
        li      a5,954437632
        addi    a5,a5,-455
        mulhu   a5,a4,a5
        srli    a4,a5,3
        la      a5,mean
        sw      a4,0(a5)
        sw      zero,-28(s0)
        j       .L14
.L16:
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a5,0(a5)
        mv      a4,a5
        la      a5,mean
        lw      a5,0(a5)
        bgeu    a4,a5,.L15
        la      a4,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a5,0(a5)
        ori     a4,a5,256
        la      a3,arr
        lw      a5,-28(s0)
        slli    a5,a5,2
        add     a5,a3,a5
        sw      a4,0(a5)
        la      a5,below_count
        lw      a5,0(a5)
        addi    a4,a5,1
        la      a5,below_count
        sw      a4,0(a5)
.L15:
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L14:
        lw      a4,-28(s0)
        li      a5,35
        bleu    a4,a5,.L16
        li      a5,0
        mv      a0,a5
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32

        li      a7,10
        ecall

passCheck:
        addi    sp,sp,-48
        sw      ra,44(sp)
        sw      s0,40(sp)
        addi    s0,sp,48
        sw      a0,-36(s0)
        li      a5,1241088
        addi    a3,a5,-1076
        li      a5,1717985280
        addi    a5,a5,1639
        mulh    a5,a3,a5
        srai    a4,a5,2
        srai    a5,a3,31
        sub     a4,a4,a5
        mv      a5,a4
        slli    a5,a5,2
        add     a5,a5,a4
        slli    a5,a5,1
        sub     a4,a3,a5
        addi    a5,a4,50
        sw      a5,-20(s0)
        lw      a4,-36(s0)
        lw      a5,-20(s0)
        bltu    a4,a5,.L2
        la      a5,pass_count
        lw      a5,0(a5)
        addi    a4,a5,1
        la      a5,pass_count
        sw      a4,0(a5)
        li      a5,1
        j       .L3
.L2:
        li      a5,0
.L3:
        mv      a0,a5
        lw      ra,44(sp)
        lw      s0,40(sp)
        addi    sp,sp,48
        jr      ra
