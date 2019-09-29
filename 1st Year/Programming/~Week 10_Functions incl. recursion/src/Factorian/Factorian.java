package Factorian;

import java.util.Scanner;

public class Factorian {

	public static void main(String[] args) {
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		String inputString = "";
		do {
			System.out.print("Enter number (or 'quit')>");
			input = new Scanner(System.in);
			if (input.hasNextInt()) {
				int number = input.nextInt();
				System.out.println(
						"The number " + number + " is " + (isFactorian(number) ? "" : "not ") + "a Factorian.");

			} else if (input.hasNext())
				inputString = input.next();
		} while (!inputString.equalsIgnoreCase("QUIT"));
	}

	public static int computeFactorial(int number) {
		int result = 1;
		for (int index = 2; (index <= number); index++)
			result *= index;
		return result;
	}

	public static boolean isFactorian(int number) {
		int currentNumber = number;
		int sumOfFactorials = 0;
		do {
			sumOfFactorials += computeFactorial(currentNumber % 10);
			currentNumber /= 10;
		} while (currentNumber != 0);
		return (number == sumOfFactorials);
	}

}
