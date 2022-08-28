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
		<div class="col-lg-10 px-5 ">
			<h3 class="mb-5 mt-1">구매내역</h3>
		    <div class="list-container">
			    <c:forEach items="${list}" var="product" varStatus="vs">
			        <div class="d-flex justify-content-between list mt-4 mb-4 list">
			        	<div class="d-flex">
			            	<a <c:if test="${product.isDelete eq 'N'}"> href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=${product.productNo}" </c:if>><img src="${pageContext.request.contextPath}/resources/upload/usedProduct/${product.productImg1}" alt="${product.productTitle}대표 이미지" width="120px" height="120" class="mr-3 ml-3"></a>
			            	<div class="d-flex">
			                	<ul class="list-unstyled mt-2">
				                	<li>
				                    	<a <c:if test="${product.isDelete eq 'N'}"> href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=${product.productNo}" </c:if> class="text-dark font-weight-bold">${product.productTitle}</a>
				                    </li>
				                    <li><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원</li>
				                    <br>
				                    <li>${product.productLocation}</li>
								</ul>
							</div>
				        </div>
			            <c:if test="${empty product.reviewNo || product.reviewNo eq ''}">
			                <a class="review-enroll btn btn-camper-color btn-sm align-self-center mr-3" data-productno="${product.productNo}">거래후기 등록</a>
			            </c:if>
			            <c:if test="${not empty product.reviewNo && product.reviewNo ne ''}" >
			                <a class="review-update btn btn-danger btn-sm align-self-center mr-3" data-reviewno="${product.reviewNo}" data-starscore="${product.starScore}" data-content="${product.content}">거래후기 수정</a>
			            </c:if>
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
    <input type="hidden" name="addNum" value="0" />
  </div>
</div>
<%-- JH START --%>
<jsp:include page="/WEB-INF/views/tradereview/reviewEnroll.jsp" />
<jsp:include page="/WEB-INF/views/tradereview/reviewUpdate.jsp" />
<script>
	
	$(document).on('click','.review-enroll', (e) => {
		e.preventDefault();
		const productNo = e.target.dataset.productno;
		$("#reviewEnroll").modal().on('hide.bs.modal');
		$("#reviewEnroll .fa-star").css("color", "rgb(230, 185, 20)");
		$("#reviewEnroll #ctent").val("");
		$("#reviewEnroll #starScore").val("5");
		$("#reviewEnroll #productNo").val(productNo);
	});


	$(document).on('click','.review-update', (e) => {
		e.preventDefault();
		const reviewNo = e.target.dataset.reviewno;
		const index = e.target.dataset.starscore - 1;
		const content = e.target.dataset.content;
		$("#reviewUpdate").modal().on('hide.bs.modal');
		$("#reviewUpdate .fa-star").css("color", "rgb(235, 235, 235)");
		for(let i = 0; i < 5; i++) {
			if(i <= index) $(`#reviewUpdate .fa-star:nth-child(\${i+1})`).css("color", "rgb(230, 185, 20)");
		}
		$("#reviewUpdate #starScore").val(`\${index + 1}`);
		$("#reviewUpdate #ctent").val(content);
		$("#reviewUpdate #wordCount").html($("#reviewUpdate #ctent").val().length);
		$("#reviewUpdate .reviewNo").val(reviewNo);
	});

</script>
<%-- JH END --%>
<script>
const io = new IntersectionObserver((entries, observer) => {
	entries.forEach((entry) => {
    	$('div.spinner-border').removeClass("d-none");
	    if (entry.isIntersecting) {
	    	let list = null;
	    	observer.disconnect();
	    	 
	        $.ajax({
	        	url:'${pageContext.request.contextPath}/mypage/trade/morePuschasedProduct',
	        	async: false,
	        	data:{
	        		offset: $('.list').length,
	        		},
	        	success(response){
	        			const {list} = response;
	        			console.log(list.length);
	        			$('input[name=addNum]').val(list.length) ;
	        			list.forEach((product) =>{
							const $prdDetailLink = '${pageContext.request.contextPath}/usedProduct/product/productDetail?no='+product.productNo;  	        			
							
							const $br = '<br>';
							const $a = '<a></a>';
		        				
							$('.list-container').append($('<hr>'));
			        		$('.list-container').append('<div class="d-flex justify-content-between mt-4 mb-4 list"></div>');
			        		$('.list').last().append('<div class="d-flex"></div>');
			        		$('.list .d-flex').last().append($a, '<div class="d-flex"></div>');
			        		console.log(product.isDelete === 'N');
			        		if(product.isDelete === 'N' ){
			        			console.log(product.isDelete);
			        			$('.list a').last().prop({
			        				href: $prdDetailLink
			        			});
			        		}
			        		$('.list .d-flex a').last().append('<img src="${pageContext.request.contextPath}/resources/upload/usedProduct/' + product.productImg1 +'" alt="'+ product.productTitle +'대표 이미지" width="120px" height="120px" class="mr-3 ml-3">');
			        		$('.list .d-flex').last().append('<ul class="list-unstyled mt-2"></ul>');
			        		$('.list ul.list-unstyled').last().append('<li></li>');
			        		$('.list li').last().append($a);
			        		$('.list a').last().prop({
			        			innerHTML:product.productTitle,
			        			className: 'font-weight-bold text-dark',
			        		});
			        		//조건문
			        		$('.list a').last().prop({
			        			href: $prdDetailLink
			        		});
			        		//조건문 end
			        		$('.list ul.list-unstyled').last().append('<li>'+ product.productPrice +'원</li>', $br, '<li>'+ product.productLocation +'</li>');
			        		$('.list').last().append($a);
		        			
		        			//console.log('거래후기등록하는 경우',product.reviewNo, typeof(product.reviewNo));
		        			if(product.reviewNo == 0){
			        			$('.list a').last().prop({
			        				innerHTML: '거래후기 등록',
			        				className: 'review-enroll btn btn-camper-color btn-sm align-self-center mr-3',
			        			}).attr('data-productno',product.productNo);
		        			} else {
			        			$('.list a').last().prop({
			        				innerHTML: '거래후기 수정',
			        				className: 'review-update btn btn-danger btn-sm align-self-center mr-3',
			        			}).attr('data-reviewno',product.reviewNo)
			        				.attr('data-starscore',product.starScore)
			        				.attr('data-content',product.content);
		        			}
	        			});
	        		},
        		error: console.log
	        });
	        
	    	$('div.spinner-border').addClass("d-none");
	  	    if($('input[name=addNum]').val() === '0')
		  		return;
			io.observe($('.list').get($('.list').length-1));
	    }
	  });
});

io.observe($('.list').get($('.list').length-1));
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />