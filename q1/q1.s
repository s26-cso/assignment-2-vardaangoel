.globl make_node
.globl insert
.globl get
.globl getAtMost

.text

make_node:  #a0 - val, returns pointer to new node
addi sp,sp,-16
sd ra,8(sp)
sd s0,0(sp)     
mv s0,a0        #s0 stores val
li a0,24        #24 bytes for struct
call malloc
sw s0,0(a0)     #val
sd x0,8(a0)     #left - nULL
sd x0,16(a0)    #right - nULL
ld s0,0(sp)
ld ra,8(sp)
addi sp,sp,16
ret



insert:     #a0 - root,a1 - val, returns root pointer
addi sp,sp,-32
sd ra,24(sp)
sd s0,16(sp)
sw a1,8(sp)
mv s0,a0        #s0 stores root pointer
bne x0,s0, fun  #base case
lw a0,8(sp)   
call make_node
mv s0,a0
j last

fun:
lw a2,0(s0)     #a2 has root->val
lw a1,8(sp)
blt a1,a2,left
ld a0,16(s0)        #a0 = root->right
call insert
sd a0,16(s0)
j last

left:
ld a0,8(s0)     #a0=root->left
call insert
sd a0,8(s0)

last:
mv a0,s0
ld s0,16(sp)
ld ra,24(sp)
addi sp,sp,32
ret



get:    #a0 - root pointer,a1 - val, returns pointer to ans or NULL
bne a0,x0, loop
li a0,0     #return NULL
ret     

loop:
lw a2,0(a0)     #a2=current->val
blt a1,a2, getleft
bgt a1,a2, getright
ret

getleft:
ld a0,8(a0)
j get
getright:
ld a0,16(a0)
j get



getAtMost:     #a0 - val, a1 - root pointer,returns greatest value<=val or -1
li a2,-1
atmostloop:
 beq a1,x0,end      #reached leaf node
 lw a3,0(a1)        #a3=curr->val
blt a3,a0,less
bgt a3,a0,more
mv a0,a3        #found exact value
ret

less:
mv a2,a3        #potential answer
ld a1,16(a1)        #going right
j atmostloop

more:
ld a1,8(a1)         #going left
j atmostloop


end:
mv a0,a2
ret