import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;

public class Main {
	
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		Map<String, String> groups = new HashMap<>();
		String input;

		System.out.println("Enter the prefix and group name separated by a space (e.g., 86 Job)");
		System.out.println("Enter \"stop\" to make stop");	
		do {
			input = scanner.nextLine();
			if (!input.equalsIgnoreCase("stop")) {
				String[] parts = input.split(" ");
				if (parts.length == 2) {
					//groups.put();
				} else {
					System.out.println("ekki");
					System.out.println("");
				}
			}
		} while(!input.equalsIgnoreCase("stop"));
	}
}
