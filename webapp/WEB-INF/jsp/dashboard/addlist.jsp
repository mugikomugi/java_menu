<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- EL式はgetAttribute省略できる --%>

<!DOCTYPE HTML>
<html lang="ja">

<head>
	<%-- head動的インクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/head_meta.jsp">
    	<jsp:param name="pageTitle" value="新規追加" />
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
        <h2 class="pageTitle">メニュー新規追加</h2>
        <!-- 新規追加入力 -->
        <form method="post" action="${pageContext.request.contextPath}/dashboard/confirm" enctype="multipart/form-data" class="menuAdd">
          <dl class="addBox">
            <dt><label for="addName">メニュータイトル<span class="need">必須</span></label></dt>
            <dd><%-- requiredは入力必須 --%>
              <input type="text" name="addName" id="addName" required>
              <c:if test="${not empty errorMsg1}">
              	<p class="error"><c:out value="${errorMsg1}" /></p>
              </c:if>
            </dd>
          </dl>
          <dl class="addBox">
            <dt><label for="addSet">セットオプション</label></dt>
            <dd>
              <select name="addSet" id="addSet">
                <option value="">無し</option>
                <option value="パンorライス付">パンorライス付</option>
                <option value="パン付">パン付</option>
                <option value="ライス付">ライス付</option>
                <option value="サラダ付">サラダ付</option>
                <option value="ドリンク付">ドリンク付</option>
              </select>
            </dd>
          </dl>
          <dl class="addBox">
            <dt>
              <label for="addPrice">料　金<span class="need">必須</span></label>
            </dt>
            <dd>
              <input type="text" name="addPrice" id="addPrice" placeholder="カンマ無し、半角数字" required>
              <c:if test="${not empty errorMsg2}">
              	<p class="error"><c:out value="${errorMsg2}" /></p>
              </c:if>
            </dd>
          </dl>
          <dl class="addBox">
            <dt>
              <label for="addCat">カテゴリ</label><span class="need">※</span><br>
              <span class="small">メインを選択した場合はサブカテゴリも選択してください</span>
            </dt>
            <dd>
              <select name="addCat" id="addCat" required>
                <option value="メイン">メイン</option>
                <option value="単品">単品</option>
                <option value="デザート">デザート</option>
                <option value="ドリンク">ドリンク</option>
              </select>
            </dd>
          </dl>
          <dl class="addBox subMain">
            <dt>
              <label for="subCat">サブカテゴリ</label>
            </dt>
            <dd>
              <select name="subCat" id="subCat" class="addSub">       
                <option value="お肉">お肉</option>
                <option value="お魚">お魚</option>
                <option value="麺">麺</option>
                <option value="丼物・ライス">丼物・ライス</option>
                <option value="パン・ピザ">パン・ピザ</option>
                <option value="" class="noMain">無し</option>
              </select>
            </dd>
          </dl>
          <dl class="addBox mb30">
            <dt>
              おすすめ表示<br>
              <span class="small">メニュー画面に「おすすめ」アイコンが付きます</span>
            </dt>
            <dd>
              <label>非表示<input type="radio" name="pickup" value="" checked></label>
              <label>表示<input type="radio" name="pickup" value="表示"></label>
            </dd>
          </dl>
          <dl class="addBox">
            <dt class="right addImg">
              <img src="${pageContext.request.contextPath}/image/noimage2.jpg" alt="">
            </dt>
            <dd>
              <span class="need">必須</span><br>
              <label>
                <input type="file" name="addImg" accept=".jpg, .jpeg, .png" required>
              </label>
              <c:if test="${not empty errorMsg3}">
              	<p class="error"><c:out value="${errorMsg3 }" /></p>
              </c:if>
              <p class="mt10">推奨サイズ 280px × 280px<br>jpeg、jpg、pngのみ可能</p>
            </dd>
          </dl>

          <button type="submit" class="sendBtn">確 認</button>
        </form>
        <p class="toList">
          <a href="${pageContext.request.contextPath}/dashboard/menulist">メニュー一覧へ</a>
        </p>
      </section>
      <!-- //.container -->
    </main>

    <jsp:include page="/WEB-INF/jsp/dashboard/footer.jsp" />
  </div>
  <!-- //.insideWrapper -->
  <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/inside.js"></script>
</body>

</html>