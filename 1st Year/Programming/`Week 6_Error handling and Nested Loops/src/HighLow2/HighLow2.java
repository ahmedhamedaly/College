package HighLow2;

import java.util.Random;
import java.util.Scanner;

/*
 * Write a program to implement a new version of the High-Low game:
 * The user has to try and guess a number between 0 and 20 (inclusive).   They
 * must keep guessing until they get the number.  For each incorrect guess they
 * are told if the guess is too big or too small.  At the end tell them how many
 * tries it took them (and if it isnt their first try then they should be told
 * if they did better or worse than the last time).
 * Once they get it right they should be allowed to play again if they want to
 */
public class HighLow2 {

	public static final int NOT_AVAILABLE = -1;
	public static final int MAX_NUMBER = 20;

	public static void main(String[] args) {

		Random generator = new Random();
		int previousGuessCount = NOT_AVAILABLE;
		boolean quit = false;
		do {
			int numberToGuess = generator.nextInt(MAX_NUMBER + 1);
			int numberGuessed = NOT_AVAILABLE;
			int guessCount = 0;

			while (numberGuessed != numberToGuess) {
				@SuppressWarnings("resource")
				Scanner input = new Scanner(System.in);
				System.out.print("Guess the number (between 0 and 20): ");
				if (input.hasNextInt()) {
					numberGuessed = input.nextInt();
					guessCount++;
					if (numberGuessed < numberToGuess)
						System.out.println("" + numberGuessed + " is too low.");
					else if (numberGuessed > numberToGuess)
						System.out.println("" + numberGuessed + " is too high.");
				} else
					System.out.println("Invalid input.  Try again.");
			}

			if (previousGuessCount == NOT_AVAILABLE)
				System.out.print("Well done.");
			else if (previousGuessCount > guessCount)
				System.out.println("Excellent.  Better than last time.");
			else if (previousGuessCount < guessCount)
				System.out.println("Hard luck.  Worse than last time.");
			else
				System.out.println("Consistent.  Same as last time.");
			System.out.println("  You got it in " + guessCount + " guesses.");
			previousGuessCount = guessCount;

			Scanner input = new Scanner(System.in);
			System.out.print("Do you want another go (yes/no)? ");
			if (input.hasNext("no"))
				quit = true;
				input.close();
		} while (!quit);
	}

}