package SquareAges;

public class SquareAges {

	final static int CURRENT_YEAR = 2018;
	final static int MAX_AGE = 123;
	final static int MIN_AGE = 0;
	final static int MAX_YEAR = CURRENT_YEAR + MAX_AGE;
	final static int MIN_YEAR = CURRENT_YEAR - MAX_AGE;

	public static void main(String[] args) {

		int age, ageSquared;
		for (age = MIN_AGE; (age <= MAX_AGE); age++) {
			ageSquared = age * age;

			if (ageSquared >= MIN_YEAR + age && ageSquared <= MAX_YEAR - age)
				System.out.println("A person that's " + age + " years old in the year " + ageSquared
						+ " AD has their age squared the same as the year ");
		}
	}
}
