<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/review/review.css" />
<%
	pageContext.setAttribute("newLine", "\n"); 
	pageContext.setAttribute("br", "<br/>");
%>

<!-- 캠핑장후기목록조회 페이지 (작성자:SJ) -->
<div class="container-md campsite-review-list-wrap pt-2">
	<jsp:include page="/WEB-INF/views/community/communityHeading.jsp"/>
		<div class="col-md float-right">
			<form:form name="reviewSearchFrm" action="${pageContext.request.contextPath}/community/review/reviewList" method="GET">
				<div class="input-group align-items-center community-search-enroll">
			    	<select id="searchType" name="searchType" class="custom-select btn-outline-success btn-outline-camper-color">
						<option value="" disabled selected>선택</option>
						<option value="nickname" ${param.searchType eq 'nickname' ? 'selected' : ''}>작성자</option>
					   	<option value="title" ${param.searchType eq 'title' ? 'selected' : ''}>제목</option>
					    <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>내용</option>
					</select>
					<input 
						type="text" 
						name="searchKeyword" 
						class="form-control border-camper-color community-search-input"
						value="${param.searchKeyword}" 
						placeholder="검색어를 입력하세요." aria-label="Recipient's username" 
						aria-describedby="communitySearchBtn">
				  	<div class="input-group-append">
				    	<button class="btn btn-outline-success btn-outline-camper-color" type="submit" id="communitySearchBtn">
				    		<i class="fa-solid fa-magnifying-glass camper-color"></i>
				    	</button>
				  	</div>
				  	<c:if test="${not empty loginMember}">
						<div class="ml-1">
							<button type="button" id="communityEnrollBtn" class="btn btn-success bg-camper-color">글쓰기</button>
						</div>
				  	</c:if>
				</div>
			</form:form>
		</div>
	</div>
	<hr />
	<div class="review-list py-3">
		<table class="table table-hover text-center review-list-table">
		  	<thead>
		    	<tr>
		      		<th scope="col">No.</th>
		      		<th scope="col">제목</th>
		      		<th scope="col">작성자</th>
		      		<th scope="col">평점</th>
		      		<th scope="col">추천수</th>
		      		<th scope="col">조회수</th>
		      		<th scope="col">작성일</th>
		    	</tr>
		  	</thead>
		  	<tbody>
		  		<c:if test="${empty list}">
					<tr>
						<td colspan="8">등록된 후기가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty list}">
					<c:forEach items="${list}" var="review" varStatus="vs">
				    	<tr>
				      		<th scope="row">${review.reviewNo}</th>
				      		<td>
				      			<a 
				      				class="font-weight-bold text-decoration-none review-title"
				      				href="${pageContext.request.contextPath}/community/review/reviewDetail?reviewNo=${review.reviewNo}">
				      				<c:choose>
										<c:when test="${fn:contains(review.title, '<')}">
									     	${fn:replace(review.title, '<', '&lt;')}
										</c:when>
										<c:when test="${fn:contains(review.title, '>')}">
											${fn:replace(review.title, '>', '&gt;')}
										</c:when>
										<c:when test="${fn:contains(review.title, newLine)}">
											${fn:replace(review.title, newLine, br)}
										</c:when>
										<c:otherwise>
											${review.title}
										</c:otherwise>
									</c:choose> (${review.commentCount})
				      			</a>
				      		</td>
				     		<td>${review.member.nickname}</td>
				      		<td>${review.reviewGrade}</td>
				      		<td>${review.recommendCount}</td>
				      		<td>${review.readCount}</td>
				      		<td>
								<fmt:parseDate value="${review.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
								<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
							</td>
				    	</tr>
					</c:forEach>
				</c:if>
		  	</tbody>
		</table>
		<div class="my-5">
			<c:if test="${not empty list}">${pagebar}</c:if>
		</div>
	</div>
</div>
<script>
/**
 * 후기 등록 페이지 이동
 */
document.querySelector("#communityEnrollBtn").addEventListener('click', (e) => {
	location.href = "${pageContext.request.contextPath}/community/review/reviewEnroll";
});
</script>
<script src="${pageContext.request.contextPath}/resources/js/community/review/reviewValidation.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>