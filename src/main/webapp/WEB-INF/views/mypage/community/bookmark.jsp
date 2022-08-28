<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/community/bookmark.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/advertiser.css" />

<div class="container">
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5">
			<div class="bookmartPageWrapper mx-auto">
				<h2>관심캠핑장</h2>
				<div class="listWrapper px-5 py-2">
					<c:if test="${empty bookmarkList}">
						<div class="mx-auto my-5 d-flex flex-column align-items-center justify-content-center emptyBookmark">
							<i class="fa-regular fa-face-sad-tear my-2"></i>
							<p class="my-2 text-center">관심캠핑장이<br/>없어요</p>
						</div>
						<div class="mx-auto d-flex flex-column align-items-center justify-content-center gotoFindCampsite">
							<a href="${pageContext.request.contextPath}/campsite/searchDetail" class="d-flex align-items-center">
								<i class="fa-solid fa-angles-right mx-2" ></i>캠핑장 둘러보기
							</a>
						</div>
					</c:if>
					<c:forEach items="${bookmarkList}" var="bookmark">
						<div class="row bookmarkWrapper py-4">
							<div class="imgWrapper d-flex justify-content-center align-items-center">
								<c:if test="${bookmark.campsite.firstImageUrl ne null}">
									<img class="campsiteImg" src="${bookmark.campsite.firstImageUrl}" alt="${bookmark.campsite.facltNm} 대표 이미지" />
								</c:if>
								<c:if test="${bookmark.campsite.firstImageUrl eq null}">
									<div class="d-flex flex-column align-items-center">
										<i class="fa-regular fa-face-sad-tear mt-2"></i>
										<p class="my-1 text-center">이미지를<br/>찾을 수 없어요</p>
									</div>
								</c:if>
							</div>
							<div class="col campsiteInfo">
								<h5 class="mt-2 mb-3 campsiteName">
									<a href="${pageContext.request.contextPath}/campsite/infoView?contentId=${bookmark.contentId}">
										${bookmark.campsite.facltNm}
									</a>
								</h5>
								<h6 class="pt-2 campsiteIntro">${bookmark.campsite.lineIntro}</h6>
								<div class="d-flex detailInfo mt-4">
									<div>
										<i class="fa-solid fa-location-dot"></i>
										<span class="campsiteAddr">${bookmark.campsite.addr1}</span>
									</div>
									<div>
										<c:if test="${bookmark.campsite.tel ne null}">
											<i class="fa-solid fa-phone"></i>
											<span class="campsiteTel">${bookmark.campsite.tel}</span>
										</c:if>
									</div>
								</div>
							</div>
							<div class="col-2 btnWrapper d-flex justify-content-center align-items-center">
								<button type="button" class="bmStatusBtn">
									<i class="fa-solid fa-heart" data-content-id="${bookmark.contentId}"></i><!-- fa-regular -->
								</button>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:if test="${not empty bookmarkList}">
					<div class="mt-5 pagebar">${pagebar}</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
<sec:authentication property="principal" var="loginMember" scope="page"/>
<script>
const headers = {
	"${_csrf.headerName}" : "${_csrf.token}"
};
	
document.querySelectorAll('.bmStatusBtn i').forEach((icon) => {
	icon.addEventListener('click', (e) => {
		const contentId = e.target.dataset.contentId;
		
		$.ajax({
			url : '${pageContext.request.contextPath}/campsite/deleteBookmark',
			type : 'POST',
			headers,
			data : {
				contentId,
				memberId : '${loginMember.memberId}'
			},
			success(response) {
				location.reload();
			},
			error: console.log
		});
	});
})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />