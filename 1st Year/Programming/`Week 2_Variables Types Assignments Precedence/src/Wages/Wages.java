package Wages;

import java.util.Scanner;

import javax.swing.JOptionPane;

/*
 * Write a program which takes in hours worked, minutes worked and an hourly pay rate,
 * and then determines the amount of pay due...
 */
public class Wages {

	public static final int MINUTES_PER_HOUR = 60;

	public static void main(String[] args) {

		while (true) {
			String input = JOptionPane.showInputDialog("Enter time worked (hours:mintes):");
			Scanner inputScanner = new Scanner(input);
			inputScanner.useDelimiter(":");
			int hoursWorked = inputScanner.nextInt();
			int minutesWorked = inputScanner.nextInt();
			input = JOptionPane.showInputDialog("Enter hourly rate (Euros.Cents):");
			inputScanner.close();
			inputScanner = new Scanner(input);
			double euroHourlyRate = inputScanner.nextDouble();
			inputScanner.close();

			double totalHoursWorked = ((double) hoursWorked) + (((double) minutesWorked) / ((double) MINUTES_PER_HOUR));
			double totalWagesInEuros = euroHourlyRate * totalHoursWorked;

			JOptionPane.showMessageDialog(null, "Having worked for " + hoursWorked + ":" + minutesWorked
					+ " at a rate of " + euroHourlyRate + " per hour,\nyou are owed wages of " + totalWagesInEuros);
		}

	}

}