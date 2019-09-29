package Umbrella;

import javax.swing.JOptionPane;

public class Umbrella {
	public static void main (String []args)
	{
		int answer = JOptionPane.showConfirmDialog(null,"Is it raining right now?");
		boolean raining = (answer == JOptionPane.YES_OPTION);
		
		if (raining) {
			JOptionPane.showMessageDialog(null, "Bring your umbrella and put it up");
		}else {
			int answer2 = JOptionPane.showConfirmDialog(null, "Does it look like it might rain today?");
			boolean mightRain = (answer2 == JOptionPane.YES_OPTION);
			
			if (mightRain) {
				JOptionPane.showMessageDialog(null, "Bring your umbrella but don't put it up");
			} else {
				JOptionPane.showMessageDialog(null, "Don't bring your umbrella");
			}
		}
	}
}	