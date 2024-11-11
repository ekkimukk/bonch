/* Copyright (c) 2024 ekkimukk. All Rights Reserved. */

import java.util.*;

public class Cipher {
	public String[] encrypt(String[] words) {
		String[] encryptWords = "".split(" ");
		// String[] decryptWords = "".split("");

		for (String word : words) {
            int key = countOccurrences(word, words);
            String encryptWord = encrypt(word, key);
            String decryptWord = decrypt(word, key);

            System.out.print(key + ">" + word + " ");
            System.out.print(encryptWord + " ");
            System.out.print(decryptWord + " ");
		}

		return encryptWords;
	}

	public int countOccurrences(String word, String[] words) {
        int count = 0;
		for (String w : words) {
            if (w.equals(word))
                count++;
		}
		return count;
	}

    public String encrypt(String word, int key) {
        String res = "";
        for (char c : word.toCharArray()) {
            if (Character.isLetter(c)) {
                char base = 'a';
                c = (char)((c - base + key) % 26 + base);
            }
            res += c;
        }
        return res;
    }

    public String decrypt(String word, int key) {
        String res = "";
        for (char c : word.toCharArray()) {
            char base = 'a';
            c = (char)((c - base - key + 26) % 26 + base + 1);
            res += c;
        }
        return res;
    }
}

