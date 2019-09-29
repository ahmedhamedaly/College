package BMI;

import java.util.Scanner;

public class BMICalculator {
	public static void main (String []args){

		System.out.println ("What is your weight in Kg?");
		Scanner inputScanner = new Scanner (System.in);
		double weight = inputScanner.nextDouble();

		System.out.println ( "What is your height in Meters? " );
		double height = inputScanner.nextDouble();
		inputScanner.close();

		double BMI = weight / (height * height); 

		System.out.println ("Your BMI is "+ BMI);

	}
}

