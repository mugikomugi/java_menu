package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DbTest")
public class DBTest extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 接続情報
        String url = "jdbc:mysql://localhost:3306/my_menu_db?useSSL=false&allowPublicKeyRetrieval=true";
        String user = "user name"; //任意のユーザーネーム
        String password = "fs8WY6K_li9q"; //任意のパスワード

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, password)) {
                out.println("<h1>DB接続成功 !</h1>");
                out.println("<p>Docker上の my_img_db につながりました。</p>");
            }
        } catch (Exception e) {
            out.println("<h1>接続失敗...</h1>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(out);
        }
    }
}