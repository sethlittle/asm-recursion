.text
.globl do_task
do_task:			# void do_task(int a, int b) {

  addi	$sp, $sp, -16        	# Set up stack
  sw	$ra, 4($sp)
  sw	$fp, 0($sp)
  addi  $fp, $sp, 4             # Set $fp to the start of do_task's stack frame

  # Your code here	
  
  sw $a0, 8($sp)
  sw $a1, 12($sp)
  
  add $t1, $a0, $0		# a in t1
  add $t2, $a1, $0		# b in t2
  add $a0, $t1, $t2		# n in a0 n = a + b
  add $a1, $t1, $0		# k in a1 k = a

  jal NchooseK
  
  add $a0, $v0, $0
  
  jal print_it
  
  add $v0, $0, $0
  
  lw $a1, 12($sp)
  
  add $a0, $a1, $0
  
  jal Fibonacci
  
  add $a0, $v0, $0
  
  jal print_it
  
  
  
  
  
  # int n, k, result;
  # n = a+b;
  # k = a;

  # result = NchooseK(n, k);
  # print_it(result);

  # result = Fibonacci(b);
  # print_it(result);
	
  
exit_from_do_task: 			# }
  addi	$sp, $fp, 4 		# restore $ra, $fp and $sp
  lw	$ra, 0($fp)
  lw	$fp, -4($fp)
  jr	$ra             	# return from procedure
end_of_do_task:
