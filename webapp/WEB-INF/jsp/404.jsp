<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="ja">

<head>
<%-- head動的インクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/head_meta.jsp">
    	<jsp:param name="pageTitle" value="404 Not found" />
    	<jsp:param name="css" value="dashboard.css" />
	</jsp:include>
</head>

<body>
  <div class="insideWrapper">
    <header class="insideHeader">
      <h1 class="insideTitle"><img src="${pageContext.request.contextPath}/image/db_logo.svg" alt="田舎や Dashboard"></h1>
    </header>

    <main class="insideMain">
      <section class="container">
        <h2 class="pageTitle">404 Not found</h2>
        <p class="deleteName">
          入力エラーもしくは、お探しのページが見つかりませんでした。<br>
          下記のボタンより一覧ページかログインページにお戻りください。
        </p>
		<%-- ログインしていなければfilterでログインにリダイレクト --%>
        <p class="cancel"><a href="${pageContext.request.contextPath}/dashboard/menulist">戻る</a></p>
      </section>
      <!-- //.container -->
    </main>

    <jsp:include page="/WEB-INF/jsp/dashboard/footer.jsp" />
  </div>
  <!-- //.insideWrapper -->

</body>