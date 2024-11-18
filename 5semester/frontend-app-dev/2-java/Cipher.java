/* Copyright (c) 2024 ekkimukk. All Rights Reserved. */

import java.util.*;

public class Cipher {
    public String[] addS(String[] arr, String str) {
        int n = arr.length;
        String[] newA = new String[n + 1];
        for (int i = 0; i < n; i++)
            newA[i] = arr[i];
        newA[n] = str;
        return newA;
    }

	public String[] encrypt(String[] words) {
		// String[] encryptWords = words.split(" ");
		// String[] decryptWords = words.split(" ");

        for (String word : words) {
            System.out.println(word);
        }
        System.out.println();

		String[] encryptWords = {""};
		for (String word : words) {
            int key = countOccurrences(word, words);
            String encryptWord = encrypt(word, key);
            encryptWords = addS(encryptWords, encryptWord);
            System.out.println(encryptWord + " ");
		}

        // for (String word : encryptWords) {
        //     System.out.println(word);
        // }

        for (String word : encryptWords) {
            int key = countOccurrences(word, encryptWords);
            String decryptWord = decrypt(word, key);
            System.out.println(decryptWord + " ");
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
            // System.out.println("(" + c + " - " + base + " - " + key + " + 26) % 26 + " + base +  " + 1");
            c = (char)((c - base - key + 26) % 26 + base);
            res += c;
        }
        return res;
    }
}

