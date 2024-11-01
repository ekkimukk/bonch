import java.util.*;

public class Main {
    public static void main(String[] args) {
      Dictionary dictionary = new Dictionary();
      dictionary.addSynonym("sing", "chant");
      dictionary.addSynonym("sing", "intone");
      dictionary.addSynonym("man", "male");
      dictionary.addSynonym("man", "guy");
      dictionary.addSynonym("man", "gent");
      dictionary.addSynonym("hallowed", "anointed");
      dictionary.addSynonym("hallowed", "beatified");

      // String text = "sing to me of the man, muse, the man of twists and turns, driven time and again off course, once he had plundered the hallowed heights of troy";
      String text = "sing to man hallowed song";
      System.out.println(text);
      
      Cipher cipher = new Cipher(dictionary);
      String encryptedText = cipher.encrypt(text);
      System.out.println(encryptedText);

      String decryptedText = cipher.decrypt(encryptedText);
      System.out.println(decryptedText);
    }
}
