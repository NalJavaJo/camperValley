<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/advertiser.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5">
			<h2>광고주 해제하기</h2>
			<form:form name="exitAdvertiserFrm" action="${pageContext.request.contextPath}/mypage/advertiser/exit" method="post" style="width: 800px;">
				<input type="hidden" name="advertiserNo" value="${advertiser.advertiserNo}"/>
				<input type="hidden" name="memberId" value="${advertiser.memberId}"/>
				<div class="divInputWrapper">
					<label for="bizName">광고계정 이름</label>
					<input type="text" name="bizName" id="bizName" class="form-control form-control-sm" value="${advertiser.bizName}" readonly>
				</div>
				<div class="divInputWrapper">
					<label for="bizLicenseNo">사업자등록번호</label>
					<input type="text" name="bizLicenseNo" id="bizLicenseNo" class="form-control form-control-sm"
						placeholder="광고주님의 사업자등록번호를 입력해주세요.">
					<small class="hide" id="bizLicenseNoMsg"></small>
					<input type="hidden" name="checkBizLicenseNo" id="checkBizLicenseNo" value="false"/>
				</div>
				<div class="divInputWrapper">
					<label for="admoney">잔여애드머니</label>
					<input type="text" name="admoney" id="admoney" class="form-control form-control-sm" value="${advertiser.admoney.balance}" readonly>
				</div>
				<div class="divInputWrapper">
					<label>광고주 해제 규정</label>
					<div name="divNotice" class="p-3">광고주해제 시 잔여 애드머니는 자동으로 환불되지 않습니다. 이점 유의하시어 잔여 애드머니를 환불하신 뒤에 광고주 해제하시길 바랍니다.</div>
					<div class="form-group form-check text-right mt-1">
						<input type="checkbox" name="agreement" id="agreement" />
						<label for="agreement" class="form-check-label">광고주 해제 규정을 확인하였습니다.</label>
					</div>
				</div>
				<div class="divInputWrapper">
					<button type="submit" class="btn btn-camper-red btn-block">광고주 해제하기</button>
				</div>

			</form:form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
document.exitAdvertiserFrm.onsubmit = (e) => {
	let result = true;
	const frm = e.target;
	if(frm.checkBizLicenseNo.value == "false")
		result = false;

	if(!frm.agreement.checked)
		result = false;
	
	return result;
};

document.querySelector('#bizLicenseNo').addEventListener('input', (e) => {
	const inputVal = e.target.value
	const realBizLicenseNo = "${advertiser.bizLicenseNo}";
	const msgSmall = document.querySelector('#bizLicenseNoMsg');
	const result = document.querySelector('#checkBizLicenseNo');
	
	if(inputVal != realBizLicenseNo){
		// 불일치
	    msgSmall.innerHTML = "사업자등록번호가 일치하지 않습니다.";
	    msgSmall.classList.add('failMsg');
	    msgSmall.classList.remove('SuccessMsg');
	    msgSmall.classList.remove('hide');
	    result.value = false;
	}
	else {
		// 일치
		msgSmall.innerHTML = "사업자등록번호가 일치합니다.";
	    msgSmall.classList.add('SuccessMsg');
	    msgSmall.classList.remove('failMsg');
	    msgSmall.classList.remove('hide');
	    result.value = true;
	}
});
</script>