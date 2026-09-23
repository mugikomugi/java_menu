package servlet;

import java.io.IOException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

// 画像アップロード(multipart/form-data)に必要なアノテーション
@MultipartConfig(location = "/tmp", maxFileSize = 1024 * 1024 * 5)
@WebServlet("/dashboard/confirm")
public class Confirm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title= request.getParameter("addName");
		String setOption = request.getParameter("addSet");
		String category = request.getParameter("addCat");
		String subCat = request.getParameter("subCat");
		String addPrice = request.getParameter("addPrice");
		String showIcon = request.getParameter("pickup");
		Part part = request.getPart("addImg");
		
		// エラー情報を保持する変数を準備（またはリスト等）
        String[] errorMsg = { null, null, null };       
        // バリデーションチェック
        if (title == null || title.trim().isEmpty()) {
            errorMsg[0] = "タイトルを入力してください";
        }       
        if (addPrice == null || !addPrice.matches("^[0-9]+$")) {
            errorMsg[1] = "料金は半角数字で入力してください";
        }
        //画像以外のファイルをアップロードされないようチェック
        String contentType = null;
        if (part == null || part.getSize() == 0) {
            errorMsg[2] = "画像ファイルを選択してください";
        } else { 
        	contentType = part.getContentType();
        	if (contentType == null || (!contentType.equals("image/jpeg") && 
                   !contentType.equals("image/png") && 
                   !contentType.equals("image/jpg"))) {
            errorMsg[2] = "JPG、JPEG、PNG形式の画像を選択してください";
        	}
        }
        
        // 分岐処理
        if (errorMsg[0] != null || errorMsg[1] != null || errorMsg[2] != null) {
            request.setAttribute("errorMsg1", errorMsg[0]);
            request.setAttribute("errorMsg2", errorMsg[1]);
            request.setAttribute("errorMsg3", errorMsg[2]);
            
            request.getRequestDispatcher("/WEB-INF/jsp/dashboard/addlist.jsp").forward(request, response);
        } else {
            // エラーがない場合：リクエストスコープに必要な情報をセットし、確認画面(confirm.jsp)へ進む
            request.setAttribute("addName", title);
            request.setAttribute("addSet", setOption);
            request.setAttribute("addCat", category);
            request.setAttribute("subCat", subCat);
            request.setAttribute("addPrice", addPrice);
            request.setAttribute("pickup", showIcon);

            byte[] imageBytes = part.getInputStream().readAllBytes();
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
            contentType = part.getContentType();
            String imgUrl = "data:" + contentType + ";base64," + base64Image;
            request.setAttribute("imgUrl", imgUrl);
            
            request.getRequestDispatcher("/WEB-INF/jsp/dashboard/confirm.jsp").forward(request, response);
        }		 
	}

}
