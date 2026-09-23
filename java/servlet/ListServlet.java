package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;
import model.Model;

@WebServlet("/dashboard/menulist")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/* class直下にインスタンス置くとHas-a（フィールド）になる
		フィールドに置いたdao ずっとメモリに残り続けます
	    private Dao dao = new Dao();
	*/
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// インクルードしたとき日本語の文字化け防止
	    request.setCharacterEncoding("UTF-8");
		
		// DAOをインスタンス化して、DBから全データを取得
		Dao dao = new Dao();
				//メソッド内だとhas-aにならない、使い終わったら捨てる、メモリの節約
				List<Model> dblist = dao.findAll();
				
				request.setAttribute("dblist", dblist);
				
				// 表示担当のJSPへフォワード（WEB-INF内の直接アクセス不可の安全な場所が推奨）
		        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/dashboard/menulist.jsp");
		        dispatcher.forward(request, response);
	}

}
