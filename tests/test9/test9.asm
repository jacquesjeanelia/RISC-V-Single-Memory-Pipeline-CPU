Address     Code        Basic                        Line Source

4194304  0x00c000ef  jal x1,12                    10       jal x1, label_jal     # x1 = return address, jump to label_jal
4194308  0x00000513  addi x10,x0,0                13       li a0, 0              # a0 used as failure flag
4194312  0x0100006f  jal x0,16                    14       j print_result
4194316  0x00008067  jalr x0,x1,0                 18       jalr x0, 0(x1)
4194320  0x00000513  addi x10,x0,0                21       li a0, 0
4194324  0x0040006f  jal x0,4                     22       j print_result
4194328  0x00100513  addi x10,x0,1                26       li a0, 1              # success flag
4194332  0x00051c63  bne x10,x0,24                27       bnez a0, print_success
4194336  0x0fc10517  auipc x10,64528              30       la a0, fail_msg
4194340  0xfe050513  addi x10,x10,-32                  
4194344  0x00400513  addi x10,x0,4                31       li a0, 4              # print string syscall
4194348  0x00000073  ecall                        32       ecall
4194352  0x0140006f  jal x0,20                    33       j exit
4194356  0x0fc10517  auipc x10,64528              36       la a0, success_msg
4194360  0xfcc50513  addi x10,x10,-52                  
4194364  0x00400513  addi x10,x0,4                37       li a0, 4              # print string syscall
4194368  0x00000073  ecall                        38       ecall
4194372  0x00a00513  addi x10,x0,10               41       li a0, 10             # exit syscall
4194376  0x00000073  ecall                        42       ecall
