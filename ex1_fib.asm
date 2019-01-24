.text
.globl Fibonacci
#Fibonacci:
#    addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp
    
 #   sw      $ra, 4($sp)         # Save $ra
 #   sw      $fp, 0($sp)         # Save $fp

#    addi    $fp, $sp, 4         # Set $fp to the start of Fibonacci's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value

    # Your code here 
Fibonacci:
	beq $a0, $0, basecase0	# checks if i == 0, if it is, we jump to the base case - and add 0 to v0
    	beq $a0, 1, basecase1  # checks if i == 1, if it is we jump to the base case - and add 1 to v0
	
recurse:
	sub $sp, $sp, 12 # We need to store 3 registers to stack
	sw $ra, 0($sp)	 # $ra is the first register
	sw $a0, 4($sp)	 # $a0 is the second register, i needs to be stored
	
	addi $a0, $a0, -1 # i - 1
	jal Fibonacci 	  # Fibonacci(i-1)
	sw $v0, 8($sp)   # store $v0, the last register to be stored on the stack
			
	lw $a0, 4($sp) 	  # reloads the original value of n
	addi $a0, $a0, -2 # i - 2
	jal Fibonacci	  # Fibonacci(i-2)
	
	lw $t0, 8($sp)   # loads the value of v0 into t0
	add $v0, $v0, $t0 # adds v0 to v0
	lw $ra, 0($sp) 	  # relaods the original return address
	addi $sp, $sp, 12 # restores the stack
	
	jr $ra

basecase1:
    	li $v0, 1	  # similar to return 1 in C
	jr $ra		  # returns to the jal from the recurse label
	
basecase0:
	li $v0, 0
	jr $ra

	
	
	
    #int Fibonacci(int i) {
    #  if((i==0) || (i==1))
    #    return i;
    #  else
    #    return Fibonacci(i-1) + Fibonacci(i-2);
    #}
	
	
#exit_from_Fibonacci:
    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.
#    addi    $sp, $fp, 4     # Restore $sp
 #   lw      $ra, 0($fp)     # Restore $ra
 #   lw      $fp, -4($fp)    # Restore $fp
 #   jr	    $ra
end_of_Fibonacci:
