package Vertebrates;

import javax.swing.JOptionPane;

public class Vertebrates {
	public static void main(String[] args) {
		int answer = JOptionPane.showConfirmDialog(null, "Is your class Cold Blooded?");

		boolean coldBlooded = (answer == JOptionPane.YES_OPTION);

		if (coldBlooded) {
			int answer2 = JOptionPane.showConfirmDialog(null, "Does your class have scales?");
			boolean scales = (answer2 == JOptionPane.YES_OPTION);

			if (scales) {
				int answer3 = JOptionPane.showConfirmDialog(null, "Does your class have fins?");
				boolean fins = (answer3 == JOptionPane.YES_OPTION);

				if (fins) {
					JOptionPane.showMessageDialog(null, "Your class is a Fish");
				} else {
					JOptionPane.showMessageDialog(null, "Your class is a Reptile");
				}
			} else {
				JOptionPane.showMessageDialog(null, "Your class is an Amphibian");
			}
		} else {
			int answer4 = JOptionPane.showConfirmDialog(null, "Does your class have feathers?");
			boolean feathers = (answer4 == JOptionPane.YES_OPTION);

			if (feathers) {
				JOptionPane.showMessageDialog(null, "Your class is a Bird");
			} else {
				JOptionPane.showMessageDialog(null, "Your class is a Mammal");
			}
		}
	}
}