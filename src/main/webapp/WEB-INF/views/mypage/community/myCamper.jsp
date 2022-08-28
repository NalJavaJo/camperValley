<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/community/community.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5">
			<h3 class="mt-1 mb-5">커뮤니티</h3>
			<div class="d-flex justify-content-between align-items-center" id="my-community-header">
				<div class="d-flex">
					<a href="${pageContext.request.contextPath}/mypage/community/myCamper" class="pr2 camper-color">캠퍼모집</a>
					<a href="${pageContext.request.contextPath}/mypage/community/myReview" class="pl-2 text-dark">작성후기</a>
				</div>
				<div class="d-flex mr-2">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
					    	<button id="searchOption" class="btn btn-outline-camper dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">${param.searchOption eq 'content' ? '내용' : '제목'}</button>
								<ul id="searchOptionItem" class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							    	<li><a class="dropdown-item" href="#" value="title">제목</a></li>
							    	<li><a class="dropdown-item" href="#" value="content">내용</a></li>
								</ul>
						</div>
					 	<input type="text" class="form-control" aria-label="Text input with dropdown button" name="searchKeyword" value="${param.searchKeyword}">
						<button class="btn btn-outline-camper" id="search" type="button">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#639A67" class="bi bi-binoculars-fill" viewBox="0 0 16 16">
								<path d="M4.5 1A1.5 1.5 0 0 0 3 2.5V3h4v-.5A1.5 1.5 0 0 0 5.5 1h-1zM7 4v1h2V4h4v.882a.5.5 0 0 0 .276.447l.895.447A1.5 1.5 0 0 1 15 7.118V13H9v-1.5a.5.5 0 0 1 .146-.354l.854-.853V9.5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v.793l.854.853A.5.5 0 0 1 7 11.5V13H1V7.118a1.5 1.5 0 0 1 .83-1.342l.894-.447A.5.5 0 0 0 3 4.882V4h4zM1 14v.5A1.5 1.5 0 0 0 2.5 16h3A1.5 1.5 0 0 0 7 14.5V14H1zm8 0v.5a1.5 1.5 0 0 0 1.5 1.5h3a1.5 1.5 0 0 0 1.5-1.5V14H9zm4-11H9v-.5A1.5 1.5 0 0 1 10.5 1h1A1.5 1.5 0 0 1 13 2.5V3z"/>
							</svg>
						</button>
					</div>
				</div>
			</div>
			<div class="review-list pb-3" id="my-community-body">
				<table class="table table-hover text-center border-bottom table-sm" id="my-camper-table">
	            	<thead>
	                	<tr>
	                    	<th>
	                        	상태
	                        </th>
	                        <th>
	                        	제목
	                        </th>
	                        <th>
	                            캠핑기간
	                        </th>
	                        <th>
	                            지역
	                        </th>
	                        <th>
	                            모집인원
	                        </th>
	                        <th>
	                        	삭제
	                        </th>
	                    </tr>
	                </thead>
	                <tbody>
		                <c:if  test="${empty list}">
		                	<tr>
		                		<td colspan="6" class="text-center">작성하신 글이 존재하지 않습니다.</td>
		                	</tr>
		                </c:if>
		                <c:forEach items="${list}" var="camper" varStatus="vs">
		                    <tr data-no="${camper.camperNo}">
		                        <td>
		                        	<select class="recruitment-status">
										<option value="I"
											<c:if test="${camper.status eq 'I'}">
												selected
											</c:if>
										>모집중</option>
										<option value="C"
											<c:if test="${camper.status eq 'C'}">
											selected
											</c:if>
										>모집완료</option>
									</select>
		                        </td>
		                        <td class="text-left">
		                            <span class="title" data-toggle="modal" data-target="#camper-detail"><c:out value="${camper.title}"/></span>
		                        </td>
		                        <td>
									${camper.departureDate} ~ ${camper.arrivalDate}
		                        </td>
		                        <td>
		                            ${camper.area}
		                        </td>
		                        <td class="align-middle">
		                            ${camper.memberCount}명
		                        </td>
								<td>
		                        	<form action="${pageContext.request.contextPath}/mypage/community/myCamper/delete" method="post">
		                        		<input type="hidden" name="camperNo" value="${camper.camperNo}" />
				                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			                        	<button>
					                        <i class="fa-solid fa-trash-can"></i>
				                        </button>
			                        </form>
		                        </td>
			                </tr>
			            </c:forEach>
	         		</tbody>
				</table>          
			</div>
			<div class="mt-3" id="pagebar-wrp">
				<c:if test="${not empty list}">${pagebar}</c:if>
			</div>
		</div>
	</div>
</div>
	
<div class="modal fade" id="camper-detail" tabindex="-1" role="dialog"
aria-labelledby="camper-detail-label" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
		<div class="modal-content px-3 pt-3">
			<div class="modal-header d-block pb-3">
				<h4 class="text-center mb-4 font-weight-bold" id="detailTitle">캠퍼모집 제목</h4>
				<div class="d-flex justify-content-between" style="line-height: 2" >
					<div class="align-self-bottom align-self-end">
						<span id="date"></span>
						<br />
						<span id="area"></span>
					</div>
					<div>
					<br />
						<div class="text-right pr-3" id="memberCount"></div>
						<select class="recruitment-status font-weight-bold">
							<option value="I">모집중</option>
							<option value="C">모집완료</option>
						</select>
					</div>
				</div>
			</div>
			<div class="modal-body py-4">
				<h6 class="font-weight-bold">상세내용</h6>
				<p id="content"></p>
				<h6 class="font-weight-bold">이용수칙</h6>
				<p id="purpose"></p>
				<h6 class="font-weight-bold">예상비용</h6>
				<p id="expectedCost"></p>
			</div>
			<div class="modal-footer px-0 pt-4">
				<button type="button" id="update" class="btn btn-outline-camper-color btn-lg border-2 shadow-sm">수정</button>
				<button class="btn btn-camper-color btn-lg shadow-sm" data-dismiss="modal">닫기</button>
			</div>
		</div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/community/camper/camperUpdate.jsp"/>
<script>
$("form[name=camperEnrollFrm]").attr("action","${pageContext.request.contextPath}/mypage/community/myCamper/camperUpdate");

$('#searchOptionItem li > a').on('click', function() {
    $('#searchOption').text($(this).text());
});

$("select.recruitment-status").change((e)=>{
	const status = $(e.target).val();
	console.log(status);
	const camperNo = $(e.target).parents("tr").data('no');
	const headers = {
			"${_csrf.headerName}" : "${_csrf.token}"
		};
	$.ajax({
		url: "${pageContext.request.contextPath}/mypage/community/myCamper/status/update",
		method : "post",
		headers,
		data: {
			camperNo, status
		},
		success(response){
			alert(response.msg);
		},
		error: console.log
	});
	
});

$("span.title").click((e)=>{
	console.log($(e.target));
	console.log('click');
	const status = $(e.target).val();
	const camperNo = $(e.target).parents("tr").data('no');
	$.ajax({
		url: "${pageContext.request.contextPath}/community/camper/camperDetail",
		data: {camperNo},
		success(response) {
			const {camper} = response;
			$("h4#detailTitle").html(XSSFilter(camper.title));
			$("span#area").html(camper.area);
			const departureDate = camper.departureDate;
			const arrivalDate = camper.arrivalDate;
			$("span#date").html(departureDate.year + "년 " + departureDate.monthValue + "월 " + departureDate.dayOfMonth + "일 ~ " + arrivalDate.year + "년 " + arrivalDate.monthValue + "월 " + arrivalDate.dayOfMonth +"일");
			console.log(typeof(camper.departureDate));
			console.log((camper.departureDate));
			$("div#memberCount").html(camper.memberCount + "명");
			camper.status === "C" ? $("#camper-detail option[value=C]").attr("selected",true) : $("#camper-detail option[value=C]").attr("selected",false);
			$("p#content").html(XSSFilter(camper.content));
			$("p#purpose").html(XSSFilter(camper.purpose));
			$("p#expectedCost").html(XSSFilter(camper.expectedCost));
		

			$("#update").click((e) => {
				const areas = camper.area.split(" ");
				document.querySelectorAll("#sido1 option").forEach((option) => {
					if(areas[0] === $(option).val()) {
						$(option).prop("selected", true).change();
					}
				});
				document.querySelectorAll("#gugun1 option").forEach((option) => {
					if(areas[1] === $(option).val()) {
						$(option).prop("selected", true).change();
					}
			});
								
			ps = (str)=>{
				return ('00' + str).slice(-2);
			}
				
			$("#camperUpdate input[name=departureDate]").val(departureDate.year + "-" + ps(camper.departureDate.monthValue) + "-" + ps(departureDate.dayOfMonth));
			$("#camperUpdate input[name=arrivalDate]").val(arrivalDate.year + "-" + ps(arrivalDate.monthValue) + "-" + ps(arrivalDate.dayOfMonth));
				
			$("#camperUpdate #memberCount").val(camper.memberCount);
			$("#camperUpdate #title").val(camper.title);
			$("#camperUpdate #content").val(camper.content);
			$("#camperUpdate #purpose").val(camper.purpose);
			$("#camperUpdate #expectedCost").val(camper.expectedCost);
			$("#camperUpdate #chatUrl").val(camper.chatUrl);
			$("#camperUpdate #camperNo").val(camper.camperNo);
			
			$("#camper-detail").modal('hide');
			
			$("#camperUpdate")
				.modal()
				.on('hide.bs.modal');
			});
		},
		error: console.log
	});			
});

$("#search").click(e=>{
	const searchOption = $("#searchOption").text()=== "제목" ? "title" : "content";
	const searchKeyword = $("input[name=searchKeyword]").val();
	
	if(searchKeyword === "") return;
	console.log(searchOption);
	console.log(searchKeyword);
	location.href = `${pageContext.request.contextPath}/mypage/community/myCamper/?searchOption=\${searchOption}&searchKeyword=\${searchKeyword}`;
});

const XSSFilter = (str) => {
	return str.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("'", "&quot;").replaceAll('"', '&#39;');
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />