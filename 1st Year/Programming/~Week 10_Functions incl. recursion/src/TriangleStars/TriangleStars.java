package TriangleStars;

public class TriangleStars {
	public static void main(String []args) {

		int currentTriangleNumber = 0;

		System.out.print("The numbers that are simultaneously star numbers and triangle number are:");

		for (int indexNumber = 1; (Integer.MAX_VALUE - currentTriangleNumber) > 0; indexNumber++ ) {

			currentTriangleNumber = determineTriangleNumber(indexNumber);

			if (isStarNumber (currentTriangleNumber)) {
				System.out.print((currentTriangleNumber == 1? " ": ", ") + currentTriangleNumber); 
			}
		}
		System.out.print(".");
	}

	
	public static boolean isStarNumber(int inputNumber) {
		int starNumber = 0;

		for (int number = 0; starNumber < inputNumber; number++) {

			starNumber = 6*number*(number - 1) + 1;

		}
		return (inputNumber == starNumber);
	}


	public static int determineTriangleNumber(int inputNumber) {
		int triangleNumber = 0;

		while (inputNumber > 0) {

			triangleNumber += inputNumber;
			inputNumber--;

		}
		return triangleNumber;
	}
}
