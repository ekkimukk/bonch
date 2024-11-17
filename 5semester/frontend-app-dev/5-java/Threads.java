public class Threads implements Runnable {
    private double amount;
    private Date date;
    private String description;

    public Threads(double amount, Date date, String description) {
        this.amount = amount;
        this.data = date;
        this.description = description;
    }

    @Override public void run() {
        try {
            new ExpenseService().addExpense(amount, date, description);
        } catch (SQLException e) {
            System.err.println("ERROR in " + e.getMessage());
        }
    }
}
