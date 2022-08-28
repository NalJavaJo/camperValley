<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/advertiser.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5">
			<div class="adDetailWrapper mx-auto">
				<h2>광고소재 등록하기</h2>
				<form:form 
					name="enrollAdFrm"
					action="${pageContext.request.contextPath}/mypage/advertiser/enrollAd" 
					method="POST"
					enctype="multipart/form-data">
					<input type="hidden" name="advertiserNo" value="${param.no}"/>
					<div class="divInputWrapper">
						<label for="adName">광고소재명</label>
						<input type="text" name="adName" id="adName" class="form-control form-control-sm"
							placeholder="광고소재의 이름을 작성해주세요.">
						<small class="resultMsg hide" id="adNameMsg"></small>
					</div>
					<div class="divInputWrapper">
						<label for="">노출위치 선택</label>
						<small class="resultMsg hide" id="adZoneMsg"></small>
						<div class="row divAdZoneOptions">
							<div class="col-4 optionWrapper">
								<div class="imgWrapper" id="imgWrapper1">
									<img src="${pageContext.request.contextPath}/resources/images/mypage/advertiser/enrollAd_example_mainhome.png" alt="메인 홈 슬라이드 배너 영역" />
								</div>
								<input type="checkbox" name="adZone" id="adZone1" value="mainHome" class="hide"/>
								<p class="my-1">메인 홈 슬라이드 배너</p>
								<span>캠퍼밸리 메인 홈에 노출되는 슬라이드배너 영역광고입니다. 광고이미지 규격은 1200px*300px 입니다.</span>
							</div>
							<div class="col-4 optionWrapper">
								<div class="imgWrapper" id="imgWrapper2">
									<img src="${pageContext.request.contextPath}/resources/images/mypage/advertiser/enrollAd_example_usedProductHome.png" alt="중고거래 홈 슬라이드 배너 영역" />
								</div>								
								<input type="checkbox" name="adZone" id="adZone2" value="usedProductHome" class="hide"/>
								<p class="my-1">중고거래 홈</p>
								<span>캠퍼밸리 캠핑용품거래 게시판의 슬라이드배너에 노출됩니다. 광고이미지 규격은 1170px*310px 입니다.</span>
							</div>
							<div class="col-4 optionWrapper">
								<div class="imgWrapper" id="imgWrapper3">
									<img src="${pageContext.request.contextPath}/resources/images/mypage/advertiser/enrollAd_example_usedProductFeed.png" alt="중고거래 게시글 피드 영역" />
								</div>								
								<input type="checkbox" name="adZone" id="adZone3" value="usedProductFeed" class="hide"/>
								<p class="my-1">중고거래 피드</p>
								<span>캠퍼밸리 캠핑용품거래 게시판의 중고거래 게시글 사이에 노출됩니다. 광고이미지 규격은 223px*215px 입니다.</span>
							</div>
						</div>
					</div>
					<div class="divInputWrapper">
						<label for="adLink">링크</label>
						<input type="text" name="adLink" id="adLink" class="form-control form-control-sm"
							placeholder="광고 클릭 시 이동할 주소를 입력해주세요.">
						<small class="resultMsg hide" id="adLinkMsg"></small>
					</div>
					<div class="divInputWrapper">
						<label for="adImg">이미지</label>
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="adImg" id="validatedCustomFile" accept="image/*">
							<label class="custom-file-label" id="upFileLabel" for="validatedCustomFile">이미지를 선택해주세요.</label>
						</div>
						<small class="resultMsg hide" id="adImgMsg"></small>
					</div>
					<div class="divInputWrapper">
						<label for="adDailyBudget">일일예산 설정</label>
						<div class="form-row">
							<div class="col-5">
								<input type="number" name="adDailyBudget" id="adDailyBudget" class="form-control form-control-sm" />
							</div>
							<div class="col align-items-bottom">
								<span>원</span>
							</div>
						</div>
						<small class="resultMsg hide" id="adDailyBudgetMsg"></small>
					</div>
					<div class="divInputWrapper">
						<label for="adCpc">클릭당 단가(CPC) 설정</label>
						<div class="form-row">
							<div class="col-5">
								<input type="number" name="adCpc" id="adCpc" class="form-control form-control-sm" />
							</div>
							<div class="col align-items-bottom">
								<span>원</span>
							</div>
						</div>
						<small class="resultMsg hide" id="adCpcMsg"></small>
					</div>
					<div class="divInputWrapper adPolicy">
						<div class="d-flex justify-content-between align-items-center px-3" id="adPolicyHead">
							<span>광고 노출 정책 안내</span>
							<i class="fa-solid fa-angle-down" id="adPolicyLoad"></i>
						</div>
						<div class="p-3" id="adPolicyBody">
							광고소재 등록 후 광고소재 이미지와 노출 위치는 변경할 수 없습니다.
							광고비는 충전한 애드머니에서 지정한 CPC(클릭당 비용)만큼 차감됩니다. 잔여 애드머니가 CPC보다 적은경우 해당 광고소재의 상태가 OFF로 변경됩니다.
							또한 설정한 일일예산을 모두 소진한 경우에도 광고소재가 자동으로 OFF처리됩니다.
							등록된 광고는 ON상태일 때 클릭당비용이 높은 광고가 우선 노출되며, 같은 클릭당 비용으로 설정된 광고소재간의 노출은 무작위로 결정됩니다.
						</div>
					</div>
					<div class="divInputWrapper row justify-content-md-center">
						<div class="col-3">
							<button type="submit" class="btn btn-camper-color btn-block">광고등록</button>
						</div>
						<div class="col-3">
							<button type="button" class="btn btn-secondary btn-block" onclick="history.go(-1);">뒤로</button>
						</div>
					</div>	
				</form:form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/resources/js/mypage/advertiser/validation.js"></script>
<script>
window.addEventListener('load', () => {
	upFile();
});

const upFile = () => {
	const fileInput = document.querySelector("#validatedCustomFile");
	fileInput.addEventListener('change', (e) => {
		const fileNameTag = document.querySelector("#upFileLabel");
		fileNameTag.innerHTML = e.target.files[0].name;
	});
};

$("#adPolicyLoad").click((e) => {
	const icon = $(e.target);
	if(icon.hasClass("fa-angle-down")){
		icon.removeClass("fa-angle-down").addClass("fa-angle-up");
		$("#adPolicyBody").slideDown(400);		
	} else {
		icon.removeClass("fa-angle-up").addClass("fa-angle-down");
		$("#adPolicyBody").slideUp(400);		
	}
});

// 노출위치에 맞는 input:ckeckbox 상태 지정
const zoneCheck = (imgDiv) => {
	document.querySelectorAll(".divAdZoneOptions input[type=checkbox]").forEach((checkbox) => {
		checkbox.checked = false;
	});
	imgDiv.nextElementSibling.checked = true;
};

// 노출위치 선택 css 부여
document.querySelectorAll(".divAdZoneOptions > div").forEach((adZone) => {
	adZone.addEventListener('click', (e) => {
		const target = e.target;
		zoneEvent(target);
	});
});
document.querySelectorAll(".divAdZoneOptions img").forEach((adZone) => {
	adZone.addEventListener('click', (e) => {
		e.stopPropagation();
		const target = e.target.parentElement;
		zoneEvent(target);
	});
});

const zoneEvent = (target) => {
	document.querySelectorAll(".optionWrapper > div:first-child").forEach((img) => {
		img.classList.remove('selectedImgWapper');
	});
	
	let imgDiv;
	if(target.classList.contains('optionWrapper')){
		imgDiv = target.firstElementChild;
	} else {
		imgDiv = target.parentElement.firstElementChild;
	}
	
	zoneCheck(imgDiv);
	if(!imgDiv.classList.contains('selectedImgWapper')){
		imgDiv.classList.add('selectedImgWapper');
	} else {
		imgDiv.classList.remove('selectedImgWapper');
	}
};
</script>