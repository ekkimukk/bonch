import java.util.*;

public class DeleteDocumentOperation implements DocumentOperation{
    private Document document;

    public DeleteDocumentOperation(Document data) {
        this.document = data;
    }

    @Override public String execute() {
        return document.delete();
    }

    @Override public String undo() {
        return document.undoDelete();
    }
}
