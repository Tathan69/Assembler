.data

#Script elaborado como desarrollo de los puntos 1 y 2 del taller 1 de la materia "Estructura de computadores"
# Estos consisten en: 1. Número mayor (mínimo 3 números) y 2. Número menor (mínimo 3 números)


mayor: .asciiz " El número mayor es: "
menor: .asciiz "\n El número menor es: "
iguales: .asciiz "Los números son iguales!"
message0: .asciiz "\n Se ha finalizado el programa!"
message1: .asciiz "\n Bienvenido al comparador de números"
message2: .asciiz "\n Para iniciar, ingresa el primer número: \n"
message3: .asciiz "\n Ingresa otro número:\n"
message4: .asciiz "\n Qué deseas hacer ahora?\n1. Ingresa 1 para registrar otro número\n2. Ingresa 2 para finalizar y concoer el número mayor y el número menor\n"
error1: .asciiz "Esta no es una opción válida \n"

.text
main:
    #Se presenta el primer mensaje al usuario
    li $v0, 4 		#se indica que se cargará un string
    la $a0, message1 	#se invoca message1
    syscall		#Es importante mencionar que syscall funciona para que el sistema ejecute el cógido que lo precede
    
    #Se presenta el segundo mensaje al usuario
    li $v0, 4		#se indica que se cargará un string
    la $a0, message2 	#se invoca message2
    syscall
    
    #Se solicita al usuario que ingrese un número, para esto se usa el 5 con el comando de carga inmediata
    li $v0, 5
    syscall
    move $t3, $v0 #Ahora el número ingresado por el usuario (en $v0) pasará a almacenarse en $t3
    
    #aquí se referenciará el primer número menor y mayor, a partir del número ingresado
    li $v0,1 #se indica que se cargará un entero
    move $t1,$t3  # $t3 se mueve a $t1, que será el número menor
    li $v0,1
    move $t2,$t3 # $t3 se mueve a $t2, que será el número menor
    
    jal comparador #se invoca la función de comparación

    li $v0, 10 #este comando se utiliza para finalizar el script
    syscall
    
#fin del main, inicio de funciones

comparador:	#función de comparación
    li $v0, 4
    la $a0, message3	#se presenta al usuario message3
    syscall
   
    li $v0, 5		#Se solicita al usuario que ingrese un número y este se carga inmediatamente a $v0
    syscall
    move $t3, $v0	#ahorael número ingresado se mueve de $v0 a $t3, para luego ser comparado con nuestras referencias $t2 y $t2
    
    blt $t3, $t1, t3Menor	#Se ejecuta la comparación, dependiendo si $t3 (número ingresado) es menor que $t1 (número menor), entonces ejecuta  función t3Menor
    bgt $t3, $t2, t3Mayor	#Se ejecuta la comparación, dependiendo si $t3 (número ingresado) es mayor que $t2 (número mayor), entonces ejecuta  función t3Mayor
    
    j opciones1 		# a modo de fin

 t3Mayor:	#función que se ejecutará cuando se ingrese un número mayor al referenciado 
    li $v0, 1
    move $t2, $t3 	#mueve el número ingresado a $t2, nuestro número mayor
    j opciones1
     
 t3Menor:	#función que se ejecutará cuando se ingrese un número menor al referenciado 
    li $v0, 1
    move $t1, $t3	#mueve el número ingresado a $t1, nuestro número menor
    j opciones1	#Se ejecuta la función que solicitará qué desea hacer el usuario ahora
    
   opciones1:
    li $v0, 4
    la $a0, message4 	#se presenta message 4 al usuario (menú de opciones)
    syscall
   
    li $v0, 5 		#Se solicita ingresar el número de la opción deseadao
    syscall
    move $t0, $v0
    	
    #dependiendo se la opción ingresada se ejecutarán las siguientes funciones:
    beq $t0, 1, comparador 	#Si se ingresa 1, regresa al comparador
    beq  $t0, 2, fin		#Si se ingresa 2, envía al fin del programa
    bgt  $t0, 2, opcionIncorrecta	#Si se ingresa un número mayor, se genera elmensaje de error y fin del programa
    beq  $t0, 0, opcionIncorrecta	#Si se ingresa 0, se genera elmensaje de error y fin del programa
    
   opcionIncorrecta: 	#función que se ejecuta si se ingresa una opción incorrecta en el menú de opciones1
    li $v0, 4
    la $a0, error1	#se presenta error1 al usuario
    syscall
    la $a0, message0 	#se presenta message0 al usuario
    syscall
    li $v0, 10 		#fin de la función
    syscall
       
   fin:
   #imprime número mayor
    	li $v0, 4
    	la $a0, mayor
    	syscall
    	
    	li $v0, 1
    	move $a0, $t2
    	syscall
    	
#imprime número menor
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
