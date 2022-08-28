<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/advertiser.css" />

<div class="container">
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp"/>
		</div>
		<div class="col-lg-10 px-5">
			<h2>광고주 등록하기</h2>
			<form:form
				name="enrollAdvertiserFrm"
				action="${pageContext.request.contextPath}/mypage/advertiser/register"
				method="POST"
				enctype="multipart/form-data"
				style="width:800px;">
				<input type="hidden" name="memberId" value=<sec:authentication property="principal.username"/> required>
				<div class="divInputWrapper">
					<label for="bizName">광고계정 이름</label>
					<input type="text" name="bizName" id="bizName" class="form-control form-control-sm" placeholder="광고계정명을 입력해주세요.">
					<small id="bizNameMsg" class="resultMsg hide"></small>
				</div>
				<div class="divInputWrapper">
					<label for="bizLicenseNo">사업자등록번호</label>
					<input type="hidden" name="bizNoResult" id="bizNoResult" value="false"/>
					<div class="input-group">
						<input type="text" name="bizLicenseNo" id="bizLicenseNo" class="form-control form-control-sm" placeholder="사업자등록번호를 입력해주세요." aria-describedby="ckBizNoBtn">
						<div class="input-group-append">
							<button class="btn btn-outline-camper-color btn-sm" type="button" id="ckBizNoBtn">확인</button>
						</div>
					</div>
					<small id="bizNoMsg" class="resultMsg hide"></small>
				</div>
				<div class="divInputWrapper">
					<label for="">사업자등록증</label>
					<input type="file" class="custom-file-input hide" name="adImg" id="upFile" accept="image/*, .pdf">
					<div class="divImgWrapper d-flex align-items-center justify-content-center" id="upFileWrapper">
						<button type="button" class="invisibleBtn" id="upFileBtn">
							<i class="fa-solid fa-circle-plus fa-2x midgreen"></i>
						</button>
					</div>
					<div class="divImgWrapper hide" id="previewWrapper">
						<img class="img-fluid rounded" id="preview" src="" alt="">
					</div>
					<small id="bizImgMsg" class="resultMsg hide"></small>
				</div>
				<div class="divInputWrapper">
					<div name="divNotice" class="p-3">
						사업자등록증 내에 기재된 생년월일, 자택주소, 휴대폰번호 등 사업주의 개인정보는 광고주님의 개인 정보 보호를 위해 삭제하여 주시기바랍니다.
						광고주 관련 기능은 관리자의 승인 후 이용하실 수 있습니다. 광고주 승인은 영업일 기준 최대 10일이 소요됩니다.
						광고관리 페이지에서 등록하신 광고는 충전된 애드머니 잔액과 해당 광고소재의 일예산, 클릭당 비용을 기준으로 노출됩니다.
					</div>
				</div>
				<div class="divInputWrapper">
					<button type="submit" class="btn btn-camper-color btn-block">광고주승인 요청하기</button>
				</div>
			</form:form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<spring:eval var="ckBusinessNo" expression="@customProperties['api.ckBusinessNo']" />
<script src="${pageContext.request.contextPath}/resources/js/mypage/advertiser/validation.js"></script>
<script>
// 사업자등록번호 검증
const checkBizNo = () => {
	const inputData = document.querySelector("#bizLicenseNo").value;
	const result = document.querySelector("#bizNoResult");
	const msg = document.querySelector("#bizNoMsg");
	
	// 테스트(배민사업자번호) : 1208765763
	// 테스트(오늘의집사업자번호) : 1198691245
	var data = {
		"b_no" : [ inputData ]
	};

	$.ajax({
		url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=${ckBusinessNo}",
		type: "POST",
		data: JSON.stringify(data),
		dataType: "JSON",
		contentType: "application/json",
		accept: "application/json",
		success(response) {
			console.log(response);
			if(response.match_cnt) {
				result.value = "true";
				msg.innerHTML = "사업자등록번호 검증에 성공하였습니다.";
				msg.classList.add('SuccessMsg');
				msg.classList.remove('failMsg');
			} else {
				result.value = "false";
				msg.innerHTML = "사업자등록번호 검증에 실패하였습니다.";
				msg.classList.add('failMsg');
				msg.classList.remove('SuccessMsg');
			}
			msg.classList.remove('hide');
		},
		error: console.log
	});
};

// 사업자등록번호 검증 상태 변경
document.querySelector("#bizLicenseNo").addEventListener('change', (e) => {
	document.querySelector("#bizNoResult").value = "false";
});
// 사업자등록번호 검증 호출
document.querySelector("#ckBizNoBtn").addEventListener('click', (e) => {
	checkBizNo();
});

// 파일 업로드 & 업로드 파일 취소
document.querySelector("#upFileBtn").addEventListener('click', (e) => {
	document.querySelector("#upFile").click();
});
document.querySelector("#preview").addEventListener('click', (e) => {
	document.querySelector("#upFile").click();
});

document.querySelector("#upFile").addEventListener('change', (e) => {
	const input = e.target;
	const upFileWrapper = document.getElementById('upFileWrapper');
	const previewWrapper = document.getElementById('previewWrapper');
	
	if (input.files && input.files[0]) {
		const reader = new FileReader();
		reader.onload = function(e) {
			document.getElementById('preview').src = e.target.result;
		};
		reader.readAsDataURL(input.files[0]);
		
		previewWrapper.classList.remove('hide');
		previewWrapper.classList.add('d-flex');
		previewWrapper.classList.add('align-items-center');
		previewWrapper.classList.add('ustify-content-center');
		
		upFileWrapper.classList.add('hide');
		upFileWrapper.classList.remove('d-flex');
		upFileWrapper.classList.remove('align-items-center');
		upFileWrapper.classList.remove('ustify-content-center');
		
	} else {
		document.getElementById('preview').src = "";
		
		previewWrapper.classList.add('hide');
		previewWrapper.classList.remove('d-flex');
		previewWrapper.classList.remove('align-items-center');
		previewWrapper.classList.remove('ustify-content-center');
		
		upFileWrapper.classList.remove('hide');
		upFileWrapper.classList.add('d-flex');
		upFileWrapper.classList.add('align-items-center');
		upFileWrapper.classList.remove('ustify-content-center');
	}
});
</script>