passCheck:
        sltiu   a0,a0,52
        seqz    a0,a0
        ret
main:
        addi    sp,sp,-48
        sw      s0,44(sp)
        sw      s1,40(sp)
        sw      s2,36(sp)
        sw      s3,32(sp)
        sw      s4,28(sp)
        sw      s5,24(sp)
        sw      s6,20(sp)
        sw      s7,16(sp)
        sw      s8,12(sp)
        sw      s9,8(sp)
        sw      s10,4(sp)
        sw      s11,0(sp)
        lla     a5,.LANCHOR0
        lw      s7,16(a5)
        lw      s6,12(a5)
        lw      s3,8(a5)
        lw      s0,4(a5)
        lw      t4,0(a5)
        lla     a3,.LANCHOR0+20
        lla     a6,.LANCHOR0+164
        mv      a2,a3
        li      s11,0
        li      s10,0
        li      s5,0
        li      s2,0
        li      t2,0
        li      a0,0
        li      a4,1241088
        addi    a4,a4,-1076
        li      t3,1662976
        addi    t3,t3,1549
        li      t1,1013903360
        addi    t1,t1,863
        li      a7,1148157952
        addi    a7,a7,1623
        li      t6,101
        li      t5,49
        li      s1,64
        li      s4,74
        li      s8,84
        li      t0,1
        j       .L8
.L3:
        bgt     a5,s1,.L5
        addi    s0,s0,1
        mv      s2,t0
.L4:
        sw      a1,0(a2)
        add     a0,a0,a5
        addi    a2,a2,4
        beq     a6,a2,.L22
.L8:
        mul     a4,a4,t3
        add     a4,a4,t1
        srli    a1,a4,16
        mulhu   a5,a1,a7
        sub     s9,a1,a5
        srli    s9,s9,1
        add     a5,a5,s9
        srli    a5,a5,6
        mul     a5,a5,t6
        sub     a5,a1,a5
        mv      a1,a5
        bgt     a5,t5,.L3
        addi    t4,t4,1
        mv      t2,t0
        j       .L4
.L5:
        bgt     a5,s4,.L6
        addi    s3,s3,1
        mv      s5,t0
        j       .L4
.L6:
        bgt     a5,s8,.L7
        addi    s6,s6,1
        mv      s10,t0
        j       .L4
.L7:
        addi    s7,s7,1
        mv      s11,t0
        j       .L4
.L22:
        beq     s11,zero,.L9
        sw      s7,.LANCHOR0+16,a5
.L9:
        beq     s10,zero,.L10
        sw      s6,.LANCHOR0+12,a5
.L10:
        beq     s5,zero,.L11
        sw      s3,.LANCHOR0+8,a5
.L11:
        beq     s2,zero,.L12
        sw      s0,.LANCHOR0+4,a5
.L12:
        beq     t2,zero,.L13
        sw      t4,.LANCHOR0,a5
.L13:
        lw      a2,.LANCHOR0+164
        lla     a4,.LANCHOR0+20
.L14:
        lw      a5,0(a4)
        sltiu   a5,a5,52
        seqz    a5,a5
        add     a2,a2,a5
        addi    a4,a4,4
        bne     a6,a4,.L14
        lla     a5,.LANCHOR0
        sw      a2,164(a5)
        li      a4,954437632
        addi    a4,a4,-455
        mulhu   a0,a0,a4
        srli    a0,a0,3
        sw      a0,168(a5)
        lw      a4,172(a5)
        li      a2,0
        li      a1,1
        j       .L16
.L15:
        addi    a3,a3,4
        beq     a6,a3,.L23
.L16:
        lw      a5,0(a3)
        bleu    a0,a5,.L15
        ori     a5,a5,256
        sw      a5,0(a3)
        addi    a4,a4,1
        mv      a2,a1
        j       .L15
.L23:
        beq     a2,zero,.L17
        sw      a4,.LANCHOR0+172,a5
.L17:
        li      a0,0
        lw      s0,44(sp)
        lw      s1,40(sp)
        lw      s2,36(sp)
        lw      s3,32(sp)
        lw      s4,28(sp)
        lw      s5,24(sp)
        lw      s6,20(sp)
        lw      s7,16(sp)
        lw      s8,12(sp)
        lw      s9,8(sp)
        lw      s10,4(sp)
        lw      s11,0(sp)
        addi    sp,sp,48
        jr      ra
P:
        .word   52
B:
        .zero   4
R:
        .word   101
SID:
        .word   1240012
        .set    .LANCHOR0,. + 0
bucket:
        .zero   20
arr:
        .zero   144
pass_count:
        .zero   4
mean:
        .zero   4
below_count:
        .zero   4