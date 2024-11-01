import java.util.*;

public class Cipher {
  public final Dictionary dictionary;

  public Cipher(Dictionary dictionary) {
    this.dictionary = dictionary;
  }
    
  public String encrypt(String text) {
    StringBuilder result = new StringBuilder();
    String[] words = text.split("[\\,\\.\\s+]");

    for (String word : words) {
      List<String> synonyms = dictionary.getSynonyms(word);
      if (!synonyms.isEmpty()) {
        int randomIndex = new Random().nextInt(synonyms.size());
        result.append(synonyms.get(randomIndex)).append(" ");
      } else {
        result.append(word).append(" ");
      }
    }

    return result.toString().trim();
  }
  
  public String decrypt(String text) {
    StringBuilder result = new StringBuilder();
    Map<String, String> reverseDictionary = createReverseDictionary(dictionary.synonyms);
    String[] words = text.split("[\\,\\.\\s+]");
    
    for (String word : words) {
      String originalWord = reverseDictionary.getOrDefault(word, word);
      result.append(originalWord).append(" ");
    }

    return result.toString().trim();
  }

  public static Map<String, String> createReverseDictionary(Map<String, List<String>> forwardDictionary) {
    Map<String, String> result = new HashMap<>();

    forwardDictionary.forEach((word, synonyms) -> {
      for (String synonym : synonyms) {
        result.put(synonym, word);
      }
    });
    
    return result;
  }
}

