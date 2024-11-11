import java.util.*;

public class Document {
    private String content = "#";

    public Document(String data) {
        this.content = data;
    }

    public String create() {
        return "Creating document " + content;
    }

    public String undoCreate() {
        return "Undo creating document " + content;
    }

    public String edit() {
        return "Editing document " + content;
    }

    public String undoEdit() {
        return "Undo editing document " + content;
    }

    public String delete() {
        return "Deleting document " + content;
    }

    public String undoDelete() {
        return "Undo deleting document " + content;
    }
}

