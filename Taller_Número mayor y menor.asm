.data

#Script elaborado como desarrollo de los puntos 1 y 2 del taller 1 de la materia "Estructura de computadores"
# Estos consisten en: 1. N�mero mayor (m�nimo 3 n�meros) y 2. N�mero menor (m�nimo 3 n�meros)


mayor: .asciiz " El n�mero mayor es: "
menor: .asciiz "\n El n�mero menor es: "
iguales: .asciiz "Los n�meros son iguales!"
message0: .asciiz "\n Se ha finalizado el programa!"
message1: .asciiz "\n Bienvenido al comparador de n�meros"
message2: .asciiz "\n Para iniciar, ingresa el primer n�mero: \n"
message3: .asciiz "\n Ingresa otro n�mero:\n"
message4: .asciiz "\n Qu� deseas hacer ahora?\n1. Ingresa 1 para registrar otro n�mero\n2. Ingresa 2 para finalizar y concoer el n�mero mayor y el n�mero menor\n"
error1: .asciiz "Esta no es una opci�n v�lida \n"

.text
main:
    #Se presenta el primer mensaje al usuario
    li $v0, 4 		#se indica que se cargar� un string
    la $a0, message1 	#se invoca message1
    syscall		#Es importante mencionar que syscall funciona para que el sistema ejecute el c�gido que lo precede
    
    #Se presenta el segundo mensaje al usuario
    li $v0, 4		#se indica que se cargar� un string
    la $a0, message2 	#se invoca message2
    syscall
    
    #Se solicita al usuario que ingrese un n�mero, para esto se usa el 5 con el comando de carga inmediata
    li $v0, 5
    syscall
    move $t3, $v0 #Ahora el n�mero ingresado por el usuario (en $v0) pasar� a almacenarse en $t3
    
    #aqu� se referenciar� el primer n�mero menor y mayor, a partir del n�mero ingresado
    li $v0,1 #se indica que se cargar� un entero
    move $t1,$t3  # $t3 se mueve a $t1, que ser� el n�mero menor
    li $v0,1
    move $t2,$t3 # $t3 se mueve a $t2, que ser� el n�mero menor
    
    jal comparador #se invoca la funci�n de comparaci�n

    li $v0, 10 #este comando se utiliza para finalizar el script
    syscall
    
#fin del main, inicio de funciones

comparador:	#funci�n de comparaci�n
    li $v0, 4
    la $a0, message3	#se presenta al usuario message3
    syscall
   
    li $v0, 5		#Se solicita al usuario que ingrese un n�mero y este se carga inmediatamente a $v0
    syscall
    move $t3, $v0	#ahorael n�mero ingresado se mueve de $v0 a $t3, para luego ser comparado con nuestras referencias $t2 y $t2
    
    blt $t3, $t1, t3Menor	#Se ejecuta la comparaci�n, dependiendo si $t3 (n�mero ingresado) es menor que $t1 (n�mero menor), entonces ejecuta  funci�n t3Menor
    bgt $t3, $t2, t3Mayor	#Se ejecuta la comparaci�n, dependiendo si $t3 (n�mero ingresado) es mayor que $t2 (n�mero mayor), entonces ejecuta  funci�n t3Mayor
    
    j opciones1 		# a modo de fin

 t3Mayor:	#funci�n que se ejecutar� cuando se ingrese un n�mero mayor al referenciado 
    li $v0, 1
    move $t2, $t3 	#mueve el n�mero ingresado a $t2, nuestro n�mero mayor
    j opciones1
     
 t3Menor:	#funci�n que se ejecutar� cuando se ingrese un n�mero menor al referenciado 
    li $v0, 1
    move $t1, $t3	#mueve el n�mero ingresado a $t1, nuestro n�mero menor
    j opciones1	#Se ejecuta la funci�n que solicitar� qu� desea hacer el usuario ahora
    
   opciones1:
    li $v0, 4
    la $a0, message4 	#se presenta message 4 al usuario (men� de opciones)
    syscall
   
    li $v0, 5 		#Se solicita ingresar el n�mero de la opci�n deseadao
    syscall
    move $t0, $v0
    	
    #dependiendo se la opci�n ingresada se ejecutar�n las siguientes funciones:
    beq $t0, 1, comparador 	#Si se ingresa 1, regresa al comparador
    beq  $t0, 2, fin		#Si se ingresa 2, env�a al fin del programa
    bgt  $t0, 2, opcionIncorrecta	#Si se ingresa un n�mero mayor, se genera elmensaje de error y fin del programa
    beq  $t0, 0, opcionIncorrecta	#Si se ingresa 0, se genera elmensaje de error y fin del programa
    
   opcionIncorrecta: 	#funci�n que se ejecuta si se ingresa una opci�n incorrecta en el men� de opciones1
    li $v0, 4
    la $a0, error1	#se presenta error1 al usuario
    syscall
    la $a0, message0 	#se presenta message0 al usuario
    syscall
    li $v0, 10 		#fin de la funci�n
    syscall
       
   fin:
   #imprime n�mero mayor
    	li $v0, 4
    	la $a0, mayor
    	syscall
    	
    	li $v0, 1
    	move $a0, $t2
    	syscall
    	
#imprime n�mero menor
    	li $v0, 4
    	la $a0, menor
    	syscall
    	li $v0, 1
    	move $a0, $t1
    	syscall

#imprime el fin del programa
   	li $v0, 4
    	la $a0, message0
    	syscall
    	li $v0, 10
    	syscall
