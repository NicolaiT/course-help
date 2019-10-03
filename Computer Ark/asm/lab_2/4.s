.section .data
hello: .ascii "Hello World!\n"
.section .text
.globl _start

number:
	.quad 0 # int number = 0
numArgs:
	.quad 0 # int numArgs = 0

_start:
	# Write your solution code here
	movq %rsp, %rbp
	push %rbp
	push %rbp
	push %rbp
	push %rbp

	movq number(%rbp), %rax

	addq $8, number
# (%rbp) : num args
# 8(%rbp): first arg (program name)
# 16(%rbp): SECOND arg 

# Count numArgs

# Pseudo-code 
# Get the ASCII address from 8(%rbp)
# Count the address length
# Syscall the address

loopstart:
	movb (%rax, %r8), %bl
	addq $1, %r8
	cmp $0, %bl
	jne loopstart

loopend:

	movq $1, %rax
	movq $1, %rdi
	movq 8(%rbp), %rsi
	movq %r8, %rdx
	syscall # prints out "Hello World!"

	pop %rsp

	# Syscall exit
	movq $60, %rax            # rax: int syscall number
	movq $0, %rdi             # rdi: int error code
	syscall




# Prints the contents of rax.
.type print_rax, @function   # This is for debugging
print_rax:
	# function prolog
	push %rbp
	movq %rsp, %rbp

	# saving registers the registers on the stack
	push %rax
	push %rcx
	push %rdx
	push %rdi
	push %rsi
	push %r9

	movq $6, %r9           # we always print the 6 characters "RAX: \n"
	push $10               # put '\n' on the stack

loop1:
	movq $0, %rdx
	movq $10, %rcx
	idivq %rcx             # idiv alwas divides rdx:rax/operand
						   # result is in rax, remainder in rdx
	addq $48, %rdx         # add 48 to remainder to get corresponding ASCII
	push %rdx              # save our first ASCII char on the stack
	addq $1, %r9           # counter
	# loop until rax = 0
	cmpq $0, %rax   
	jne loop1

	# and then push the prefix of our output
	movq $0x20, %rax       # ' '
	push %rax
	movq $0x3a, %rax       # ':'
	push %rax
	movq $0x58, %rax       # 'X'
	push %rax
	movq $0x41, %rax       # 'A"
	push %rax
	movq $0x52, %rax       # 'R'
	push %rax

print_loop:
	movq $1, %rax          # Here we make a syscall. 1 in rax designates a sys_write
	movq $1, %rdi          # rdx: int file descriptor (1 is stdout)
	movq %rsp, %rsi        # rsi: char* buffer (rsp points to the current char to write)
	movq $1, %rdx          # rdx: size_t count (we write one char at a time)
	syscall                # instruction making the syscall
	addq $8, %rsp          # set stack pointer to next char
	addq $-1, %r9
	jne print_loop

	# restore the previously saved registers
	pop %r9
	pop %rsi
	pop %rdi
	pop %rdx
	pop %rcx
	pop %rax

	# function epilog
	movq %rbp, %rsp
	pop %rbp
	ret
