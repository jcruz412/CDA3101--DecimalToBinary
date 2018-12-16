


 
.section .data


.data
#Formats
stringForm:		.asciz "%s"
numForm:		.asciz "%d"
charForm:		.asciz "%c"

# Needed strings and Prompts
prompt:			.asciz "Input a decimal number\n"


#Creates new line or enter
flush: .asciz "\n"

#Space in Memory for Variables
binary: .space 100
numInput: .space 100
counter: .space 100

.text
.global main

main:

	#Prompts the user to input an integer
	ldr x0,=stringForm
	ldr x1, = prompt
	bl printf

	#Gets the user's input
	ldr x0, = numForm
	ldr x1, = numInput
	bl scanf


	#Initialize counter/ offset 
	mov x2, #0

	#Branch to getModulo
	b getModulo

#Gets the length of the string using stack
getModulo:

	#Load input into x8
	ldr x3, = numInput 
	ldr x8,[x3, #0]

	ldr x5, = counter
	ldr x2, [x5, #0]

	#Get modulo and then divide by two
	and x4, x8, #1

	#place asci mod result into x4
	add x4, x4, #48
	
	
	#store character byte 
	ldr x7, = binary
	strb w4, [x7, x2]

	#increment counter
	add x2, x2, #1

	#Store counter into memory
	str x2,[x5, #0]

	#Load input into x8
	ldr x3, = numInput 
	lsr x8, x8, #1
	str x8,[x3, #0]

	#loop to Print if Quotient is zero
	cmp x8, #0
	b.eq Display

	#Print Quotients
	#ldr x0, = numForm
	#mov x1, x8
	#bl printf
	#ldr x0, = flush
	#bl printf

	#quotient is not zero. Run through loop again
	b getModulo

Display:
	
	#Loading the coutner
	ldr x0,=numForm
	ldr x1, = counter
	ldr x2,[x1, #0]

	#Check if counter is 0
	cmp x2, #-1
	b.eq exit

	
	#Decrement counter because going backwards in memory
	sub x2, x2, #1
	str x2,[x1, #0]
	
	#Print character one by one
	#ldr x0,= charForm
	ldr x6, = binary
	ldrb w1, [x6,x2]
	ldr x0,= charForm
	bl printf

	b Display


#exit program
exit:
	
	ldr x0, = stringForm
	ldr x1, = flush
	bl printf

	#Exit out
	mov x8, #93
	mov x0, #42
	svc #0


