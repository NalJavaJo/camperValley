
// 유효성검사 실패 메세지 출력
const printErrSmall = (target, msg) => {
    const msgSmall = document.querySelector(target);
    msgSmall.innerHTML = msg;
    msgSmall.classList.add('failMsg');
    msgSmall.classList.remove('SuccessMsg');
    msgSmall.classList.remove('hide');
};

// 유효성검사결과 메세지 초기화
const resetMsg = (target) => {
	const msgSmall = document.querySelector(target);
	msgSmall.innerHTML = "";
};

// 광고주 등록 신청 유효성검사
if(document.enrollAdvertiserFrm != null){
	document.enrollAdvertiserFrm.onsubmit = () => {
		let result = true;
		
		if(!/^[a-zA-Z가-힣0-9]{3,20}$/.test(bizName.value)) {
			printErrSmall("#bizNameMsg", "광고계정명은 3자 이상 20자 이내의 영문/한글/숫자로 구성되어야합니다.");
			result = false;
		} else resetMsg("#bizNameMsg");
		
		if(bizNoResult.value != "true") {
			printErrSmall("#bizNoMsg", "사업자등록번호 확인이 필요합니다.");
			result = false;
		}
		
		if(upFile.files.length == 0) {
			printErrSmall("#bizImgMsg", "사업자등록증 파일을 추가해주세요.");
			result = false;
		} else resetMsg("#bizImgMsg");
		
		return result;
	};
}

// 관리자페이지 광고주 검색 유효성검사
if(document.searchAdvertiserFrm != null) {
	document.searchAdvertiserFrm.onsubmit = (e) => {
		let result = true;
		if(!/^[0-9]{0,10}$/.test(searchBizLicenseNo.value)) {
			searchBizLicenseNo.classList.add('is-invalid');
			result = false;
		} else {
			searchBizLicenseNo.classList.remove('is-invalid');
		}
		return result;
	};
};

// 광고등록 유효성검사
if(document.enrollAdFrm != null) {
	document.enrollAdFrm.onsubmit = (e) => {
		let result = true;
		
		if(!/^[^\<\>\/]{5,100}$/.test(adName.value)) {
			printErrSmall("#adNameMsg", "일부 특수문자(<,>,/)를 제외하여 5자 이상 100자 이내로 입력해주세요.");
			result = false;
		} else resetMsg("#adNameMsg");
		
		const checkedbox = document.querySelectorAll(".divAdZoneOptions input[type=checkbox]:checked");
		if(checkedbox.length == 0) {
			printErrSmall("#adZoneMsg", "광고노출 위치를 선택해주세요.");
			document.querySelector("#adZoneMsg").style.marginLeft = 0;
			result = false;
		} else resetMsg("#adZoneMsg");
		
		if(!/^(https?):\/\/([a-z0-9-]+\.)+[a-z0-9]{2,4}.*$/.test(adLink.value)) {
			printErrSmall("#adLinkMsg", "http:// 혹은 https://로 시작하는 적절한 이동링크를 입력해주세요.");
			result = false;
		} else resetMsg("#adLinkMsg");
		
		if(validatedCustomFile.files.length == 0) {
			printErrSmall("#adImgMsg", "광고소재 이미지를 등록해주세요.");
			result = false;
		} else resetMsg("#adImgMsg");
		
		if(adDailyBudget.value == '') {
			printErrSmall("#adDailyBudgetMsg", "일일예산을 설정해주세요.");
			result = false;
		} else resetMsg("#adDailyBudgetMsg");

		if(adCpc.value == '') {
			printErrSmall("#adCpcMsg", "클릭당 단가를 설정해주세요.");
			result = false;
		} else resetMsg("#adCpcMsg");
		
		return result;
	};
};