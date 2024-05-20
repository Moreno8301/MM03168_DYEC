section .data
    ; Mensaje para solicitar el primer número
    msg1 db "Ingrese el primer número: ", 0xA, 0xD
    len1 equ $- msg1
    
    ; Mensaje para solicitar el segundo número
    msg2 db "Ingrese el segundo número: ", 0xA, 0xD
    len2 equ $- msg2
    
    ; Mensaje para mostrar el resultado de la división
    msg_resultado db "El resultado de la división es: ", 0xA, 0xD
    len_resultado equ $- msg_resultado
    
    nuevalinea db 0xA, 0xD
    len_nuevalinea equ $- nuevalinea
    
section .bss
    ; Variables para almacenar los números ingresados por el usuario y el resultado de la división
    num1 resd 1
    num2 resd 1
    resultado resd 1
    
section .text
    global _start
    
_start:
    ; Solicitar y leer el primer número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 0x80
    
    ; Solicitar y leer el segundo número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80
    
    ; Cargar los números en los registros
    mov eax, [num1]
    mov ebx, [num2]
    
    ; Dividir el primer número por el segundo
    div ebx
    
    ; Guardar el resultado de la división en la variable 'resultado'
    mov [resultado], eax
    
    ; Mostrar el resultado de la división
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_resultado
    mov edx, len_resultado
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 4
    int 0x80
    
    ; Imprimir nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, nuevalinea
    mov edx, len_nuevalinea
    int 0x80
        
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
