package BMI2;

//import javax.swing.JOptionPane;
import java.util.Scanner;

/*
* Write a program which computes the Body Mass Index (BMI) of a person.  The BMI is
* computed by dividing the weight of a person (in kgs) by the square of the height of
* the person in metres.  The program should also classify the person as one of the
* following:
* - Underweight (BMI less than 18.5), 
* - Normal (BMI between 18.5 and 24.99999),
* - Overweight (BMI between 25.0 and 29.99999), or
* - Obese (BMI of 30 or more). 
*/
public class BMI2 {

	public static final String UNDERWEIGHT = "Underweight";
	public static final double MIN_NORMAL_BMI = 18.5;
	public static final String NORMAL = "Normal";
	public static final double MIN_OVERWEIGHT_BMI = 25.0;
	public static final String OVERWEIGHT = "Overweight";
	public static final double MIN_OBESE_BMI = 30.0;
	public static final String OBESE = "Obese";

	public static void main(String[] args) {

		Scanner input = new Scanner(System.in);
		System.out.print("What is your weight in kg? ");
		double weight = input.nextDouble();
		System.out.print("What is your height in metres? ");
		double height = input.nextDouble();

		double bmi = weight / (height * height);

		String weightClassification = "";
		if (bmi < MIN_NORMAL_BMI) {
			weightClassification = UNDERWEIGHT;
		} else if (bmi < MIN_OVERWEIGHT_BMI) {
			weightClassification = NORMAL;
		} else if (bmi < MIN_OBESE_BMI) {
			weightClassification = OVERWEIGHT;
		} else {
			weightClassification = OBESE;
		}
		/*
		 * A shorter alternative: String weightClassification = (bmi < MIN_NORMAL_BMI) ?
		 * UNDERWEIGHT : (bmi < MIN_OVERWEIGHT_BMI) ? NORMAL : (bmi < MIN_OBESE_BMI) ?
		 * OVERWEIGHT : OBESE;
		 */

		System.out.println("Your BMI is " + bmi + " which is classified as " + weightClassification);
		input.close();
	}

}
