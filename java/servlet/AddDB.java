package servlet;

import java.io.IOException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;
import logic.ImgLogic;

/**
 * Servlet implementation class AddDB
 */
@WebServlet("/dashboard/AddDB")
public class AddDB extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("addName");
		String setOption = request.getParameter("addSet");
		String category = request.getParameter("addCat");
		String subCat = request.getParameter("subCat");
		String addPrice = request.getParameter("addPrice");
		String showIcon = request.getParameter("pickup");
		String imgUrl = request.getParameter("addImg");
		
		// "data:image/png;base64," のプレフィックスを削除
		String[] parts = imgUrl.split(",");
		String header = parts[0]; 
		String imageString = parts[1];
		byte[] imageBytes = Base64.getDecoder().decode(imageString);
		  
     // 環境変数 "UPLOAD_DIR" からパスを取得。設定がない場合はローカル用のデフォルトパスを使用
        String uploadPath = System.getenv("UPLOAD_DIR");
        if (uploadPath == null || uploadPath.isEmpty()) {
        	//if 文の中（ローカル用の直書きパス）は実行されず無視。本番移行時にこのコードを書き換える必要無し。
            uploadPath = "/Applications/Eclipse_2023-12.app/Contents/workspace/java_menu_test/src/main/webapp/upload";
        }
        
        // "data:image/png;base64,..." から拡張子を取得 png以外はデフォルトで .jpg
        String extension = ".jpg";
        if (header.contains("image/png")) {
            extension = ".png";
        } else if (header.contains("image/jpeg")) {
        	extension = ".jpeg";
        }

        ImgLogic imgLogic = new ImgLogic();
        String newFileName = imgLogic.generateRandomFileName("image" + extension);
        
        // 保存先ディレクトリの存在チェック＆作成
        java.io.File uploadDir = new java.io.File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // その後ファイル書き込み
        java.io.File file = new java.io.File(uploadPath + "/" + newFileName);
        try (java.io.FileOutputStream fos = new java.io.FileOutputStream(file)) {
            fos.write(imageBytes);
        }

        // DBには新しいランダムなファイル名でパスを登録
        String dbPath = "upload/" + newFileName;

		//addPriceをfloat型に変換
		try {
		    float price = Float.parseFloat(addPrice);
		    System.out.println("変換成功: " + price );		
        
        // DAOを使ってDBに登録 (この後、DbDaoにinsertメソッドで追加)
        Dao dao = new Dao();
        boolean success = dao.insert(title, setOption, category, subCat, price, dbPath, showIcon);
        
        // 結果に応じてリダイレクト
        if (success) {
            response.sendRedirect("menulist"); // 一覧画面に戻る
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
