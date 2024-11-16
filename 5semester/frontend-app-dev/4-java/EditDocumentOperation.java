import java.util.*;

public class EditDocumentOperation implements DocumentOperation {
    private Document document;

    public EditDocumentOperation(Document data) {
        this.document = data;
    }

    @Override public String execute() {
        return document.edit();
    }

    @Override public String undo() {
        return document.undoEdit();
    }
}
