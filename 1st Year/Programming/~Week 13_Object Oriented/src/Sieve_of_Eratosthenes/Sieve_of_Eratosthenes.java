/* SELF ASSESSMENT  
   1.  createSequence:
Did I use the correct method definition?
Mark out of 5: 5
Comment: Ye, they are the correct function definitions
Did I create an array of size n (passed as the parameter) and initialise it?
Mark out of 5: 5 
Comment: yes, i initialised it by n
Did I return the correct item?
Mark out of 5: 5
Comment: it didnt return anything, it just initialised it
   2.  crossOutMultiples
Did I use the correct method definition?
Mark out of 5: 5
Comment: Ye, they are the correct function definitions
Did I ensure the parameters are not null and one of them is a valid index into the array
Mark out of 2: 2
Comment: yes, if its null it ends, if not then it goes through the array
Did I loop through the array using the correct multiple?
Mark out of 5: 5
Comment: yea, it loops through the array properly for any value
Did I cross out correct items in the array that were not already crossed out?
Mark out of 3: 3
Comment: yes, I used 0 to "cross" them out
   3.  sieve   
Did I have the correct function definition?
Mark out of 5: 5
Comment: Ye, they are the correct function definitions
Did I make calls to other methods?
Mark out of 5: 5
Comment: ye, this was the only function being called     
Did I return an array with all non-prime numbers are crossed out?
Mark out of 2: 2
Comment: ye, after theres a change in the function
   4.  sequenceTostring  
Did I have the correct function definition?
Mark out of 5: 5
Comment: Ye, they are the correct function definitions
Did I ensure the parameter to be used is not null?
Mark out of 3: 3
Comment: ye, it looped through until it reached the end of the array
Did I Loop through the array updating the String variable with the non-crossed out numbers and the crossed numbers in brackets? 
Mark out of 10: 10
Comment: yes, it did this whenever there is a change in the array   
   5.  nonCrossedOutSubseqToString  
Did I have the correct function definition
Mark out of 5: 5
Comment: Ye, they are the correct function definitions       
Did I ensure the parameter to be used is not null?  
Mark out of 3: 3
Comment: it looped around it perfectly so yes
Did I loop through the array updating the String variable with just the non-crossed out numbers? 
Mark out of 5: 5
Comment: I did that, it works perfectly
   6.  main  
Did I ask  the user for input n and handles input errors?  
Mark out of 5: 5
Comments: I handled all input errors.
Did I make calls to other methods (at least one)?
Mark out of 5: 5
Comment: yes, I called the sieve function as it did everything
Did I print the output as shown in the question?  
Mark out of 5: 5
Comment:  The output from my program is exactly the same as the one in the question.
   7.  Overall
Is my code indented correctly?
Mark out of 4: 4
Comments: The code was indented correctly throughout the whole code
Do my variable names make sense?
Mark out of 4: 4
Comments: my variable names made perfect sense to anyone trying to understand my program
Do my variable names, method names and class name follow the Java coding standard
Mark out of 4: 4
Comments: yes, I used the right variable names and function names....
      Total Mark out of 100 (Add all the previous marks): 100 
 */

package Sieve_of_Eratosthenes;

import java.util.Scanner;

public class Sieve_of_Eratosthenes {
	public static void main(String[] args) {
		Scanner inputScanner = new Scanner(System.in);

		System.out.println("Enter int >= 2: ");

		if (!inputScanner.hasNextInt()) {
			System.out.println("Invalid Input! Please try again.");
			inputScanner.next();
			main(args);
		}

		try {

			int inputNumber = inputScanner.nextInt();
			inputNumber += 1;

			int[] sieveArray = new int[inputNumber];
			int[] sieveDup = new int[inputNumber];

			sieve(inputNumber, sieveArray, sieveDup);

		} catch (Exception lessThanTwo) {
			System.out.println("The number you have entered is less than 2! Please try again.");
			main(args);
		}
	}

	public static void createSequence(int inputNumber, int[] sieveArray) {
		int counter = 0;

		while (counter < inputNumber) {
			sieveArray[counter] = counter;
			counter++;
		}
	}

	public static void crossOutHigherMultiples(int currentNumber, int[] sieveArray, int inputNumber) {
		int counter = 0;

		while (counter < sieveArray.length) {
			if (counter != 0 && counter != currentNumber) {
				sieveArray[(counter)] = 0;
			}
			counter += currentNumber;
		}
	}

	public static void sieve(int inputNumber, int[] sieveArray, int[] sieveDup) {
		String allNumbers = "";

		createSequence(inputNumber, sieveArray);

		for (int i = 1; i + 1 < sieveArray.length; i++) {
			allNumbers += sieveArray[i + 1] + ", ";
		}
		System.out.println(allNumbers.substring(0, allNumbers.length() - 2));

		for (int i = 0; i + 1 < sieveArray.length; i++) {
			if (sieveArray[i] > 1) {

				int currentNumber = sieveArray[i];
				crossOutHigherMultiples(currentNumber, sieveArray, inputNumber);

				for (int j = 0; j < sieveArray.length; j++) {
					if (sieveArray[j] != sieveDup[j]) {
						System.out.println(sequenceToString(sieveArray));
						System.arraycopy(sieveArray, 0, sieveDup, 0, sieveArray.length);
					}
				}
			}
		}
		System.out.println(nonCrossedOutSubseqToString(sieveArray));
	}

	public static String sequenceToString(int[] sieveArray) {
		int counter = 2;
		String sequence = "";

		while (counter < sieveArray.length) {
			if (sieveArray[counter] != 0) {
				sequence += (sieveArray[counter]) + ", ";
			} else {
				sequence += ("[" + (counter) + "], ");
			}
			counter++;
		}
		String sequenceToString = sequence.substring(0, sequence.length() - 2);
		return sequenceToString;
	}

	public static String nonCrossedOutSubseqToString(int[] sieveArray) {
		int counter = 2;
		String nonCrossedOutSubseq = "";

		while (counter < sieveArray.length) {
			if (sieveArray[counter] != 0) {
				nonCrossedOutSubseq += sieveArray[counter] + ", ";
			}
			counter++;
		}
		String nonCrossedOutSubseqToString = nonCrossedOutSubseq.substring(0, nonCrossedOutSubseq.length() - 2);
		return nonCrossedOutSubseqToString;
	}
}
