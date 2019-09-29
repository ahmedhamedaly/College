package ValidDate;

import java.util.Scanner;
import javax.swing.JOptionPane;

/*
 * Write a program to determine is an entered date (day/month/year) is valid.
 * As part of the program write and use the following routines:
 *  - validDate() which takes a year, month and day and returns whether or not
 *  the date is valid
 *  - daysInMonth() which takes a month (between 1 and 12) and year, and returns
 *    the number of days in the month.
 *  - isLeapYear() which takes a year and return whether or not it is a leap year.
 */
public class ValidDate {

	public static final int DAYS_IN_APRIL_JUNE_SEPT_NOV = 30;
	public static final int DAYS_IN_FEBRUARY_NORMALLY = 28;
	public static final int DAYS_IN_FEBRUARY_IN_LEAP_YEAR = 29;
	public static final int DAYS_IN_MOST_MONTHS = 31;
	public static final int NUMBER_OF_MONTHS = 12;

	public static void main(String[] args) {

		try {
			String input = JOptionPane.showInputDialog("Enter date (day/month/year):");
			@SuppressWarnings("resource")
			Scanner scanner = new Scanner(input);
			scanner.useDelimiter("/");
			int day = scanner.nextInt();
			int month = scanner.nextInt();
			int year = scanner.nextInt();

			if (validDate(day, month, year)) {
				JOptionPane.showMessageDialog(null, "" + day + "/" + month + "/" + year + " is a valid date.");
			} else {
				JOptionPane.showMessageDialog(null, "" + day + "/" + month + "/" + year + " is not a valid date.",
						"Error", JOptionPane.ERROR_MESSAGE);
			}
		} catch (NullPointerException exception) {
		} catch (java.util.NoSuchElementException exception) {
			JOptionPane.showMessageDialog(null, "No number entered.", "Error", JOptionPane.ERROR_MESSAGE);
		}

	}

	public static boolean validDate(int day, int month, int year) {
		return ((year >= 0) && (month >= 1) && (month <= NUMBER_OF_MONTHS) && (day >= 1)
				&& (day <= daysInMonth(month, year)));
	}

	public static int daysInMonth(int month, int year) {
		int numberOfDaysInMonth = DAYS_IN_MOST_MONTHS;
		switch (month) {
		case 2:
			numberOfDaysInMonth = isLeapYear(year) ? DAYS_IN_FEBRUARY_IN_LEAP_YEAR : DAYS_IN_FEBRUARY_NORMALLY;
			break;
		case 4:
		case 6:
		case 9:
		case 11:
			numberOfDaysInMonth = DAYS_IN_APRIL_JUNE_SEPT_NOV;
			break;
		default:
			numberOfDaysInMonth = DAYS_IN_MOST_MONTHS;
			break;
		}
		return numberOfDaysInMonth;
	}

	public static boolean isLeapYear(int year) {
		return (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0));
	}
}
