<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/sidebar.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/main.css"/>

<div id="section" style="margin-top:150px">
	<div class="container">
		<p class="usedProduct-title">캠퍼밸리 중고거래</p>
		<hr class="line"/>
		
		<!-- 검색창 영역 -->
		<div class="search-area">
		  <div class="form-outline">
		    <input type="text" id="searchProduct" name="searchProduct" 
		    		class="form-control" autocomplete="off" placeholder="상품명, @판매자 검색">
		  </div>
		  <button id="searchBtn" class="btn btn-primary" style="cursor: pointer;" onclick="search()">
		      <i class="fas fa-search" style="color: #639A67;"></i>
		  </button>
		  <sec:authorize access="!hasRole('BLACK') && isAuthenticated()">
			  <div class="ml-1">
				  <button type="button" id="enrollBtn" class="btn btn-success bg-camper-color" onclick="location.href='${pageContext.request.contextPath}/usedProduct/product/registForm'">글쓰기</button>
			  </div>
		  </sec:authorize>
		</div>
			
		<!-- 카테고리 선택 -->
		<div class="dropdown-button"
							style="margin-top: 20px; height: 25px;">
			<a id="btn_menu" class="cateList"> <i class="fas fa-bars"></i></a>
		</div>
		
		<div class="dropdown-area" style="display: inline-block; height: 0px;">
			<div>
				 <div class="dropmenu" style="display: none;">
					<ul>
						<li id="category">
							<p>카테고리 선택</p>
							<ul>
								<a href="/campervalley/usedProduct/main/mainPage">전체상품목록</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=100" data-category="100">텐트/타프</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=200" data-category="200">침낭/매트</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=300" data-category="300">테이블/의자</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=400" data-category="400">조명기구</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=500" data-category="500">주방용품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=600" data-category="600">화로/버너/BBQ</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=700" data-category="700">안전/위생용품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=800" data-category="800">전기/전자제품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=900" data-category="900">캠핑카/카라반/용품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=1000" data-category="1000">루프탑/트레일러</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=1100" data-category=1100">차박용품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=1200" data-category="1200">의류/수납용품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=1300" data-category="1300">겨울용품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=1400" data-category="1400">기타캠핑용품</a>
								<a href="/campervalley/usedProduct/main/cateDisplay?cateNo=1500" data-category="1500">기타생활용품</a>
							</ul>
						</li>
					</ul>
				</div>  
			</div>
			
		</div>
		<!-- container -->
		<div class="content">
			<!-- section -->
			<div id="section">
				<div>
					<c:if test="${not empty display}">
						<jsp:include page="/WEB-INF/views/${display}" />
					</c:if>
					<c:if test="${empty display}">
						<jsp:include page="/WEB-INF/views/usedProduct/main/display.jsp"/>
					</c:if>
				</div>
			</div>
			<!-- 아이템  -->
		</div>
	</div>
</div>
		<!-- nav -->
		<div id="nav">
			<jsp:include page="/WEB-INF/views/usedProduct/main/sidebar.jsp">
		 		<jsp:param value="${wishCnt}" name="wishCnt"/>
			</jsp:include>
		</div>
<script>

/* 검색 */ 

/* 카테고리 */
//ajax 통신을 위한 csrf 설정
 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $(document).ajaxSend(function(e, xhr, options) {
     xhr.setRequestHeader(header, token);
 });
 
 var categoray_list

 $(document).ready(function() {
 	
 	// 카테고리 목록 조회
 	$.ajax({
 		type : 'post',
 		url : '${pageContext.request.contextPath}/usedProduct/main/cateList',
 		dataType : 'json',
 		success : function(data) {
 			categoray_list = data.list;
 		},
 		error : function(data) {
 			console.log("data:" + data);
 		}
 	});
 })
 
/* 카테고리 검색 */
// 카테고리 마우스 오버 이벤트
$("#btn_menu").hover(function(){
	// 카테고리 보이기
	$(".dropmenu").show();
})
// 첫번째 카테고리 마우스 오버 이벤트
$(".dropmenu li:first a").hover(function() {
	$(".dropmenu ul > li").eq(1).show();
	$(".dropmenu li:first a").removeClass("active");
	$(this).addClass("active");
})
// 카테고리 마우스 벗어나면 숨김
$(".dropmenu").mouseleave(function() {
	console.log(this.className)
	$(".dropmenu li:first a").removeClass("active");
	$(".dropmenu").hide();
})

/* 검색어 검색 */
function search() {
	var keyword = $('#searchProduct').val();
	
	location.href = '/campervalley/usedProduct/main/searchDisplay?keyword=' + keyword;
}
 
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>