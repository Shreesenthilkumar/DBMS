package FAQ;



import java.sql.\*;

import java.util.Scanner;



public class FAQS {



    private static final String DB\_URL =

        "jdbc:mysql://localhost:3306/faq\_management\_system?useSSL=false\&allowPublicKeyRetrieval=true\&serverTimezone=UTC";

    private static final String DB\_USER = "root";

    private static final String DB\_PASS = "Shree123@";



    private Connection conn;

    private final Scanner sc = new Scanner(System.in);



    public FAQS() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(DB\_URL, DB\_USER, DB\_PASS);

            System.out.println("Connected");

        } catch (Exception e) {

            System.out.println("DB connection failed: " + e.getMessage());

            System.exit(1);

        }

    }



    private void insertFaq() {

        try {

            System.out.print("Question : ");

            String question = (sc.nextLine().trim());



            String check = "SELECT faq\_id, count FROM faq WHERE question = ?";

            try (PreparedStatement ps = conn.prepareStatement(check)) {

                ps.setString(1, question);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    int faqId = rs.getInt("faq\_id");

                    int currentCount = rs.getInt("count");

                    String update = "UPDATE faq SET count = ? WHERE faq\_id = ?";

                    try (PreparedStatement ups = conn.prepareStatement(update)) {

                        ups.setInt(1, currentCount + 1);

                        ups.setInt(2, faqId);

                        ups.executeUpdate();

                        System.out.println("FAQ already exists. Count incremented.");

                        return;

                    }

                }

            }



            System.out.print("Answer : ");

            String answer = (sc.nextLine().trim());



            System.out.print("User ID (creator) : ");

            int userId = Integer.parseInt(sc.nextLine().trim());



            String insert = "INSERT INTO faq (question, answer, created\_by) VALUES (?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(insert)) {

                ps.setString(1, question);

                ps.setString(2, answer);

                ps.setInt(3, userId);

                ps.executeUpdate();

                System.out.println("New FAQ inserted.");

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

    }



    private void updateFaq() {

        PreparedStatement ps = null;

        try {

            String sql = "UPDATE faq SET answer = ? WHERE faq\_id = ?";

            ps = conn.prepareStatement(sql);



            System.out.print("FAQ ID to update : ");

            int id = Integer.parseInt(sc.nextLine().trim());



            System.out.print("New answer : ");

            String ans = sc.nextLine();



            ps.setString(1, ans);

            ps.setInt(2, id);



            System.out.println(ps.executeUpdate() + " row updated.");

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            closeQuiet(ps);

        }

    }



    private void deleteFaq() {

        PreparedStatement ps = null;

        try {

            String sql = "DELETE FROM faq WHERE faq\_id = ?";

            ps = conn.prepareStatement(sql);



            System.out.print("FAQ ID to delete : ");

            ps.setInt(1, Integer.parseInt(sc.nextLine().trim()));



            System.out.println(ps.executeUpdate() + " row deleted.");

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            closeQuiet(ps);

        }

    }



    private void listFaqs() {

        PreparedStatement ps = null;

        ResultSet rs = null;

        try {

            String sql = "SELECT f.faq\_id, f.question, f.answer, f.count, u.username FROM faq f " +

                         "LEFT JOIN users u ON u.user\_id = f.created\_by ORDER BY f.faq\_id";

            ps = conn.prepareStatement(sql);



            rs = ps.executeQuery();

            System.out.println("\\n--- All FAQs ---");

            while (rs.next()) {

                System.out.println("----------------------------------------");

                System.out.println("FAQ ID   : " + rs.getInt("faq\_id"));

                System.out.println("Question : " + rs.getString("question"));

                System.out.println("Answer   : " + rs.getString("answer"));

                System.out.println("Count    : " + rs.getInt("count"));

                System.out.println("User     : " + rs.getString("username"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            closeQuiet(rs);

            closeQuiet(ps);

        }

    }



    private static void closeQuiet(AutoCloseable ac) {

        if (ac != null) {

            try {

&nbsp;               \*\*ac.close();0\*\*

            \*\*} catch (Exception ignored) {}\*\*

        \*\*}\*\*

    \*\*}\*\*



    \*\*private void menu() {\*\*

        \*\*while (true) {\*\*

            \*\*System.out.println("\\\\n===== FAQ Management =====");\*\*

            \*\*System.out.println("1. Insert FAQ");\*\*

            \*\*System.out.println("2. Update FAQ Answer");\*\*

            \*\*System.out.println("3. Delete FAQ");\*\*

            \*\*System.out.println("4. View All FAQs");\*\*

            \*\*System.out.println("5. Exit");\*\*

            \*\*System.out.print("Choose (1-5): ");\*\*



            \*\*int choice;\*\*

            \*\*try {\*\*

                \*\*choice = Integer.parseInt(sc.nextLine().trim());\*\*

            \*\*} catch (NumberFormatException e) {\*\*


                System.out.println("Invalid input.");

                continue;

            }



            switch (choice) {

                case 1: insertFaq(); break;

                case 2: updateFaq(); break;

                case 3: deleteFaq(); break;

                case 4: listFaqs(); break;

                case 5: closeAll(); return;

                default: System.out.println("Invalid option.");

            }

        }

    }



    private void closeAll() {

        closeQuiet(conn);

        sc.close();

        System.out.println("Exit!");

    }



    public static void main(String\[] args) {

        new FAQS().menu();

    }

}

