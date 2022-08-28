<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>profile check</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<!-- alert js -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
	<!-- 사용자작성 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tradereview/profileCheck.css" />
	<!-- font awesome -->
	<spring:eval var="fontawesomeKey" expression="@customProperties['api.fontawesome']" />
	<script src="https://kit.fontawesome.com/${fontawesomeKey}.js" crossorigin="anonymous"></script>
</head>
<body>
	<div class="modal fade" id="profileCheck">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content px-5 py-2">
				<div class="modal-header px-2 py-3">
					<div>
						<c:if test="${not empty member.profileImg}">
							<div><img id="profileImg" src="${pageContext.request.contextPath}/resources/upload/member/${member.profileImg}" alt="" /></div>
						</c:if>
						<c:if test="${empty member.profileImg}">
							<div><i class="fa-solid fa-circle-user fa-6x" style="color: #639A67;"></i></div>
						</c:if>
					</div>
					<div class="ml-5">
						<div class="text-15"><span class="camper-color">[${member.nickname}]</span>님</div>
						<div>
							<span class="text-13">판매상품 : ${counts.productCount}개, </span>
							<span class="text-13">거래리뷰 : ${counts.reviewCount}개</span>
						</div>
						<div class="mt-4">
							<span><i class="fa-solid fa-star"></i></span>
							<span>&nbsp;${not empty counts.starScoreAvg ? counts.starScoreAvg : "0"}점</span>
						</div>
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body px-0 my-3">
					<div class="col-md-7 mb-4">
						<ul class="nav profile-nav">
						  	<li id="productList" class="nav-item mr-3 active">판매상품</li>
						  	<li id="reviewList" class="nav-item">거래리뷰</li>
						</ul>
					</div>
					<div class="d-flex flex-column justify-content-between" style="height: 680px;">
						<div id="listSection"></div>
						<div id="pagebarSection"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%-- report enroll modal --%>
	<jsp:include page="/WEB-INF/views/tradereview/reportEnroll.jsp"/>
<script>
$(document).ready(() =>{
	renderProductList(1);
	
});

$(".profile-nav li").click((e) => {
	$(".profile-nav li").removeClass("active");
	$(e.target).addClass("active");
});

const sellerId = "${member.sellerId}";
// 판매자 정보 판매상품 목록 조회 비동기
const renderProductList = (cPage) => {
	$("#listSection").html("");
	$("#pagebarSection").html("");
	$.ajax({
		url: "${pageContext.request.contextPath}/usedProduct/productList",
		data: {sellerId, cPage},
		dataType: "json",
		success(response) {
			const {productList, pagebar} = response;
			console.log(productList);
			for(let i = 0; i < productList.length; i++) {
				const $productBox = $(`<div class="productBox d-flex ml-3 mb-4" onclick='location.href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=\${productList[i].productNo}"'></div>`);
				const $productImgBox = $('<div class="image col-md-3 px-0"></div>');
				const $productImg = $(`<img src="${pageContext.request.contextPath}/resources/upload/usedProduct/\${productList[i].productImg1}" />`);
				const $productInfoBox = $('<div class="info col-md-9 px-0"></div>');
				const $titleCreatedAt = $('<div class="d-flex justify-content-between"></div>');
				const $title = $(`<div class="title text-15 font-weight-bold">\${productList[i].productTitle}</div>`);
				const createdAt = productList[i].productEnrollTime;
				const $createdAt = $(`<div class="createdAt text-13 text-secondary">\${createdAt.substr(0,4)}.\${createdAt.substr(5,2)}.\${createdAt.substr(8,2)}</div>`);
				const $priceStatus = $('<div class="d-flex justify-content-between"></div>');
				
				const $price = $(`<div class="price my-2 font-weight-bold">\${	parseInt(productList[i].productPrice).toLocaleString()}원</div>`);
				let $status;
				if(productList[i].buyerId == '') $status = $('<div class="text-13 camper-color">판매중</div>');
				else $status = $('<div class="text-13 text-danger">판매완료</div>');
				const $content = $('<div class="content text-13"></div>');
				const content = productList[i].productContent;
				if(content.length <= 50) $content.html(content);
				else $content.html(content.substr(0, 50) + '...');
				$productImgBox.append($productImg);
				$titleCreatedAt.append($title, $createdAt);
				$priceStatus.append($price, $status);
				$productInfoBox.append($titleCreatedAt, $priceStatus, $content);
				$productBox.append($productImgBox, $productInfoBox);
				$("#listSection").append($productBox);
			}
			$("#pagebarSection").append(pagebar);
			$(".pagination a").on("click", () =>{
				return false;
			});
		},
		error: console.log
	});
}

// 판매자 정보 거래후기 목록 조회 비동기
const renderReviewList = (cPage) => {
	$("#listSection").html("");
	$("#pagebarSection").html("");
	$.ajax({
		url: "${pageContext.request.contextPath}/tradereview/reviewList",
		data: {sellerId, cPage},
		dataType: "json",
		success(response) {
			const {reviewList, pagebar} = response;
			console.log(reviewList);
			for(let i = 0; i < reviewList.length; i++) {
				const $reviewBox = $('<div class="reviewBox d-flex ml-3"></div>');
				const $userImage = $('<div class="image col-md-2 px-0"></div>');
				const $userEnrollImg = $(`<img class="profileImg" src="${pageContext.request.contextPath}/resources/upload/member/\${reviewList[i].profileImg}"/>`)
				const $userIcon = $('<i class="fa-solid fa-circle-user fa-5x" style="color:rgb(235,235,235);"></i>');
				const $reviewInfo = $('<div class="info col-md-10 pl-0 pr-4 ml-4">');
				const $infoDiv1 = $('<div class="d-flex justify-content-between">');
				const $starNickname = $('<div></div>');
				const $star = $('<span></span>');
				for(let j = 0; j < 5; j++) {
					if(j <= reviewList[i].starScore - 1)
						$star.append('<i class="fa-solid fa-star fa-xs" style="color: rgb(230, 185, 20)">');
					else
						$star.append('<i class="fa-solid fa-star fa-xs" style="color: rgb(235, 235, 235)">')
				}
				$star.append(`<span class="px-2 text-13">\${reviewList[i].starScore}점</span>`);
				const $nickname = $(`<span class="ml-2 text-14">\${reviewList[i].nickname}</span>`);
				// 분기처리 loginMember.memberId와 memberId비교
				if(${not empty loginMember}) {
					if("${loginMember.memberId}" === sellerId) {
						if(reviewList[i].reportNo == null || reviewList[i].reportNo == "") {
							const $report = $('<div class="report text-13 text-secondary mt-1" style="cursor:pointer"></div>');
							const $reportIcon = $('<i class="fa-regular fa-lightbulb fa-sm position-relative"></i>');
							const $reportBtn = $('<span>신고하기</span>');
							
							$report.append($reportIcon, $reportBtn);
							// 신고하기 클릭 시 모달창
							$report.on('click', (re) => {
								$("#reportEnroll").modal().on('hide.bs.modal', () => {
									$("#profileCheck").show();
								});
								$("#profileCheck").hide();
								$("#reportEnroll #reviewNo").val(`\${reviewList[i].reviewNo}`)
								$("#reportEnroll #productNo").val(`\${productNo}`);
							});
							$infoDiv1.append($report);
						} 
					}
				}
				if(reviewList[i].reportNo != null && reviewList[i].reportNo != "") {
					const $report = $('<div class="report text-13 text-secondary mt-1"></div>');
					const $reportAlready = $('<span class="text-danger">판매자에 의해 신고된 리뷰입니다.</span>');
					$report.append($reportAlready);
					$infoDiv1.append($report);
				}
				const $content = $(`<div class="content text-13">\${reviewList[i].content}</div>`);
				const $createdAt = $(`<div class="text-right text-secondary text-13"/*  style="line-height: 100px;" */>\${reviewList[i].createdAt.year}.\${reviewList[i].createdAt.monthValue}.\${reviewList[i].createdAt.dayOfMonth}</div>`);
				const $infoDiv2 = $('<div class="d-flex justify-content-between"></div>');
				$starNickname.append($star, $nickname);
				$infoDiv1.prepend($starNickname);
				$infoDiv2.append($content, $createdAt);
				$reviewInfo.append($infoDiv1, $infoDiv2);
				if(reviewList[i].profileImg) $userImage.append($userEnrollImg);
				else $userImage.append($userIcon);
				$reviewBox.append($userImage, $reviewInfo);
				$("#listSection").append($reviewBox);
			}
			$("#pagebarSection").append(pagebar);
			$(".pagination a").on("click", () =>{
				return false;
			});
		},
		error: console.log
	});
}

// pagebar 비동기 요청
document.querySelector("#reviewList").addEventListener("click", (e) => {
	renderReviewList(1);
});
document.querySelector("#productList").addEventListener("click", (e) => {
	renderProductList(1);
});
</script>
</html>