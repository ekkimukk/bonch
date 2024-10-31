import java.util.*;

public class Main {
	
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		Map<String, String> groups = new HashMap<>();
		String input;

		// Entering the prefix and group name
		System.out.println("Enter the prefix and group name separated by a space (e.g., 86 Job)");
		System.out.println("Enter \"stop\" to make stop");	
		do {
			input = scanner.nextLine();
			if (!input.equalsIgnoreCase("stop")) {
				String[] parts = input.split(" ");
				if (parts.length == 2) {
					groups.put(parts[0], parts[1]);
				} else {
					System.out.println("ERROR: Wrong input");
				}
			}
		} while(!input.equalsIgnoreCase("stop"));

		// Entering the phone numbers
		System.out.println("Enter the phone number (e.g., 8-993-357-46-80)");
		System.out.println("Enter \"stop\" to make stop");	
		String tmp = "";
		do {
			 input = scanner.nextLine();
			 if (!input.equalsIgnoreCase("stop")) {
				tmp += " " + input;
			 }
		} while(!input.equalsIgnoreCase("stop"));
		String[] phoneNumbers = tmp.split(" ");
		
		// Sort numbers
		Map<String, List<String>> groupsAndNumbers = new HashMap<>();
		for (String number : phoneNumbers) {
			boolean foundGroup = false;

			for (String prefix : groups.keySet()) {
				if (number.startsWith(prefix)) {

					if (!groupsAndNumbers.containsKey(prefix)) {
						groupsAndNumbers.put(prefix, new ArrayList<>());
					}

					groupsAndNumbers.get(prefix).add(number);
				}
				foundGroup = true;
				break;
			}

			if (!foundGroup) {
				System.out.printf("There is no group for number: ");
			}
		}

		for (String prefix : groupsAndNumbers.keySet()) {
			System.err.println(prefix + ":");
			for (String number : groupsAndNumbers.get(prefix)) {
				System.out.println("-> " + number);
			}
		}

		// Output the prefix and group name
		// for (Map.Entry<String, String> entry : groups.entrySet()) {
		// 	System.out.println(entry.getKey() + " -> " + entry.getValue());
		// }

		scanner.close();
	}
}
