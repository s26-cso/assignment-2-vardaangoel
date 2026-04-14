.globl main
.section .rodata
name: .string "./input.txt"
mode:.string "r"
yes: .string "Yes\n"
no: .string "No\n"

.text

main:
addi sp,sp,-48
sd ra,40(sp)
sd s0,32(sp)        #file pointer
sd s1,24(sp)        #left 
sd s2,16(sp)        #right
sd s3,8(sp)     #left char
li s1,0
la a0, name
la a1, mode     #"r"
call fopen
mv s0,a0
beq s0,x0,not

li a1,0     #offset
li a2,2     #seek end mode
call fseek
mv a0,s0
call ftell
addi s2,a0,-1       #s2=n-1

loop:
mv a0,s0
mv a1,s1
li a2,0
call fseek
mv a0,s0
call fgetc
mv s3,a0        #left char

mv a0,s0
mv a1,s2
li a2,0
call fseek
mv a0,s0
call fgetc          #right char at a0

bne s3,a0, not
addi s1,s1,1
addi s2,s2,-1
bge s1,s2,is
j loop

is:
la a0,yes
call printf
j end

not:
la a0,no
call printf

end:
mv a0,s0
call fclose
ld ra,40(sp)
ld s0,32(sp)
ld s1,24(sp)
ld s2,16(sp)
ld s3,8(sp)
addi sp,sp,48
ret
