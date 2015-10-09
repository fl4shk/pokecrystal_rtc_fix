global PreFixTime

SECTION "RTC_fix_70", ROM0[$0070]
Function70:
;[0x70] ld a, [$d4b8]
	ld a, [StartMinute]
	add a, $01
	cp $3c
;[0x77] jr z, $04 ; 0x7d
	jr z, .asm_7d
	ld [StartMinute], a
	ret
	
.asm_7d:
;[0x7d] ld a, $00
	ld a, $00
	ld [StartMinute], a
	ld a, [StartHour]
	add a, $01
	cp $18
;[0x89] jr z, $04 ; 0x8f
	jr z, .asm_8f
	ld [StartHour], a
	ret
	
.asm_8f:
;[0x8f] ld a, $00
	ld a, $00
	ld [StartHour], a
	ld a, [StartDay]
	add a, $01
	cp $07
;[0x9b] jr z, $04 ; 0xa1
	jr z, .asm_a1
	ld [StartDay], a
	ret
	
.asm_a1:
;[0xa1] ld a, $00
	ld a, $00
	ld [StartDay], a
	ret

SECTION "RTC_fix_b0", ROM0[$00b0]
Functionb0:
;[0xb0] ld a, [StartMinute]
	ld a, [StartMinute]
	cp $00
;[0xb5] jr z, $06 ; 0xbd
	jr z, .asm_bd
	sub $01
	ld [StartMinute], a
	ret
	
.asm_bd:
;[0xbd] ld a, $3b
	ld a, $3b
	ld [StartMinute], a
	ld a, [StartHour]
	cp $00
;[0xc7] jr z, $06 ; 0xcf
	jr z, .asm_cf
	sub $01
	ld [StartHour], a
	ret
	
.asm_cf:
;[0xcf] ld a, $17
	ld a, $17
	ld [StartHour], a
	ld a, [StartDay]
	cp $00
;[0xd9] jr z, $06 ; 0xe1
	jr z, .asm_e1
	sub $01
	ld [StartDay], a
	ret
.asm_e1:
;[0xe1] ld a, $06
	ld a, $06
	ld [StartDay], a
	ret



SECTION "RTC_fix_3fc0", ROM0[$3fc0]
PreFixTime:: ; 3fc0
	;ld a, [$cfb9]
	ld a, [PredefAddress + 2]
	cp a, $c5
	jr z, .asm_3fca
	jp FixTime
.asm_3fca:
	;ld a, [$cf65]
	ld a, [wcf65]
	cp a, $00
	jr z, .asm_3fd4
	jp FixTime
.asm_3fd4:
	;ld a, [$d434]
	ld a, [ScriptFlags]
	cp a, $04
	jr z, .asm_3fde
	jp FixTime
.asm_3fde:
	;ldh a, [$a4]
	ld a, [hJoypadDown]
	cp a, $80
	jr z, .asm_3ff3
	cp a, $40
	jr z, .asm_3feb
	jp FixTime
.asm_3feb:
	call Function70
	jp FixTime
	nop
	nop
.asm_3ff3:
	call Functionb0
	jp FixTime


