package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;
import model.Model;

@WebServlet("/dashboard/delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	//表示用
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int id = Integer.parseInt(request.getParameter("id"));
		Dao dao = new Dao();
		Model oneItem = dao.findById(id);
		request.setAttribute("oneItem", oneItem);
		request.getRequestDispatcher("/WEB-INF/jsp/dashboard/delete.jsp").forward(request, response);
	}

	//削除操作
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int id = Integer.parseInt(request.getParameter("id"));
		Dao dao = new Dao();
    	
    	// DBから削除対象のデータ（画像パス）を安全に取得
    	Model targetItem = dao.findById(id);
    			
    	if (targetItem != null) {
    		String uploadPath = System.getenv("UPLOAD_DIR");
    		if (uploadPath == null || uploadPath.isEmpty()) {
    			uploadPath = "/Applications/Eclipse_2023-12.app/Contents/workspace/java_menu_test/src/main/webapp/upload";
    		}				
    		String dlImg = targetItem.getImgUrl();
		
    		//ファイルを削除
    		if (dlImg != null && !dlImg.isEmpty()) {
    			String dlFileName = dlImg.replace("upload/", "");
    			java.io.File dlFile = new java.io.File(uploadPath, dlFileName);
    			if (dlFile.exists()) {
    				dlFile.delete(); 
    			}
    		}
    	}
		dao.delete(id);
		
		response.sendRedirect("menulist");
	}

}
