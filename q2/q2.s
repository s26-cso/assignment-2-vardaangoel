.globl main
.section .rodata
int: .string "%d"
newline: .string "\n"
space: .string " "

.text

main:
addi sp,sp,-80
sd ra,72(sp)
sd s0, 64(sp)   #stores n
sd s1, 56(sp)       #pointer to array
sd s2,48(sp)        #arg count
sd s3,40(sp)        #arg v
sd s4,32(sp)        #answer ka pointer
sd s5,24(sp)     #stack ka pointer
sd s6,16(sp)     #stack ka top
sd s7,8(sp)     #for loops
addi s0,a0,-1
mv s2,a0
mv s3,a1
slli a0,s0,2        #space for n elements
call malloc
mv s1,a0        #array pointer stored
slli a0,s0,2        
call malloc
mv s4,a0        #ans pointer stored
slli a0,s0,2       
call malloc
mv s5,a0        #stack pointer stored

li s7,0         #i=0 se start
loop:
beq s7,s0,calc      #if i==n
addi a3,s7,1        #i+1
slli a3,a3,3
add a3,s3,a3        
ld a0,0(a3)     #a0=arg[i+1]
call atoi

slli a3,s7,2
add a3,s1,a3
sw a0,0(a3)     #stores the element
addi s7,s7,1
j loop

calc:
li s6,-1            #top=-1
addi s7,s0,-1       #j=n-1

for:
blt s7,x0,print
calcloop:
blt s6,x0,loopend       #loop end condition

slli a3,s6,2
add a3,s5,a3       
lw a3,0(a3)         #a3=top index
slli a3,a3,2
add a3,s1,a3
lw a3,0(a3)         #a3=arr[top index]
slli a4,s7,2
add a4,s1,a4
lw a4,0(a4)         #a4=arr[j]
bgt a3,a4,loopend       #loopend cond, arr[top index]>arr[j]
addi s6,s6,-1           #pop
j calcloop


loopend:
slli a4,s7,2
add a4,s4,a4        #a4=pointer to ans[j]
blt s6,x0,minusone      #empty stack
slli a3,s6,2        
add a3,s5,a3
lw a3,0(a3)     

sw a3,0(a4)         #ans[j]=top index, stored
j push

minusone:
li a3,-1
sw a3,0(a4)          #ans[j]=-1 stored

push:
addi s6,s6,1
slli a3,s6,2
add a3,s5,a3
sw s7,0(a3)         #stores the curr index on stack
addi s7,s7,-1
j for

print:
li s7,0
ploop:
beq s7,s0,end       #loop end cond
slli a3,s7,2
add a3,s4,a3
lw a1,0(a3)
la a0,int
call printf
addi a3,s0,-1
beq s7,a3,skip
la a0,space
call printf

skip:
addi s7,s7,1
j ploop

end:
la a0,newline
call printf
ld s7,8(sp)
ld s6,16(sp)
ld s5,24(sp)
ld s4,32(sp)
ld s3,40(sp)
ld s2,48(sp)
ld s1,56(sp)
ld s0,64(sp)
ld ra,72(sp)
addi sp,sp,80
ret


