<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="view" type="model.Model" required="true" %>

<li>
   <section class="menuBox">
      <h2 class="menuName"><c:out value="${ view.title }" /></h2>
      <figure class="menuImg">
          <img src="${pageContext.request.contextPath}/${ view.imgUrl }" alt="<fmt:formatNumber value="${ view.price }" pattern="###0" />">
      </figure>
      <c:if test="${not empty view.pickUp}">
        <img src="${pageContext.request.contextPath}/image/osusume.svg" alt="おすすめ" class="pickUp">
      </c:if>                
      <p class="vewPrice" data-price="<fmt:formatNumber value="${ view.price }" pattern="###0" />">
      	<c:if test="${not empty view.setOption}">
        	<span><c:out value="${ view.setOption }" /></span><br>
      	</c:if>
      	<fmt:formatNumber value="${ view.price }" pattern="#,##0" /><span>円</span>
      	<span>（ 税込<fmt:formatNumber value="${ view.price * 1.1 }" pattern="#,##0" />円）</span>
      </p>           
       <img src="${pageContext.request.contextPath}/image/order_btn.svg" alt="注文する" class="order_btn">
   </section>
</li>
