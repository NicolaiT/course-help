.section .data
hello: .ascii "Hello World!\n"
.section .text
.globl _start

_start:
	# Write your solution code here
	
	movq $hello, %rax
loopstart:
	movb (%rax, %r8), %bl
	addq $1, %r8
	cmp $0, %bl
	jne loopstart

loopend:
	
	
	movq $1, %rax
	movq $1, %rdi
	movq $hello, %rsi
	movq %r8, %rdx # Moves the length to rdx
	syscall # prints out "Hello World!"

	# Syscall exit
	movq $60, %rax            # rax: int syscall number
	movq $0, %rdi             # rdi: int error code
	syscall
