package AverageStandardDeviation;

import java.util.Scanner;

import javax.swing.JOptionPane;

/*
 * Write a program which takes in 3 numbers and computes their average
 * and standard deviation.
 */
public class AverageStandardDeviation {

	public static void main(String[] args) {

		String input = JOptionPane.showInputDialog("Enter three numbers separated by spaces:");
		Scanner inputScanner = new Scanner(input);
		double number1 = inputScanner.nextDouble();
		double number2 = inputScanner.nextDouble();
		double number3 = inputScanner.nextDouble();
		inputScanner.close();

		double average = (number1 + number2 + number3) / 3.0;
		double variance = ((number1 - average) * (number1 - average) + (number2 - average) * (number2 - average)
				+ (number3 - average) * (number3 - average)) / 3.0;
		double standardDeviation = Math.sqrt(variance);

		JOptionPane.showMessageDialog(null, "For numbers " + number1 + ", " + number2 + ", " + number3
				+ ", the average is " + average + " and the standard deviation is " + standardDeviation);
	}

}