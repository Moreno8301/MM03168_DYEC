_EXIT  equ 1
_READ  equ 3
_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data 

   msg1 db "Ingrese el primer numero (del 0 al 9)", 0xA,0xD 
   len1 equ $- msg1 

   msg2 db "Ingrese el segundo numero (del 0 al 9)", 0xA,0xD 
   len2 equ $- msg2 
   
   msg3 db "Ingrese el tercer numero (del 0 al 9)", 0xA,0xD 
   len3 equ $- msg3
   
   msg4 db "El resultado de la resta es: "
   len4 equ $- msg4
   
   nuevalinea db 0xA, 0xD
   len_nuevalinea equ $- nuevalinea

segment .bss

   num1 resb 2 
   num2 resb 2 
   num3 resb 2
   res resb 1
   
section	.text
   global _start    
	
_start:     
  
   ; limpiando registros
   mov eax,0
   mov ebx,0
   mov ecx,0
   mov edx,0
   
   ; solicitando el primer numero
   mov eax, _WRITE         
   mov ebx, STDOUT         
   mov ecx, msg1         
   mov edx, len1 
   int 0x80                

   ; leyendo el primer numero
   mov eax, _READ 
   mov ebx, STDIN  
   mov ecx, num1 
   mov edx, 2
   int 0x80            

   ; solicitando el segundo numero
   mov eax, _WRITE        
   mov ebx, STDOUT         
   mov ecx, msg2          
   mov edx, len2         
   int 0x80

   ; leyendo el segundo numero
   mov eax, _READ  
   mov ebx, STDIN  
   mov ecx, num2 
   mov edx, 2
   int 0x80
   
   ; solicitando el tercer numero
   mov eax, _WRITE        
   mov ebx, STDOUT         
   mov ecx, msg3          
   mov edx, len3         
   int 0x80

   ; leyendo el tercer numero
   mov eax, _READ  
   mov ebx, STDIN  
   mov ecx, num3 
   mov edx, 2
   int 0x80

   ; imprimiendo el contexto del resultado
   mov eax, _WRITE         
   mov ebx, STDOUT         
   mov ecx, msg4          
   mov edx, len4         
   int 0x80

   ; Se carga el primer numero en el registro
   mov ax, [num1]
   ; se resta el caracter cero en  ascii '0' para covertir a     numero decimal
   sub ax, '0'
   	
   ; el segundo numero se carga en el registro
   mov bx, [num2]
   ; se resta el caracter cero en  ascii '0' para covertir a numero decimal
   sub bx, '0'
   
   ; ax =   ax - bx
   sub ax, bx
      
   ; el tercer numero se carga en el registro
   mov bx, [num3]
   ; se resta el caracter cero en  ascii '0' para covertir a numero decimal
   sub bx, '0'
      
   ; ax =   ax - bx
   sub ax, bx
   ; Se convierte el resultado a ASCII
   add ax, '0'

   ; el resultado de la resta se guarda en la dirección de memoria apuntada por res
   mov [res], ax

   ; se imprime la resta 
   mov eax, _WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1        
   int 0x80
   
   ; Imprimir nueva línea
   mov eax, 4
   mov ebx, 1
   mov ecx, nuevalinea
   mov edx, len_nuevalinea
   int 0x80

exit:    
   
   mov eax, _EXIT   
   xor ebx, ebx 
   int 0x80

