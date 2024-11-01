import java.util.*;

public class Dictionary {
  public final Map<String, List<String>> synonyms = new HashMap<>();

  public void addSynonym(String word, String synonym) {
    if (!synonyms.containsKey(word)) {
      synonyms.put(word, new ArrayList<>());
    }
    synonyms.get(word).add(synonym);
  }

  public List<String> getSynonyms(String word) {
    return synonyms.getOrDefault(word, new ArrayList<>());
  }
}

