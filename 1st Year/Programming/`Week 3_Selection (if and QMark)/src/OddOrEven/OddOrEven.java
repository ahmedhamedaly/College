package OddOrEven;

import java.util.Scanner;

/*
 * Write a program to determine if a number is odd or even.
 */
public class OddOrEven {

	public static void main(String[] args) {

		System.out.print("Enter your number? ");
		Scanner input = new Scanner(System.in);
		int number = input.nextInt();

		boolean odd = false; // (number%2)==1;

		if (odd) {
			System.out.println("The number " + number + " is odd.");
		} else {
			System.out.println("The number " + number + " is even.");
		}
		input.close();
	}

}