package LeapYears;

import java.util.Scanner;

/*
 * Write a program to determine what years are leap years between two (user)
 * specified years.
 * For example, leap year between 2000 and 2023
 *   2000 is a leap year.
 *   2004 is a leap year.
 *   2008 is a leap year.
 *   2012 is a leap year.
 *   2016 is a leap year.
 *   2020 is a leap year.
 */
public class LeapYears {

	public static void main(String[] args) {

		Scanner input = new Scanner(System.in);
		System.out.print("Enter the first year: ");
		int firstYear = input.nextInt();
		System.out.print("Enter the last year: ");
		int lastYear = input.nextInt();

		for (int year = firstYear; (year <= lastYear); year++) {
			if ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))) {
				System.out.println("" + year + " is a leap year.");
			}
		}
		input.close();

	}

}