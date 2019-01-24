.text
.globl NchooseK
#NchooseK:
#    addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp

 #   sw      $ra, 4($sp)         # Save $ra
 #   sw      $fp, 0($sp)         # Save $fp

 #   addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value


    # Your code here
    
NchooseK:
	beq $a1, $0, basecase	# checks if k is equal to 0, if it is, we jump to the base case - and add 1 to v0
    	beq $a1, $a0, basecase  # checks if n = k, if it is we jump to the base case - and add 1 to v0
	
recurse:
	sub $sp, $sp, 16 # We need to store 4 registers to stack
	sw $ra, 0($sp)	 # $ra is the first register
	sw $a0, 4($sp)	 # $a0 is the second register, n needs to be stored
	sw $a1, 8($sp)	 # k in third
	
	addi $a0, $a0, -1 # n - 1
	addi $a1, $a1, -1 # k - 1
	jal NchooseK 	  # NchooseK(n - 1, k - 1)
	sw $v0, 12($sp)   # store $v0, the fourth register to be stored on the stack
			
	lw $a0, 4($sp) 	  # reloads the original value of n
	lw $a1, 8($sp)	  # reloads the original value of k
	addi $a0, $a0, -1 # n - 1
	jal NchooseK	  # NchooseK(n - 1, k)
	
	lw $t0, 12($sp)   # loads the value of v0 into t0
	add $v0, $v0, $t0 # adds v0 to v0
	lw $ra, 0($sp) 	  # relaods the original return address
	addi $sp, $sp, 16 # restores the stack
	
	jr $ra

basecase:
    	li $v0, 1	  # similar to return 1 in C
	jr $ra		  # returns to the jal from the recurse label

	
    #int NchooseK(int n, int k) {
    #  if((k==0) || (n==k))
    #    return 1;
    #  else
    #    return NchooseK(n-1, k-1) + NchooseK(n-1, k);
    #}



    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.
#end_NchooseK:
 #   addi    $sp, $fp, 4     # Restore $sp
  #  lw      $ra, 0($fp)     # Restore $ra
  #  lw      $fp, -4($fp)    # Restore $fp
  #  jr      $ra             # Return from procedure

    # =============================================================


