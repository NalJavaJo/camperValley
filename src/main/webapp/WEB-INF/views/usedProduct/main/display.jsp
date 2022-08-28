<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/main.css"/>

<hr />
<!-- 광고 -->
<c:if test="${not empty adList}">
<div class="adPlace">
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
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
</c:if>

<div id="displayHeader">
	<p class="displayName" style="margin-left: 7px;">전체 상품 목록</p>
</div>

<div id="display-list" class="row" style="width: 1200px;">
	<c:forEach items="${list}" var="list" varStatus="vs">
		<div class="item col-3" onclick="productDetailNo(${item.productNo})">
			<div class="item">
				<div id="itemSolid">
					<img src="${list.productImg1}" class="rounded float-start" alt="상품이미지">
					<h5 id="displayTitle">${list.productTitle}</h5>
					<div class="price-time">
						<p class="displayPrice">${list.productPrice}원</p>
						<h5 class="displayTime">${list.productEnrollTime}</h5>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>	
</div>
<div id="moreShow">
	<a id="more" class="more" onclick="viewMore()">더 보기<br><i class="fa-solid fa-caret-down"></i></a>
</div>
<script>
// 광고
// 전체 상품 목록 출력 및 페이징
//ajax 통신을 위한 csrf 설정
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});
var page = 1;
let adCount = 0;
let totalItemCount = 0;
$(document).ready(function() {
	getProductList(page);
});
function viewMore() {
	page = page + 1;
	getProductList(page);
}
function getProductList(page) {
	$.ajax({
		type : 'post',
		url : '${pageContext.request.contextPath}/usedProduct/main/getProductList',
		dataType : 'json',
		data : {
			page : page,
			adCount
		},
		success : function(data) {
			
			if(data.list.length == 0) {
				$('#more').hide();
			} else {
				let adCountInPage = 0;
				for(let i = 0; i < 10; i++) {
					const item = data.list[i - adCountInPage];
					
					var html = "";
					const now = new Date().getTime();
					var time = Date.parse(item.productEnrollTime);
					time = Math.round((now - time) / 1000 / 60);
					var time_before = "분 전";
					
					if(time > (60 * 24)) {
						time = Math.round(time / (60 * 24));
						time_before = '일 전';
					} else if (time > 60) {
						time = Math.round(time / 60);
						time_before = "시간 전";
					}
					
					if((totalItemCount + 1) % 6 != 0 || data.feedAdList[adCount] == null) {
						html = '<div class="item col-3"' + 'onclick="productDetailNo('
							+ item.productNo + ');"'
							   + 'style="cursor: pointer;">'
							   + '<div class ="item">' + '<div id="itemSolid">'
							   + '<div class="img-box">'
							   + '<img src="${pageContext.request.contextPath}/resources/upload/usedProduct/' + item.productImg1
							   + '" class="rounded float-start" alt="'
							   + item.productTitle + '">' + '</div>'
							   + '<div class="text-box">'
							   + '<div class="displayName">'
							   + item.productTitle + '</div>'
							   + '<div class="price-time">'
							   + '<div class="displayPrice">' + Number(item.productPrice).toLocaleString("ko-KR")
							   + '</div>' + '<div class="displayTime"><span>'
							   + time + time_before + '<span></div>' + '</div>'
							   + '</div>' + '</div>' + '</div>' + '</div>';
					}
					
					// 피드 광고출력
					if((totalItemCount + 1) % 6 == 0 && data.feedAdList[adCount] != null) {
						adCountInPage++;
						const advertisementNo = data.feedAdList[adCount].advertisementNo;
						const adLink = data.feedAdList[adCount].adLink;
						const filename = data.feedAdList[adCount++].adAttach.renamedFilename;
						
						html = '<div class="item col-3" style="cursor: pointer;">'
								+ '<div class ="item">'
								+ '<div id="itemSolid">'
								+ '<div class="img-box" onclick="clickUpAndMove(' + advertisementNo + ', \'' + adLink + '\');">'
								+ '	<img src="${pageContext.request.contextPath}/resources/upload/mypage/advertiser/advertisement/' + filename
								+ 	'" class="rounded float-start" alt="광고이미지">'
								+ '</div>'
								+ '<div class="text-box">'
								+ '<div class="displayName"></div>'
								+ '<div class="price-time">'
								+ '	<div class="displayPrice"></div>'
								+ '	<div class="displayTime"></div>'
								+ '</div>'
								+ '</div></div></div>'
						viewUpAd(advertisementNo);
					}
					
					$('#display-list').append(html);
					totalItemCount++;
				};
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
}
function productDetailNo(no) {
	location.href = '/campervalley/usedProduct/product/productDetail?no=' + no;
}
</script>
<%-- EJ start --%>
<script>
window.addEventListener('load', (e) => {
	// 첫번째 배너 광고 조회수 증가처리
	viewUpFirstAd();
});
const viewUpFirstAd = () => {
	const active = document.querySelector(".carousel-inner .active");
	if(active == null)
		return;
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