<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="ja">

<head>
	<%-- head動的インクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/head_meta.jsp">
    	<jsp:param name="pageTitle" value="管理画面ログイン" />
    	<jsp:param name="css" value="dashboard.css" />
	</jsp:include>
</head>

<body>
  <div class="insideWrapper">
    <header class="insideHeader">
      <h1 class="insideTitle">
      	<img src="${pageContext.request.contextPath}/image/db_logo.svg" alt="田舎や Dashboard">
      </h1>
    </header>

    <main class="insideMain">
      <section class="container">
        <h2 class="pageTitle">ログイン画面</h2>
        <p class="once">IDとパスワードを入力してください。</p>

        <form method="post" action="login" class="loginBox">
        <!-- トークンを隠しフィールドとして追加 -->
    	<input type="hidden" name="csrfToken" value="<c:out value="${csrfToken}" />">
    	
          <dl class="formBox">
            <dt><label for="loginID">ログインID<span class="need">必須</span></label></dt>
            <dd><input type="text" name="loginID" id="loginID" class="idBox" required></dd>
          </dl>
          <dl class="formBox">
            <dt><label for="loginPass">パスワード<span class="need">必須</span></label></dt>
            <dd>
              <input type="password" name="loginPass" id="loginPass" class="idBox" required>
            </dd>
          </dl>
          
          <%-- エラーメッセージがあれば表示 --%>
		<c:if test="${not empty errorMsg}">
        	<p class="error"><c:out value="${errorMsg}" /></p>
    	</c:if>

          <button type="submit" class="sendBtn">ログイン</button>
        </form>

      </section>
      <!-- //.container -->
    </main>

    <jsp:include page="/WEB-INF/jsp/dashboard/footer.jsp" />
  </div>
  <!-- //.insideWrapper -->

</body>

</html>