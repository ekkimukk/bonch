import java.util.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Document {
    private String content;

    public Document(String data) {
        this.content = data;
    }

    public String create() {
        System.out.println("Creating document \"" + content + "\"");
        try {
            File f = new File(content);
            if (f.createNewFile()) {
                return "File created: " + f.getName();
            } else {
                return "File already exists";
            }
        } catch (Exception e) {
            return "An error occurred.";
        }
    }

    public String undoCreate() {
        System.out.println("Undo creating document \"" + content + "\"");
        return "";
    }

    public String edit() {
        System.out.println("Editing document \"" + content + "\"");
        try {
            FileWriter myWriter = new FileWriter(content);
            myWriter.write("ICH LIEBE CAPIBARA!!");
            myWriter.close();
            return "Successfully edit the file.";
        } catch (IOException e) {
            return "An error occurred.";
        }
    }

    public String undoEdit() {
        System.out.println("Undo editing document \"" + content + "\"");
        return "";
    }

    public String delete() {
        System.out.println("Deleting document \"" + content + "\"");
        File myObj = new File(content);
        if (myObj.delete()) {
            return "Deleted the file: \"" + myObj.getName() + "\"";
        } else {
            return "Failed to delete the file";
        }
    }

    public String undoDelete() {
        return "Undo deleting document \"" + content + "\"";
    }
}

