section .data
    ; Mensajes para solicitar los números al usuario
    msg1 db "Ingrese el primer número (del 0 al 9): ", 0xA, 0xD
    len1 equ $- msg1
    
    msg2 db "Ingrese el segundo número (del 0 al 9): ", 0xA, 0xD
    len2 equ $- msg2
    
    ; Mensaje para mostrar el resultado de la multiplicación
    msg_resultado db "El resultado de la multiplicación es: ", 0xA, 0xD
    len_resultado equ $- msg_resultado
    
    nuevalinea db 0xA, 0xD
    len_nuevalinea equ $- nuevalinea
    
section .bss
    ; Variables para almacenar los números ingresados por el usuario y el resultado de la multiplicación
    num1 resb 1
    num2 resb 1
    resultado resb 1
    
section .text
    global _start
    
_start:
    ; limpiando registros
    mov eax,0
    mov ebx,0
    mov ecx,0
    mov edx,0

    ; Solicitar el primer número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80
    
    ; Guardando el primer número
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 0x80
    
    ; Solicitar el segundo numero
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80
    
    ; capturar el segundo numero
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 0x80
    
    ; Se carga el primer numero en el registro al
    mov al, [num1]
    ;  se resta el caracter cero en  ascii '0' para convertir a  numero decimal
    sub eax, '0'
    
    ; Se carga el primer numero en el registro bl
    mov bl, [num2]
    ;  se resta el caracter cero en  ascii '0' para convertir a  numero decimal
    sub bl, '0'
    
    ; Multiplicar los números
    mul bl
    
    ; Convertir el resultado a ASCII y almacenarlo en la variable 'resultado'
    add al, '0'
    mov [resultado], al
    
    ; Mostrar el resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_resultado
    mov edx, len_resultado
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 2
    int 0x80
    
    ; Imprimir nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, nuevalinea
    mov edx, len_nuevalinea
    int 0x80
    
exit:
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
