<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 外部から受ける変数（Modelオブジェクト）を宣言 --%>
<%@ attribute name="item" type="model.Model" required="true" %>

<li>
  <figure><img src="${pageContext.request.contextPath}/${ item.imgUrl }" alt="<c:out value="${ item.title }" />"></figure>
  <div class="matter">
    <p class="mb5">
      <span class="pr10">ID: <c:out value="${ item.id }" /></span>
      <span class="pr10"><c:out value="${ item.title }" /></span>
      <%-- c:outは値がnullの場合に何も出力しないため、条件分岐を外して直接指定OK --%>
      <c:out value="${ item.setOption }" />
    </p>
    <p class="mb10">
    <%-- fmt安全にフォーマットされているため変更不要 --%>
      <span class="pr10">料金: <fmt:formatNumber value="${ item.price }" pattern="#,##0" />円</span>
      税込 <fmt:formatNumber value="${ item.price * 1.1 }" pattern="#,##0" />円
    </p>
    <p>
      <c:if test="${not empty item.pickUp}">
        <span class="optionUp"><img src="${pageContext.request.contextPath}/image/osusume.svg" alt=""></span>
      </c:if>                
      <span class="catName"><c:out value="${ item.category }" /></span>
      <c:if test="${not empty item.subCat}">
        <span class="catName"><c:out value="${ item.subCat }" /></span>
      </c:if>
    </p>
  </div>
  <div class="editBtn">
    <p class="edit"><a href="${pageContext.request.contextPath}/dashboard/edit?id=${ item.id }">編集する</a></p>
    <p class="delete"><a href="${pageContext.request.contextPath}/dashboard/delete?id=${ item.id }">削除</a></p>
  </div>
</li>