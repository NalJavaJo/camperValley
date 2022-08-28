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
					<a href="${pageContext.request.contextPath}/mypage/community/myCamper" class="pr2 text-dark">캠퍼모집</a>
					<a href="${pageContext.request.contextPath}/mypage/community/myReview" class="pl-2 camper-color">작성후기</a>
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
				<table class="table table-hover text-center border-bottom">
	            	<thead>
	                	<tr>
	                    	<th>
	                        	제목
	                        </th>
	                        <th>
	                        	야영장명
	                        </th>
	                        <th>
	                        	평점
	                    	</th>
	                        <th>
	                        	조회수
	                        </th>
	                        <th>
	                            추천수
	                        </th>
	                        <th>
	                            작성일
	                        </th>
	                        <th>
	                           	삭제
	                        </th>
	                    </tr>
	                </thead>
	                <tbody>
						<c:if test="${empty list}">
		                	<tr>
		                		<td colspan="6" class="text-center">작성하신 글이 존재하지 않습니다.</td>
		                	</tr>
		                </c:if>
		                <c:forEach items="${list}" var="review" varStatus="vs">
		                    <tr data-no="${board.no}">
		                    	<td class="text-left">
		                            <a href="${pageContext.request.contextPath}/community/review/reviewDetail?reviewNo=${review.reviewNo}">${review.title}[${review.commentCount}]</a>
		                        </td>
		                        <td class="text-left">
		                        	${review.facltNm}
		                        </td>
		                        <td>
		                        	${review.reviewGrade}
		                        </td>
		                        <td>
		                        	${review.readCount}
		                        </td>
		                        <td>
		                        	${review.recommendCount}
		                        </td>
		                        <td>
									<fmt:parseDate value="${review.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
									<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
		                        </td>
		                        <td>
		                        	<form action="${pageContext.request.contextPath}/mypage/community/myReview/delete" method="post">
		                        		<input type="hidden" name="reviewNo" value="${review.reviewNo}" />
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
	
<script>
$('#searchOptionItem li > a').on('click', function() {
    $('#searchOption').text($(this).text());
});

$("#search").click( e => {

	const searchOption = $("#searchOption").text()=== "제목" ? "title" : "content";
	const searchKeyword = $("input[name=searchKeyword]").val();
	
	if(searchKeyword === "") return;
	console.log(searchOption);
	console.log(searchKeyword);
	location.href = `${pageContext.request.contextPath}/mypage/community/myReview/?searchOption=\${searchOption}&searchKeyword=\${searchKeyword}`;
	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />