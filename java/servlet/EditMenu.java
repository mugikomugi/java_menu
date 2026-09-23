package servlet;

import java.io.IOException;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dao.Dao;
import logic.ImgLogic;
import model.Model;

/**
 * Servlet implementation class EditMenu
 */
@MultipartConfig(location = "/tmp", maxFileSize = 1024 * 1024 * 5)
@WebServlet("/dashboard/edit")
public class EditMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//初期画面表示
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int id = Integer.parseInt(request.getParameter("id"));
		Dao dao = new Dao();
		Model oneItem = dao.findById(id);
		request.setAttribute("oneItem", oneItem);
		request.getRequestDispatcher("/WEB-INF/jsp/dashboard/edit.jsp").forward(request, response);
	}
	
	//更新処理
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int id = Integer.parseInt(request.getParameter("id"));
		
		String title= request.getParameter("editName");
		String setOption = request.getParameter("editSet");
		String category = request.getParameter("editCat");
		String subCat = request.getParameter("subCat");
		String addPrice = request.getParameter("editPrice");
		String showIcon = request.getParameter("pickup");
		Part part = request.getPart("editImg");
		
		Dao dao = new Dao();
		Model oldData = dao.findById(id);
		String dbPath = oldData.getImgUrl(); // デフォルト画像は今のパス
		
		// 新しい画像がアップロードされた場合
        if (part != null && part.getSize() > 0) {
        	// ここより修正、環境変数から保存先フォルダを取得（未設定ならローカル用デフォルト）
        	String uploadPath = System.getenv("UPLOAD_DIR");
        	if (uploadPath == null || uploadPath.isEmpty()) {
        		uploadPath = "/Applications/Eclipse_2023-12.app/Contents/workspace/java_menu_test/src/main/webapp/upload";
        	}

        	java.io.File uploadDir = new java.io.File(uploadPath);
        	if (!uploadDir.exists()) {
        	    uploadDir.mkdirs(); // フォルダが存在しない場合は作成
        	}

        	//古いファイルを削除
        	//DBに初期画像がない（または削除済み）場合 NullPointerException対策
        	if (oldData.getImgUrl() != null && !oldData.getImgUrl().isEmpty()) {
        		// oldData.getImgUrl() は "upload/ファイル名.jpg" の形式なので、ファイル名部分だけを取り出す
        		String oldFileName = oldData.getImgUrl().replace("upload/", "");
        		java.io.File oldFile = new java.io.File(uploadDir, oldFileName);
        		if (oldFile.exists()) {
        			oldFile.delete(); 
        		}
        	}

        	// 2. 新しいファイルを保存
        	String originalName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        	ImgLogic imgLogic = new ImgLogic();
        	String newFileName = imgLogic.generateRandomFileName(originalName);

        	// 指定フォルダに新画像を書き込み
        	part.write(uploadPath + "/" + newFileName);

        	// DBに保存するパス（Web表示用パス）
        	dbPath = "upload/" + newFileName;
        }
        
        //addPriceをfloat型に変換
      	try {
      		float price = Float.parseFloat(addPrice);
      		System.out.println("変換成功: " + price );
        
      		// DB更新
	      	if (dao.update(id, title, setOption, category, subCat, price, dbPath, showIcon)) {
	      			response.sendRedirect("menulist");
		       } else {
		    	   response.sendRedirect(request.getContextPath() + "/404");
		        }
      		} catch (NumberFormatException e) {
    			//価格をfloatにできなかったら
    		    System.out.println("数字として変換できません: " + addPrice );
    		    response.sendRedirect(request.getContextPath() + "/404");
    	}	
	}

}
