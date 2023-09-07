.data

#Se crean los elementos que se estarán implementando en el código

message0: .asciiz "\n Se ha finalizado el programa!"
message1: .asciiz "\n Bienvenido al comparador de números"
message2: .asciiz "\n Cuántos números de la Serie  Fibonacci deseas conocer? Ingresa un número:\n"
message3: .asciiz "\n La Serie Fibonacci sería:"
salto: .asciiz "\n"
.text
main:
    li $v0, 4		#Se indica que se cargará un string
    la $a0, message1	#Se invoca message1
    syscall
    
    li $v0, 4		#Se indica que se cargará un string
    la $a0, message2	#Se invoca message2, solicitando al usuario cuántos numeros de la serie se desean conocer
    syscall
    
    li $v0, 5		#Se indica que se cargará un número ingresado por el usuario
    syscall		#Se solicita al usuario que ingrese el número
    add $t2,$v0,1	#A este número se le sumará 1 y esto se almacenará en $t2, que será nuestro límite para el bucle

    
    li $v0, 4		#Se indica que se cargará un string
    la $a0, message3	#Se invoca message3
    syscall
    
    #Se inicializan las variables que se utilizarán
    li $v0, 1		#Se indica que se cargará un número
    li $t1, 1		#iterador / contador
    li $t3, 0 		#número actual de la serie
    li $t4, 1 		#número auxiliar
    syscall
    
    
    bgt $t2,0, serieFibonacci	#Se procede a ingresar al bucle
    blt $t2,1,fin
    li $v0, 10		#Fin de main
    syscall
   
#funciones

serieFibonacci:

     li $v0, 4
     la $a0, salto 	#Se inicia con un salto \n
     syscall     
     
     add $t5, $t3, $t4	#En $t5 se almacenará la suma de $t3 y $t4, lo que corresponderá a nuestro número siguiente
     move $t3, $t4	#Ahora, se mueve $t4 a $t3, que se mantiene con el valor actual, sin embargo, este irá cambiando,
     move $t4, $t5	#A media que $t4 se convierte en número siguiente
     
     li $v0,1
     move $a0, $t3	#Se muestra el valor de $t3
     syscall
     
     add $t1, $t1, 1	#Se suma 1 al contador
     
     beq $t1, $t2, fin #Una vez el contador sea igual al número ingresado, se saltará a la función fin
    j serieFibonacci


fin:
    li $v0, 4		#Se indica que se cargará un string
    la $a0, message0	#Se invoca message0
    syscall
    
    li $v0, 10
    syscall
