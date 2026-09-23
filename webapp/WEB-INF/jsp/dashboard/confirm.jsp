<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML>
<html lang="ja">

<head>
<%-- head動的インクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/head_meta.jsp">
    	<jsp:param name="pageTitle" value="入力確認" />
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
        <h2 class="pageTitle">入力確認</h2>

        <form method="post" action="${pageContext.request.contextPath}/dashboard/AddDB" class="menuAdd">
          <dl class="addBox">
            <dt>メニュータイトル<span class="need">必須</span></dt>
            <dd>
              <p><c:out value="${ addName }" /></p>
              <input type="hidden" name="addName" value="<c:out value="${addName}" />">
            </dd>
          </dl>
          <dl class="addBox">
            <dt>セットオプション</dt>
            <dd>
              <p>
              <c:choose>
              	<c:when test="${not empty addSet }">
              		<c:out value="${ addSet }" />
              	</c:when>
              	<c:otherwise>
              		無し
              	</c:otherwise>
              </c:choose>
              </p>
              <input type="hidden" name="addSet" value="<c:out value="${ addSet }" />">
            </dd>
          </dl>
          <dl class="addBox">
            <dt>
              料　金<span class="need">必須</span>
            </dt>
            <dd>
              <p><fmt:formatNumber value="${ addPrice }" pattern="#,##0" />円
              <span class="addtax">税込　<fmt:formatNumber value="${ addPrice * 1.1 }" pattern="#,##0" />円</span>
              </p>
              <input type="hidden" name="addPrice" value="<c:out value="${ addPrice }" />">
            </dd>
          </dl>
          <dl class="addBox">
            <dt>
              カテゴリ<span class="need">必須</span>
            </dt>
            <dd>
              <p><c:out value="${ addCat }" /></p>
              <input type="hidden" name="addCat" value="<c:out value="${ addCat }" />">
            </dd>
          </dl>
          <dl class="addBox subMain">
            <dt>
              サブカテゴリ
            </dt>
            <dd>
              <p>
              <c:choose>
              	<c:when test="${not empty subCat }">
              		<c:out value="${ subCat }" />
              	</c:when>
              	<c:otherwise>
              		無し
              	</c:otherwise>
              </c:choose>
              </p>
              <input type="hidden" name="subCat" value="<c:out value="${ subCat }" />">
            </dd>
          </dl>
          <dl class="addBox mb30">
            <dt>
              おすすめ表示<br>
              <span class="small">メニュー画面に「おすすめ」アイコンが付きます</span>
            </dt>
            <dd>
              <p>
              <c:choose>
              	<c:when test="${not empty pickup }">
              		<c:out value="${ pickup }" />
              	</c:when>
              	<c:otherwise>
              		非表示
              	</c:otherwise>
              </c:choose>
              </p>
              <input type="hidden" name="pickup" value="<c:out value="${ pickup }" />">
            </dd>
          </dl>
          <dl class="addBox">
            <dt class="right addImg">
              <img src="${ imgUrl }" alt="新規画像">
            </dt>
            <dd>
              <p class="mt10">新規画像</p>
              <p class="mt10">推奨サイズ 280px × 280px<br>jpeg、jpg、pngのみ可能</p>
              <input type="hidden" name="addImg" value="${ imgUrl }">
            </dd>
          </dl>

          <button type="submit" class="sendBtn">追加する</button>
          <a href="addlist" class="backBtn">キャンセル</a>
        </form>
        
      </section>
      <!-- //.container -->
    </main>

    <jsp:include page="/WEB-INF/jsp/dashboard/footer.jsp" />
  </div>
  <!-- //.insideWrapper -->

</body>

</html>