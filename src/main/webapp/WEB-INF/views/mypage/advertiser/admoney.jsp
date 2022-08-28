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
<!-- iamport -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- jquery-confirm -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>

<div class="container">
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5">
			<div class="adMoneyWrapper mx-auto">
				<h2>애드머니</h2>
				<div class="divNowAdMoney d-flex justify-content-between">
					<h6 class="d-inline">현재 보유 애드머니</h6>
					<div>
						<h5 class="d-inline" id="balance"><fmt:formatNumber value="${admoney.balance}" pattern="#,###" /></h5>
						<small class="ml-1">원</small>
					</div>
				</div>
				<div class="selectBtnWrapper">
					<button type="button" class="btn btn-camper-color btn-block" onclick="clickChargeBtn(100000);">100,000원 충전</button>
					<button type="button" class="btn btn-camper-color btn-block" onclick="clickChargeBtn(250000);">250,000원 충전</button>
					<button type="button" class="btn btn-camper-color btn-block" onclick="clickChargeBtn(500000);">500,000원 충전</button>
					<button type="button" class="btn btn-camper-color btn-block" onclick="clickChargeBtn(1000000);">1,000,000원 충전</button>
					<div class="form-group">
						<label for="">직접입력하기</label>
						<div class="form-row d-flex justify-content-between">
							<div class="form-row align-items-center">
								<div class="col-auto">
									<input type="number" class="form-control" name="amountCustom" id="chargeCustom" />
								</div>
								<div class="col-auto">
									<span>원</span>
								</div>
							</div>
							<div class="col-auto">
								<button class="btn btn-camper-color" onclick="clickChargeBtn(chargeCustom.value);">충전</button>
							</div>
						</div>
					</div>
				</div>
				<div class="text-right">
					<button class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#refundModal">애드머니 환불</button>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<%-- 모달영역 --%>
<div class="modal fade" id="refundModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">애드머니 환불</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form:form action="" onsubmit="return false;" name="refundAdmoneyFrm">
				<div class="modal-body px-4">
					<p>보유애드머니 : <span class="camper-color mx-1"><fmt:formatNumber value="${admoney.balance}" pattern="#,###" /></span><small>원</small></p>
					<small>*소진이 시작된 결제건은 제외됩니다.</small>
					<div class="d-flex justify-content-center" id="payListWrapper">
						<table id="payListTbl" class="table">
							<thead>
								<tr>
									<td class="text-center px-3">선택</td>
									<td class="text-center px-3">결제번호</td>
									<td class="text-center px-3">환불가능액</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${canRefundList}" var="pay">
									<tr>
										<td class="text-center">
											<input type="checkbox" class="" name="cancelTarget" value="${pay.merchantUid}">
										</td>
										<td class="text-center">${pay.merchantUid}</td>
										<td class="text-center"><fmt:formatNumber value="${pay.paidAmount}" pattern="#,###" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">뒤로가기</button>
					<button type="button" onclick="cancelPay();" class="btn btn-sm btn-camper-red">환불하기</button>
				</div>
			</form:form>
		</div>
	</div>
</div>

<spring:eval var="impStoreCode" expression="@customProperties['api.impStoreCode']" />
<sec:authentication property="principal" var="loginMember" scope="page"/>
<script>

// 결제기능
IMP.init('${impStoreCode}');

const clickChargeBtn = (amount) => {
	const merchantUid = '${admoney.advertiserNo}_' + new Date().getTime();

	IMP.request_pay({
		
		// 일반결제 테스트 상점아이디 : INIpayTest
		pg : 'html5_inicis.INIpayTest',
		
		pay_method : 'card',
		merchant_uid : merchantUid,
		name : '애드머니충전',
		digital: true,
		amount : amount,
		buyer_name : '${loginMember.name}',
		buyer_tel : '${loginMember.tel}',
		buyer_email : '${loginMember.email}'
		
	}, function (rsp) {
		
		// 결제 성공 시
		if(rsp.success) {
			
			const {imp_uid : impUid, pay_method : payMethod, paid_amount : paidAmount, status, 
				buyer_email : buyerEmail, buyer_name : buyerName, buyer_tel : buyerTel, 
				paid_at : paidAt, pg_provider : pgProvider} = rsp;
			
			const headers = {"${_csrf.headerName}" : "${_csrf.token}"};
			
			// DB에 결제정보 반영
			$.ajax({
				url : '${pageContext.request.contextPath}/mypage/advertiser/admoneyCharge',
				method : 'POST',
				headers,
				data : {
					merchantUid,
					advertiserNo : '${admoney.advertiserNo}',
					impUid,
					payMethod,
					paidAmount,
					status,
					buyerEmail,
					buyerName,
					buyerTel,
					paidAt,
					pgProvider
				}
				
			}).done(function(data) {
				
				const {balance : afterBalace} = data;
				$.confirm({
					title: '결제완료',
					content: '애드머니가 정상적으로 충전되었습니다.',
					buttons: {
						OK: function () {
							location.reload();
						}
					}
				});
			});
			
		} else {
			console.log(rsp.error_msg);
		}
	});
}

// 환불기능
const cancelPay = () => {

	const headers = {
		"${_csrf.headerName}" : "${_csrf.token}"
	};

	const merchantUidList = [];
	document.querySelectorAll("input[name=cancelTarget]:checked").forEach((checked, index) => {
		merchantUidList[index] = checked.value;
	});
	// 환불대상이 지정되지 않은 경우 조기리턴
	if(merchantUidList.length == 0)
		return;

	$.ajax({
		
		url : '${pageContext.request.contextPath}/mypage/advertiser/refund',
		method : 'post',
		headers,
		data : {
			merchantUidList,
			advertiserNo : '${admoney.advertiserNo}',
			reason : '테스트 결제 환불'
		}
		
	}).done(function(result) { // 환불 성공시 로직 
		console.log(result);
		$.confirm({
			title: '환불완료',
			content: '정상적으로 환불처리되었습니다.',
			buttons: {
				OK: function () {
					location.reload();
				}
			}
		});
	}).fail(function(error) { // 환불 실패시 로직
		console.log(error);
		const {responseText : errorMID} = error;
		$.confirm({
			title: '환불실패',
			content: `결제번호 [\${errorMID}]의 환불이 실패하였습니다.`,
			buttons: {
				OK: function () {
					location.reload();
				}
			}
		});
	});
};

</script>