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

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/datepicker.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/jquery-ui.css" />
<!-- jquery-confirm -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="container">
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10">
			<div class="d-flex justify-content-between" id="dashboardTop">
				<div class="align-self-center">
					<form name="chartPeriodFrm" class="m-0" onsubmit="return false;">
						<div class="form-row align-items-center">
							<label for="" class="mb-0">조회기간</label>
							<div class="form-group mb-0">
								<input type="text" class="form-control form-control-sm input-daterange" name="chartStart" autocomplete="off" readonly />
							</div>
							<div>
								<span>~</span>
							</div>
							<div class="form-group mb-0">
								<input type="text" class="form-control form-control-sm input-daterange" name="chartEnd" autocomplete="off" readonly />
							</div>
							<div>
								<button id="rangeSubmitBtn" class="btn btn-camper-color btn-sm">조회</button>
							</div>
						</div>
					</form>
				</div>
				<div class="divAdMoney align-self-center d-flex">
					<h5 class="d-inline d-flex align-items-center">
						<c:if test="${isPauseAdvertiser eq true}">
							<span class="badge badge-pill badge-warning mx-2 pusedStatusBadge">권한정지</span>
						</c:if>
						<span class="advertiserName">${advertiser.bizName}</span>의&nbsp;
						<a id="adMoneyCharge" href="${pageContext.request.contextPath}/mypage/advertiser/admoney?no=${advertiser.advertiserNo}">애드머니</a>
					</h5>
					<h5 class="d-inline" id="admoneyAmount" data-balance="${advertiser.admoney.balance}">
						<fmt:formatNumber value="${advertiser.admoney.balance}" pattern="#,###" /><small class="ml-1">원</small>
					</h5>
				</div>
			</div>
			<div class="my-3 py-2" id="chartSection">
				<canvas id="lineChart"></canvas>
			</div>
			<button type="button" class="btn btn-camper-color btn-sm"
				onclick="location.href='${pageContext.request.contextPath}/mypage/advertiser/enrollAd?no=${advertiser.advertiserNo}'"
				${isPauseAdvertiser eq true ? 'disabled' : ''}>광고만들기</button>
			<table id="tblAdList" class="table my-3">
				<thead class="adListHead">
					<tr class="text-center">
						<td>삭제</td>
						<td>On/Off</td>
						<td class="tdAdName">광고소재명</td>
						<td class="tdAdZone">노출위치</td>
						<td>클릭수</td>
						<td>노출수</td>
						<td>클릭률</td>
						<td>클릭당 단가</td>
						<td>일예산</td>
						<td>수정</td>
					</tr>
				</thead>
				<tbody class="adListBody">
					<c:if test="${empty adList}">
						<tr class="text-center"><td class="py-2" colspan="10">등록된 광고소재가 없습니다.</td></tr>
					</c:if>
					<c:if test="${not empty adList}">
						<c:forEach items="${adList}" var="advertisement" varStatus="vs">
							<tr data-advertisement-no="${advertisement.advertisementNo}" data-cpc="${advertisement.adCpc}"
								data-daily-budget="${advertisement.adDailyBudget}" id="tr${vs.count}">
								<td class="text-center">
									<button class="btn btn-camper-red btn-sm delAdBtn" ${isPauseAdvertiser eq true ? 'disabled' : ''}>삭제</button>
								</td>
								<td>
									<div class="custom-control custom-switch text-center">
										<input type="checkbox" class="custom-control-input" name="adStatus" id="customSwitch${vs.count}"
											${advertisement.adStatus eq true ? 'checked' : ''}>
										<label class="custom-control-label" for="customSwitch${vs.count}"></label>
									</div>
								</td>
								<td>
									<input type="text" class="form-control-plaintext"
										name="adName" value="${advertisement.adName}" disabled/>
								</td>
								<td>
									<c:if test="${advertisement.adZone eq 'mainHome'}">
										<c:set var="adZone" value="메인 홈"/>
									</c:if>
									<c:if test="${advertisement.adZone eq 'usedProductHome'}">
										<c:set var="adZone" value="중고거래 홈"/>
									</c:if>
									<c:if test="${advertisement.adZone eq 'usedProductFeed'}">
										<c:set var="adZone" value="중고거래 피드"/>
									</c:if>
									<input type="text" class="form-control-plaintext" name="adZone"
										value="${adZone}" disabled/>
								</td>
								<td class="text-center">${advertisement.adClickCnt}</td>
								<td class="text-center">${advertisement.adViewCnt}</td>
								<td class="text-center">
									<c:set var="clickCnt" value="${advertisement.adClickCnt}"/>
									<c:set var="viewCnt" value="${advertisement.adViewCnt}"/>
									<c:if test="${viewCnt ne 0}">
										<fmt:formatNumber value="${clickCnt / viewCnt * 100}" pattern="#.##"/>								
									</c:if>
									<c:if test="${viewCnt eq 0}">0</c:if>									
									<small>%</small>
								</td>
								<td class="text-center">
									<input type="number" class="form-control form-control-sm"
										name="adCpc" value="${advertisement.adCpc}" />
								</td>
								<td class="text-center">
									<input type="number" class="form-control form-control-sm"
										name="adDailyBudget" value="${advertisement.adDailyBudget}" />
								</td>
								<td class="text-center">
									<button class="btn btn-camper-color btn-sm updateAdBtn" ${isPauseAdvertiser eq true ? 'disabled' : ''}>적용</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			<c:if test="${not empty adList}">
				<div class="mt-5 pagebar">${pagebar}</div>
			</c:if>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
window.addEventListener('load', (e) => {
	$('.input-daterange').datepicker({
		dateFormat: 'yy-mm-dd',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    yearSuffix: '년',
		todayHighlight: true,
		showMonthAfterYear: true,
		startDate: '0d',
		maxDate: 0
	});
	
	printlineChart(${dateList}, ${viewList}, ${clickList});
});

const headers = {
	"${_csrf.headerName}" : "${_csrf.token}"
};

document.querySelector('#rangeSubmitBtn').addEventListener('click', () => {
	const frm = document.chartPeriodFrm;
	const date1 = frm.chartStart.value;
	const date2 = frm.chartEnd.value;
	const advertiserNo = ${advertiser.advertiserNo};
	$.ajax({
		url: "${pageContext.request.contextPath}/mypage/advertiser/searchChart",
		type: "POST",
		headers,
		data: {
			advertiserNo,
			date1,
			date2
		},
		success(response) {
			const {dateList, viewList, clickList} = response;
			document.querySelector("#chartSection").innerHTML = `<canvas id="lineChart"></canvas>`;
			printlineChart(dateList, viewList, clickList);
		},
		error: console.log
	});
});

const printlineChart = (days, viewData, clickData) => {
	const context = document.querySelector('#lineChart').getContext("2d");
	const lineChart = new Chart(context, {
		type: 'line',
		data: { // 차트에 들어갈 데이터
			labels: days,
			datasets: [
				{
					label: '클릭수',
					lineTension: 0,
					backgroundColor: '#639A67',
					borderColor: '#639A67',
					data: clickData
				},
				{
					label: '조회수',
					lineTension: 0,
					backgroundColor: '#D9BF77',
					borderColor: '#D9BF77',
					data: viewData
				}
			]
		},
		options: {
			maintainAspectRatio: false,
			legend: { display: false }
		}
	});
};

document.querySelectorAll(".delAdBtn").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const advertisementNo = e.target.parentElement.parentElement.dataset.advertisementNo;
		console.log(advertisementNo);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/mypage/advertiser/deleteAd",
			type: "POST",
			headers,
			data: {
				advertisementNo
			},
			success(response) {
				const {msg} = response;
				$.confirm({
					title: '삭제완료',
					content: `\${msg}`,
					buttons: {
						OK: function () {
							location.reload();
						}
					}
				});
			},
			error: console.log
		});
	});
});

document.querySelectorAll("input[name='adStatus']").forEach((input) => {
	input.addEventListener('change', (e) => {
		const newStatus = e.target.checked;
		if(!newStatus) return;
		
		const tr = e.target.parentElement.parentElement.parentElement;
		const advertisementNo = tr.dataset.advertisementNo;
		const adCpc = document.querySelector(`#\${tr.id} input[name='adCpc']`).value;
		
		$.ajax({
			url: "${pageContext.request.contextPath}/mypage/advertiser/checkBalance",
			type: "POST",
			headers,
			data: {
				advertisementNo,
				adCpc
			},
			success(response) {
				const {result, msg} = response;
				if(!result) {
					$.confirm({
						title: '변경불가',
						content: `\${msg}`,
						buttons: {
							OK: function () {
								e.target.checked = false;
							}
						}
					});
				}
			},
			error: console.log
		});
	});
});

document.querySelectorAll("input[name='adCpc']").forEach((input) => {
	input.addEventListener('change', (e) => {
		const tr = e.target.parentElement.parentElement;
		const adDailyBudget = Number(document.querySelector(`#\${tr.id} input[name='adDailyBudget']`).value);
		const adCpc = Number(e.target.value);
		const advertisementNo = tr.dataset.advertisementNo;
		const originalCpc = tr.dataset.cpc;
		const adStatus = document.querySelector(`#\${tr.id} input[name='adStatus']`);
		const admoneyAmount = Number(document.querySelector("#admoneyAmount").dataset.balance);

		if(adCpc > admoneyAmount && adStatus.checked == true) {
			$.confirm({
				title: '변경불가',
				content: 'ON 상태의 광고소재는 클릭당 단가가 보유애드머니를 초과 할 수 없습니다.',
				buttons: {
					OK: function () {
						e.target.value = originalCpc;
						if(adCpc > admoneyAmount)
							adStatus.checked = false;
					}
				}
			});
		}
			
		if(adCpc > adDailyBudget) {
			$.confirm({
				title: '변경불가',
				content: '클릭당 단가는 일예산보다 클 수 없습니다.',
				buttons: {
					OK: function () {
						e.target.value = originalCpc;
					}
				}
			});
		}
	});
});

document.querySelectorAll("input[name='adDailyBudget']").forEach((input) => {
	input.addEventListener('change', (e) => {
		const tr = e.target.parentElement.parentElement;
		const adCpc = Number(document.querySelector(`#\${tr.id} input[name='adCpc']`).value);
		const adDailyBudget = Number(e.target.value);
		const originalBudget = tr.dataset.dailyBudget;
		
		if(adDailyBudget < adCpc) {
			$.confirm({
				title: '변경불가',
				content: '일예산은 클릭당 단가보다 작을 수 없습니다.',
				buttons: {
					OK: function () {
						e.target.value = originalBudget;
					}
				}
			});
		}
	});
});

document.querySelectorAll(".updateAdBtn").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const tr = e.target.parentElement.parentElement;
		const trId = tr.id;

		const advertisementNo = tr.dataset.advertisementNo;
		const adStatus = document.querySelector(`#\${trId} input[name='adStatus']`).checked;
		const adCpc = document.querySelector(`#\${trId} input[name='adCpc']`).value;
		const adDailyBudget = document.querySelector(`#\${trId} input[name='adDailyBudget']`).value;

		$.ajax({
			url: "${pageContext.request.contextPath}/mypage/advertiser/updateAd",
			type: "POST",
			headers,
			data: {
				advertisementNo,
				adStatus,
				adCpc,
				adDailyBudget
			},
			success(response) {
				// console.log(response);
				const {msg} = response;
				$.confirm({
					title: '변경완료',
					content: '광고소재 정보가 변경되었습니다.',
					buttons: {
						OK: function () {}
					}
				});
			},
			error: console.log
		});
	});
});
</script>