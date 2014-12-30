	.file "/home/phil/Projects/phoenix/firmware/bootloader/usb_winusb.c"
	.section	.text,code
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
	.file "/home/phil/Projects/phoenix/firmware/bootloader/usb_config.h"
	.file "/home/phil/Projects/phoenix/firmware/bootloader/usb/include/usb_microsoft.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdint.h"
	.def	_microsoft_os_descriptor
	.scl	10
	.type	010
	.size	18
	.endef
	.def	_bLength
	.val	0
	.scl	8
	.type	014
	.endef
	.def	_bDescriptorType
	.val	1
	.scl	8
	.type	014
	.endef
	.def	_qwSignature
	.val	2
	.scl	8
	.dim	7
	.size	14
	.type	076
	.endef
	.def	_bMS_VendorCode
	.val	16
	.scl	8
	.type	014
	.endef
	.def	_bPad
	.val	17
	.scl	8
	.type	014
	.endef
	.def	.eos
	.val	18
	.scl	102
	.tag	_microsoft_os_descriptor
	.size	18
	.endef
	.def	_microsoft_extended_compat_header
	.scl	10
	.type	010
	.size	16
	.endef
	.def	_dwLength
	.val	0
	.scl	8
	.type	017
	.endef
	.def	_bcdVersion
	.val	4
	.scl	8
	.type	016
	.endef
	.def	_wIndex
	.val	6
	.scl	8
	.type	016
	.endef
	.def	_bCount
	.val	8
	.scl	8
	.type	014
	.endef
	.def	_reserved
	.val	9
	.scl	8
	.dim	7
	.size	7
	.type	074
	.endef
	.def	.eos
	.val	16
	.scl	102
	.tag	_microsoft_extended_compat_header
	.size	16
	.endef
	.def	_microsoft_extended_compat_function
	.scl	10
	.type	010
	.size	24
	.endef
	.def	_bFirstInterfaceNumber
	.val	0
	.scl	8
	.type	014
	.endef
	.def	_reserved
	.val	1
	.scl	8
	.type	014
	.endef
	.def	_compatibleID
	.val	2
	.scl	8
	.dim	8
	.size	8
	.type	074
	.endef
	.def	_subCompatibleID
	.val	10
	.scl	8
	.dim	8
	.size	8
	.type	074
	.endef
	.def	_reserved2
	.val	18
	.scl	8
	.dim	6
	.size	6
	.type	074
	.endef
	.def	.eos
	.val	24
	.scl	102
	.tag	_microsoft_extended_compat_function
	.size	24
	.endef
	.def	_microsoft_extended_properties_header
	.scl	10
	.type	010
	.size	10
	.endef
	.def	_dwLength
	.val	0
	.scl	8
	.type	017
	.endef
	.def	_bcdVersion
	.val	4
	.scl	8
	.type	016
	.endef
	.def	_wIndex
	.val	6
	.scl	8
	.type	016
	.endef
	.def	_bCount
	.val	8
	.scl	8
	.type	016
	.endef
	.def	.eos
	.val	10
	.scl	102
	.tag	_microsoft_extended_properties_header
	.size	10
	.endef
	.def	_microsoft_extended_property_section_header
	.scl	10
	.type	010
	.size	8
	.endef
	.def	_dwSize
	.val	0
	.scl	8
	.type	017
	.endef
	.def	_dwPropertyDataType
	.val	4
	.scl	8
	.type	017
	.endef
	.def	.eos
	.val	8
	.scl	102
	.tag	_microsoft_extended_property_section_header
	.size	8
	.endef
	.file "/home/phil/Projects/phoenix/firmware/bootloader/usb_winusb.h"
	.file "/opt/microchip/xc16/v1.23/bin/bin/../../include/stdint.h"
	.def	_extended_compat_descriptor_packet
	.scl	10
	.type	010
	.size	40
	.endef
	.def	_header
	.val	0
	.scl	8
	.tag	_microsoft_extended_compat_header
	.size	16
	.type	010
	.endef
	.def	_function
	.val	16
	.scl	8
	.tag	_microsoft_extended_compat_function
	.size	24
	.type	010
	.endef
	.def	.eos
	.val	40
	.scl	102
	.tag	_extended_compat_descriptor_packet
	.size	40
	.endef
	.section	.text,code
	.align	2
	.def	_m_stack_winusb_get_microsoft_compat
	.val	_m_stack_winusb_get_microsoft_compat
	.scl	2
	.type	056
	.endef
	.global	_m_stack_winusb_get_microsoft_compat	; export
_m_stack_winusb_get_microsoft_compat:
	.def	.bf
	.val	.
	.scl	101
	.line	74
	.endef
	.def	_interface
	.val	0
	.scl	17
	.type	014
	.endef
	.def	_descriptor
	.val	1
	.scl	17
	.type	0121
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	74
	.endef
	.set ___PA___,1
	.def	___FP
	.val	15
	.scl	4
	.type	4
	.endef
	.ln	76
	mov	#_this_extended_compat_descriptor,w4
	mov	w4,[w1]
	.ln	78
	retlw	#40,w0
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	78
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	78
	.endef
	.def	_m_stack_winusb_get_microsoft_compat
	.val	.
	.scl	-1
	.endef
	.align	2
	.def	_m_stack_winusb_get_microsoft_property
	.val	_m_stack_winusb_get_microsoft_property
	.scl	2
	.type	056
	.endef
	.global	_m_stack_winusb_get_microsoft_property	; export
_m_stack_winusb_get_microsoft_property:
	.def	.bf
	.val	.
	.scl	101
	.line	82
	.endef
	.def	_interface
	.val	0
	.scl	17
	.type	014
	.endef
	.def	_descriptor
	.val	1
	.scl	17
	.type	0121
	.endef
	.def	.bb
	.val	.
	.scl	100
	.line	82
	.endef
	.set ___PA___,1
	.def	___FP
	.val	15
	.scl	4
	.type	4
	.endef
	.ln	84
	mov	#_interface_0_property_descriptor,w4
	mov	w4,[w1]
	.ln	86
	retlw	#10,w0
	.set ___PA___,0
	.def	.eb
	.val	.
	.scl	100
	.line	86
	.endef
	.def	.ef
	.val	.
	.scl	101
	.line	86
	.endef
	.def	_m_stack_winusb_get_microsoft_property
	.val	.
	.scl	-1
	.endef
	.section	.ndata,data,near
	.align	2
_interface_0_property_descriptor:
	.long	10
	.word	256
	.word	5
	.word	0
	.align	2
_this_extended_compat_descriptor:
	.long	40
	.word	256
	.word	4
	.byte 1
	.byte 0
	.skip	6
	.byte 0
	.byte 1
	.asciz	"WINUSB"
	.skip	1
	.byte	0
	.skip	7
	.byte 0
	.skip	5
	.section	.text,code
	.def	_this_extended_compat_descriptor
	.val	_this_extended_compat_descriptor
	.scl	3
	.tag	_extended_compat_descriptor_packet
	.size	40
	.type	010
	.endef
	.def	_interface_0_property_descriptor
	.val	_interface_0_property_descriptor
	.scl	3
	.tag	_microsoft_extended_properties_header
	.size	10
	.type	010
	.endef

	.section __c30_signature, info, data
	.word 0x0001
	.word 0x0000
	.word 0x0000

; MCHP configuration words

	.set ___PA___,0
	.end
