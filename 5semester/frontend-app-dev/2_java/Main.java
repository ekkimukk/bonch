import java.util.*;

public class Main {
    public static void main(String[] args) {
        FrequencyDictionary dictionary = new FrequencyDictionary();

        dictionary.addSynonym("sing", "chant");
        dictionary.addSynonym("sing", "intone");
        dictionary.addSynonym("man", "male");
        dictionary.addSynonym("man", "guy");
        dictionary.addSynonym("man", "gent");
        dictionary.addSynonym("muse", "inspiration");

        for (Map.Entry<String, List<String>> entry : dictionary.entrySet()) {
            System.out.println(entry.getKey());
            System.out.println(entry.getValue());
        }

        // System.out.println(dictionary.());

        String text = "sing to me of the man, muse";
    }
}