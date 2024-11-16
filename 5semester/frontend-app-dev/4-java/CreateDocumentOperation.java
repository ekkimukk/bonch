import java.util.*;

public class CreateDocumentOperation implements DocumentOperation {
    private Document document;

    public CreateDocumentOperation(Document data) {
        this.document = data;
    }

    @Override public String execute() {
        return document.create();
    }

    @Override public String undo() {
        return document.undoCreate();
    }
}
