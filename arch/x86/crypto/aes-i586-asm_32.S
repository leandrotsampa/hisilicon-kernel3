

.file "aes-i586-asm.S"
.text

#include <linux/linkage.h>
#include <asm/asm-offsets.h>

#define tlen 1024   // length of each of 4 'xor' arrays (256 32-bit words)

/* offsets to parameters with one register pushed onto stack */
#define ctx 8
#define out_blk 12
#define in_blk 16

/* offsets in crypto_aes_ctx structure */
#define klen (480)
#define ekey (0)
#define dkey (240)


#define r0  eax
#define r1  ebx
#define r2  ecx
#define r3  edx
#define r4  esi
#define r5  edi

#define eaxl  al
#define eaxh  ah
#define ebxl  bl
#define ebxh  bh
#define ecxl  cl
#define ecxh  ch
#define edxl  dl
#define edxh  dh

#define _h(reg) reg##h
#define h(reg) _h(reg)

#define _l(reg) reg##l
#define l(reg) _l(reg)



#define do_col(table, a1,a2,a3,a4, idx, tmp)	\
	movzx   %l(idx),%tmp;			\
	xor     table(,%tmp,4),%a1;		\
	movzx   %h(idx),%tmp;			\
	shr     $16,%idx;			\
	xor     table+tlen(,%tmp,4),%a2;	\
	movzx   %l(idx),%tmp;			\
	movzx   %h(idx),%idx;			\
	xor     table+2*tlen(,%tmp,4),%a3;	\
	xor     table+3*tlen(,%idx,4),%a4;

#define do_fcol(table, a1,a2,a3,a4, idx, tmp, sched) \
	mov     0 sched,%a1;			\
	movzx   %l(idx),%tmp;			\
	mov     12 sched,%a2;			\
	xor     table(,%tmp,4),%a1;		\
	mov     4 sched,%a4;			\
	movzx   %h(idx),%tmp;			\
	shr     $16,%idx;			\
	xor     table+tlen(,%tmp,4),%a2;	\
	movzx   %l(idx),%tmp;			\
	movzx   %h(idx),%idx;			\
	xor     table+3*tlen(,%idx,4),%a4;	\
	mov     %a3,%idx;			\
	mov     8 sched,%a3;			\
	xor     table+2*tlen(,%tmp,4),%a3;

#define do_icol(table, a1,a2,a3,a4, idx, tmp, sched) \
	mov     0 sched,%a1;			\
	movzx   %l(idx),%tmp;			\
	mov     4 sched,%a2;			\
	xor     table(,%tmp,4),%a1;		\
	mov     12 sched,%a4;			\
	movzx   %h(idx),%tmp;			\
	shr     $16,%idx;			\
	xor     table+tlen(,%tmp,4),%a2;	\
	movzx   %l(idx),%tmp;			\
	movzx   %h(idx),%idx;			\
	xor     table+3*tlen(,%idx,4),%a4;	\
	mov     %a3,%idx;			\
	mov     8 sched,%a3;			\
	xor     table+2*tlen(,%tmp,4),%a3;


#define save(a1, a2)		\
	mov     %a2,4*a1(%esp)

#define restore(a1, a2)		\
	mov     4*a2(%esp),%a1


#define fwd_rnd1(arg, table)						\
	save   (0,r1);							\
	save   (1,r5);							\
									\
	/* compute new column values */					\
	do_fcol(table, r2,r5,r4,r1, r0,r3, arg);	/* idx=r0 */	\
	do_col (table, r4,r1,r2,r5, r0,r3);		/* idx=r4 */	\
	restore(r0,0);							\
	do_col (table, r1,r2,r5,r4, r0,r3);		/* idx=r1 */	\
	restore(r0,1);							\
	do_col (table, r5,r4,r1,r2, r0,r3);		/* idx=r5 */

#define fwd_rnd2(arg, table)						\
	save   (0,r1);							\
	save   (1,r5);							\
									\
	/* compute new column values */					\
	do_fcol(table, r0,r5,r4,r1, r2,r3, arg);	/* idx=r2 */	\
	do_col (table, r4,r1,r0,r5, r2,r3);		/* idx=r4 */	\
	restore(r2,0);							\
	do_col (table, r1,r0,r5,r4, r2,r3);		/* idx=r1 */	\
	restore(r2,1);							\
	do_col (table, r5,r4,r1,r0, r2,r3);		/* idx=r5 */


#define inv_rnd1(arg, table)						\
	save    (0,r1);							\
	save    (1,r5);							\
									\
	/* compute new column values */					\
	do_icol(table, r2,r1,r4,r5, r0,r3, arg);	/* idx=r0 */	\
	do_col (table, r4,r5,r2,r1, r0,r3);		/* idx=r4 */	\
	restore(r0,0);							\
	do_col (table, r1,r4,r5,r2, r0,r3);		/* idx=r1 */	\
	restore(r0,1);							\
	do_col (table, r5,r2,r1,r4, r0,r3);		/* idx=r5 */

#define inv_rnd2(arg, table)						\
	save    (0,r1);							\
	save    (1,r5);							\
									\
	/* compute new column values */					\
	do_icol(table, r0,r1,r4,r5, r2,r3, arg);	/* idx=r2 */	\
	do_col (table, r4,r5,r0,r1, r2,r3);		/* idx=r4 */	\
	restore(r2,0);							\
	do_col (table, r1,r4,r5,r0, r2,r3);		/* idx=r1 */	\
	restore(r2,1);							\
	do_col (table, r5,r0,r1,r4, r2,r3);		/* idx=r5 */

/* void aes_enc_blk(struct crypto_aes_ctx *ctx, u8 *out_blk, const u8 *in_blk) */

.extern  crypto_ft_tab
.extern  crypto_fl_tab

ENTRY(aes_enc_blk)
	push    %ebp
	mov     ctx(%esp),%ebp


1:	push    %ebx
	mov     in_blk+4(%esp),%r2
	push    %esi
	mov     klen(%ebp),%r3   // key size
	push    %edi
#if ekey != 0
	lea     ekey(%ebp),%ebp  // key pointer
#endif


	mov     (%r2),%r0
	mov     4(%r2),%r1
	mov     8(%r2),%r4
	mov     12(%r2),%r5
	xor     (%ebp),%r0
	xor     4(%ebp),%r1
	xor     8(%ebp),%r4
	xor     12(%ebp),%r5

	sub     $8,%esp	
	add     $16,%ebp
	cmp     $24,%r3
	jb      4f	
	lea     32(%ebp),%ebp
	je      3f	
	lea     32(%ebp),%ebp

2:	fwd_rnd1( -64(%ebp), crypto_ft_tab)
	fwd_rnd2( -48(%ebp), crypto_ft_tab)
3:	fwd_rnd1( -32(%ebp), crypto_ft_tab)
	fwd_rnd2( -16(%ebp), crypto_ft_tab)
4:	fwd_rnd1(    (%ebp), crypto_ft_tab)
	fwd_rnd2( +16(%ebp), crypto_ft_tab)
	fwd_rnd1( +32(%ebp), crypto_ft_tab)
	fwd_rnd2( +48(%ebp), crypto_ft_tab)
	fwd_rnd1( +64(%ebp), crypto_ft_tab)
	fwd_rnd2( +80(%ebp), crypto_ft_tab)
	fwd_rnd1( +96(%ebp), crypto_ft_tab)
	fwd_rnd2(+112(%ebp), crypto_ft_tab)
	fwd_rnd1(+128(%ebp), crypto_ft_tab)
	fwd_rnd2(+144(%ebp), crypto_fl_tab)


	add     $8,%esp
	mov     out_blk+12(%esp),%ebp
	mov     %r5,12(%ebp)
	pop     %edi
	mov     %r4,8(%ebp)
	pop     %esi
	mov     %r1,4(%ebp)
	pop     %ebx
	mov     %r0,(%ebp)
	pop     %ebp
	ret
ENDPROC(aes_enc_blk)

/* void aes_dec_blk(struct crypto_aes_ctx *ctx, u8 *out_blk, const u8 *in_blk) */

.extern  crypto_it_tab
.extern  crypto_il_tab

ENTRY(aes_dec_blk)
	push    %ebp
	mov     ctx(%esp),%ebp


1:	push    %ebx
	mov     in_blk+4(%esp),%r2
	push    %esi
	mov     klen(%ebp),%r3   // key size
	push    %edi
#if dkey != 0
	lea     dkey(%ebp),%ebp  // key pointer
#endif
	

	mov     (%r2),%r0
	mov     4(%r2),%r1
	mov     8(%r2),%r4
	mov     12(%r2),%r5
	xor     (%ebp),%r0
	xor     4(%ebp),%r1
	xor     8(%ebp),%r4
	xor     12(%ebp),%r5

	sub     $8,%esp	
	add     $16,%ebp
	cmp     $24,%r3
	jb      4f	
	lea     32(%ebp),%ebp
	je      3f	
	lea     32(%ebp),%ebp

2:	inv_rnd1( -64(%ebp), crypto_it_tab)
	inv_rnd2( -48(%ebp), crypto_it_tab)
3:	inv_rnd1( -32(%ebp), crypto_it_tab)
	inv_rnd2( -16(%ebp), crypto_it_tab)
4:	inv_rnd1(    (%ebp), crypto_it_tab)
	inv_rnd2( +16(%ebp), crypto_it_tab)
	inv_rnd1( +32(%ebp), crypto_it_tab)
	inv_rnd2( +48(%ebp), crypto_it_tab)
	inv_rnd1( +64(%ebp), crypto_it_tab)
	inv_rnd2( +80(%ebp), crypto_it_tab)
	inv_rnd1( +96(%ebp), crypto_it_tab)
	inv_rnd2(+112(%ebp), crypto_it_tab)
	inv_rnd1(+128(%ebp), crypto_it_tab)
	inv_rnd2(+144(%ebp), crypto_il_tab)


	add     $8,%esp
	mov     out_blk+12(%esp),%ebp
	mov     %r5,12(%ebp)
	pop     %edi
	mov     %r4,8(%ebp)
	pop     %esi
	mov     %r1,4(%ebp)
	pop     %ebx
	mov     %r0,(%ebp)
	pop     %ebp
	ret
ENDPROC(aes_dec_blk)
