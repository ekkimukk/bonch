import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class ReadFile {
	public String readFile() {
		StringBuilder result = new StringBuilder();
		File file = new File("faust.txt");
		try {
			Scanner reader = new Scanner(file);
			while (reader.hasNextLine()) {
				String data = reader.nextLine();
				result.append(data).append(" ");
			}
		} catch(FileNotFoundException e) {}

	return result.toString().trim();
	}
}
