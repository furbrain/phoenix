	.file "/home/phil/Projects/phoenix/firmware/program/sensors.c"
	.section	.text,code
	.file "/home/phil/Projects/phoenix/firmware/program/sensors.h"
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
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdbool.h"
	.def	_RAW_SENSORS
	.scl	10
	.type	010
	.size	22
	.endef
	.def	_accel
	.val	0
	.scl	8
	.dim	3
	.size	6
	.type	064
	.endef
	.def	_temp
	.val	6
	.scl	8
	.type	04
	.endef
	.def	_gyro
	.val	8
	.scl	8
	.dim	3
	.size	6
	.type	064
	.endef
	.def	_mag
	.val	14
	.scl	8
	.dim	3
	.size	6
	.type	064
	.endef
	.def	_distance
	.val	20
	.scl	8
	.type	04
	.endef
	.def	.eos
	.val	22
	.scl	102
	.tag	_RAW_SENSORS
	.size	22
	.endef
	.def	_COOKED_SENSORS
	.scl	10
	.type	010
	.size	44
	.endef
	.def	_accel
	.val	0
	.scl	8
	.dim	3
	.size	12
	.type	066
	.endef
	.def	_temp
	.val	12
	.scl	8
	.type	06
	.endef
	.def	_gyro
	.val	16
	.scl	8
	.dim	3
	.size	12
	.type	066
	.endef
	.def	_mag
	.val	28
	.scl	8
	.dim	3
	.size	12
	.type	066
	.endef
	.def	_distance
	.val	40
	.scl	8
	.type	06
	.endef
	.def	.eos
	.val	44
	.scl	102
	.tag	_COOKED_SENSORS
	.size	44
	.endef
	.file "/home/phil/Projects/phoenix/firmware/program/i2c_util.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdint.h"
	.section	.text,code
	.align	2
	.def	_sensors_init
	.val	_sensors_init
	.scl	2
	.type	041
	.endef
	.global	_sensors_init	; export
_sensors_init:
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
	.def	_temp
	.val	0
	.scl	1
	.type	014
	.endef
	.set ___PA___,1
	lnk	#2
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	50
	clr.b	w2
	mov.b	#106,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	51
	mov.b	#7,w2
	mov.b	#106,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	53
	mov.b	#49,w2
	mov.b	#25,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	54
	mov.b	#66,w2
	mov.b	#26,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	57
	clr.b	w4
	mov.b	w4,[w14]
	.ln	71
	mov.b	[w14],w2
	mov.b	#27,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	75
	clr.b	w4
	mov.b	w4,[w14]
	.ln	88
	mov.b	[w14],w2
	mov.b	#28,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	90
	mov.b	#121,w2
	mov.b	#35,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	93
	mov.b	#64,w2
	mov.b	#36,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	94
	mov.b	#-116,w2
	mov.b	#37,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	95
	mov.b	#3,w2
	mov.b	#38,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	96
	mov.b	#-42,w2
	mov.b	#39,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	97
	mov.b	#12,w2
	mov.b	#40,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	98
	mov.b	#10,w2
	mov.b	#41,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	99
	mov.b	#-127,w2
	mov.b	#42,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	100
	mov.b	#17,w2
	mov.b	#100,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	101
	mov.b	#1,w2
	mov.b	#52,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	102
	mov.b	#-125,w2
	mov.b	#103,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	106
	mov.b	#100,w2
	mov.b	#106,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	108
	clr.b	w2
	mov.b	#107,w1
	mov.b	#104,w0
	rcall	_write_i2c_data2
	.ln	110
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	110
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	110
	.endef
	.def	_sensors_init
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_byte_swap
	.val	_byte_swap
	.scl	2
	.type	041
	.endef
	.global	_byte_swap	; export
_byte_swap:
	.def	.bf
	.val	.
	.scl	101
	.line	114
	.endef
	.def	_word
	.val	0
	.scl	9
	.type	036
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	114
	.endef
	.set ___PA___,1
	lnk	#2
	mov	w0,[w14]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	115
	mov	[w14],w4
	mov	[w4],w4
	sl	w4,#8,w5
	lsr	w4,#8,w4
	mov	w5,w6
	ior	w6,w4,w6
	mov	w6,w4
	mov	[w14],w5
	mov	w4,[w5]
	.ln	116
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	116
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	116
	.endef
	.def	_byte_swap
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_sensors_read_raw
	.val	_sensors_read_raw
	.scl	2
	.type	041
	.endef
	.global	_sensors_read_raw	; export
_sensors_read_raw:
	.def	.bf
	.val	.
	.scl	101
	.line	118
	.endef
	.def	_sensors
	.val	2
	.scl	9
	.tag	_RAW_SENSORS
	.size	22
	.type	030
	.endef
	.def	_lidar
	.val	4
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	118
	.endef
	.def	_i
	.val	0
	.scl	1
	.type	04
	.endef
	.set ___PA___,1
	lnk	#6
	mov	w0,[w14+2]
	mov.b	w1,[w14+4]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	120
	mov	[w14+2],w4
	mov.b	#22,w3
	mov	w4,w2
	mov.b	#59,w1
	mov.b	#104,w0
	rcall	_read_i2c_data
	.ln	121
	mov.b	[w14+4],w4
	sub.b	w4,#0,[w15]
	.set ___BP___,0
	bra	z,.L4
	rcall	_sensors_read_lidar
	mov	w0,w4
	bra	.L5
.L4:
	clr	w4
.L5:
	mov	[w14+2],w5
	mov	w4,[w5+20]
	.ln	122
	clr	w4
	mov	w4,[w14]
	bra	.L6
.L7:
	.ln	123
	mov	[w14+2],w5
	mov	[w14],w4
	add	w4,w4,w4
	add	w5,w4,w4
	mov	w4,w0
	rcall	_byte_swap
	.ln	122
	inc	[w14],[w14]
.L6:
	mov	[w14],w4
	sub	w4,#10,[w15]
	.set ___BP___,0
	bra	le,.L7
	.ln	125
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	125
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	125
	.endef
	.def	_sensors_read_raw
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_sensors_read_cooked
	.val	_sensors_read_cooked
	.scl	2
	.type	041
	.endef
	.global	_sensors_read_cooked	; export
_sensors_read_cooked:
	.def	.bf
	.val	.
	.scl	101
	.line	127
	.endef
	.def	_sensors
	.val	24
	.scl	9
	.tag	_COOKED_SENSORS
	.size	44
	.type	030
	.endef
	.def	_lidar
	.val	26
	.scl	9
	.type	014
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	127
	.endef
	.def	_raw_sensors
	.val	2
	.scl	1
	.tag	_RAW_SENSORS
	.size	22
	.type	010
	.endef
	.def	_i
	.val	0
	.scl	1
	.type	04
	.endef
	.set ___PA___,1
	lnk	#28
	mov	w0,[w14+24]
	mov.b	w1,[w14+26]
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	130
	inc2	w14,w4
	mov.b	[w14+26],w1
	mov	w4,w0
	rcall	_sensors_read_raw
	.ln	132
	clr	w4
	mov	w4,[w14]
	bra	.L9
.L10:
	.ln	133
	mov	[w14],w4
	add	w4,w4,w4
	add	w14,w4,w4
	mov	[w4+2],w4
	asr	w4,#15,w5
	mov.d	w4,w0
	rcall	___floatsisf
	mov.d	w0,w4
	mov	#0,w2
	mov	#14464,w3
	mov.d	w4,w0
	rcall	___mulsf3
	mov.d	w0,w4
	mov	[w14+24],w7
	mov	[w14],w6
	sl	w6,#2,w6
	add	w7,w6,w6
	mov.d	w4,[w6]
	.ln	134
	mov	[w14],w1
	add	w1,#4,w4
	add	w4,w4,w4
	add	w14,w4,w4
	mov	[w4+2],w4
	asr	w4,#15,w5
	mov.d	w4,w0
	rcall	___floatsisf
	mov.d	w0,w4
	mov	#0,w2
	mov	#15354,w3
	mov.d	w4,w0
	rcall	___mulsf3
	mov.d	w0,w4
	mov	[w14+24],w7
	mov	[w14],w1
	add	w1,#4,w6
	sl	w6,#2,w6
	add	w7,w6,w6
	mov.d	w4,[w6]
	.ln	135
	mov	[w14],w5
	add	w5,#7,w4
	add	w4,w4,w4
	add	w14,w4,w4
	mov	[w4+2],w4
	asr	w4,#15,w5
	mov.d	w4,w0
	rcall	___floatsisf
	mov.d	w0,w4
	mov	#32768,w2
	mov	#15897,w3
	mov.d	w4,w0
	rcall	___mulsf3
	mov.d	w0,w4
	mov	[w14+24],w7
	mov	[w14],w1
	add	w1,#7,w6
	sl	w6,#2,w6
	add	w7,w6,w6
	mov.d	w4,[w6]
	.ln	132
	inc	[w14],[w14]
.L9:
	mov	[w14],w4
	sub	w4,#2,[w15]
	.set ___BP___,0
	bra	le,.L10
	.ln	137
	mov	[w14+8],w4
	asr	w4,#15,w5
	mov.d	w4,w0
	rcall	___floatsisf
	mov.d	w0,w4
	mov	#61276,w2
	mov	#17318,w3
	mov.d	w4,w0
	rcall	___divsf3
	mov.d	w0,w4
	mov	#0,w2
	mov	#16808,w3
	mov.d	w4,w0
	rcall	___addsf3
	mov.d	w0,w4
	mov	[w14+24],w6
	mov	w4,[w6+12]
	mov	w5,[w6+14]
	.ln	138
	mov	[w14+22],w4
	asr	w4,#15,w5
	mov.d	w4,w0
	rcall	___floatsisf
	mov.d	w0,w4
	mov	#0,w2
	mov	#17096,w3
	mov.d	w4,w0
	rcall	___divsf3
	mov.d	w0,w4
	mov	[w14+24],w6
	mov	w4,[w6+40]
	mov	w5,[w6+42]
	.ln	140
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	140
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	140
	.endef
	.def	_sensors_read_cooked
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_sensors_read_lidar
	.val	_sensors_read_lidar
	.scl	2
	.type	044
	.endef
	.global	_sensors_read_lidar	; export
_sensors_read_lidar:
	.def	.bf
	.val	.
	.scl	101
	.line	142
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	142
	.endef
	.set ___PA___,1
	lnk	#0
	.def	___FP
	.val	14
	.scl	4
	.type	4
	.endef
	.ln	145
	mov	#1000,w4
	.ln	146
	mov	w4,w0
	ulnk	
	return	
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	146
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	146
	.endef
	.def	_sensors_read_lidar
	.val	.
	.scl	-1
	.endef

	.section __c30_signature, info, data
	.word 0x0001
	.word 0x0000
	.word 0x0000

; MCHP configuration words

	.set ___PA___,0
	.end
