package GCD;

import java.util.Scanner;
import javax.swing.JOptionPane;

/*
 * Write a program which, given two integers (from the user) will compute the
 * Greatest Common Divisor (GCD) of those numbers.  As part of your solution
 * write and use the following functions:
 *  - getGreatestCommonDivisor which takes to integers and returns their
 *    greatest common divisor.
 *  - getNextDivisor() which takes a number and a divisor (of that number)
 *    and returns the next highest divisor of the number.  If there is no
 *    such divisor -1 is returned.
 * Ensure that you handle all possible errors.
 */
public class GCD {

	public static void main(String[] args) {

		try {
			String input = JOptionPane.showInputDialog("Enter first number:");
			@SuppressWarnings("resource")
			Scanner scanner = new Scanner(input);
			int number1 = scanner.nextInt();
			input = JOptionPane.showInputDialog("Enter second number:");
			scanner = new Scanner(input);
			int number2 = scanner.nextInt();
			if ((number1 <= 0) || (number2 <= 0))
				throw new NumberFormatException();

			int gcd = getGreatestCommonDivisor(number1, number2);

			JOptionPane.showMessageDialog(null,
					"The greatest common divisor of " + number1 + " and " + number2 + " is " + gcd);
		} catch (NullPointerException exception) {
		} catch (java.util.NoSuchElementException exception) {
			JOptionPane.showMessageDialog(null, "No number entered.", "Error", JOptionPane.ERROR_MESSAGE);
		} catch (NumberFormatException exception) {
			JOptionPane.showMessageDialog(null, "Numbers must be greater than 0.", "Error", JOptionPane.ERROR_MESSAGE);
		}
	}

	// Returns the largest number which is evenly divisible into two provided
	// numbers.
	public static int getGreatestCommonDivisor(int number1, int number2) {
		int gcd = 1;
		int divisor = 1;
		while ((divisor != -1) && (divisor < number2)) {
			if (number2 % divisor == 0) {
				gcd = divisor;
			}
			divisor = getNextDivisor(divisor, number1);
		}
		return gcd;
	}

	// Given a number and a divisor, find and return the next highest
	// divisor of the number. If there is no such divisor return -1.
	public static int getNextDivisor(int lastDivisor, int number) {

		if ((lastDivisor > 0) && (lastDivisor < number) && (number % lastDivisor == 0)) {
			int divisor = lastDivisor;
			do {
				divisor++;
			} while ((divisor < number) && (number % divisor != 0));
			if (number % divisor == 0) {
				return divisor;
			}
		}
		return -1;
	}
}