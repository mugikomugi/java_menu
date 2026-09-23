<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List, model.Model" %>
<%-- 繰り返しliのコンポーネント化 --%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<!DOCTYPE HTML>
<html lang="ja">
<head>
	<%-- head動的インクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/head_meta.jsp">
    	<jsp:param name="pageTitle" value="メニュー画面" />
    	<jsp:param name="css" value="dashboard.css" />
	</jsp:include>
</head>

<body>
  <div class="insideWrapper">
    <header class="insideHeader">
      <h1 class="insideTitle"><img src="${pageContext.request.contextPath}/image/db_logo.svg" alt="田舎や Dashboard"></h1>
      <div class="btnHeder">
        <p class="prevPage"><a href="${pageContext.request.contextPath}/" target="_blank">プレビュー</a></p>
        <p class="logOut" id="logOut">
        	<a href="${pageContext.request.contextPath}/dashboard/logout">ログアウト</a>
        </p>
      </div>
    </header>

    <main class="insideMain">

      <div class="addBtn">
        <a href="${pageContext.request.contextPath}/dashboard/addlist">メニュー新規追加</a>
      </div>

      <section class="menuList">

        <h2 class="pageTitle">メニュー一覧</h2>

        <ul class="catTab">
          <li class="actCat" data-id="catMain">メイン</li>
          <li class="none" data-id="catOne">単品</li>
          <li class="none" data-id="catSweet">デザート</li>
          <li class="none" data-id="catDrink">ドリンク</li>
        </ul>

        <!-- メイン -->
        <ul class="detail" id="catMain">
        <c:set var="hasMain" value="false" />
          <c:forEach var="m" items="${ dblist }">
            <c:if test="${ m.category == 'メイン' }">
              <c:set var="hasMain" value="true" />
          	<%-- 独自タグ共通化、prefix:ファイル名拡張子無しで紐漬け --%>
              <my:menuItem item="${ m }" />
          </c:if>
          </c:forEach>
          <c:if test="${ !hasMain }">
            <li><p>メインのデータがありません。</p></li>
          </c:if>
        </ul>

        <!-- 単品 -->
        <ul class="detail" id="catOne">
          <c:set var="hasOne" value="false" />
          <c:forEach var="m" items="${ dblist }">
            <c:if test="${ m.category == '単品' }">
              <c:set var="hasOne" value="true" />
				<my:menuItem item="${ m }" />	
            </c:if>
          </c:forEach>
          <c:if test="${ !hasOne }">
            <li>単品のデータがありません。</li>
          </c:if>
        </ul>

        <!-- デザート -->
        <ul class="detail" id="catSweet">
          <c:set var="hasSweet" value="false" />
          <c:forEach var="m" items="${ dblist }">
            <c:if test="${ m.category == 'デザート' }">
              <c:set var="hasSweet" value="true" />
              <my:menuItem item="${ m }" />
            </c:if>
          </c:forEach>
          <c:if test="${ !hasSweet }">
            <li><p>デザートのデータがありません。</p></li>
          </c:if>
        </ul>

        <!-- ドリンク -->
        <ul class="detail" id="catDrink">
          <c:set var="hasDrink" value="false" />
          <c:forEach var="m" items="${ dblist }">
            <c:if test="${ m.category == 'ドリンク' }">
              <c:set var="hasDrink" value="true" />
              <my:menuItem item="${ m }" />
            </c:if>
          </c:forEach>
          <c:if test="${ !hasDrink }">
            <li><p>ドリンクのデータがありません。</p></li>
          </c:if>
        </ul>

      </section>
      <!-- //.menuList -->

    </main>
	<%-- footerインクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/footer.jsp" />
  </div>
  <!-- //.insideWrapper -->

  <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/inside.js"></script>
</body>

</html>