	.file "/home/phil/Projects/phoenix/firmware/program/display.c"
	.section	.text,code
	.file "/home/phil/Projects/phoenix/firmware/program/display.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdbool.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdint.h"
	.def	_int8_t
	.scl	13
	.type	02
	.endef
	.def	_int16_t
	.scl	13
	.type	04
	.endef
	.def	_int32_t
	.scl	13
	.type	05
	.endef
	.def	_int64_t
	.scl	13
	.type	05
	.endef
	.def	_uint8_t
	.scl	13
	.type	014
	.endef
	.def	_uint16_t
	.scl	13
	.type	016
	.endef
	.def	_uint32_t
	.scl	13
	.type	017
	.endef
	.def	_uint64_t
	.scl	13
	.type	017
	.endef
	.def	_int_least8_t
	.scl	13
	.type	02
	.endef
	.def	_int_least16_t
	.scl	13
	.type	04
	.endef
	.def	_int_least24_t
	.scl	13
	.type	05
	.endef
	.def	_int_least32_t
	.scl	13
	.type	05
	.endef
	.def	_int_least64_t
	.scl	13
	.type	05
	.endef
	.def	_uint_least8_t
	.scl	13
	.type	014
	.endef
	.def	_uint_least16_t
	.scl	13
	.type	016
	.endef
	.def	_uint_least24_t
	.scl	13
	.type	05
	.endef
	.def	_uint_least32_t
	.scl	13
	.type	017
	.endef
	.def	_uint_least64_t
	.scl	13
	.type	017
	.endef
	.def	_int_fast8_t
	.scl	13
	.type	04
	.endef
	.def	_int_fast16_t
	.scl	13
	.type	04
	.endef
	.def	_int_fast24_t
	.scl	13
	.type	05
	.endef
	.def	_int_fast32_t
	.scl	13
	.type	05
	.endef
	.def	_int_fast64_t
	.scl	13
	.type	05
	.endef
	.def	_uint_fast8_t
	.scl	13
	.type	016
	.endef
	.def	_uint_fast16_t
	.scl	13
	.type	016
	.endef
	.def	_uint_fast24_t
	.scl	13
	.type	017
	.endef
	.def	_uint_fast32_t
	.scl	13
	.type	017
	.endef
	.def	_uint_fast64_t
	.scl	13
	.type	017
	.endef
	.def	_intmax_t
	.scl	13
	.type	05
	.endef
	.def	_uintmax_t
	.scl	13
	.type	017
	.endef
	.file "/home/phil/Projects/phoenix/firmware/program/font.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdint.h"
	.def	_GLYPH_DATA
	.scl	10
	.type	010
	.size	4
	.endef
	.def	_width
	.val	0
	.scl	8
	.type	014
	.endef
	.def	_pages
	.val	1
	.scl	8
	.type	014
	.endef
	.def	_index
	.val	2
	.scl	8
	.type	016
	.endef
	.def	.eos
	.val	4
	.scl	102
	.tag	_GLYPH_DATA
	.size	4
	.endef
	.def	_FONT
	.scl	10
	.type	010
	.size	8
	.endef
	.def	_advance
	.val	0
	.scl	8
	.type	014
	.endef
	.def	_max_pages
	.val	1
	.scl	8
	.type	014
	.endef
	.def	_max_width
	.val	2
	.scl	8
	.type	014
	.endef
	.def	_indices
	.val	4
	.scl	8
	.tag	_GLYPH_DATA
	.size	4
	.type	030
	.endef
	.def	_bitmaps
	.val	6
	.scl	8
	.type	022
	.endef
	.def	.eos
	.val	8
	.scl	102
	.tag	_FONT
	.size	8
	.endef
	.file "/home/phil/Projects/phoenix/firmware/program/i2c_util.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdint.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../support/generic/h/libpic30.h"
	.def	__prog_addressT
	.scl	13
	.type	017
	.endef
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/string.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stddef.h"
	.def	_ptrdiff_t
	.scl	13
	.type	04
	.endef
	.def	_size_t
	.scl	13
	.type	016
	.endef
	.def	_wchar_t
	.scl	13
	.type	015
	.endef
	.section	.nbss,bss,near
	.global	_buffer
_buffer:	.space	1024
	.global	_top_page	; export
	.align	2
_top_page:
	.skip	2
	.global	_display_inverted	; export
_display_inverted:
	.skip	1
	.global	_cur_column	; export
	.align	2
_cur_column:
	.skip	2
	.global	_cur_page	; export
	.align	2
_cur_page:
	.skip	2
	.section	.text,code
	.align	2
	.def	_send1
	.val	_send1
	.scl	2
	.type	042
	.endef
	.global	_send1	; export
_send1:
	.def	.bf
	.val	.
	.scl	101
	.line	19
	.endef
	.def	_command
	.val	0
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	19
	.endef
	.set ___PA___,1
	lnk	#2
	mov.b	w0,[w14]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	20
	mov.b	#1,w3
	mov	w14,w2
	clr.b	w1
	mov.b	#60,w0
	rcall	_write_i2c_command_block
	.ln	21
	mov.b	w4,w0
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	21
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	21
	.endef
	.def	_send1
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_send2
	.val	_send2
	.scl	2
	.type	042
	.endef
	.global	_send2	; export
_send2:
	.def	.bf
	.val	.
	.scl	101
	.line	23
	.endef
	.def	_command
	.val	2
	.scl	9
	.type	014
	.endef
	.def	_data
	.val	3
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	23
	.endef
	.def	_both_bytes
	.val	0
	.scl	1
	.dim	2
	.size	2
	.type	074
	.endef
	.set ___PA___,1
	lnk	#4
	mov.b	w0,[w14+2]
	mov.b	w1,[w14+3]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	25
	mov.b	[w14+2],w4
	mov.b	w4,[w14]
	.ln	26
	mov.b	[w14+3],w4
	mov.b	w4,[w14+1]
	.ln	27
	mov.b	#2,w3
	mov	w14,w2
	clr.b	w1
	mov.b	#60,w0
	rcall	_write_i2c_command_block
	mov.b	w0,w4
	.ln	28
	mov.b	w4,w0
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	28
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	28
	.endef
	.def	_send2
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_init
	.val	_display_init
	.scl	2
	.type	041
	.endef
	.global	_display_init	; export
_display_init:
	.def	.bf
	.val	.
	.scl	101
	.line	30
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	30
	.endef
	.set ___PA___,1
	lnk	#0
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	32
	mov.b	#-83,w0
	rcall	_send1
	.ln	33
	mov.b	#-117,w0
	rcall	_send1
	.ln	34
	mov	#4608,w0
	mov	#122,w1
	rcall	___delay32
	.ln	35
	mov.b	#63,w1
	mov.b	#-88,w0
	rcall	_send2
	.ln	36
	mov.b	#80,w1
	mov.b	#-43,w0
	rcall	_send2
	.ln	37
	mov.b	#18,w1
	mov.b	#-38,w0
	rcall	_send2
	.ln	38
	mov.b	#-81,w0
	rcall	_send1
	.ln	39
	mov.b	#-96,w0
	rcall	_send1
	.ln	40
	mov.b	#-64,w0
	rcall	_send1
	.ln	41
	setm.b	w0
	rcall	_display_set_brightness
	.ln	42
	clr.b	w1
	mov.b	#-45,w0
	rcall	_send2
	.ln	43
	mov.b	#-90,w0
	rcall	_send1
	.ln	44
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	44
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	44
	.endef
	.def	_display_init
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_close
	.val	_display_close
	.scl	2
	.type	041
	.endef
	.global	_display_close	; export
_display_close:
	.def	.bf
	.val	.
	.scl	101
	.line	46
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	46
	.endef
	.set ___PA___,1
	lnk	#0
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	47
	mov.b	#-82,w0
	rcall	_send1
	.ln	48
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	48
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	48
	.endef
	.def	_display_close
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_send_data
	.val	_display_send_data
	.scl	2
	.type	041
	.endef
	.global	_display_send_data	; export
_display_send_data:
	.def	.bf
	.val	.
	.scl	101
	.line	50
	.endef
	.def	_data
	.val	0
	.scl	9
	.type	034
	.endef
	.def	_length
	.val	2
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	50
	.endef
	.set ___PA___,1
	lnk	#4
	mov	w0,[w14]
	mov.b	w1,[w14+2]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	51
	mov.b	[w14+2],w4
	ze	w4,w5
	mov	_cur_page,w4
	sl	w4,#7,w6
	mov	_cur_column,w4
	add	w6,w4,w6
	mov	#_buffer,w4
	add	w6,w4,w4
	mov	w5,w2
	mov	[w14],w1
	mov	w4,w0
	rcall	_memcpy
	.ln	52
	mov.b	[w14+2],w3
	mov	[w14],w2
	mov.b	#64,w1
	mov.b	#60,w0
	rcall	_write_i2c_command_block
	.ln	53
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	53
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	53
	.endef
	.def	_display_send_data
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_set_page
	.val	_set_page
	.scl	2
	.type	041
	.endef
	.global	_set_page	; export
_set_page:
	.def	.bf
	.val	.
	.scl	101
	.line	55
	.endef
	.def	_page
	.val	0
	.scl	9
	.type	04
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	55
	.endef
	.set ___PA___,1
	lnk	#2
	mov	w0,[w14]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	56
	mov	[w14],w4
	mov.b	w4,w5
	mov.b	#-80,w4
	add.b	w5,w4,w4
	mov.b	w4,w0
	rcall	_send1
	.ln	57
	mov	[w14],w4
	mov	w4,_cur_page
	.ln	58
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	58
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	58
	.endef
	.def	_set_page
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_set_column
	.val	_set_column
	.scl	2
	.type	041
	.endef
	.global	_set_column	; export
_set_column:
	.def	.bf
	.val	.
	.scl	101
	.line	60
	.endef
	.def	_column
	.val	0
	.scl	9
	.type	04
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	60
	.endef
	.set ___PA___,1
	lnk	#2
	mov	w0,[w14]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	61
	inc2	[w14],w5
	mov	#16,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov.b	w4,w4
	mov.b	w4,w0
	rcall	_send1
	.ln	62
	inc2	[w14],w5
	mov	#16,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w0,w4
	mov.b	w4,w4
	add.b	w4,#16,w4
	mov.b	w4,w0
	rcall	_send1
	.ln	63
	mov	[w14],w4
	mov	w4,_cur_column
	.ln	64
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	64
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	64
	.endef
	.def	_set_column
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_clear_screen
	.val	_display_clear_screen
	.scl	2
	.type	041
	.endef
	.global	_display_clear_screen	; export
_display_clear_screen:
	.def	.bf
	.val	.
	.scl	101
	.line	65
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	65
	.endef
	.def	_x
	.val	0
	.scl	1
	.type	04
	.endef
	.set ___PA___,1
	lnk	#2
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	66
	clr	w4
	mov	w4,[w14]
	.ln	67
	mov	#1024,w2
	clr	w1
	mov	#_buffer,w0
	rcall	_memset
	.ln	68
	clr	w4
	mov	w4,[w14]
	bra	.L9
.L10:
	.ln	69
	clr	w0
	rcall	_set_column
	.ln	70
	mov	[w14],w0
	rcall	_set_page
	.ln	71
	mov	#_buffer,w4
	mov.b	#-128,w3
	mov	w4,w2
	mov.b	#64,w1
	mov.b	#60,w0
	rcall	_write_i2c_command_block
	.ln	68
	inc	[w14],[w14]
.L9:
	mov	[w14],w4
	sub	w4,#7,[w15]
	.set ___BP___,0
	bra	le,.L10
	.ln	73
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	73
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	73
	.endef
	.def	_display_clear_screen
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_write_text
	.val	_display_write_text
	.scl	2
	.type	041
	.endef
	.global	_display_write_text	; export
_display_write_text:
	.def	.bf
	.val	.
	.scl	101
	.line	75
	.endef
	.def	_page
	.val	132
	.scl	9
	.type	04
	.endef
	.def	_column
	.val	134
	.scl	9
	.type	04
	.endef
	.def	_text
	.val	136
	.scl	9
	.type	022
	.endef
	.def	_font
	.val	138
	.scl	9
	.tag	_FONT
	.size	8
	.type	030
	.endef
	.def	_right_justify
	.val	140
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	75
	.endef
	.def	_i
	.val	0
	.scl	1
	.type	04
	.endef
	.def	_end_col
	.val	2
	.scl	1
	.type	04
	.endef
	.def	_temp_buffer
	.val	4
	.scl	1
	.dim	128
	.size	128
	.type	074
	.endef
	.set ___PA___,1
	lnk	#142
	mov	w0,[w14+132]
	mov	w1,[w14+134]
	mov	w2,[w14+136]
	mov	w3,[w14+138]
	mov.b	w4,[w14+140]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	76
	clr	w4
	mov	w4,[w14]
	.ln	79
	bra	.L12
.L17:
	.ln	80
	add	w14,#4,w4
	mov	#128,w2
	clr	w1
	mov	w4,w0
	rcall	_memset
	.ln	81
	mov	[w14+132],w4
	add	w4,[w14],w4
	mov	w4,w0
	rcall	_set_page
	.ln	82
	mov.b	[w14+140],w4
	sub.b	w4,#0,[w15]
	.set ___BP___,0
	bra	z,.L13
	.ln	83
	add	w14,#4,w5
	mov	[w14+138],w4
	mov	[w14+136],w3
	clr	w2
	mov	[w14],w1
	mov	w5,w0
	rcall	_render_text_to_page
	mov	w0,w4
	mov	w4,[w14+2]
	.ln	84
	mov	[w14+2],w5
	mov	[w14+134],w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	le,.L14
	.ln	85
	clr	w0
	rcall	_set_column
	bra	.L15
.L14:
	.ln	87
	mov	[w14+134],w5
	mov	[w14+2],w4
	sub	w5,w4,w4
	mov	w4,w0
	rcall	_set_column
.L15:
	.ln	89
	mov	[w14+2],w4
	mov.b	w4,w4
	add	w14,#4,w5
	mov.b	w4,w1
	mov	w5,w0
	rcall	_display_send_data
	bra	.L16
.L13:
	.ln	91
	add	w14,#4,w5
	mov	[w14+138],w4
	mov	[w14+136],w3
	mov	[w14+134],w2
	mov	[w14],w1
	mov	w5,w0
	rcall	_render_text_to_page
	mov	w0,w4
	mov	w4,[w14+2]
	.ln	92
	mov	[w14+134],w0
	rcall	_set_column
	.ln	93
	mov	[w14+2],w4
	mov.b	w4,w5
	mov	[w14+134],w4
	mov.b	w4,w4
	sub.b	w5,w4,w4
	mov	[w14+134],w5
	add	w14,#4,w6
	add	w6,w5,w5
	mov.b	w4,w1
	mov	w5,w0
	rcall	_display_send_data
.L16:
	.ln	95
	inc	[w14],[w14]
.L12:
	.ln	79
	mov	[w14+138],w4
	mov.b	[w4+1],w4
	ze	w4,w4
	sub	w4,[w14],[w15]
	.set ___BP___,0
	bra	gt,.L17
	.ln	97
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	97
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	97
	.endef
	.def	_display_write_text
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_scroll_page
	.val	_display_scroll_page
	.scl	2
	.type	041
	.endef
	.global	_display_scroll_page	; export
_display_scroll_page:
	.def	.bf
	.val	.
	.scl	101
	.line	101
	.endef
	.def	_data
	.val	134
	.scl	9
	.type	034
	.endef
	.def	_up
	.val	136
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	101
	.endef
	.def	_i
	.val	0
	.scl	1
	.type	04
	.endef
	.def	_j
	.val	2
	.scl	1
	.type	04
	.endef
	.def	_mask
	.val	4
	.scl	1
	.type	014
	.endef
	.def	_temp_buffer
	.val	5
	.scl	1
	.dim	128
	.size	128
	.type	074
	.endef
	.set ___PA___,1
	lnk	#138
	mov	w0,[w14+134]
	mov.b	w1,[w14+136]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	106
	add	w14,#5,w4
	mov	#128,w2
	clr	w1
	mov	w4,w0
	rcall	_memset
	.ln	107
	mov.b	[w14+136],w4
	sub.b	w4,#0,[w15]
	.set ___BP___,0
	bra	z,.L19
	.ln	108
	mov	_top_page,w4
	mov	w4,w0
	rcall	_set_page
	.ln	109
	clr	w0
	rcall	_set_column
	.ln	110
	add	w14,#5,w4
	mov.b	#-128,w1
	mov	w4,w0
	rcall	_display_send_data
	.ln	112
	clr	w4
	mov	w4,[w14]
	bra	.L20
.L23:
	.ln	113
	mov	_top_page,w4
	sl	w4,#3,w4
	add	w4,[w14],w4
	inc	w4,w5
	mov	#64,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov.b	w4,w4
	mov.b	w4,w1
	mov.b	#-45,w0
	rcall	_send2
	.ln	114
	clr	w0
	rcall	_set_column
	.ln	115
	inc	[w14],w4
	mov	#1,w5
	sl	w5,w4,w4
	mov.b	w4,w4
	dec.b	w4,w4
	mov.b	w4,[w14+4]
	.ln	116
	clr	w4
	mov	w4,[w14+2]
	bra	.L21
.L22:
	.ln	117
	mov	[w14],w4
	mov	[w14+134],w5
	add	w5,w4,w4
	mov.b	[w4],w5
	mov.b	[w14+4],w4
	and.b	w5,w4,w4
	add	w14,#5,w5
	add	w5,[w14],w5
	mov.b	w4,[w5]
	.ln	116
	mov	[w14+2],w4
	inc	w4,w4
	mov	w4,[w14+2]
.L21:
	mov	[w14+2],w5
	mov	#127,w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	le,.L22
	.ln	119
	add	w14,#5,w4
	mov.b	#-128,w1
	mov	w4,w0
	rcall	_display_send_data
	.ln	120
	mul.uu	w0,#0,w0
	rcall	___delay32
	.ln	112
	inc	[w14],[w14]
.L20:
	mov	[w14],w4
	sub	w4,#7,[w15]
	.set ___BP___,0
	bra	le,.L23
	.ln	122
	mov	_top_page,w4
	inc	w4,w5
	mov	#8,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov	w4,_top_page
	bra	.L24
.L19:
	.ln	124
	mov	_top_page,w4
	add	w4,#7,w5
	mov	#8,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov	w4,w0
	rcall	_set_page
	.ln	125
	clr	w0
	rcall	_set_column
	.ln	126
	add	w14,#5,w4
	mov.b	#-128,w1
	mov	w4,w0
	rcall	_display_send_data
	.ln	128
	clr	w4
	mov	w4,[w14]
	bra	.L25
.L28:
	.ln	129
	mov	_top_page,w4
	sl	w4,#3,w5
	com	[w14],w4
	add	w5,w4,w5
	mov	#64,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov.b	w4,w4
	mov.b	w4,w1
	mov.b	#-45,w0
	rcall	_send2
	.ln	130
	clr	w0
	rcall	_set_column
	.ln	131
	mov	#8,w5
	sub	w5,[w14],w4
	mov	#1,w5
	sl	w5,w4,w4
	mov.b	w4,w4
	neg.b	w4,w4
	mov.b	w4,[w14+4]
	.ln	132
	clr	w4
	mov	w4,[w14+2]
	bra	.L26
.L27:
	.ln	133
	mov	[w14],w4
	mov	[w14+134],w5
	add	w5,w4,w4
	mov.b	[w4],w5
	mov.b	[w14+4],w4
	and.b	w5,w4,w4
	add	w14,#5,w5
	add	w5,[w14],w5
	mov.b	w4,[w5]
	.ln	132
	mov	[w14+2],w4
	inc	w4,w4
	mov	w4,[w14+2]
.L26:
	mov	[w14+2],w5
	mov	#127,w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	le,.L27
	.ln	135
	add	w14,#5,w4
	mov.b	#-128,w1
	mov	w4,w0
	rcall	_display_send_data
	.ln	136
	mul.uu	w0,#0,w0
	rcall	___delay32
	.ln	128
	inc	[w14],[w14]
.L25:
	mov	[w14],w4
	sub	w4,#7,[w15]
	.set ___BP___,0
	bra	le,.L28
	.ln	138
	mov	_top_page,w4
	add	w4,#7,w5
	mov	#8,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov	w4,_top_page
.L24:
	.ln	140
	clr	w0
	rcall	_set_column
	.ln	141
	mov.b	#-128,w1
	mov	[w14+134],w0
	rcall	_display_send_data
	.ln	142
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	142
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	142
	.endef
	.def	_display_scroll_page
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_render_text_to_page
	.val	_render_text_to_page
	.scl	2
	.type	044
	.endef
	.global	_render_text_to_page	; export
_render_text_to_page:
	.def	.bf
	.val	.
	.scl	101
	.line	148
	.endef
	.def	_buffer
	.val	4
	.scl	9
	.type	034
	.endef
	.def	_page
	.val	6
	.scl	9
	.type	04
	.endef
	.def	_column
	.val	8
	.scl	9
	.type	04
	.endef
	.def	_text
	.val	10
	.scl	9
	.type	022
	.endef
	.def	_font
	.val	12
	.scl	9
	.tag	_FONT
	.size	8
	.type	030
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	148
	.endef
	.def	_i
	.val	0
	.scl	1
	.type	04
	.endef
	.def	_glyph
	.val	2
	.scl	1
	.tag	_GLYPH_DATA
	.size	4
	.type	030
	.endef
	.set ___PA___,1
	lnk	#14
	mov	w0,[w14+4]
	mov	w1,[w14+6]
	mov	w2,[w14+8]
	mov	w3,[w14+10]
	mov	w4,[w14+12]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	151
	bra	.L30
.L35:
	.ln	152
	clr	w4
	mov	w4,[w14]
	.ln	153
	mov	[w14+12],w4
	mov	[w4+4],w5
	mov	[w14+10],w4
	mov.b	[w4],w4
	se	w4,w4
	sub	#32,w4
	sl	w4,#2,w4
	add	w5,w4,w4
	mov	w4,[w14+2]
	.ln	154
	bra	.L31
.L34:
	.ln	155
	mov	[w14+2],w4
	mov.b	[w4+1],w4
	ze	w4,w5
	mov	[w14+6],w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	le,.L32
	.ln	156
	mov	[w14+8],w4
	mov	[w14+4],w5
	add	w5,w4,w6
	mov	[w14+12],w4
	mov	[w4+6],w7
	mov	[w14+2],w4
	mov	[w4+2],w0
	mov	[w14+2],w4
	mov.b	[w4],w4
	ze	w4,w5
	mov	[w14+6],w4
	mul.ss	w5,w4,w4
	mov	w4,w4
	add	w0,w4,w5
	mov	[w14],w4
	add	w5,w4,w4
	add	w7,w4,w4
	mov.b	[w4],w4
	mov.b	w4,[w6]
.L32:
	.ln	158
	mov	[w14+8],w4
	inc	w4,w4
	mov	w4,[w14+8]
	.ln	159
	inc	[w14],[w14]
.L31:
	.ln	154
	mov	[w14+8],w5
	mov	#127,w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	gt,.L33
	mov	[w14+2],w4
	mov.b	[w4],w4
	ze	w4,w4
	sub	w4,[w14],[w15]
	.set ___BP___,0
	bra	gt,.L34
.L33:
	.ln	161
	mov	[w14+12],w4
	mov.b	[w4],w4
	ze	w4,w4
	mov	[w14+8],w5
	add	w5,w4,w4
	mov	w4,[w14+8]
	.ln	162
	mov	[w14+10],w4
	inc	w4,w4
	mov	w4,[w14+10]
.L30:
	.ln	151
	mov	[w14+10],w4
	mov.b	[w4],w4
	sub.b	w4,#0,[w15]
	.set ___BP___,0
	bra	nz,.L35
	.ln	164
	mov	[w14+8],w4
	.ln	165
	mov	w4,w0
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	165
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	165
	.endef
	.def	_render_text_to_page
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_scroll_text
	.val	_display_scroll_text
	.scl	2
	.type	041
	.endef
	.global	_display_scroll_text	; export
_display_scroll_text:
	.def	.bf
	.val	.
	.scl	101
	.line	168
	.endef
	.def	_page
	.val	130
	.scl	9
	.type	04
	.endef
	.def	_column
	.val	132
	.scl	9
	.type	04
	.endef
	.def	_text
	.val	134
	.scl	9
	.type	022
	.endef
	.def	_font
	.val	136
	.scl	9
	.tag	_FONT
	.size	8
	.type	030
	.endef
	.def	_up
	.val	138
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	168
	.endef
	.def	_temp_buffer
	.val	2
	.scl	1
	.dim	128
	.size	128
	.type	074
	.endef
	.def	_i
	.val	0
	.scl	1
	.type	04
	.endef
	.set ___PA___,1
	lnk	#140
	mov	w0,[w14+130]
	mov	w1,[w14+132]
	mov	w2,[w14+134]
	mov	w3,[w14+136]
	mov.b	w4,[w14+138]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	171
	mov.b	[w14+138],w4
	sub.b	w4,#0,[w15]
	.set ___BP___,0
	bra	z,.L37
	.ln	172
	clr	w4
	mov	w4,[w14]
	.ln	173
	bra	.L38
.L40:
	.ln	174
	inc2	w14,w4
	mov	#128,w2
	clr	w1
	mov	w4,w0
	rcall	_memset
	.ln	175
	mov	[w14+136],w4
	mov.b	[w4+1],w4
	ze	w4,w4
	sub	w4,[w14],[w15]
	.set ___BP___,0
	bra	le,.L39
	inc2	w14,w5
	mov	[w14+136],w4
	mov	[w14+134],w3
	mov	[w14+132],w2
	mov	[w14],w1
	mov	w5,w0
	rcall	_render_text_to_page
.L39:
	.ln	176
	inc2	w14,w4
	mov.b	[w14+138],w1
	mov	w4,w0
	rcall	_display_scroll_page
	.ln	177
	inc	[w14],[w14]
.L38:
	.ln	173
	mov	#9,w4
	sub	w4,[w14],w5
	mov	[w14+130],w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	gt,.L40
	bra	.L36
.L37:
	.ln	180
	mov	[w14+136],w4
	mov.b	[w4+1],w4
	ze	w4,w4
	dec	w4,[w14]
	bra	.L42
.L43:
	.ln	181
	inc2	w14,w4
	mov	#128,w2
	clr	w1
	mov	w4,w0
	rcall	_memset
	.ln	182
	inc2	w14,w5
	mov	[w14+136],w4
	mov	[w14+134],w3
	mov	[w14+132],w2
	mov	[w14],w1
	mov	w5,w0
	rcall	_render_text_to_page
	.ln	183
	inc2	w14,w4
	mov.b	[w14+138],w1
	mov	w4,w0
	rcall	_display_scroll_page
	.ln	180
	dec	[w14],[w14]
.L42:
	mov	[w14],w4
	sub	w4,#0,[w15]
	.set ___BP___,0
	bra	ge,.L43
	.ln	185
	inc2	w14,w4
	mov	#128,w2
	clr	w1
	mov	w4,w0
	rcall	_memset
	.ln	186
	clr	w4
	mov	w4,[w14]
	bra	.L44
.L45:
	.ln	187
	inc2	w14,w4
	mov.b	[w14+138],w1
	mov	w4,w0
	rcall	_display_scroll_page
	.ln	186
	inc	[w14],[w14]
.L44:
	mov	[w14+130],w4
	mov	[w14],w5
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	lt,.L45
.L36:
	.ln	190
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	190
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	190
	.endef
	.def	_display_scroll_text
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_swipe_pages
	.val	_display_swipe_pages
	.scl	2
	.type	041
	.endef
	.global	_display_swipe_pages	; export
_display_swipe_pages:
	.def	.bf
	.val	.
	.scl	101
	.line	192
	.endef
	.def	_start_page
	.val	134
	.scl	9
	.type	04
	.endef
	.def	_data
	.val	136
	.scl	9
	.type	034
	.endef
	.def	_page_count
	.val	138
	.scl	9
	.type	04
	.endef
	.def	_left
	.val	140
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	192
	.endef
	.def	_offset
	.val	0
	.scl	1
	.type	04
	.endef
	.def	_page
	.val	2
	.scl	1
	.type	04
	.endef
	.def	_real_page
	.val	4
	.scl	1
	.type	04
	.endef
	.def	_temp_buffer
	.val	6
	.scl	1
	.dim	128
	.size	128
	.type	074
	.endef
	.set ___PA___,1
	lnk	#142
	mov	w0,[w14+134]
	mov	w1,[w14+136]
	mov	w2,[w14+138]
	mov.b	w3,[w14+140]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	196
	mov.b	[w14+140],w4
	sub.b	w4,#0,[w15]
	.set ___BP___,0
	bra	z,.L47
	.ln	197
	clr	w4
	mov	w4,[w14]
	bra	.L48
.L51:
	.ln	198
	clr	w4
	mov	w4,[w14+2]
	bra	.L49
.L50:
	.ln	199
	add	w14,#6,w4
	mov	#128,w2
	clr	w1
	mov	w4,w0
	rcall	_memset
	.ln	200
	mov	_top_page,w5
	mov	[w14+134],w4
	add	w5,w4,w5
	mov	[w14+2],w4
	add	w5,w4,w5
	mov	#8,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov	w4,[w14+4]
	.ln	202
	mov	#120,w4
	sub	w4,[w14],w4
	mov	w4,w6
	mov	[w14+4],w4
	sl	w4,#7,w4
	add	w4,#8,w5
	mov	#_buffer,w4
	add	w5,w4,w5
	add	w14,#6,w4
	mov	w6,w2
	mov	w5,w1
	mov	w4,w0
	rcall	_memcpy
	.ln	203
	mov	[w14],w6
	mov	[w14+2],w4
	sl	w4,#7,w4
	mov	[w14+136],w5
	add	w5,w4,w5
	mov	#128,w4
	sub	w4,[w14],w4
	add	w14,#6,w7
	add	w7,w4,w4
	mov	w6,w2
	mov	w5,w1
	mov	w4,w0
	rcall	_memcpy
	.ln	204
	mov	[w14+4],w0
	rcall	_set_page
	.ln	205
	clr	w0
	rcall	_set_column
	.ln	206
	add	w14,#6,w4
	mov.b	#-128,w1
	mov	w4,w0
	rcall	_display_send_data
	.ln	198
	mov	[w14+2],w4
	inc	w4,w4
	mov	w4,[w14+2]
.L49:
	mov	[w14+2],w5
	mov	[w14+138],w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	lt,.L50
	.ln	208
	mul.uu	w0,#0,w0
	rcall	___delay32
	.ln	197
	mov	[w14],w4
	add	w4,#8,[w14]
.L48:
	mov	#127,w4
	mov	[w14],w5
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	le,.L51
	bra	.L46
.L47:
	.ln	211
	mov	#128,w4
	mov	w4,[w14]
	bra	.L53
.L56:
	.ln	212
	clr	w4
	mov	w4,[w14+2]
	bra	.L54
.L55:
	.ln	213
	add	w14,#6,w4
	mov	#128,w2
	clr	w1
	mov	w4,w0
	rcall	_memset
	.ln	214
	mov	_top_page,w5
	mov	[w14+134],w4
	add	w5,w4,w5
	mov	[w14+2],w4
	add	w5,w4,w5
	mov	#8,w4
	repeat	#18-1
	div.sw	w5,w4
	mov	w1,w4
	mov	w4,[w14+4]
	.ln	216
	mov	[w14],w5
	sub	w5,#8,w4
	mov	w4,w6
	mov	[w14+4],w4
	sl	w4,#7,w5
	mov	[w14],w4
	sub	w5,w4,w4
	mov	#128,w5
	add	w5,w4,w5
	mov	#_buffer,w4
	add	w5,w4,w5
	mov	#136,w4
	sub	w4,[w14],w4
	add	w14,#6,w7
	add	w7,w4,w4
	mov	w6,w2
	mov	w5,w1
	mov	w4,w0
	rcall	_memcpy
	.ln	217
	mov	#128,w4
	sub	w4,[w14],w4
	mov	w4,w6
	mov	[w14+2],w4
	sl	w4,#7,w4
	add	w4,[w14],w4
	mov	[w14+136],w5
	add	w5,w4,w5
	add	w14,#6,w4
	mov	w6,w2
	mov	w5,w1
	mov	w4,w0
	rcall	_memcpy
	.ln	218
	mov	[w14+4],w0
	rcall	_set_page
	.ln	219
	clr	w0
	rcall	_set_column
	.ln	220
	add	w14,#6,w4
	mov.b	#-128,w1
	mov	w4,w0
	rcall	_display_send_data
	.ln	212
	mov	[w14+2],w4
	inc	w4,w4
	mov	w4,[w14+2]
.L54:
	mov	[w14+2],w5
	mov	[w14+138],w4
	sub	w5,w4,[w15]
	.set ___BP___,0
	bra	lt,.L55
	.ln	222
	mul.uu	w0,#0,w0
	rcall	___delay32
	.ln	211
	mov	[w14],w0
	sub	w0,#8,[w14]
.L53:
	mov	[w14],w4
	sub	w4,#0,[w15]
	.set ___BP___,0
	bra	gt,.L56
.L46:
	.ln	225
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	225
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	225
	.endef
	.def	_display_swipe_pages
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_flip
	.val	_display_flip
	.scl	2
	.type	041
	.endef
	.global	_display_flip	; export
_display_flip:
	.def	.bf
	.val	.
	.scl	101
	.line	227
	.endef
	.def	_invert
	.val	2
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	227
	.endef
	.def	_i
	.val	0
	.scl	1
	.type	04
	.endef
	.set ___PA___,1
	lnk	#4
	mov.b	w0,[w14+2]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	229
	mov.b	[w14+2],w4
	sub.b	w4,#0,[w15]
	.set ___BP___,0
	bra	z,.L58
	.ln	230
	mov.b	#-95,w0
	rcall	_send1
	.ln	231
	mov.b	#-56,w0
	rcall	_send1
	bra	.L59
.L58:
	.ln	233
	mov.b	#-96,w0
	rcall	_send1
	.ln	234
	mov.b	#-64,w0
	rcall	_send1
.L59:
	.ln	236
	mov.b	[w14+2],w0
	mov.b	WREG,_display_inverted
	.ln	237
	clr	w4
	mov	w4,[w14]
	bra	.L60
.L61:
	.ln	238
	clr	w0
	rcall	_set_column
	.ln	239
	mov	[w14],w0
	rcall	_set_page
	.ln	240
	mov	#_buffer,w5
	mov	[w14],w4
	sl	w4,#7,w4
	add	w5,w4,w4
	mov.b	#-128,w1
	mov	w4,w0
	rcall	_display_send_data
	.ln	237
	inc	[w14],[w14]
.L60:
	mov	[w14],w4
	sub	w4,#7,[w15]
	.set ___BP___,0
	bra	le,.L61
	.ln	243
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	243
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	243
	.endef
	.def	_display_flip
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_display_set_brightness
	.val	_display_set_brightness
	.scl	2
	.type	041
	.endef
	.global	_display_set_brightness	; export
_display_set_brightness:
	.def	.bf
	.val	.
	.scl	101
	.line	245
	.endef
	.def	_brightness
	.val	0
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	245
	.endef
	.set ___PA___,1
	lnk	#2
	mov.b	w0,[w14]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	246
	mov.b	[w14],w1
	mov.b	#-127,w0
	rcall	_send2
	.ln	247
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	247
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	247
	.endef
	.def	_display_set_brightness
	.val	.
	.scl	-1
	.endef
	.def	_display_inverted
	.val	_display_inverted
	.scl	2
	.type	014
	.endef
	.section	.text,code
	.def	_buffer
	.val	_buffer
	.scl	2
	.dim	8,128
	.size	1024
	.type	0374
	.endef
	.def	_top_page
	.val	_top_page
	.scl	2
	.type	04
	.endef
	.def	_cur_column
	.val	_cur_column
	.scl	2
	.type	04
	.endef
	.def	_cur_page
	.val	_cur_page
	.scl	2
	.type	04
	.endef

	.section __c30_signature, info, data
	.word 0x0001
	.word 0x0001
	.word 0x0000

; MCHP configuration words

	.set ___PA___,0
	.end
