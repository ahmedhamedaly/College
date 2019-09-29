package Polynomial;

import java.util.Scanner;

// Answer with incomplete error checking which does not deal with a==0 or a==0,b==0 or complex roots.
public class Polynomial {
	public static void main(String[] args) {
		boolean finished = false;
		Scanner inputScanner = new Scanner(System.in);
		do {
			System.out.print(
					"Enter the coefficients of your second order polynomial separated by spaces (or enter quit): ");
			if (inputScanner.hasNextDouble()) {
				double a = 0.0, b = 0.0, c = 0.0;
				a = inputScanner.nextDouble();
				b = inputScanner.nextDouble();
				c = inputScanner.nextDouble();
				double root1 = (-b + Math.sqrt(b * b - 4.0 * a * c)) / (2.0 * a);
				double root2 = (-b - Math.sqrt(b * b - 4.0 * a * c)) / (2.0 * a);
				System.out.println("The roots to this equation are x=" + root1 + " and x=" + root2);
			} else if (inputScanner.hasNext("quit"))
				finished = true;
			else
				inputScanner.next();
		} while (!finished);
		inputScanner.close();
	}
}