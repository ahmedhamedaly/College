package NarcissisticNumbers;

//Write a program to find all narcissistic numbers between 1 and 10,000.
//A narcissistic number is one where the sum of the powers of the individual
//digits to some power n is equal to the number itself.
//  e.g.  8208 = 85 + 25 + 05 + 85 = 4096 + 16 + 0 + 4096
//Note that it can be demonstrated mathematically that n must be less than 60.
public class NarcissisticNumbers {
	public static final int MAX_NUMBER = 10000;
	public static final int MAX_POWER = 60;
	public static final int UNKNOWN_POWER = -1;

	public static void main(String[] args) {
		for (int number = 1; (number < MAX_NUMBER); number++) {
			int narcissisticPower = UNKNOWN_POWER;
			for (int power = 1; ((power < MAX_NUMBER) && (narcissisticPower == UNKNOWN_POWER)); power++) {
				int sum = 0;
				int remainingNumber = number;
				while ((remainingNumber > 0) && (sum <= number)) {
					int digit = remainingNumber % 10;
					sum += Math.pow(digit, power);
					remainingNumber /= 10;
				}
				if (sum == number) {
					narcissisticPower = power;
				}
			}
			if (narcissisticPower != UNKNOWN_POWER) {
				System.out.println(
						"The number " + number + " is a narcissistic number (power = " + narcissisticPower + ").");
			}
		}
	}
}