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
	cmp $10, %bl
	jne loopstart

loopend:
	
	movq %r8, %rdi

	call printNum           # print the RAX register
	# Syscall exit
	movq $60, %rax            # rax: int syscall number
	movq $0, %rdi             # rdi: int error code
	syscall

