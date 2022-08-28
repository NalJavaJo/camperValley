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
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
.modalOpen:hover {
	cursor: pointer;
}
</style>
<div class="container" style="display: flex;" id="admin-container">
	<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />
	<div class="admin-content" style="width: 80%;">
		<h5 class="admin-hd">캠퍼모집 관리</h5>
		<div class="camper-hd" style="margin-top:40px;">
		<div class="float-right">
					<button type="button" class="btn-delete btn btn-danger btn-sm">선택삭제
					</button>
				</div>
	<div class="search-group float-left mb-2">
						<select id="search-type">
							<option value="title" ${map.searchType eq 'title' ? 'selected' : ''}>제목</option>
							<option value="content" ${map.searchType eq 'content' ? 'selected' : ''}>내용</option>
						</select>
						<input class="input-search" type="text" name="searchType" placeholder="검색어 입력" name="searchKeyword" id="searchKeyword">
						<button class="btn-search" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
					
			<table class="table table-hover text-center" id="tb-admin">
				<thead>
					<tr>
						<th class="col-md-1"><input name="checkAll" id="checkAll" type="checkbox" /></th>
						<th class="col-md-1">No.</th>
						<th class="col-md-6">제목</th>
						<th>아이디</th>
						<th>작성일</th>
					</tr>
				</thead>
				<c:if test="${empty list}">
						<td colspan="5">등록된 글이 없습니다.</td>
					</c:if>
				<tbody>
				<form action="${pageContext.request.contextPath}/admin/camperDelete" method="post" name="deleteCamperFrm">
				<c:forEach items="${list}" var="list" varStatus="vs">
					<tr data-camper-no="${list.camperNo}" 
					data-title="${list.title}" 
					data-content="${list.content}"
					data-purpose="${list.purpose}"
					data-expected-cost="${list.expectedCost}"
					data-chat-url="${list.chatUrl}"
					data-departure-date="${list.departureDate}"
					data-arrival-date="${list.arrivalDate}"
					data-area="${list.area}"
					data-member-count="${list.memberCount}"
					data-status="${list.status}">
						<td><input name="deleteList" type="checkbox" class="deleteList" value="${list.camperNo}" /></td>
						<td>${list.camperNo}</td>
						<td><span class="modalOpen" data-toggle="modal" data-target="#adminCamperModal" >${list.title}</span></td>
						<td>${list.memberId}</td>
						<td>
							<fmt:parseDate value="${list.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
							<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
						</td>
						

					</tr>
					</c:forEach>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</tbody>
			</table>
			<c:if test="${not empty list}">
    	<div class="mt-5" id="pageBar">${pagebar}</div>
</c:if>
	</div>
</div>

<!-- 모 -->
<style>
.modal-header {
	background-color: #fff !important;
	color: #000 !important;
}
.modal-header span {
	font-weight: 400;
}
</style>
<div class="modal fade" id="adminCamperModal" tabindex="-1" role="dialog" aria-labelledby="#adminProductModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered px-5 modal-dialog-scrollable modal-lg" role="document">
				<div class="modal-content px-3  pt-3">
					<div class="modal-header  d-block  pb-4">
						<h4 class="text-center mb-4 font-weight-bold" id="title">캠퍼모집 제목</h4>
						<div class="d-flex justify-content-between font-weight-bold" >
							<div class="align-self-bottom align-self-end">
								<span id="departureDate"></span><span> ~ </span><span id="arrivalDate"></span>
								<br />
								<span id="area"></span>
							</div>
							<div>
							<br />
								<span class="text-center" id="memberCount"></span><span>명</span>
								<br />
								<span id="status"></span>
							</div>
						</div>
					</div>
					<div class="modal-body py-4">
						<h6 class="font-weight-bold">상세내용</h6>
						<p id="modal-content"></p>
						<h6 class="font-weight-bold">이용수칙</h6>
						<p id="purpose"></p>
						<h6 class="font-weight-bold">예상비용</h6>
						<p id="expectedCost"></p>
						<h6 class="font-weight-bold">채팅 URL</h6>
						<p id="chatUrl"></p>
					</div>
					<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			  </div>
				</div>
	        </div>
		</div>
		
<script>
document.querySelectorAll('.btn-search').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		let keyword = document.getElementById('searchKeyword').value;
		let searchType = document.getElementById('search-type').value;

		let url = "${pageContext.request.contextPath}/admin/camperManagement";
		url = url + "?searchType=" + searchType;
		url = url + "&searchKeyword=" + keyword;
		location.href = url;
		console.log(url);
		
	})
})

document.querySelectorAll('.btn-delete').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		document.deleteCamperFrm.submit();
	})
});

$(document).ready(function() {
    $("input:checkbox[name='checkAll']").click(function() {
        if($("input:checkbox[name='checkAll']").is(":checked") == true) {
            $("input:checkbox[name='deleteList']").prop("checked", true);
        } else {
            $("input:checkbox[name='deleteList']").prop("checked", false);
        }
    });

    $("input:checkbox[name='deleteList']").click(function() {
        var allCnt = $("input:checkbox[name='deleteList']").length;         
        var selCnt = $("inupt:checkbox[name='deleteList']:checked").length; 

        if(allCnt != selCnt) {
            $("input:checkbox[name='checkAll']").prop("checked", false);
        }
    });
});

document.querySelectorAll(".modalOpen").forEach((modal) => {
	modal.addEventListener('click', (e) => {
		const tr = e.target.parentElement.parentElement;

		const title = tr.dataset.title;
		const content = tr.dataset.content;
		const purpose = tr.dataset.purpose;
		const expectedCost = tr.dataset.expectedCost;
		const departureDate = tr.dataset.departureDate;
		const arrivalDate = tr.dataset.arrivalDate;
		const area = tr.dataset.area;
		const memberCount = tr.dataset.memberCount;
		const chatUrl = tr.dataset.chatUrl;
		
		const status = tr.dataset.status;
		
		if(status === "I") {
			document.querySelector("#status").innerHTML = '모집중'
		} else{
			document.querySelector("#status").innerHTML = '모집완료'
		}
		
		document.querySelector("#title").innerHTML = title;
		document.querySelector("#modal-content").innerHTML = content;
		document.querySelector("#purpose").innerHTML = purpose;
		document.querySelector("#expectedCost").innerHTML = expectedCost;
		document.querySelector("#departureDate").innerHTML = departureDate;
		document.querySelector("#arrivalDate").innerHTML = arrivalDate;
		document.querySelector("#area").innerHTML = area;
		document.querySelector("#memberCount").innerHTML = memberCount;
		document.querySelector("#chatUrl").innerHTML = chatUrl;
	})
})


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>