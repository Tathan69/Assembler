.data

#Se crean los elementos que se estar�n implementando en el c�digo

message0: .asciiz "\n Se ha finalizado el programa!"
message1: .asciiz "\n Bienvenido al comparador de n�meros"
message2: .asciiz "\n Cu�ntos n�meros de la Serie  Fibonacci deseas conocer? Ingresa un n�mero:\n"
message3: .asciiz "\n La Serie Fibonacci ser�a:"
salto: .asciiz "\n"
.text
main:
    li $v0, 4		#Se indica que se cargar� un string
    la $a0, message1	#Se invoca message1
    syscall
    
    li $v0, 4		#Se indica que se cargar� un string
    la $a0, message2	#Se invoca message2, solicitando al usuario cu�ntos numeros de la serie se desean conocer
    syscall
    
    li $v0, 5		#Se indica que se cargar� un n�mero ingresado por el usuario
    syscall		#Se solicita al usuario que ingrese el n�mero
    add $t2,$v0,1	#A este n�mero se le sumar� 1 y esto se almacenar� en $t2, que ser� nuestro l�mite para el bucle

    
    li $v0, 4		#Se indica que se cargar� un string
    la $a0, message3	#Se invoca message3
    syscall
    
    #Se inicializan las variables que se utilizar�n
    li $v0, 1		#Se indica que se cargar� un n�mero
    li $t1, 1		#iterador / contador
    li $t3, 0 		#n�mero actual de la serie
    li $t4, 1 		#n�mero auxiliar
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
     
     add $t5, $t3, $t4	#En $t5 se almacenar� la suma de $t3 y $t4, lo que corresponder� a nuestro n�mero siguiente
     move $t3, $t4	#Ahora, se mueve $t4 a $t3, que se mantiene con el valor actual, sin embargo, este ir� cambiando,
     move $t4, $t5	#A media que $t4 se convierte en n�mero siguiente
     
     li $v0,1
     move $a0, $t3	#Se muestra el valor de $t3
     syscall
     
     add $t1, $t1, 1	#Se suma 1 al contador
     
     beq $t1, $t2, fin #Una vez el contador sea igual al n�mero ingresado, se saltar� a la funci�n fin
    j serieFibonacci


fin:
    li $v0, 4		#Se indica que se cargar� un string
    la $a0, message0	#Se invoca message0
    syscall
    
    li $v0, 10
    syscall
