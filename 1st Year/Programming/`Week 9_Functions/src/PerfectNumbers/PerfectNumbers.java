package PerfectNumbers;

/*
 * Write a program to find and print out all perfect numbers between 1 and 10,000.
 * A number is perfect if the sum of its divisors equals the number itself.  As
 * part of your program write two routines:
 * - isPerfectNumber() which takes a number a return whether it is perfect or not.
 * - getNextDivisor() which takes a number and a divisor (of that number) and returns
 *   the next highest divisor of the number.  If there is no such divisor -1 is returned.
 */
public class PerfectNumbers {

	public static final int MAX_NUMBER = 10000;

	public static void main(String args[]) {
		for (int number = 1; (number <= MAX_NUMBER); number++) {
			if (isPerfectNumber(number)) {
				System.out.println("The number " + number + " is a perfect number.");
			}
		}
	}

	// Check if the passed number is a perfect number (i.e. if the sum of
	// its divisors equals the number itself).
	private static boolean isPerfectNumber(int number) {
		int sumOfDivisors = 0;
		int currentDivisor = 1;
		while ((currentDivisor != number) && (currentDivisor != -1)) {
			sumOfDivisors += currentDivisor;
			currentDivisor = getNextDivisor(currentDivisor, number);
		}
		return (number == sumOfDivisors);
	}

	// Given a number and a divisor, find and return the next highest
	// divisor of the number. If there is no such divisor return -1.
	private static int getNextDivisor(int lastDivisor, int number) {
		if ((lastDivisor > 0) && (lastDivisor < number) && (number % lastDivisor == 0)) {
			int divisor = lastDivisor;
			do {
				divisor++;
			} while (number % divisor != 0);
			return divisor;
		}
		return -1;
	}
}
