package ReverseDigits2;

import java.util.Scanner;
import javax.swing.JOptionPane;

/*
 * Write a program to reverse the order of the digits in a user
 * supplied integer.  For example if the user entered 395 the
 * system would output 593.
 */
public class ReverseDigits2 {

	public static void main(String[] args) {

		try {
			String input = JOptionPane.showInputDialog("Enter number to reverse:");
			@SuppressWarnings("resource")
			Scanner scanner = new Scanner(input);
			int number = scanner.nextInt();

			int reversedNumber = 0;
			int remainingNumber = number;
			while (remainingNumber > 0) {
				reversedNumber = reversedNumber * 10 + remainingNumber % 10;
				remainingNumber = remainingNumber / 10;
			}

			JOptionPane.showMessageDialog(null, "The reverse of " + number + " is " + reversedNumber);
		} catch (NullPointerException exception) {
		} catch (java.util.NoSuchElementException exception) {
			JOptionPane.showMessageDialog(null, "No number entered.");
		}
	}

}
