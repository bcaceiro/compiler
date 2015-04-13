	.file	"out.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp3:
	.cfi_def_cfa_offset 16
.Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp5:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Ltmp6:
	.cfi_offset %rbx, -24
	movb	$0, -13(%rbp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB0_12
# BB#1:                                 # %and.do0
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rax
	movq	%rax, %rsp
	movb	$1, -16(%rcx)
	xorl	%ecx, %ecx
	testb	%cl, %cl
	jne	.LBB0_3
# BB#2:                                 # %and.do1
	movb	$1, (%rax)
.LBB0_3:                                # %and.end1
	movb	(%rax), %cl
	movq	%rsp, %rdx
	leaq	-16(%rdx), %rax
	movq	%rax, %rsp
	movb	%cl, -16(%rdx)
	testb	%cl, %cl
	je	.LBB0_7
# BB#4:                                 # %and.do2
	movq	%rsp, %rdx
	leaq	-16(%rdx), %rcx
	movq	%rcx, %rsp
	movb	$1, -16(%rdx)
	xorl	%edx, %edx
	testb	%dl, %dl
	jne	.LBB0_6
# BB#5:                                 # %and.do3
	movb	$0, (%rcx)
.LBB0_6:                                # %and.end3
	movb	(%rcx), %cl
	notb	%cl
	andb	$1, %cl
	movb	%cl, (%rax)
.LBB0_7:                                # %and.end2
	movb	(%rax), %cl
	movq	%rsp, %rdx
	leaq	-16(%rdx), %rax
	movq	%rax, %rsp
	movb	%cl, -16(%rdx)
	testb	%cl, %cl
	je	.LBB0_9
# BB#8:                                 # %and.do4
	movb	$1, (%rax)
.LBB0_9:                                # %and.end4
	movb	(%rax), %al
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rbx
	movq	%rbx, %rsp
	movb	%al, -16(%rcx)
	testb	%al, %al
	je	.LBB0_11
# BB#10:                                # %and.do5
	callq	test2
	andb	$1, %al
	movb	%al, (%rbx)
.LBB0_11:                               # %and.end5
	movb	(%rbx), %al
	movb	%al, -13(%rbp)
.LBB0_12:                               # %and.end0
	cmpb	$1, -13(%rbp)
	jne	.LBB0_14
# BB#13:                                # %if.do6
	movl	$.L.printInt, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf
.LBB0_14:                               # %if.end6
	movl	$-1, -12(%rbp)
	movl	$.L.printInt, %edi
	movl	$-1, %esi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	leaq	-8(%rbp), %rsp
	popq	%rbx
	popq	%rbp
	ret
.Ltmp7:
	.size	main, .Ltmp7-main
	.cfi_endproc

	.globl	test1
	.align	16, 0x90
	.type	test1,@function
test1:                                  # @test1
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp10:
	.cfi_def_cfa_offset 16
.Ltmp11:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp12:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movb	$1, -1(%rbp)
	movb	$0, -2(%rbp)
	movb	-1(%rbp), %al
	movb	%al, -3(%rbp)
	testb	%al, %al
	jne	.LBB1_6
# BB#1:                                 # %and.do7
	movb	-2(%rbp), %cl
	movq	%rsp, %rdx
	leaq	-16(%rdx), %rax
	movq	%rax, %rsp
	movb	%cl, -16(%rdx)
	testb	%cl, %cl
	je	.LBB1_3
# BB#2:                                 # %and.do8
	movb	-1(%rbp), %cl
	movb	%cl, (%rax)
.LBB1_3:                                # %and.end8
	movb	(%rax), %cl
	movq	%rsp, %rdx
	leaq	-16(%rdx), %rax
	movq	%rax, %rsp
	movb	%cl, -16(%rdx)
	testb	%cl, %cl
	je	.LBB1_5
# BB#4:                                 # %and.do9
	movb	-2(%rbp), %cl
	movb	%cl, (%rax)
.LBB1_5:                                # %and.end9
	movb	(%rax), %al
	movb	%al, -3(%rbp)
.LBB1_6:                                # %and.end7
	movb	-3(%rbp), %al
	movq	%rbp, %rsp
	popq	%rbp
	ret
.Ltmp13:
	.size	test1, .Ltmp13-test1
	.cfi_endproc

	.globl	test2
	.align	16, 0x90
	.type	test2,@function
test2:                                  # @test2
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp15:
	.cfi_def_cfa_offset 16
	movq	.L.printBool+8(%rip), %rdi
	xorl	%eax, %eax
	callq	printf
	movb	$1, %al
	popq	%rdx
	ret
.Ltmp16:
	.size	test2, .Ltmp16-test2
	.cfi_endproc

	.type	.L.printInt,@object     # @.printInt
	.section	.rodata,"a",@progbits
.L.printInt:
	.asciz	"%d\n"
	.size	.L.printInt, 4

	.type	.L.true,@object         # @.true
.L.true:
	.asciz	"true\n"
	.size	.L.true, 6

	.type	.L.false,@object        # @.false
.L.false:
	.asciz	"false\n"
	.size	.L.false, 7

	.type	.L.printBool,@object    # @.printBool
	.align	8
.L.printBool:
	.quad	.L.false
	.quad	.L.true
	.size	.L.printBool, 16


	.section	".note.GNU-stack","",@progbits
