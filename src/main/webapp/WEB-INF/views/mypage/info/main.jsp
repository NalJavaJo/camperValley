<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/info/main.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<c:set var="profileFileName" value="${empty loginMember.profileImg ? 'default-profile.svg' : loginMember.profileImg}"/>

<div class="container">	
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 pl-5 mt-4" id="mypage-main-container">
		<%-- 본문시작 --%>
		<div class="px-4">
		  <div class="row justify-content-between" >
               <div class="col-md-6 align-self-center border-right pl-4 font-weight-bold">
                   <div class="rounded-circle" id="profileImg-wrp">
                    	<img alt="${loginMember.nickname}님의 프로필사진" src="${pageContext.request.contextPath}/resources/upload/member/${profileFileName}" id="profileImg"/>
                    </div >
                    	<span id="nickname" class="d-block">${loginMember.nickname}</span>
                    <a href="${pageContext.request.contextPath}/mypage/info/edit"  class="shadow-sm btn btn-camper d-block mt-3 ml-2 mb-2">
                        회원정보 수정
                    </a>
                </div>
                <div class="col-md-6 pl-4 ">
                    <h4 class="ml-3 mt-y mb-3 ">
                        중고거래 내역
                    </h4>
                    <div class="row text-center">
                        <div class="col-md-4 ">
                            <div class="m-4">
	                            <a href="${pageContext.request.contextPath}/mypage/trade/selling">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="#639A67" class="bi bi-currency-dollar" viewBox="0 0 16 16">
									  <path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718H4zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73l.348.086z"/>
									</svg>
								</a>
                            </div>
                            <a href="${pageContext.request.contextPath}/mypage/trade/selling" class="font-weight-bold">
                           		판매내역
                            </a>
                        </div>
                        <div class="col-md-4">
                            <div class="m-4">
	                            <a href="${pageContext.request.contextPath}/mypage/trade/purchased">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="#639A67" class="bi bi-bag-fill" viewBox="0 0 16 16">
									  <path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1zm3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4h-3.5z"/>
									</svg>
								</a>
                            </div>
                            <a href="${pageContext.request.contextPath}/mypage/trade/purchased" class="font-weight-bold">
                            	구매내역
                            </a>
                        </div>
                        <div class="col-md-4">
                            <div class="m-4">
	                            <a href="${pageContext.request.contextPath}/mypage/trade/wish">
									<i class="fa-solid fa-heart camper-color"></i>
								</a>
                            </div>
                            <a href="${pageContext.request.contextPath}/mypage/trade/wish" class="font-weight-bold">
                            	관심상품
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-12 d-flex justify-content-between p-0 pt-5 mt-5 mb-3">
                        <h4 class="mb-3 pt-2 ">
                            관심캠핑장
                        </h4> 
                        <a type="button" class="btn btn-link" href="${pageContext.request.contextPath}/mypage/community/bookmark">
                            >> 더보기
                        </a>
                    </div>
                    <div class="listWrapper px-3 py-2">
						<c:if test="${empty bookmarkList}">
						<div class="text-center">등록하신 관심 캠핑장이 존재하지 않습니다.</div>
			            </c:if>
                    <c:forEach items="${bookmarkList}" var="bookmark">
						<div class="row bookmarkWrapper pt-3 pb-4">
							<div class="col-2 pl-3 d-flex align-items-center" id="imgWrapper">
								<div class="imgWrapper border" style="cursor: pointer;">
									<a href="http://localhost:9090/campervalley/campsite/infoView?contentId=${bookmark.contentId}">
										<c:if test="${bookmark.campsite.firstImageUrl ne null}">
											<img class="campsiteImg" src="${bookmark.campsite.firstImageUrl}" 
											 alt="${bookmark.campsite.facltNm}대표사진" />
										</c:if>
										<c:if test="${bookmark.campsite.firstImageUrl eq null}">
											<div class="d-flex flex-column align-items-center">
												<i class="fa-regular fa-face-sad-tear"></i>
												<p class="my-2 text-center">이미지를<br/>찾을 수 없어요</p>
											</div>
										</c:if>
									</a>
								</div>
							</div>
						<div class="col campsiteInfo p-0 pl-3 pt-2">
							<a href="http://localhost:9090/campervalley/campsite/infoView?contentId=${bookmark.contentId}">
								<h5 class="mb-3 campsiteName">${bookmark.campsite.facltNm}</h5>
							</a>
							<h6 class="pt-2 campsiteIntro">${bookmark.campsite.lineIntro}</h6>
							<div class="d-flex detailInfo mt-4">
								<div>
									<i class="fa-solid fa-location-dot"></i>
									&nbsp;<span class="campsiteAddr">${bookmark.campsite.addr1}</span>
								</div>
								<div>
									<i class="fa-solid fa-phone"></i>
									<span class="campsiteTel">
										&nbsp;${empty bookmark.campsite.tel ? '전화번호가 등록되어 있지 않습니다.' : bookmark.campsite.tel}</span>
								</div>
							</div>
						</div>
					</div>
					</c:forEach>
				</div>
	            <div class="row">
	                <div class="col-md-12 mt-5">
	                    <div class="col-md-12  d-flex justify-content-between p-0 mt-5">
	                        <h4 class="mb-4">
	                            작성후기
	                        </h4> 
	                        <a href="${pageContext.request.contextPath}/mypage/community/myReview" type="button" class="btn btn-link">
	                            >> 더보기
	                        </a>
	                    </div>
	                </div>
	                <div class="col-md-12">
	                    <table class="table table-hover border-bottom">
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
	                            </tr>
	                        </thead>
	                        <tbody>
		                        <c:if test="${empty reviewList}">
				                    <tr>
				                		<td colspan="6" class="text-center">작성하신 글이 존재하지 않습니다.</td>
				                	</tr>
		                        </c:if>
		                        <c:forEach items="${reviewList}" var="review" varStatus="vs">
		                            <tr data-no="${board.no}">
		                                <td class="text-left">
		                                    	<c:out value="${review.title}"/>[${review.commentCount}]
		                                </td>
				                        <td class="text-left">
				                          <c:out value="${review.facltNm}"/>
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
		                            </tr>
		                        </c:forEach>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	            <div class="row mt-3 mb-5">
	                <div class="col-md-12">
	                    <div class="col-md-12 d-flex justify-content-between p-0 mt-5">
	                        <h4 class="mb-4">
	                            캠퍼모집
	                        </h4> 
	                        <a type="button" class="btn btn-link" href="${pageContext.request.contextPath}/mypage/community/myCamper">
	                            >> 더보기
	                        </a>
	                    </div>
							<table class="table table-hover text-center border-bottom" id="#my-camper-table">
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
				                    </tr>
				                </thead>
				                <tbody>
					                <c:if test="${empty camperList}">
								    	<tr>
								        	<td colspan="5" class="text-center">작성하신 글이 존재하지 않습니다.</td>
								        </tr>
						            </c:if>
						            <c:forEach items="${camperList}" var="camper" varStatus="vs">
					                    <tr>
					                        <td>
												<c:if test="${camper.status eq 'I'}">
													모집중
												</c:if>
												<c:if test="${camper.status eq 'C'}">
													모집완료
												</c:if>
					                        </td>
					                        <td class="text-left">
					                            <span class="title" data-toggle="modal" data-target="#camper-detail">
					                            	<c:out value="${fn:substring(camper.title,0,22)}"/>
					                            	<c:if test="${fn:length(camper.title) > 22}">
					                            	..
					                            	</c:if>	
					                            </span>
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
						                    </tr>
										</c:forEach>
				                	</tbody>
				            	</table>          
							</div>
	                	</div>
	            	</div>
	         	</div>          
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>