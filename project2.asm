    .data
prompt:     .asciiz "Enter a number (N >= 25): "
error_msg:  .asciiz "Illegal Number!\n"

    .text
    .globl main

main:
    # Initialize registers
    li $v0, 4           # syscall: print_str
    la $a0, prompt      # load address of prompt string
    syscall             # Commit 1: Display Prompt message 

get_input:
    li $v0, 5           # syscall: read_int
    syscall             # Commit 2: Read integer input 
    move $s0, $v0       # save the input in $s0

    # Check if the input is legal
    blez $s0, illegal    # if N <= 0, branch to illegal
    li $t0, 25          # load 25 to $t0
    blt $s0, $t0, illegal # if N < 25, branch to illegal

    # Print Fibonacci sequence
    li $v0, 4           # syscall: print_str
    la $a0, result_msg  # load address of result message
    syscall             # Commit 3: Display result message 

    # Initialize Fibonacci sequence
    li $t0, 0           # fib(n-2)
    li $t1, 1           # fib(n-1)

    # Loop to calculate and print Fibonacci sequence
    li $t2, 0           # counter
fibonacci_loop:
    bge $t2, $s0, end_program   # if counter >= N, exit loop

    # Calculate fib(n) = fib(n-1) + fib(n-2)
    add $t3, $t0, $t1   # fib(n) = fib(n-1) + fib(n-2)
    
    # Print fib(n)
    li $v0, 1           # syscall: print_int
    move $a0, $t3       # move fib(n) to $a0
    syscall             # Commit 4: Display Fibonnaci number 

    # Print newline
    li $v0, 4           # syscall: print_str
    la $a0, newline      # load address of newline string
    syscall              # commit 5: Display newline 

    # Update fib(n-2) and fib(n-1) for the next iteration
    move $t0, $t1       # fib(n-2) = fib(n-1)
    move $t1, $t3       # fib(n-1) = fib(n)
    
    # Increment counter
    addi $t2, $t2, 1

    j fibonacci_loop    # jump to the beginning of the loop

illegal:
    # Print error message
    li $v0, 4           # syscall: print_str
    la $a0, error_msg   # load address of error message
    syscall             # Commit 6: Display error message 
    j get_input         # jump back to get_input to prompt for input again

end_program:
    # Exit program
    li $v0, 10          # syscall: exit
    syscall             # Commit 7: Exit Program

    .data
result_msg: .asciiz "Fibonacci sequence:\n"
newline:    .asciiz "\n"

