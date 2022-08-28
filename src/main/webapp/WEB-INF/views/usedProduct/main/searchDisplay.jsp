<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/main.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/sidebar.css"/>

<input type="hidden" id="keyword" name="keyword" value="${keyword}"/>
<input type="hidden" id="order" name="order" value="${order}"/>
<input type="hidden" id="page" name="page" value="${page}"/>
<input type="hidden" id="searchResult" name="searchResult" value="${searchResult}"/>

<div id="section">
	<hr />
	<!-- 광고 -->
	<div class="adPlace">
		<div id="carouselExampleIndicators" class="carousel slide"
			data-bs-ride="carousel">
			<ol class="carousel-indicators">
				<c:forEach items="${adList}" var="advertisement" varStatus="vs">
					<li data-target="#carouselExampleIndicators" data-slide-to="${vs.count - 1}" ${vs.count eq 1 ? 'active' : ''}></li>
				</c:forEach>
			</ol>
			<div class="carousel-inner">
				<c:forEach items="${adList}" var="advertisement" varStatus="vs">
		    		<div class="carousel-item ${vs.count eq 1 ? 'active' : ''}"
		    			data-advertisement-no="${advertisement.advertisementNo}"
		    			onclick="clickUpAndMove(${advertisement.advertisementNo}, '${advertisement.adLink}');">
		    			<img src="${pageContext.request.contextPath}/resources/upload/mypage/advertiser/advertisement/${advertisement.adAttach.renamedFilename}"
		    				alt="중고거래홈 광고이미지${vs.count}" id="${vs.count}" class="d-block w-100" style="cursor: pointer;"/>
					</div>
				</c:forEach>
			</div>
			<c:if test="${fn:length(adList) > 1}">
				<a class="carousel-control-prev mx-auto" href="#carouselExampleIndicators" role="button" data-slide="prev" style="margin-top: 30px;">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden"></span>
				</a>
				<a class="carousel-control-next mx-auto" href="#carouselExampleIndicators" role="button" data-slide="next" style="margin-top: 30px;">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden"></span>
				</a>
			</c:if>
		</div>
	</div>

	<!-- page -->
	<div id="productTop">
		<!-- 상품+개수 -->
		<div>
			<span id="productName">${keyword}</span><span>${searchResult}</span>
			<span class="productNum">${cnt}개</span>
		</div>
	</div>
	
	<div class="productListTop" style="height: 30px;">
		<div class="listTopInner">
			<div class="group" style="float: right; margin-right: 10px;">
				<!-- 카테고리 정렬 -->
			<a class="groupChecked ${order eq null ? 'active' : ''} ${order eq 'A' ? 'active' : ''}"
				onclick="order('A')">최신순</a> <a
				class="groupOther ${order eq 'B' ? 'active' : ''}"
				onclick="order('B')">인기순</a> <a
				class="groupOther ${order eq 'C' ? 'active' : ''}"
				onclick="order('C')">저가순</a> <a
				class="groupOther ${order eq 'D' ? 'active' : ''}"
				onclick="order('D')">고가순</a>
			</div>
		</div>
	</div>
	
<div id="display-list" class="row">
	<c:forEach varStatus="status" items="${list}" var="item">
		<c:set var="b_time" value="${item.productEnrollTime}" />
		<c:set var="time"
			value="${ b_time > (60 * 24) ? Math.round( b_time / (60 * 24) ) : ( b_time > 60 ? Math.round( b_time / 60 ) : b_time ) }" />

		<c:if test="${60 > b_time}">
			<c:set var="time_before" value="분 전" />
		</c:if>
		<c:if test="${ b_time > 60}">
			<c:set var="time_before" value="시간 전" />
		</c:if>
		<c:if test="${ b_time > (60 * 24)}">
			<c:set var="time_before" value="일 전" />
		</c:if>
		
		<div class="item col-3" onclick="test(${item.productNo})" style="cursor: pointer; margin-right: -58.5px;">
			<div class="item">
				<div id="itemSolid">
					<div class="img-box">
						<img src="${pageContext.request.contextPath}/resources/upload/usedProduct/${item.productImg1}" class="rounded float-start" alt="${item.productTitle}">
					</div>
					<div class="text-box">
						<div class="displayName">${item.productTitle}</div>
						<div class="price-time">
							<div class="displayPrice">${item.productPrice}</div>
							<div class="displayTime">
								<span>${time}${time_before}<span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
	<!-- sidebar -->
	<div id="nav">
 			<jsp:include page="/WEB-INF/views/usedProduct/main/sidebar.jsp">
		 		<jsp:param value="${wishCnt}" name="wishCnt"/>
			</jsp:include>
	</div>
</div>

<script>

function order(order) {
	location.href = '/campervalley/usedProduct/main/searchDisplay?keyword='
				  + $("#keyword").val()
				  + "&page=" + $("#page").val()
				  + "&order=" + order
}

function test(no) {
	location.href = '/campervalley/usedProduct/product/productDetail?no=' + no
}
</script>
<%-- EJ start --%>
<script>
window.addEventListener('load', (e) => {
	// 첫번째 광고 조회수 증가처리
	viewUpFirstAd();
});
const viewUpFirstAd = () => {
	const active = document.querySelector(".carousel-inner .active");
	const advertisementNo = active.dataset.advertisementNo;
	viewUpAd(advertisementNo);
};
// 조회수 증가
const viewUpAd = (advertisementNo) => {
	$.ajax({
		url: "${pageContext.request.contextPath}/mypage/advertiser/viewUp",
		type: "POST",
		headers: {
			"${_csrf.headerName}" : "${_csrf.token}"
		},
		data: {
			advertisementNo
		},
		error: console.log
	});
};
// 슬라이드 시 조회수증가 function 실행
$('#carouselExampleIndicators').on('slid.bs.carousel', function () {
	const active = document.querySelector(".carousel-inner .active");
	const advertisementNo = active.dataset.advertisementNo;
	viewUpAd(advertisementNo);
});
// 클릭수 증가 -> 광고 링크 이동
const clickUpAndMove = (advertisementNo, adLink) => {
	
	$.ajax({
		url: "${pageContext.request.contextPath}/mypage/advertiser/clickUp",
		type: "POST",
		headers: {
			"${_csrf.headerName}" : "${_csrf.token}"
		},
		data: {
			advertisementNo
		},
		success(response) {
			location.href = adLink;
		},
		error: console.log
	});
};
</script>
<%-- EJ end --%>