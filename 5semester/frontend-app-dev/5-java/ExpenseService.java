public class ExpenseService {
    public void addExpense(double amount, Date date, String description) throws SQLException {
        try (
            Connection connection = new DatabaseConnection.getConnection();
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO expenses (amount, date, description) VALUES (?, ?, ?)")
        ) {
            stmt.setDouble(1, amount);
            stmt.setDate(2, new java.sql.Date(date.getTime()));
            stmt.setString(3, description);
            stmt.executeUpdate();
        }
    }
}
