<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/advertiser.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<div class="container" id="admin-container" style="display: flex;">
	<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />
	<div class="admin-content" style="width: 80%;">
		<h5 class="admin-hd">광고주회원 관리</h5>
		<!-- 콘텐츠 영역 -->
		<div class="formBox my-5 d-flex align-items-center justify-content-center">
			<form:form name="searchAdvertiserFrm" action="${pageContext.request.contextPath}/admin/advertiser" method="GET">
				<div class="row">
					<div class="col row filterWrapper">
						<div class="px-0 d-flex align-items-center justify-content-center divInputWrapper">
							<label for="">승인상태</label>
							<select class="custom-select custom-select-sm" name="status">
								<option value="all" ${(param.status eq 'all') || (empty param.status) ? 'selected' : ''}>전체</option>
								<option value="permission" ${param.status eq 'permission' ? 'selected' : ''}>승인완료</option>
								<option value="waiting" ${param.status eq 'waiting' ? 'selected' : ''}>승인대기</option>
								<option value="pause" ${param.status eq 'pause' ? 'selected' : ''}>권한정지</option>
							</select>
						</div>
						<div class="col px-0 d-flex align-items-center justify-content-center divInputWrapper">
							<label for="memberId">회원ID</label>
							<input type="text" class="form-control form-control-sm" name="memberId" value="${param.memberId}"/>
						</div>
						<div class="col px-0 d-flex align-items-center justify-content-center divInputWrapper">
							<label for="bizName">광고계정명</label>
							<input type="text" class="form-control form-control-sm" name="bizName" value="${param.bizName}"/>
						</div>
						<div class="col px-0 d-flex align-items-center justify-content-center divInputWrapper">
							<label for="bizLicenseNo">사업자등록번호</label>
							<input type="text" class="form-control form-control-sm" name="bizLicenseNo" id="searchBizLicenseNo" value="${param.bizLicenseNo}"/>
						</div>
					</div>
					<div class="col-1 divInputWrapper">
						<button type="submit" class="btn btn-camper-color btn-sm">검색</button>
					</div>
				</div>
			</form:form>
		</div>
		<div class="listBox">
			<table id="tblAdvertiserList" class="table mt-5 mb-3">
				<thead class="listHead">
					<tr class="text-center">
						<td>상태</td>
						<td>회원ID</td>
						<td>광고계정명</td>
						<td>사업자등록번호</td>
						<td>사업자등록증</td>
						<td>승인요청일</td>
						<td>권한관리</td>
					</tr>
				</thead>
				<tbody class="listBody">
					<c:if test="${empty list}">
						<tr><td colspan="7">조회결과가 없습니다.</td></tr>
					</c:if>
					<c:if test="${not empty list}">
					<c:forEach items="${list}" var="advertiser" varStatus="vs">
						<tr data-advertiser-no="${advertiser.advertiserNo}" data-member-id="${advertiser.memberId}">
							<c:if test="${advertiser.withdrawal eq 'Y'}">
								<td class="withdrawal">회원탈퇴</td>
							</c:if>
							<c:if test="${advertiser.withdrawal eq 'N'}">
								<c:if test="${advertiser.bizStatus eq 'N'}">
									<td class="waiting">승인대기</td>
								</c:if>
								<c:if test="${advertiser.bizStatus eq 'Y'}">
									<c:if test="${not empty advertiser.deletedAt}">
										<td class="withdrawal">광고주탈퇴</td>
									</c:if>
									<c:if test="${empty advertiser.deletedAt}">
										<c:if test="${not fn:contains(advertiser.authorities, 'ROLE_AD')}">
											<td class="pause">권한정지</td>
										</c:if>
										<c:if test="${fn:contains(advertiser.authorities, 'ROLE_AD')}">
											<td class="permission">승인완료</td>
										</c:if>
									</c:if>
								</c:if>
							</c:if>
							<td>${advertiser.memberId}</td>
							<td>${advertiser.bizName}</td>
							<td>
								<c:set var="bizLicenseNo" value="${advertiser.bizLicenseNo}"/>
								${fn:substring(bizLicenseNo, 0, 3)}-${fn:substring(bizLicenseNo, 3, 5)}-${fn:substring(bizLicenseNo, 5, 10)}
							</td>
							<td>
								<a href="${pageContext.request.contextPath}/admin/advertiser/fileDownload?no=${advertiser.licenseFile.licenseFileNo}">
									<i class="fa-solid fa-download"></i>
								</a>
							</td>
							<td>
								<fmt:parseDate value="${advertiser.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt" />
								<fmt:formatDate value="${createdAt}" pattern="yy-MM-dd HH:mm"/>
							</td>
							<td>
								<c:if test="${advertiser.withdrawal eq 'Y'}">
									<button class="btn btn-sm btn-secondary" disabled>탈퇴</button>
								</c:if>
								<c:if test="${advertiser.withdrawal eq 'N'}">
									<c:if test="${advertiser.bizStatus eq 'N'}">
										<button class="updateBtn btn btn-sm btn-camper-color" value="${advertiser.advertiserNo}">승인</button>
									</c:if>
									<c:if test="${advertiser.bizStatus eq 'Y'}">
										<c:if test="${not empty advertiser.deletedAt}">
											<button class="btn btn-sm btn-secondary" disabled>탈퇴</button>
										</c:if>
										<c:if test="${empty advertiser.deletedAt}">
											<c:if test="${not fn:contains(advertiser.authorities, 'ROLE_AD')}">
												<button class="updateBtn btn btn-sm btn-camper-color" value="${advertiser.advertiserNo}">승인</button>
											</c:if>
											<c:if test="${fn:contains(advertiser.authorities, 'ROLE_AD')}">
												<button class="updateBtn btn btn-sm btn-camper-red" value="${advertiser.advertiserNo}">회수</button>
											</c:if>
										</c:if>
									</c:if>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			<c:if test="${not empty list}">
				<div class="mt-5 pagebar">${pagebar}</div>
			</c:if>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/mypage/advertiser/validation.js"></script>
<script>
document.querySelectorAll(".updateBtn").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const advertiserNo = e.target.value;
		const actionType = e.target.innerHTML == "승인" ? "PERMISSION" : "PAUSE";

		const tr = document.querySelector(`[data-advertiser-no="\${advertiserNo}"]`);
		const memberId = tr.dataset.memberId;
		
		const headers = {
			"${_csrf.headerName}" : "${_csrf.token}"
		};
		
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/advertiser/updateRole",
			method : "POST",
			headers,
			data : {
				advertiserNo,
				memberId,
				actionType
			},
			success(response) {
				console.log(response);
				location.reload();
			},
			error : console.log
		});
	});
});
</script>