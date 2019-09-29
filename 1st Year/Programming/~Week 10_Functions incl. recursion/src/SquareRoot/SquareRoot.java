package SquareRoot;

import javax.swing.JOptionPane;
import java.util.Scanner;

/*
 * Write a program to compute the square root of a number to the specified precision (e.g. 0.001) using the following formula:
 *
 *   SR( 1 ) = n / 2
 *    SR( n ) = ( (n / SR(n-1)) + SR(n-1)) / 2
 */
public class SquareRoot {

	public static void main(String[] args) {

		String input = JOptionPane.showInputDialog("Enter number to determine square root:");
		@SuppressWarnings("resource")
		Scanner scanner = new Scanner(input);
		double number = scanner.nextDouble();
		input = JOptionPane.showInputDialog("Enter precision required (e.g. 0.01):");
		scanner = new Scanner(input);
		double precision = scanner.nextDouble();

		double squareRoot = determineSquareRoot(number, precision);
		if (squareRoot != -1.0) {
			JOptionPane.showMessageDialog(null, "The square root of " + number + " is " + squareRoot);
			// System.out.println( "The square root of " + number + " is " + square_root );
		} else {
			JOptionPane.showMessageDialog(null, "Could not compute the square root of " + number);
			// System.out.println( "Could not compute the square root of " + number );
		}
	}

	public static double determineSquareRoot(double number, double precision) {
		if (number <= 0.0) {
			return -1.0;
		}
		double estimate = number / 2.0;
		double currentPrecision = 0.0; // Unknown.
		do {
			double improvedEstimate = (number / estimate + estimate) / 2.0;
			currentPrecision = Math.abs(improvedEstimate * improvedEstimate - number);
			estimate = improvedEstimate;
		} while (currentPrecision > Math.abs(precision));
		return estimate;
	}

}
