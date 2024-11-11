/* Copyright (c) 2024 ekkimukk. All Rights Reserved. */

import java.util.*;

public class Main {
	public static void main(String[] args) {
		ReadFile faust_file = new ReadFile();
		String faust = faust_file.readFile();
		String[] words = faust.toLowerCase().split("[\\s+\\— \\-\\.\\,\\:\\;\\!\\?\"\\’\\'\\(\\)]");

		Cipher cipher = new Cipher();
		String[] encryptedWords = cipher.encrypt(words);
	}
}
