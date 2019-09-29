package PrimeFinder;

import java.util.Scanner;

// A Sports body has decided that to encourage participants in a competition
// they will award prizes to those in 1st, 2nd and 3rd place AND will also
// give prizes to anyone whose place number is prime (e.g. the runners in
// 5th, 7th, 11th, 13th, ... places will also get prizes).
// Write a program which outputs the list of which competitors should get 
// prizes for a user supplied number of competitors.  The output must have
// the following form:  (assuming that the user has entered 25 as the number
// of competitors...)
// Prizes should be given to the competitors who come 1st, 2nd, 3rd, 5th, 7th, 11th, 13th, 17th, 19th, 23rd
// Your solution must check if numbers are prime and must use at least one
// switch statement.
public class PrimeFinder {

	public static void main(String[] args) {

		System.out.print("Please enter the number of competitors: ");
		Scanner inputScanner = new Scanner(System.in);
		if (inputScanner.hasNextInt()) {
			int numberOfCompetitors = inputScanner.nextInt();
			String outputString = "Prizes should be given to the competitors who come 1st";
			for (int currentNumber = 2; (currentNumber <= numberOfCompetitors); currentNumber++) {
				// Check if current number is a prime number
				boolean isPrime = true;
				for (int divisor = 2; ((divisor < currentNumber) && (isPrime)); divisor++) {
					if (currentNumber % divisor == 0)
						isPrime = false;
				}
				if (isPrime) {
					outputString = outputString + ", " + currentNumber;
					if (((currentNumber % 100) / 10) == 1)
						outputString += "th";
					else {
						switch (currentNumber % 10) {
						case 1:
							outputString += "st";
							break;
						case 2:
							outputString += "nd";
							break;
						case 3:
							outputString += "rd";
							break;
						default:
							outputString += "th";
							break;
						}
					}
				}
			}
			System.out.println(outputString);
		}
		inputScanner.close();
	}

}
