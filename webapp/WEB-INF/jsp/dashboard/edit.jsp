<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List, model.Model" %>
<!DOCTYPE HTML>
<html lang="ja">

<head>
	<%-- head動的インクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/head_meta.jsp">
    	<jsp:param name="pageTitle" value="メニュー編集" />
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
        <h2 class="pageTitle">メニュー編集</h2>
        <form method="post" action="${pageContext.request.contextPath}/dashboard/edit" enctype="multipart/form-data" class="menuAdd">
        <input type="hidden" name="id" value="<c:out value="${ oneItem.id }" />">
          <dl class="addBox">
            <dt><label for="addName">メニュータイトル<span class="need">必須</span></label></dt>
            <dd>
              <input type="text" name="editName" id="addName" value="<c:out value="${ oneItem.title }" />" required>
              <!-- <p class="error">タイトルを入力してください</p> -->
            </dd>
          </dl>
          <dl class="addBox">
            <dt><label for="addSet">セットオプション</label></dt>
            <dd>
              <select name="editSet" id="addSet">
                <option value="" ${empty oneItem.setOption ? 'selected' : ''}>無し</option>
                <option value="パンorライス付" ${oneItem.setOption == 'パンorライス付' ? 'selected' : ''}>パンorライス付</option>
                <option value="パン付" ${oneItem.setOption == 'パン付' ? 'selected' : ''}>パン付</option>
                <option value="ライス付" ${oneItem.setOption == 'ライス付' ? 'selected' : ''}>ライス付</option>
                <option value="サラダ付" ${oneItem.setOption == 'サラダ付' ? 'selected' : ''}>サラダ付</option>
                <option value="ドリンク付" ${oneItem.setOption == 'ドリンク付' ? 'selected' : ''}>ドリンク付</option>
                
              </select>
            </dd>
          </dl>
          <dl class="addBox">
            <dt>
              <label for="addPrice">料　金<span class="need">必須</span></label>
            </dt>
            <dd>
              <input type="text" name="editPrice" id="addPrice" value="<fmt:formatNumber value="${ oneItem.price }" pattern="###0" />" required>
              <span class="addtax">税込　<fmt:formatNumber value="${ oneItem.price * 1.1 }" pattern="#,##0" />円</span>
              <p class="small">半角英数字で入力してください</p>
            </dd>
          </dl>
          <dl class="addBox">
            <dt>
              <label for="addCat">カテゴリ</label><span class="need">※</span><br>
              <span class="small">メインを選択した場合はサブカテゴリも選択してください</span>
            </dt>
            <dd>
              <select name="editCat" id="addCat">
                <option value="メイン" ${oneItem.category == 'メイン' ? 'selected' : ''}>メイン</option>
                <option value="単品" ${oneItem.category == '単品' ? 'selected' : ''}>単品</option>
                <option value="デザート" ${oneItem.category == 'デザート' ? 'selected' : ''}>デザート</option>
                <option value="ドリンク" ${oneItem.category == 'ドリンク' ? 'selected' : ''}>ドリンク</option>
              </select>
            </dd>
          </dl>
          <dl class="addBox subMain">
            <dt>
              <label for="subCat">サブカテゴリ</label>
            </dt>
            <dd>
              <select name="subCat" id="subCat" class="editSub">
                <option value="お肉" ${oneItem.subCat == 'お肉' ? 'selected' : ''}>お肉</option>
				<option value="お魚" ${oneItem.subCat == 'お魚' ? 'selected' : ''}>お魚</option>
				<option value="麺" ${oneItem.subCat == '麺' ? 'selected' : ''}>麺</option>
				<option value="丼物・ライス" ${oneItem.subCat == '丼物・ライス' ? 'selected' : ''}>丼物・ライス</option>
				<option value="パン・ピザ" ${oneItem.subCat == 'パン・ピザ' ? 'selected' : ''}>パン・ピザ</option>
				<option value="" class="noMain" ${empty oneItem.subCat ? 'selected' : ''}>無し</option>
              </select>
            </dd>
          </dl>
          <dl class="addBox mb30">
            <dt>
              おすすめ表示<br>
              <span class="small">メニュー画面に「おすすめ」アイコンが付きます</span>
            </dt>
            <dd>
              <label>非表示<input type="radio" name="pickup" value="" <c:if test="${empty oneItem.pickUp}">checked</c:if>></label>
              <label>表示<input type="radio" name="pickup" value="表示" <c:if test="${oneItem.pickUp == '表示' }">checked</c:if>></label>
            </dd>
          </dl>
          <dl class="addBox">
            <dt class="right addImg">
              <img src="${pageContext.request.contextPath}/${ oneItem.imgUrl }" alt="">
            </dt>
            <dd>
              <label>
                <input type="file" name="editImg" value="${ oneItem.imgUrl }" accept=".jpg, .jpeg, .png" class="editImgBtn">
              </label>
              <p class="mt10">画像を変更する場合は選択してください。上書きされます。<br>
              変更した際にプレビュー画像は変わりませんがファイル名が表示されます。<br>
              ボタンを押さなければ変更はありません。
              </p>
              <p>推奨サイズ 280px × 280px<br>jpeg、jpg、pngのみ可能</p>
            </dd>
          </dl>

          <button type="submit" class="sendBtn">更 新</button>
          <p class="cancel"><a href="${pageContext.request.contextPath}/dashboard/menulist">キャンセル</a></p>
        </form>

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