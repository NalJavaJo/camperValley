<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css" />
<style>
.col-form-label {
	width: 80px !important;
	margin-left: 70px !important;
}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<div class="container" style="display: flex;" id="admin-container">
	<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />
	<div class="admin-content" style="width: 80%;">
		<h5 class="admin-hd">신고 내역 관리</h5>

		<div class="report-hd" style="margin-top: 75px;"></div>
		<!--report-hd-->

		<table class="table table-hover text-center" id="tb-admin">
			<thead style="border-top: 2px solid #dee2e6;">
				<tr>
					<th class="col-md-1">No.</th>
					<th>신고자</th>
					<th>리뷰작성자</th>
					<th class="col-md-3">신고유형</th>
					<th class="col-md-2">신고일</th>
					<th>상태</th>
					<th class="col-md-1"></th>
				</tr>
			</thead>
			<c:if test="${empty list}">
				<td colspan="7">등록된 글이 없습니다.</td>
			</c:if>
			<tbody>
				<c:forEach items="${list}" var="list" varStatus="vs">
					<tr data-report-no="${list.reportNo}"
						data-seller-id="${list.sellerId}"
						data-member-id="${list.memberId}" data-category="${list.category}"
						data-created-at="${list.createdAt}"
						data-state-yn="${list.stateYn}" data-content="${list.content}"
						data-authorities="${list.authorities}"
						data-product-no="${list.productNo}" data-review="${list.review}">
						<td>${list.reportNo}</td>
						<td>${list.sellerId}</td>
						<td>${list.memberId}</td>
						<td><c:if test="${fn:contains(list.category, 'relation')}">언어 폭력(욕설 및 성희롱)</c:if>
							<c:if test="${fn:contains(list.category, 'language')}">게시글과 무관한 내용</c:if>
							<c:if test="${fn:contains(list.category, 'ad')}">광고</c:if> <c:if
								test="${fn:contains(list.category, 'etc')}">기타</c:if></td>
						<td><fmt:parseDate value="${list.createdAt}"
								pattern="yyyy-MM-dd'T'HH:mm" var="createdAt" /> <fmt:formatDate
								value="${createdAt}" pattern="yyyy-MM-dd" /></td>
						<td><c:if test="${fn:contains(list.stateYn, 'Y')}">처리</c:if>
							<c:if test="${fn:contains(list.stateYn, 'N')}">미처리</c:if></td>
						<td style="padding: 6px;">
							<button type="button"
								class="btn btn-outline-camper-color btn-sm btn-update"
								data-toggle="modal" data-target="#adminReportModal">처리</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${not empty list}">
			<div class="mt-5" id="pageBar">${pagebar}</div>
		</c:if>
	</div>
</div>

<!-- 모달창 -->
<div class="modal fade" id="adminReportModal" tabindex="-1"
	role="dialog" aria-labelledby="#adminReportModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="adminReportModalLabel">신고처리</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true" style="color: #fff">&times;</span>
				</button>
			</div>
			<form:form name="buyerRoleUpdateFrm" method="POST"
				action="${pageContext.request.contextPath}/admin/updateBuyerBlack">
				<div class="modal-body pb-1">
					<div class="float-right">
						<a href="" id="productView" data-value="" style="color: #777;">판매글
							상세보기</a>
					</div>
					<div class="form-group mt-4">
						<label for="name" class="col-form-label">리뷰작성자</label> <input
							type="text" class="input-report pt-1 pb-1 pl-2" id="memberId"
							name="memberId" value="" readonly></input>
					</div>
					<div class="form-group">
						<label for="message-text" class="col-form-label float-left mr-1">리뷰내용</label>
						<textarea class="input-report pt-1 pb-1 pl-2" id="review"
							style="display: inline; height: 50px;" readonly></textarea>
					</div>

					<div class="form-group">
						<label for="memberId" class="col-form-label">신고자</label> <input
							type="text" class="input-report pt-1 pb-1 pl-2" id="sellerId"
							value="" readonly>
					</div>
					<div class="form-group">
						<label for="nickname" class="col-form-label">신고유형</label> <input
							type="text" class="input-report pt-1 pb-1 pl-2" id="category"
							value="" readonly></input>
					</div>

					<div class="form-group">
						<label for="message-text" class="col-form-label float-left mr-1">신고내용</label>
						<textarea class="input-report pt-1 pb-1 pl-2" id="contentre"
							style="display: inline; height: 100px;" readonly></textarea>
					</div>


					<div class="form-group mb-0">
						<p class="form-check form-check-inline mr-4 ml-6"
							style="margin-left: 70px;">
							블랙리스트&nbsp;<span style="color: red;">*</span>
						</p>

						<div class="form-check form-check-inline" style="top: -15px;">
							<div class="custom-control custom-switch"
								style="margin-left: -15px;">
								<input type="checkbox" class="custom-control-input" id="black"
									name="ROLE_BLACK"> <label class="custom-control-label"
									for="black"></label>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" name="reportNo" id="reportNo" value="" />
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary"
						id="btn-report-update">처리</button>
				</div>
		</div>
		</form:form>
	</div>
</div>
<div class="result" id="menuType-result"></div>
<script>


$(document).ready(function(){
	$('.toggle-btn').click(function() {
	$(this).toggleClass('active').siblings().removeClass('active');
	});
});
	
document.querySelectorAll(".btn-update").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		console.log(e.target);
		const tr = e.target.parentElement.parentElement;
		console.log(tr);

		const reportNo = tr.dataset.reportNo;		
		const sellerId = tr.dataset.sellerId;
		const memberId = tr.dataset.memberId;
		
		const category = tr.dataset.category;
		
		if(category === "relation")
			document.querySelector("#category").setAttribute('value','언어 폭력(욕설 및 성희롱)');
		
		if(category === "ad")
			document.querySelector("#category").setAttribute('value','광고');
		
		if(category === "etc")
			document.querySelector("#category").setAttribute('value','기타');

		if(category === "language")
			document.querySelector("#category").setAttribute('value','게시글과 무관한 내용');
		
		const content = tr.dataset.content;
		const productNo = tr.dataset.productNo;
		const review = tr.dataset.review;
		
		document.getElementById("productView").setAttribute('href', "${pageContext.request.contextPath}/usedProduct/product/productDetail?no="+productNo);
		
		const authorities = tr.dataset.authorities;
		
		 if(authorities.includes('ROLE_BLACK')) {
			document.getElementById("black").checked = true;
			console.log(document.getElementById("black").checked);
		} else {
			document.getElementById("black").checked = false;
		}
		 
		document.querySelector("#sellerId").value = sellerId;
		document.querySelector("#memberId").value = memberId;
		document.querySelector("#contentre").value = content;
		document.querySelector("#review").value = review;
		document.querySelector("#reportNo").value = reportNo;
		
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>