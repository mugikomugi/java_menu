package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dashboard/addlist")
public class AddList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// インクルードしたとき日本語の文字化け防止
		request.setCharacterEncoding("UTF-8");
		request.getRequestDispatcher("/WEB-INF/jsp/dashboard/addlist.jsp").forward(request, response);
	}

}
