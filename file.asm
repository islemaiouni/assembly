    .data
    num: .word 5     #number to calculate factorial of
    result: .word 1 #initialize result as 1

    .text
    .globl main
main:
    li $a0, 5       #load number to calculate factorial of
    li $s0, 1       #load initial result
    jal factorial   #jump to factorial function
    move $a0, $v0   #move result to $a0 for printing
    li $v0, 1
    syscall
    li $v0, 10
    syscall

factorial:
    addi $sp, $sp, -4 #allocate space on stack
    sw $ra, 0($sp)   #save return address
    beq $a0, 1, end  #if number is 1, return 1
    addi $a0, $a0, -1 #decrement number
    jal factorial    #recursive call
    lw $ra, 0($sp)   #restore return address
    addi $sp, $sp, 4 #deallocate stack space
    mul $v0, $v0, $a0 #multiply result by number
end:
    jr $ra           #return to main




/////



data
string1: .asciiz "Enter a number:"
string2: .asciiz "Enter the secon number:"
string3: .asciiz "Sum:"
endLine: .asciiz "\n"

.text
main:

	li $v0 , 4				#print string1 
	la $a0 , string1  
	syscall

	li $v0 , 5	 			#read integer
	syscall
	
	move $t0,$v0            #Girdiğimiz integer değeri temporary(geçici) değere akttardık.
	
	li $v0 , 4
	la $a0 , endLine        #Boşluk vermek için. 
	syscall
	
	li $v0 , 4
	la $a0 , string2        
	syscall
	
	li $v0 , 5
	syscall
	
	move $t1,$v0             
	
	li $v0 , 4
	la $a0 , string3
	syscall
	
	add $t2,$t1,$t0			#İki tane yazdığımız integer değerleri toplayıp $t2 temporary değere aktardık.s
	li $v0, 1			    #print integer
	move $a0, $t2			#Temporary değeri a0 a aktardık.
	syscall
	
		 
	li $v0, 10              #exit
	syscall
	
//

    .data
    n: .word 10    #index of Fibonacci number to calculate

    .text
    .globl main
main:
    li $a0, 10     #load index
    jal fibonacci  #call fibonacci function
    move $a0, $v0  #move result to $a0 for printing
    li $v0, 1
    syscall
    li $v0, 10
    syscall

fibonacci:
    addi $sp, $sp, -8 #allocate space on stack
    sw $ra, 0($sp)   #save return address
    sw $a0, 4($sp)   #save n
    beq $a0, 0, end0  #if n is 0, return 0
    beq $a0, 1, end1  #if n is 1, return 1
    addi $a0, $a0, -1 #decrement n
    jal fibonacci    #recursive call to calculate fib(n-1)
    lw $ra, 0($sp)   #restore return address
    lw $a0, 4($sp)   #restore n
    addi $a0, $a0, -2 #decrement n
    jal fibonacci    #recursive call to calculate fib(n-2)
    lw $ra, 0($sp)   #restore return address
    add $v0, $v0, $v0 #add fib(n-1) and fib(n-2)
    addi $sp, $sp, 8 #deallocate stack space
    jr $ra           #return to main

end0:
    li $v0, 0
    jr $ra
end1:
    li $v0, 1
    jr $ra



// 

# This program will find the maximum value in an array

# Array of values
.data
array: .word 5, 3, 8, 12, 1

# Length of the array
.set array_length, 5

# Initialize the max value to the first value in the array
la $t0, array
lw $t1, 0($t0)

# Initialize the counter
li $t2, 1

loop:
    # Load the current value in the array
    lw $t3, 0($t0)
    addi $t0, $t0, 4

    # Compare the current value with the max value
    bgt $t3, $t1, update_max
    addi $t2, $t2, 1
    bne $t2, array_length, loop
    j end

update_max:
    move $t1, $t3
    addi $t2, $t2, 1
    bne $t2, array_length, loop

end:
    # Print the max value
    li $v0, 1
    move $a0, $t1
    syscall

# Exit the program
li $v0, 10
syscall




//swap 


    .data
    .align 2
a: .word 1, 2, 3, 4, 5
    .text
    .globl main
main:
    lw $s0, a # load the address of the array into $s0
    addi $s1, $0, 5 # size = 5
    addi $s2, $0, 0 # i = 0

outer_loop:
    beq $s2, $s1, end # if i == size then jump to end
    addi $s3, $s2, 1 # j = i + 1

inner_loop:
    beq $s3, $s1, outer_loop_end # if j == size then jump to outer_loop_end
    lw $t0, 0($s0, $s2) # t0 = a[i]
    lw $t1, 0($s0, $s3) # t1 = a[j]
    bgt $t0, $t1, outer_loop_end # if a[i] > a[j] then jump to outer_loop_end
    move $t2, $t0 # temp = a[i]
    sw $t1, 0($s0, $s2) # a[i] = a[j]
    sw $t2, 0($s0, $s3) # a[j] = temp
    addi $s3, $s3, 1 # j = j + 1
    j inner_loop # jump to inner_loop

outer_loop_end:
    addi $s2, $s2, 1 # i = i + 1
    j outer_loop # jump to outer_loop

end:
    li $v0, 4
    la $a0, prompt
    move $a1, $s2
    syscall

    li $v0, 10
    syscall



//buble sort  
#include <stdio.h>

void bubble_sort(int array[], int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 1; j < size; j++) {
            if (array[j] < array[i]) {
                int temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
        }
    }
}

int main() {
    int array[] = {7, 4, 5, 2, 8, 1, 6, 3};
    int size = sizeof(array) / sizeof(array[0]);
    bubble_sort(array, size);
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
    return 0;
}
