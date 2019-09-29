package TwelveDaysOfChristmas;

public class TwelveDaysOfChristmas {

	public static final int MAX_DAYS = 12;

	public static void main(String[] args) {

		int dayNumber = 1, dayNumber2 = 1;
		while (dayNumber <= MAX_DAYS && dayNumber2 <= MAX_DAYS) {

			String day = "";
			switch (dayNumber) {
			case 1:
				day = "first";
				dayNumber++;
				break;
			case 2:
				day = "second";
				dayNumber++;
				break;
			case 3:
				day = "third";
				dayNumber++;
				break;
			case 4:
				day = "fourth";
				dayNumber++;
				break;
			case 5:
				day = "fifth";
				dayNumber++;
				break;
			case 6:
				day = "sixth";
				dayNumber++;
				break;
			case 7:
				day = "seventh";
				dayNumber++;
				break;
			case 8:
				day = "eighth";
				dayNumber++;
				break;
			case 9:
				day = "ninth";
				dayNumber++;
				break;
			case 10:
				day = "tenth";
				dayNumber++;
				break;
			case 11:
				day = "eleventh";
				dayNumber++;
				break;
			case 12:
				day = "twelfth";
				dayNumber++;
				break;
			}

			System.out.print("On the " + day + " day of Christmas\r\n" + "my true love sent to me:\n");

			switch (dayNumber2) {
			case 12:
				System.out.print("Twelve Drummers Drumming,\n");
			case 11:
				System.out.print("Eleven Pipers Piping,\n");
			case 10:
				System.out.print("Ten Lords a-leaping,\n");
			case 9:
				System.out.print("Nine Ladies dancing,\n");
			case 8:
				System.out.print("Eight Maids a-milking,\n");
			case 7:
				System.out.print("Seven Swans a-swimming,\n");
			case 6:
				System.out.print("Six Geese a-laying,\n");
			case 5:
				System.out.print("Five Golden Rings,\n");
			case 4:
				System.out.print("Four Calling Birds,\n");
			case 3:
				System.out.print("Three French Hens,\n");
			case 2:
				System.out.print("Two Turtle Doves,\nAnd a Partridge in a Pear Tree.\n\n");
				dayNumber2++;
				break;
			case 1:
				System.out.print("A Partridge in a Pear Tree.\n\n");
				dayNumber2++;
				break;
			}

		}

	}
}
