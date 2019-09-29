package DayOfTheWeek;

import java.util.Scanner;
import java.lang.Math;

public class DayOfTheWeek {

	public static final int DAYS_IN_APRIL_JUNE_SEPT_NOV = 30;
	public static final int DAYS_IN_FEBRUARY_NORMALLY = 28;
	public static final int DAYS_IN_FEBRUARY_IN_LEAP_YEAR = 29;
	public static final int DAYS_IN_MOST_MONTHS = 31;
	public static final int NUMBER_OF_MONTHS = 12;

	public static void main(String[] args) {
		System.out.println("Enter the Date (DD MM YYYY): ");
		Scanner inputScanner = new Scanner(System.in);

		// inputScanner.useDelimiter("/");
		// The delimited isnt working properly, you have to input the date as
		// day/month/year/

		int dayInput = inputScanner.nextInt();
		int monthInput = inputScanner.nextInt();
		int yearInput = inputScanner.nextInt();

		inputScanner.close();

		if (validDate(dayInput, monthInput, yearInput)) {
			System.out.println(dayOfTheWeek(dayInput, monthInput, yearInput) + ", " + dayInput + numberEnding(dayInput)
					+ " " + monthName(monthInput) + " " + yearInput);
		} else {
			System.out.println("The date is invalid");
		}
	}

	// THIS CODE IS FROM KENS TUTORIALS ON BLACKBOARD
	// This function gets the number of days in a month, (used to check valid date)
	public static int daysInMonth(int monthInput, int yearInput) {
		int year = yearInput;
		int month = monthInput;
		int dayInMonth = DAYS_IN_MOST_MONTHS;

		if ((year > 0) && (month >= 1) && (month <= NUMBER_OF_MONTHS)) {
			dayInMonth = DAYS_IN_MOST_MONTHS;
			switch (month) {
			case 2:
				boolean isLeapYear = (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0));
				dayInMonth = isLeapYear ? DAYS_IN_FEBRUARY_IN_LEAP_YEAR : DAYS_IN_FEBRUARY_NORMALLY;
				break;
			case 4:
			case 6:
			case 9:
			case 11:
				dayInMonth = DAYS_IN_APRIL_JUNE_SEPT_NOV;
				break;
			default:
				dayInMonth = DAYS_IN_MOST_MONTHS;
				break;
			}
		}
		return dayInMonth;
	}

	// THIS CODE IS FROM KENS TUTORIALS ON BLACKBOARD
	// This function checks if its a leap year or not (used to check valid date)
	public static boolean isLeapYear(int yearIsLeap) {
		boolean year = false;

		if ((yearIsLeap % 400 == 0) || ((yearIsLeap % 4 == 0) && (yearIsLeap % 100 != 0))) {
			year = true;
		}
		return year;
	}

	// THIS CODE IS FROM KENS TUTORIALS ON BLACKBOARD
	// This function checks if the date entered is valid or not
	public static boolean validDate(int dayInput, int monthInput, int yearInput) {
		if (dayInput > 0 && dayInput <= daysInMonth(monthInput, yearInput) && monthInput > 0 && monthInput <= 12) {
			return true;
		} else {
			return false;
		}
	}

	// This function gets the day of the week
	public static String dayOfTheWeek(int dayInput, int monthInput, int yearInput) {

		int dayOfTheWeekCalc;
		int y, c;
		String dayOfTheWeek = "";

		y = yearInput % 1000;
		c = yearInput / 100;

		dayOfTheWeekCalc = (int) (1 + Math.abs(dayInput + Math.floor(2.6 * (((monthInput + 9) % 12) + 1) - 0.2) + y
				+ Math.floor(y / 4) + Math.floor(c / 4) - 2 * c) % 7);

		switch (dayOfTheWeekCalc) {
		case 1:
			dayOfTheWeek = "Sunday";
			break;
		case 2:
			dayOfTheWeek = "Monday";
			break;
		case 3:
			dayOfTheWeek = "Tuesday";
			break;
		case 4:
			dayOfTheWeek = "Wednesday";
			break;
		case 5:
			dayOfTheWeek = "Thursday";
			break;
		case 6:
			dayOfTheWeek = "Friday";
			break;
		case 7:
			dayOfTheWeek = "Saturday";
			break;

		}
		return dayOfTheWeek;

	}

	// This function gets the ending of the number eg(1st, 2nd, 3rd, 4th etc..)
	public static String numberEnding(int dayInput) {
		String numberEnding = "";

		switch (dayInput) {
		case 1:
			numberEnding = "st";
			break;
		case 2:
			numberEnding = "nd";
			break;
		case 3:
			numberEnding = "rd";
			break;
		default:
			numberEnding = "th";
		}
		return numberEnding;
	}

	// This function gets the name of the month
	public static String monthName(int monthInput) {
		String monthName = "";
		switch (monthInput) {
		case 1:
			monthName = "January";
			break;
		case 2:
			monthName = "February";
			break;
		case 3:
			monthName = "March";
			break;
		case 4:
			monthName = "April";
			break;
		case 5:
			monthName = "May";
			break;
		case 6:
			monthName = "June";
			break;
		case 7:
			monthName = "July";
			break;
		case 8:
			monthName = "August";
			break;
		case 9:
			monthName = "September";
			break;
		case 10:
			monthName = "October";
			break;
		case 11:
			monthName = "November";
			break;
		case 12:
			monthName = "December";
			break;
		default:
		}

		return monthName;
	}
}
