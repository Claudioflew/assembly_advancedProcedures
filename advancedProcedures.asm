;--------------------------------------------------------------------------------------
; Description: Demonstrates stack parameter list usage, PROTO and INVOKE directives
; Author name: Koichi Nakata
; Author email: kanakta595@insite.4cd.edu
; Last modified date: April 26, 2024
; Creation date: April 25, 2024
;--------------------------------------------------------------------------------------

INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, ExitCode: dword
AddThree PROTO, val1: dword, val2: dword, val3: dword
SetColor PROTO, forecolor: byte, backcolor: byte
WriteColorChar PROTO, char: byte, forecolor: byte, backcolor: byte

.code
main PROC
	INVOKE AddThree, 112233h, 223344h, 334455h
	call DumpRegs

	INVOKE SetColor, yellow, blue
	call DumpRegs

	INVOKE WriteColorChar, 'V', black, green

	INVOKE ExitProcess, 0
main ENDP

;--------------------------------------------------------------------------------------
AddThree PROC, val1: dword, val2: dword, val3: dword
; Calculates and returns three integers' sum.
; Receives: val1: dword, val2: dword, val3: dword
; Returns: EAX: the sum
;--------------------------------------------------------------------------------------
	mov  eax, 0
	add  eax, val1
	add  eax, val2
	add  eax, val3
	ret
AddThree ENDP

;--------------------------------------------------------------------------------------
SetColor PROC USES eax, forecolor: byte, backcolor: byte
; Receives forecolor and backcolor value and calls SetTextColor proc from Irvine32.
; Receives: forecolor: byte, backcolor: byte
; Returns: void
;--------------------------------------------------------------------------------------
	movzx eax, backcolor		; Same as mov eax, 0 -> mov eax, backcolor
	shl   eax, 4			; Shifts to upper 4 bits
	add   al, forecolor		; Add instead of mov, otherwise it overwrites
	call  SetTextColor
	ret
SetColor ENDP

;--------------------------------------------------------------------------------------
WriteColorChar PROC USES eax, char: byte, forecolor: byte, backcolor: byte
; Receives one character, forecolor and backcolor values and display the single character.
; Receives: char: byte, forecolor: byte, backcolor: byte
; Return: void
;--------------------------------------------------------------------------------------
	INVOKE SetColor, forecolor, backcolor
	mov    al, char
	call   WriteChar
	ret
WriteColorChar ENDP

END main




