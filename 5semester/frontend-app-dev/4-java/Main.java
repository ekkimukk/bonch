import java.util.*;

public class Main {
    public static void main(String[] args) {
        System.out.println("Go");
        Invoker invoker = new Invoker();
        Document document = new Document("File");
        CreateDocumentOperation createDocumentOperation = new CreateDocumentOperation(document);

        System.out.println(invoker.executeOperation(new CreateDocumentOperation(document)));
        System.out.println(invoker.undoOperation(new CreateDocumentOperation(document)));
        System.out.println();

        System.out.println(invoker.executeOperation(new EditDocumentOperation(document)));
        System.out.println(invoker.undoOperation(new EditDocumentOperation(document)));
        System.out.println();

        System.out.println(invoker.executeOperation(new DeleteDocumentOperation(document)));
        System.out.println(invoker.undoOperation(new DeleteDocumentOperation(document)));
    }
}
