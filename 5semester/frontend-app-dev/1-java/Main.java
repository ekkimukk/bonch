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
    System.out.println();

		// Entering the phone numbers
		System.out.println("Enter the phone number (e.g., 8-993-357-46-80)");
		System.out.println("Enter \"stop\" to make stop");	
		String tmp = "";
		do {
			 input = scanner.nextLine();
			 if (!input.equalsIgnoreCase("stop")) {
				tmp += input + " ";
			 }
		} while(!input.equalsIgnoreCase("stop"));
		String[] phoneNumbers = tmp.split(" ");
    System.out.println();
		
		// Sort numbers
    int count;
    String tmp2 = "";
    for (String prefix : groups.keySet()) {
      count = 0;
      System.out.println(prefix + " (" + groups.get(prefix) + "):");

      for (String number : phoneNumbers) {
        if (number.startsWith(prefix)) {
          System.out.println("-> " + number);
          count++;
        }
      }
      if (count == 0) {
        System.out.println("-> no numbers");
      }
    }
    System.out.println();

    boolean haveTheGroup;
    for (String number : phoneNumbers) {
      haveTheGroup = false;

      for (String prefix : groups.keySet()) {
        if (number.startsWith(prefix)) {
          haveTheGroup = true;
          break;
        }

      }
      if (haveTheGroup == false) {
        tmp2 += number + " ";
      }
    }

		String[] phoneNumbersWithNoGroup = tmp2.split(" ");

    System.out.println("Numbers with no group: ");
    for (String number : phoneNumbersWithNoGroup) {
      System.out.println("-> " + number);
    }

		scanner.close();
	}
}

