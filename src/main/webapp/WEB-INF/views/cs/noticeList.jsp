<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cs/cs.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
.bar-notice {color: black !important;}
</style>

<h5 class="cs-header text-center">공지사항</h5>

<div class="notice-wrap" style="width: 85%; float:none; margin:0 auto">
	
	<div class="cs-bar float-left">
		<a href="${pageContext.request.contextPath}/cs/noticeList" class="bar-notice">공지사항</a>
		<a href="${pageContext.request.contextPath}/cs/faq" class="bar-faq">자주 묻는 질문</a>
	</div>
	
		<div class="search-group float-right">
		<select id="search-type">
            <option value="title" ${map.searchType eq 'title' ? 'selected' : ''}>제목</option>
            <option value="content" ${map.searchType eq 'content' ? 'selected' : ''}>내용</option>
        </select>
        	<input type="hidden" name="searchType" value="title">
			<input type="hidden" name="searchType" value="content">
			<input class="input-search" type="text" placeholder="검색어를 입력하세요." name="searchKeyword" id="searchKeyword">
			<button class="btn-search" type="button" id="searchButton">
				<i class="fa fa-search"></i>
			</button>
		</div>
	
<div class="container h-60" id="tb-notice" style="padding: 0px;">
	<table class="table text-center">
		<thead>
			<tr>
				<th class="col-md-1">No.</th>
				<th>제목</th>
				<th class="col-md-2">날짜</th>
				<th class="col-md-1">조회수</th>
			</tr>
		</thead>
		<c:if test="${empty list}">
						<td colspan="4">등록된 글이 없습니다.</td>
					</c:if>
		<c:forEach items="${list}" var="list" varStatus="vs">
			<tr>
				<td>${list.noticeNo}</td>
				<td><a href="${pageContext.request.contextPath}/cs/noticeDetail?noticeNo=${list.noticeNo}">${list.title}</a></td>
				<td>
					<fmt:parseDate value="${list.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
					<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${list.readCount}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	 <sec:authorize access="hasRole('ADMIN')">
	<button type="button" class="btn btn-primary btn-sm float-right" id="btn-nt-enroll" onclick="location.href='${pageContext.request.contextPath}/cs/noticeEnroll';">글등록</button>
	</sec:authorize>
</div>
</div>
<c:if test="${not empty list}">
    	<div class="mt-5" id="pageBar">${pagebar}</div>
</c:if>
<script>
document.querySelectorAll('.btn-search').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		let keyword = document.getElementById('searchKeyword').value;
		let searchType = document.getElementById('search-type').value;

		let url = "${pageContext.request.contextPath}/cs/noticeList";
		url = url + "?searchType=" + searchType;
		url = url + "&searchKeyword=" + keyword;
		location.href = url;
		console.log(url);
		
	})
})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>