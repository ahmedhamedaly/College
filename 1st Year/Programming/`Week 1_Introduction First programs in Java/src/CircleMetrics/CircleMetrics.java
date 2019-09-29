package CircleMetrics;

import javax.swing.JOptionPane;
import java.util.Scanner;

/*
 * Write a program which gets the radius of a circle from the user
 * and then computes the diameter, area and circumference.  Input
 * should be obtained and results should be displayed using
 * dialog boxes.
 */
public class CircleMetrics {

	public static void main(String[] args) {

		String radiusInput = JOptionPane.showInputDialog("What is the radius of the circle?");
		Scanner inputScanner = new Scanner( radiusInput );
		double radius = inputScanner.nextDouble();

		double diameter = radius * 2;
		double circumference = 2 * Math.PI * radius;
		double area = Math.PI * radius * radius;
		
		System.out.println( "For a circle of radius " + radius +
			"\n Diameter = " + diameter + "\n Circumference = " + circumference + 
			"\n Area = " + area );
		inputScanner.close();
	}

}