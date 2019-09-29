package DaysInTheMonth;

import java.util.Scanner;

import javax.swing.JOptionPane;

/*
 * Given a month (1-12) and a year determine the number of days
 * in the month (i.e. assume that int month and int year are
 * already defined).
 * Note:  There are 28 or 29 days in February, 30 days in April,
 *        June, September and November, and 31 days in all the
 *        other months.
 */
public class DaysInTheMonth {

	public static final int DAYS_IN_APRIL_JUNE_SEPT_NOV = 30;
	public static final int DAYS_IN_FEBRUARY_NORMALLY = 28;
	public static final int DAYS_IN_FEBRUARY_IN_LEAP_YEAR = 29;
	public static final int DAYS_IN_MOST_MONTHS = 31;
	public static final int NUMBER_OF_MONTHS = 12;

	@SuppressWarnings("resource")
	public static void main(String[] args) {

		String input = JOptionPane.showInputDialog("Enter year:");
		Scanner scanner = new Scanner(input);
		int year = scanner.nextInt();
		input = JOptionPane.showInputDialog("Enter month (1-" + NUMBER_OF_MONTHS + "):");
		scanner = new Scanner(input);
		int month = scanner.nextInt();

		if ((year > 0) && (month >= 1) && (month <= NUMBER_OF_MONTHS)) {
			int daysInMonth = DAYS_IN_MOST_MONTHS;
			switch (month) {
			case 2:
				boolean isLeapYear = (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0));
				daysInMonth = isLeapYear ? DAYS_IN_FEBRUARY_IN_LEAP_YEAR : DAYS_IN_FEBRUARY_NORMALLY;
				break;
			case 4:
			case 6:
			case 9:
			case 11:
				daysInMonth = DAYS_IN_APRIL_JUNE_SEPT_NOV;
				break;
			default:
				daysInMonth = DAYS_IN_MOST_MONTHS;
				break;
			}
			String monthString = "";
			switch (month) {
			case 1:
				monthString = "January";
				break;
			case 2:
				monthString = "February";
				break;
			case 3:
				monthString = "March";
				break;
			case 4:
				monthString = "April";
				break;
			case 5:
				monthString = "May";
				break;
			case 6:
				monthString = "June";
				break;
			case 7:
				monthString = "July";
				break;
			case 8:
				monthString = "August";
				break;
			case 9:
				monthString = "September";
				break;
			case 10:
				monthString = "October";
				break;
			case 11:
				monthString = "November";
				break;
			case 12:
				monthString = "December";
				break;
			default:
			}
			JOptionPane.showMessageDialog(null,
					"There are " + daysInMonth + " days in " + monthString + " in " + year + ".");
		} else {
			JOptionPane.showMessageDialog(null, "Invalid month / year.", "Error", JOptionPane.ERROR_MESSAGE);
			scanner.close();
		}
	}

}
