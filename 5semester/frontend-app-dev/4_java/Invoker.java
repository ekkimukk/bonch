import java.util.*;

public class Invoker {
    private final List<DocumentOperation> documentOperations
    = new ArrayList<>();

    public String executeOperation(DocumentOperation documentOperation) {
        documentOperations.add(documentOperation);
        return documentOperation.execute();
    }

    public String undoOperation(DocumentOperation documentOperation) {
        documentOperations.add(documentOperation);
        return documentOperation.undo();
    }
}

