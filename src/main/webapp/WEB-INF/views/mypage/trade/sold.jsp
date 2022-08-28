<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/trade/trade.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">	
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5">
		<h3 class="mt-1 mb-5">판매내역</h3>
	    <div class="border-bottom mb-5 d-flex ">
	        <a href="${pageContext.request.contextPath}/mypage/trade/selling" class="d-block btn btn-outline-dark">판매중</a>
	        <a href="${pageContext.request.contextPath}/mypage/trade/sold" class="d-block btn btn-dark">판매완료</a>
	    </div>
		    <div class="list-container">
		    <c:forEach items="${list}" var="product" varStatus="vs">
		        <div class="d-flex justify-content-between mt-4 mb-4 list">
		            <div class="d-flex">
		            <a href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=${product.productNo}"><img src="${pageContext.request.contextPath}/resources/upload/usedProduct/${product.productImg1}" alt="${product.productTitle}대표 이미지" width="120px" height="120" class="mr-3 ml-3"></a>
		                <div class="d-flex">
		                    <ul class="list-unstyled mt-2">
		                        <li>
			                        <a href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=${product.productNo}" class="text-dark font-weight-bold">${product.productTitle}</a>
			                    </li>
			                    <li><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원</li>
			                    <br>
			                    <li>${product.productLocation}</li>
		                    </ul>
		                </div>
		            </div>
		        </div>
		        <c:if test="${vs.last eq false}"><hr /></c:if>
		        </c:forEach>
		    </div>
		</div>
	</div>
</div>
<div class="d-flex justify-content-center mt-3">
  <div class="spinner-border d-none" role="status">
    <span class="sr-only">Loading...</span>
    <input type="hidden" name="addNum" value="0"/>
  </div>
</div>

<script>

const io = new IntersectionObserver((entries, observer) => {
	entries.forEach((entry) => {
    	$('div.spinner-border').removeClass("d-none");
	    if (entry.isIntersecting) {
	    	let list = null;
	    	observer.disconnect();
	    	 
	        $.ajax({
	        	url:'${pageContext.request.contextPath}/mypage/trade/moreSoldProduct',
	        	async: false,
	        	data:{
	        		offset: $('.list').length,
	        		},
	        	success(response){
	        		const {list} = response;
	        		$('input[name=addNum]').val(list.length) ;
	        		list.forEach((product) =>{
							const $prdDetailLink = '<a href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no='+product.productNo+'"></a>';  	        			
							const $br = '<br>';
							const $a = '<a></a>';
			        			
							$('.list-container').append($('<hr>'));
			        		$('.list-container').append('<div class="d-flex justify-content-between mt-4 mb-4 list"></div>');
			        		$('.list').last().append('<div class="d-flex"></div>');
			        		$('.list .d-flex').last().append($prdDetailLink, '<div class="d-flex"></div>');
			        		$('.list .d-flex a').last().append('<img src="${pageContext.request.contextPath}/resources/upload/usedProduct/' + product.productImg1 +'" alt="'+ product.productTitle +'대표 이미지" width="120px" height="120" class="mr-3 ml-3">');
			        		$('.list .d-flex').last().append('<ul class="list-unstyled mt-2"></ul>');
			        		$('.list ul.list-unstyled').last().append('<li></li>');
			        		$('.list li').last().append($prdDetailLink);
			        		$('.list a').last().prop({
			        			innerHTML:product.productTitle,
			        			className: 'font-weight-bold text-dark'
			        		});
			        		$('.list ul.list-unstyled').last().append('<li>'+ product.productPrice +'원</li>', $br, '<li>'+ product.productLocation +'</li>');
	        			} );
	        		},
        		error: console.log
	        });
	    	$('div.spinner-border').addClass("d-none");
	  	    	if($('input[name=addNum]').val() !== '0'){
				io.observe($('.list').get($('.list').length-1));
		 	}
		  	return;
		}
	});
});

io.observe($('.list').get($('.list').length-1));

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />