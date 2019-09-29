package HiLoGame;

import java.util.Random;
import java.util.Scanner;

public class HiLoGame {

	public static final int JACK = 11;
	public static final int QUEEN = 12;
	public static final int KING = 13;
	public static final int ACE = 14;

	public static void main(String[] args) {
		Scanner userGuess = new Scanner(System.in);
		Random generator = new Random();

		int card = 2 + generator.nextInt(13), guess = 1;

		boolean correct = true;
		while (guess <= 4 && correct) {

			int lastCard = 2 + generator.nextInt(13);

			if (card == JACK) {
				System.out.println("The card is a Jack");
			} else if (card == QUEEN) {
				System.out.println("The card is a Queen");
			} else if (card == KING) {
				System.out.println("The card is a King");
			} else if (card == ACE) {
				System.out.println("The card is an Ace");
			} else {
				System.out.println("The card is a " + card);
			}
			System.out.println("Do you think the next card will be higher, lower or equal?");

			if (userGuess.hasNext("higher") || (userGuess.hasNext("lower") || (userGuess.hasNext("equal")))) {
				if (userGuess.hasNext("higher")) {
					if (lastCard > card) {
						correct = true;
					} else {
						correct = false;
					}
					userGuess.next();
				} else if (userGuess.hasNext("lower")) {
					if (lastCard < card) {
						correct = true;
					} else {
						correct = false;
					}
					userGuess.next();
				} else if (userGuess.hasNext("equal")) {
					if (lastCard == card) {
						correct = true;
					} else {
						correct = false;
					}
					userGuess.next();

				}
			} else {
				System.out.println(
						"Invalid input. Please make sure its cAsE sEnSiTiVe and is either 'higher', 'lower' or 'equal'");
				userGuess.close();
				System.exit(0);
			}

			guess++;
			card = lastCard;

		}
		if (correct) {
			System.out.println("Congratulations. You got them all correct.");
		} else {
			System.out.println("Unfortunately, you guessed wrong!!!");
			if (card == JACK) {
				System.out.println("The card was a Jack");
			} else if (card == QUEEN) {
				System.out.println("The card was a Queen");
			} else if (card == KING) {
				System.out.println("The card was a King");
			} else if (card == ACE) {
				System.out.println("The card was an Ace");
			}

			else {
				System.out.println("The card was a " + card);
			}
		}
	}
}
