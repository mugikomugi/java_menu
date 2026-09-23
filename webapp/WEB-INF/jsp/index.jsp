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
    	<jsp:param name="pageTitle" value="プレビュー画面" />
    	<jsp:param name="css" value="vew.css" />
	</jsp:include>
</head>

<body>
  <div class="vewWrapper">
    <header class="vewHeader">
      <h1 class="vewH1">Sample Menu Preview</h1>
      <figure class="topImg">
        <img src="${pageContext.request.contextPath}/image/prev_main.jpg" alt="">
        <img src="${pageContext.request.contextPath}/image/prev_title.png" alt="田舎屋" class="titleImg">
      </figure>
    </header>
    <main class="vewMain">

      <!-- カテゴリー タブ切り替え -->
      <ul class="vewCattab">
        <li data-id="osusume" class="act">おすすめ</li>
        <li data-id="mainCat" class="none">メイン</li>
        <li data-id="oneCat" class="none">単品</li>
        <li data-id="cakeCat" class="none">デザート</li>
        <li data-id="drinkCat" class="none">飲み物</li>
      </ul>

      <div class="menuContainer">

        <!-- おすすめメニュー -->
        <div class="active" id="osusume">
          <ul class="vewMenu">
          <c:set var="hasShow" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ not empty m.pickUp }">
          	<c:set var="hasShow" value="true" />
            <li>
              <section class="menuBox">
                <h2 class="menuName"><c:out value="${ m.title }" /></h2>
                <figure class="menuImg">
                  <img src="${pageContext.request.contextPath}/${ m.imgUrl }" alt="<c:out value="${ m.title }" />">
                </figure>
        		<img src="${pageContext.request.contextPath}/image/osusume.svg" alt="おすすめ" class="pickUp">              
                <p class="vewPrice" data-price="<fmt:formatNumber value="${ m.price }" pattern="###0" />">
                  <c:if test="${not empty m.setOption}">
        			<span><c:out value="${ m.setOption }" /></span><br>
      				</c:if>
                  <fmt:formatNumber value="${ m.price }" pattern="#,##0" /><span>円</span>
                  <span>（ 税込<fmt:formatNumber value="${ m.price * 1.1 }" pattern="#,##0" />円）</span>
                </p>
                <img src="${pageContext.request.contextPath}/image/order_btn.svg" alt="注文する" class="order_btn">
              </section>
            </li>
            </c:if>
            </c:forEach>
            <c:if test="${ !hasShow }">
            <li><p>おすすめのデータがありません。</p></li>
          </c:if>
          </ul>
        </div>
        <!-- //おすすめメニュー -->

        <!-- メイン -->
        <section class="noActive" id="mainCat">
          <h2 class="subMenu"><span>Meat</span>お肉</h2>
          <ul class="vewMenu">
          <c:set var="hasMeet" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == 'メイン' && m.subCat == 'お肉' }">
          	<c:set var="hasMeet" value="true" />
            	<%-- 独自タグ共通化、prefix:ファイル名拡張子無しで紐づけ --%>
              	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasMeet }">
            <li><p>お肉のデータがありません。</p></li>
          </c:if>
          </ul>
          <!-- tagお魚 -->
          <h2 class="subMenu"><span>Fish</span>お魚</h2>
          <ul class="vewMenu">
          <c:set var="hasFish" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == 'メイン' && m.subCat == 'お魚' }">
          	<c:set var="hasFish" value="true" />
            	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasFish }">
            <li><p>お魚のデータがありません。</p></li>
          </c:if>         
          </ul>
          
          <!-- tag麺 -->
          <h2 class="subMenu"><span>Noodles</span>麺</h2>
          <ul class="vewMenu">
          <c:set var="hasPasta" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == 'メイン' && m.subCat == '麺' }">
          	<c:set var="hasPasta" value="true" />
            	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasPasta }">
            <li><p>麺のデータがありません。</p></li>
          </c:if>         
          </ul>
          
          <!-- 丼物・ライス -->
          <h2 class="subMenu"><span>Rice</span>丼物・ライス</h2>
          <ul class="vewMenu">
          <c:set var="hasRice" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == 'メイン' && m.subCat == '丼物・ライス' }">
          	<c:set var="hasRice" value="true" />
            	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasRice }">
            <li><p>丼物・ライスのデータがありません。</p></li>
          </c:if>         
          </ul>
          
          <!-- パン・ピザ -->
          <h2 class="subMenu"><span>Bread</span>パン・ピザ</h2>
          <ul class="vewMenu">
          <c:set var="hasPan" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == 'メイン' && m.subCat == 'パン・ピザ' }">
          	<c:set var="hasPan" value="true" />
            	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasPan }">
            <li><p>パン・ピザのデータがありません。</p></li>
          </c:if>         
          </ul>
          
        </section>
        <!-- //メイン -->

        <!-- 単品 -->
        <div class="noActive" id="oneCat">
          <ul class="vewMenu">
          <c:set var="hasOne" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == '単品' }">
          	<c:set var="hasOne" value="true" />
            	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasOne }">
            <li><p>単品のデータがありません。</p></li>
          </c:if>
          </ul>
        </div>
        <!-- //単品 -->

        <!-- デザート -->
        <div class="noActive" id="cakeCat">
          <ul class="vewMenu">
          <c:set var="hasSweets" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == 'デザート' }">
          	<c:set var="hasSweets" value="true" />
            	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasSweets }">
            <li><p>デザートのデータがありません。</p></li>
          </c:if>
          </ul>
        </div>
        <!-- //デザート -->

        <!-- 飲み物 -->
        <div class="noActive" id="drinkCat">
          <ul class="vewMenu">
          <c:set var="hasDrink" value="false" />
          <c:forEach var="m" items="${ dblist }">
          	<c:if test="${ m.category == 'ドリンク' }">
          	<c:set var="hasDrink" value="true" />
            	<my:menuview view ="${ m }" />
            </c:if>
            </c:forEach>
            <c:if test="${ !hasDrink }">
            <li><p>ドリンクのデータがありません。</p></li>
          </c:if>
          </ul>
        </div>
        <!-- //飲み物 -->

      </div>
      <!-- //.menuContainer -->

      <section class="explanation">
        <h2 class="explanTitle">制作環境と仕様について</h2>
        <div class="explanText">
          <p class="mb20">Javaでテストメニュー立ち上げました。サイズはPCとタブレット端末を対象にしています。<br>
            こちらの画面は一般公開の表示用に作りました。横幅820pxを最小値にしています。<br>
            フロント側では、モーダルで注文リストと会計、thanks画面の流れをjsで作り、個数操作と計算処理を組みました。
            ページ移行はないので注文ボタンでclickした値はオブジェクトにセットし、そのまま会計まで持っていくようにして、
            注文確定すると要素は削除し、オブジェクトは空になるようにしています。
            </p>
            <p class="mb20">
            また、ログイン形式で操作用ダッシュボードも制作しました。<br>
            filterパッケージの中に専用のclassを作成。sessionスコープによりログイン判定させてます。
            メニュー情報はDBに格納して、一般公開ページとダッシュボードの一覧を同じテーブルから書き出し、追加、編集、削除機能を実装しました。<br>
            DAOパターンを使うと決めていたのでMVCモデルです。<br>
            画像はURLのみDBへ保存し画像本体は専用のディレクトリに入れ、エラーとセキュリティ対策の為ファイル名はランダムな16文字の英小文字に変換しています。<br>
            制作途中にTomcatのデフォルトで何もしないとアップロードした画像は隠しフォルダの深い階層に入ってしまい、確認ができず困ってしまいました。<br>
            任意のディレクトリへ入れたい場合は画像リンク専用のサーブレットが必要になり、パスの設定もローカル環境用と本環境用に条件分岐を記述。<br>
            本環境はymlファイルから指定します。<br>
            実務ではほとんどSpring Bootが使われているそうですが、初めてのJava構築なのでフレームワークは使わず
            仕組みがわかるよう素組みで開発しました。
            </p>
            <div class="mb20">
            開発環境：
            <ul>
            	<li>Java17</li>
            	<li>Tomcat9</li>
            	<li>Eclipse2023</li>
            	<li>Docker4.89</li>
            	<li>MySQL8</li>
            	<li>XAMPP8 <span class="small">※phpmyadminでMySQLとテーブルのカラム作成</span></li>
            	<li>Visual Studio Code <span class="small">※フロントエンドコーディング</span></li>
            	<li>Figma <span class="small">※デザイン作成</span></li>
            	<li>Photo shop <span class="small">※画像トリミング</span></li>
            	<li>Mac OS14</li>
            </ul>
            </div>
          <p class="mb20">更新日：2026年００月００日</p>
          <p class="link">
            <a href="#"><img src="${pageContext.request.contextPath}/image/github.svg" alt="Git hub"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/image/qiita.svg" alt="Qiita"></a>
          </p>
        </div>
      </section>
      <!-- //.explanation -->

  <!-- モーダル -->
  <div class="overlay"></div>
  <!-- 注文票 -->
  <section class="orderList">
    <h2 class="orderTitle">ご注文リスト</h2>
    <p class="notes">「メニューを見る」ボタンで追加注文できます。</p>
    <ul class="orderBox">
    </ul>
    <div class="cashiers" id="cash">お会計へ</div>
    <div class="toMenu" id="toMenu">メニューを見る</div>
  </section>

  <!-- お会計 -->
  <section class="cashList">
    <h2 class="orderTitle">お会計</h2>
    <ul class="cashBox"></ul>
    <div class="total"></div>
    <div class="cashiers" id="practice">注文する</div>
    <div class="toMenu" id="toBack">戻る</div>
  </section>

  <!-- thanks -->
  <section class="thanks">
    <h2 class="orderTitle">ご注文を承りました</h2>
    <div class="thanksText">
      <p class="mb20">
        こちらは注文受付画面になります。<br>
        メニュー一覧の注文ボタンを押すとjsでモーダルウィンドウが表示され注文詳細、会計、最終画面まで同一ページで完結する仕様にしています。
      </p>
      <p>
        ページ移行がないのでjsで値を拾いオブジェクトへ追加、リアルタイムでinputから個数の変化を読み取っています。会計画面では、そのまま計算処理をして表示しています。「メニューに戻る」ボタンではオブジェクトを空の状態にしてモーダルウィンドウを非表示にする処理をしています。
      </p>
    </div>
    <div class="toMenu" id="toList">メニューに戻る</div>
  </section>
  <!-- //モーダル -->
  
    </main>
    <%-- footerインクルード --%>
	<jsp:include page="/WEB-INF/jsp/dashboard/footer.jsp" />
  </div>
  <!-- // .vewWrapper-->

  <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/base.js"></script>
</body>

</html>