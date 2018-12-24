#int fib(int n){
#	if(n == 0){
#		return 0;
#	}
#	else if(n == 1){
#		return 1;
#	}
#	else{
#		return fib(n-1) + fib(n-2)
#	}
#}

# Assume that the value of n is in register $a0 and register $v0 holds the result of the function.

addi $a0,$a0,10#temp (n = 10)
jal fib #jump to [fib] and link
j end#jump to [end] after finish with [fib]

fib:
addi $sp, $sp, -12 #make room for stack (3 words)
sw $ra, 8($sp)#push return adrdress to stack
sw $s0, 4($sp)
sw $a0, 0($sp)

add $s0,$zero,$zero
addi $s0,$s0,1 #s0 = 1

#beq $a0, $zero, baseCase0 #branch to baseCase0 if n == 0
beq $a0, $s0, baseCase1 #branch to baseCase1 if n == 1
slti $t0,$a0,2#test for n<2
beq $t0,$zero,else #if n >= 2, jump to else
#baseCase0, n==0:
add $v0, $zero, $zero#return value = 0
lw $a0, 0($sp)#restore original value of $a0
lw $s0, 4($sp)
lw $ra, 8($sp)
addi $sp, $sp, 12 # readjust stack
jr $ra#return to caller
baseCase1:
addi $v0, $zero, 1 # return value = 1
lw $a0, 0($sp)#restore original value of $a0
lw $s0, 4($sp)
lw $ra, 8($sp)
addi $sp, $sp, 12 # readjust stack
jr $ra#return to caller
#...else ...
else:
addi $a0,$a0, -1# n-1
jal fib#fib(n-1)
sw  $v0,4($sp)#save result in stack
addi $a0,$a0, -1# n-2
jal fib#fib(n-2)
lw $a0, 0($sp)#restore original value of $a0
lw $s0, 4($sp)
lw $ra, 8($sp)
addi $sp, $sp, 12 #adjust stack pointer

add $v0, $s0,$v0 #return value = fib(n-1) + fib(n-2)
jr $ra #return to caller

end:

