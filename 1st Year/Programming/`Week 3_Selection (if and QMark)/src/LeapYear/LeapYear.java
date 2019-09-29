package LeapYear;

import java.util.Scanner;

import javax.swing.JOptionPane;

/*
 * Write a program to determine is the year entered is a leap year or not.  A year
 * is a leap year if it is divisible by 4  (e.g. the year 2012 is a leap year) unless
 * it is divisible by 100 (e.g. the year 2100 is not a leap year) unless it is
 * divisible by 400 (e.g. the year 2000 is a leap year).
 */
public class LeapYear {

	public static void main(String[] args) {

		String input = JOptionPane.showInputDialog("Enter year:");
		Scanner scanner = new Scanner(input);
		int year = scanner.nextInt();

		boolean leapYear = false;
		if (year % 400 == 0) {
			leapYear = true;
		} else if (year % 100 == 0) {
			// leapYear = false;
		} else if (year % 4 == 0) {
			leapYear = true;
		}
		// else
		// {
		// leapYear = false;
		// }

		// Alternative code:
		// if (leapYear)
		// JOptionPane.showMessageDialog(null, "" + year +
		// " is a leap year.");
		// else JOptionPane.showMessageDialog(null, "" + year +
		// " is not a leap year.");

		JOptionPane.showMessageDialog(null, "" + year + " is " + (leapYear ? "" : "not ") + "a leap year.");
		scanner.close();
	}

}
