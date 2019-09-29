package Factorial;

import java.util.Scanner;
import javax.swing.JOptionPane;

/*
 * Write a program to calculate factorial of some number (i.e. number!).
 * For example 4! = 1*2*3*4 = 24
 */
public class Factorial {

	public static void main(String[] args) {

		String input = JOptionPane.showInputDialog("Enter an integer to compute its factorial:");
		Scanner scanner = new Scanner( input );
		int number = scanner.nextInt();
		
		
		int factorial = 1;
		for (int i=2; (i<=number); i++)
		{
			factorial = factorial * i;
		}
/*
  		int factorial = 1;
		int i=2;
		while (i <= number)
		{
			factorial = factorial*i;
			i += 1;
		}
		int factorial = 1;
		int i=2;
		while (i <= number)
			factorial = factorial*i++;
	*/	
		JOptionPane.showMessageDialog(null, "The factorial of " + number +
										" is " + factorial );
		scanner.close();
	}

}
