;Autor: Said De la Vega
;actividad 2

.org 0000h

;Declaramos valores de B y C

	LD B, 15
	LD C, 26

;Convertimos C a BCD

	LD A, C			; Copia el valor de C en A
	LD H, 0			; Inicializa H (contador de decenas) a 0
	LD L, 10		; L contiene 10, que se usa para comparar el valor en A

CICLO_BCD_c:
	CP L			; Compara A con 10
	JR C, GUARDAR_DE	; Si A < 10, dirige a GUARDAR_DE:
	SUB L			; Resta 10 de A
	INC H 			; Incrementa H (contador de decenas)
	JR CICLO_BCD_C		; Repite el bucle

GUARDAR_DE:
	LD D, H			; Guarda las decenas en D
	LD E, A			; Guarda las unidades en E

; Ahora convertimos B a BCD

	LD A, B			; Copia el valor de B en A
	LD H, 0			; Inicializa H (contador de decenas) a 0

CICLO_BCD_B:
	CP L			; Comparar A con 10
	JR C, GUARDAR_BC	; Si A < 10, dirige a GUARDAR_BC:
	SUB L			; Resta 10 de A
	INC H			; Incrementa H (contador de decenas)
	JR CICLO_BCD_B		; Repite el bucle

GUARDAR_BC:
	LD B, H           ; Guarda las decenas en B
	LD C, A           ; Guarda las unidades en C

;Sumamos las unidades

	LD A, C
	ADD A, E

;el dato que se guardo en A lo convertimos a decimal

	LD H, 0			; Inicializa el (CARRY) a 0
	LD E, 10		; cargamos 10 en L, que se usa para comparar el valor en A

CICLO_UNIDAD_CE:
	CP E			; Compara A con 10
	JR C, GUARDAR_UNIDAD_L		; Si A < 10, dirige a GUARDAR_UNIDAD_L:
	SUB E			; Resta 10 de A
	INC H 			; Incrementa H (CARRY) de decenas
	JR CICLO_UNIDAD_CE		; Repite el bucle

GUARDAR_UNIDAD_L:
	LD L, A			; Guarda las unidades en L


;Sumamos las decenas

	LD A, B
	ADD A, D
	ADD A, H		;Aqui suma el Carry
	LD B, 0

CICLO_DECENAS_BD:
	CP E			; Compara A con 10
	JR C, GUARDAR_H_Y_A	; Si A < 10, dirige a GUARDAR_H_Y_A:
	SUB E			; Resta 10 de A
	INC B			; Incrementa B (CARRY) de centenas
	JR CICLO_DECENAS_BD	; Repite el bucle

GUARDAR_H_Y_A:
	LD H, A			; Guarda las decenas en H
	LD A, B			; Guarda las centenas en A