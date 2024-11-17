public class DatabaseConnection {
    public static final String DB_URL = "jdbc:mariadb://localhost:3306/expenses";
    public static final String USER = "k";
    public static final String PASSWD = "";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, USER, PASSWD);
    }
}
