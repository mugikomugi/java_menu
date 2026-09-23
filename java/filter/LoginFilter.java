package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserModel;

@WebFilter("/dashboard/*")
public class LoginFilter extends HttpFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		
		//HttpServletRequest / HttpServletResponse にキャスト
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
		//セッションを取得（存在しなければ null）
		HttpSession session = req.getSession(false);
		
		UserModel loginUser = null;
        if (session != null) {
            loginUser = (UserModel) session.getAttribute("loginUser");
        }
		
		if (loginUser == null) {
            // 未ログインならログイン画面へ飛ばす
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
		
		// ブラウザの「戻る」ボタン対策 ログアウト後キャッシュ無効化（No-Cache）
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		res.setHeader("Pragma", "no-cache");
		res.setDateHeader("Expires", 0);
		
		chain.doFilter(request, response);
	}

}
