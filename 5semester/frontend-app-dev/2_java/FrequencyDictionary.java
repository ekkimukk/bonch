import java.util.*;

public class FrequencyDictionary {
    private final Map<String, List<String>> synonyms = new HashMap<>();
    
    public void addSynonym(String word, String synonym) {
        if (!synonyms.containsKey(word)) {
            synonyms.put(word, new ArrayList<>());
        }
        synonyms.get(word).add(synonym);
    }
}