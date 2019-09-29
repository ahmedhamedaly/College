package MinMaxNumbers;

import java.util.Scanner;

public class MinMaxNumbers {
	public static void main (String[] agrs)
	{
		Scanner input = new Scanner (System.in);
		System.out.println("Enter a list of whole numbers \n seperate it by a space and it with 0");
		
		int minNumber = 0, maxNumber = 0;
		int currentNumber = input.nextInt();
		minNumber = currentNumber;
				
		while (input.hasNextInt()){
			currentNumber = input.nextInt();
			
			if (currentNumber == 0)
				break;
			
			if (currentNumber < minNumber)
				minNumber = currentNumber;
			
			if (currentNumber > maxNumber)
				maxNumber = currentNumber;
			
			
			
		}
		System.out.println("Max Number = "+maxNumber +" ;Min Number = "+minNumber);
		input.close();
	}
}