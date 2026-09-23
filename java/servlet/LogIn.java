package servlet;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserModel;

@WebServlet("/login")
public class LogIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// CSRF対策：トークンを生成してセッションに保存
        String csrfToken = UUID.randomUUID().toString();
        request.getSession().setAttribute("csrfToken", csrfToken);
                
		request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		// CSRF トークンの検証を最優先で行う
	    HttpSession session = request.getSession(false);
	    String sessionToken = (session != null) ? (String) session.getAttribute("csrfToken") : null;
	    String requestToken = request.getParameter("csrfToken");

	    if (sessionToken == null || !sessionToken.equals(requestToken)) {
	        // トークン不一致・不正なアクセスの場合は処理を中断して404へ
	        response.sendRedirect(request.getContextPath() + "/404");
	        return;
	    }

	    // トークン検証をクリアしたらワンタイム用にセッションからトークンを消去
	    session.removeAttribute("csrfToken");

		String loginID = request.getParameter("loginID");
		String loginPass = request.getParameter("loginPass");
		
		UserModel userModel = new UserModel(loginID, loginPass);
		
		//IDとパスワード設定
    	String idname = "任意のID NAME";
    	String passw = "任意のPASSWORD";
    	
    	// 認証チェック
    	if(idname.equals(userModel.getUserId()) && passw.equals(userModel.getUserPass())) {
    		// 認証が通ったユーザー情報をセッションに保存
    		session.setAttribute("loginUser", userModel);
    		response.sendRedirect(request.getContextPath() + "/dashboard/menulist");
    	} else {
    		request.setAttribute("errorMsg", "IDまたはパスワードが違います");
    	    request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    	}

	}
}
