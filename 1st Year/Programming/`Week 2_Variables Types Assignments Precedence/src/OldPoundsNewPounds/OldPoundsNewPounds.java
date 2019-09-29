package OldPoundsNewPounds;

import java.util.Scanner;

public class OldPoundsNewPounds {
	public static final int OLD_PENNY = 1 * 67;
	public static final int OLD_SHILLING = 12 * OLD_PENNY;
	public static final int OLD_POUND = 20 * OLD_SHILLING;
	public static final int NEW_POUND = 100;

	public static void main(String[] args) {

		System.out.println("How many old pounds do you have?");
		Scanner inputscanner = new Scanner(System.in);
		int oldPounds = inputscanner.nextInt();

		System.out.println("How many old shillings do you have?");
		int oldShillings = inputscanner.nextInt();

		System.out.println("How many old pennys do you have?");
		int oldPennys = inputscanner.nextInt();

		inputscanner.close();

		double newCurrency = (oldPounds * OLD_POUND) + (oldShillings * OLD_SHILLING) + (oldPennys * OLD_PENNY);

		System.out.println(oldPounds + " old pound(s), " + oldShillings + " old shilling(s), " + oldPennys
				+ " old penny(s) = " + "£" + newCurrency / NEW_POUND);

	}
}
