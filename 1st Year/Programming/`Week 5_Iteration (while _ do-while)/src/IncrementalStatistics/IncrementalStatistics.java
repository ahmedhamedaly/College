package IncrementalStatistics;

import java.util.Scanner;

public class IncrementalStatistics {
	public static void main (String[] args)
	{
		double lastAverage = 0.0, lastVariance = 0.0, currentAverage, currentVariance;
		int numbersInputed = 0, inputNumber;

		Scanner mainInput = new Scanner (System.in);

		System.out.println("This program computes the average and variance of all numbers entered.");

		boolean computing = true;
		while (computing) {
			if (numbersInputed == 0) {
				System.out.println("Enter a number (or type 'exit') ");
			}
			else {
				System.out.println("Enter another number (or type 'exit') ");
			}

			if (mainInput.hasNext("exit")) {
				computing = false;
			}
			else {

				if (mainInput.hasNextDouble())
				{
					inputNumber = mainInput.nextInt();
					numbersInputed++;

					currentAverage = lastAverage + ((double)inputNumber - lastAverage)/numbersInputed;
					currentVariance = ((lastVariance * ((double)numbersInputed - 1)) + ((double)inputNumber - lastAverage) * ((double)inputNumber - currentAverage))/numbersInputed;

					System.out.println("So far the average is "+currentAverage+" and the variance is "+currentVariance);

					lastAverage = currentAverage;
					lastVariance = currentVariance;
				} else {
					System.out.println("Invalid input. Please try again.");
					mainInput.next();

				}
			}
		}
		System.out.println("Goodbye.");
		mainInput.close();
	}

}	
