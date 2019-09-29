package RecursiveFactorial;

import java.util.Scanner;
import javax.swing.JOptionPane;

/*
 * Write a program to calculate factorial (n!) using a recursive function call.
 *
 *  n! = 1*2**(n-1)*n
 *
 * e.g. 1! = 1,   2! = 2,  3! = 6,  4! = 24,  5! = 120
 */
public class RecursiveFactorial {

	public static void main(String[] args) {

		String input = JOptionPane.showInputDialog("Enter an integer to compute its factorial:");
		@SuppressWarnings("resource")
		Scanner scanner = new Scanner(input);
		int number = scanner.nextInt();

		int factorial = ComputeFactorial(number);

		JOptionPane.showMessageDialog(null, "The factorial of " + number + " is " + factorial);

	}

	public static int ComputeFactorial(int number) {
		if (number >= 1)
			return number * ComputeFactorial(number - 1);
		else
			return 1;
	}

}