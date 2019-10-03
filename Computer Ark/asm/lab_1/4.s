.section .data
.section .text
.globl _start

zero:
	.quad 0 # int zero = 0

three:
	.quad 3 # int three = 3

five:
	.quad 5 # int five = 5

_start:
	movq $42, %rcx # assign 42 to RCX register

if: # if (RBX % 3 == 0)
	addq $1, %rsi # RSI += 1
	movq %rsi, %rax # RAX = RSI
	cqto
	idivq three # RAX/3. Remainder is in RDX register
	cmpq %rdx, zero 
	je divisible # jump to divisible if RDX == 0 

elseif: # else if (RBX % 5 == 0)
	movq %rsi, %rax
	cqto
	idivq five # rbx/5. Remainder is in RDX register
	cmpq %rdx, zero 
	je divisible # jump to divisible if RDX == 0

else:
	cmpq %rsi, %rcx
	jne if # jump if RSI != 42 
	jmp end # else jump to end

divisible:
	addq %rsi, %r9 # add divisible value to r9
	cmpq %rsi, %rcx
	jne if # jump if RBX != 42, else continue to end

end:
	movq %r9, %rax 	# move final result to RAX

	call print_rax            # print the RAX register
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
