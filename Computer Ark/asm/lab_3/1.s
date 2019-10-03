.section .data
.section .text
.globl _start

_start:
	# Write your solution code here
	# push %rsp
	# movq %rsp, %rbp
	


# (%rsp) : num args
# 8(%rsp): first arg (program name)
# 16(%rsp): SECOND arg

	# jmp _start

	movq %rsp, %rax	
	movq 8(%rsp), %rax	

	pop %rsp
	pop %rax
	pop %rbp

	call printNum           # print the RAX register
	# Syscall exit
	movq $60, %rax            # rax: int syscall number
	movq $0, %rdi             # rdi: int error code
	syscall

