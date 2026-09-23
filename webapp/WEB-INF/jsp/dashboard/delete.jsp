<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="ja">

<head>
	<%-- head動的インクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/head_meta.jsp">
    	<jsp:param name="pageTitle" value="メニュー削除" />
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
        <h2 class="pageTitle">メニュー削除</h2>
        <p class="once">下記のメニューを削除します。ご確認の上、削除ボタンを押して下さい。</p>
        <figure class="deleteImg">
          <img src="${pageContext.request.contextPath}/${ oneItem.imgUrl }" alt="">
        </figure>
        <p class="deleteName">
          ID: <c:out value="${ oneItem.id }" /><br>
          メニュータイトル: <c:out value="${ oneItem.title }" />
        </p>

        <form method="post" action="${pageContext.request.contextPath}/dashboard/delete">
          <input type="hidden" name="id" value="<c:out value="${ oneItem.id }" />">
          <button type="submit" class="sendBtn">削 除</button>
        </form>
        <p class="cancel"><a href="${pageContext.request.contextPath}/dashboard/menulist">キャンセル</a></p>
      </section>
      <!-- //.container -->
    </main>

    <jsp:include page="/WEB-INF/jsp/dashboard/footer.jsp" />
  </div>
  <!-- //.insideWrapper -->

</body>