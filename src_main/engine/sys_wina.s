//
// sys_wina.s
// x86 assembly-language Win-dependent routines.

#define GLQUAKE	1	// don't include unneeded defs
#include "asm_i386.h"
#include "quakeasm.h"

// LATER should be id386-dependent, and have an equivalent C path

	.data

	.align	4
fpenv:
	.long	0, 0, 0, 0, 0, 0, 0, 0

	.text

.globl C(MaskExceptions)
C(MaskExceptions):
	fnstenv	fpenv
	orl		$0x3F,fpenv
	fldenv	fpenv

	ret

#if 0
.globl C(unmaskexceptions)
C(unmaskexceptions):
	fnstenv	fpenv
	andl		$0xFFFFFFE0,fpenv
	fldenv	fpenv

	ret
#endif

	.data

	.align	4
.globl	ceil_cw, single_cw, full_cw, cw, pushed_cw, highchop_cw, temp_cw
ceil_cw:	.long	0
single_cw:	.long	0
full_cw:	.long	0
highchop_cw:	.long	0
cw:			.long	0
pushed_cw:	.long	0
temp_cw:	.long	0

	.text

.globl C(Sys_LowFPPrecision)
C(Sys_LowFPPrecision):
	fldcw	single_cw

	ret

.globl C(Sys_HighFPPrecision)
C(Sys_HighFPPrecision):
	fldcw	highchop_cw

	ret

.globl C(Sys_PushFPCW_SetHigh)
C(Sys_PushFPCW_SetHigh):
	fnstcw	pushed_cw
	fldcw	full_cw

	ret

.globl C(Sys_PopFPCW)
C(Sys_PopFPCW):
	fldcw	pushed_cw

	ret

.globl C(Sys_SetFPCW)
C(Sys_SetFPCW):
	fnstcw	cw
	movl	cw,%eax
#if	id386
	andb	$0xF0,%ah
	orb		$0x03,%ah	// round mode, 64-bit precision
#endif
	movl	%eax,full_cw
#if id386
//	orb		$0x0F,%ah
#endif
	movl	%eax, highchop_cw

#if	id386
	andb	$0xF0,%ah
	orb		$0x0C,%ah	// chop mode, single precision
#endif
	movl	%eax,single_cw

#if	id386
	andb	$0xF0,%ah
	orb		$0x08,%ah	// ceil mode, single precision
#endif
	movl	%eax,ceil_cw

	ret


.globl C(Sys_TruncateFPU)
C(Sys_TruncateFPU):

// This is disabled for now until we figure out how to make this work with the optimizer
#if id386
//	fnstcw	temp_cw
//	movl	temp_cw, %eax
//	orb		$0x0C, %ah
//	movl	%eax, temp_cw
//	fldcw	temp_cw
#endif

	ret
	