<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kh.campervalley.community.review.model.dto.CampsiteReviewExt" %>
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
<style>
.detail-photo {border-radius: 5px; cursor: pointer;	transition: 0.3s;}
.detail-photo:hover {opacity: 0.7;}
.photo-modal {display: none; position: fixed; z-index: 2000; padding-top: 100px; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0,0,0); background-color: rgba(0,0,0,0.9);}
.modal-content {margin: auto; display: block; width: 80%; max-width: fit-content; animation-name: zoom; animation-duration: 0.6s;}
@keyframes zoom { from {transform: scale(0)} to {transform: scale(1)} }
.modal-close {position: absolute; top: 15px; right: 35px; color: #f1f1f1; font-size: 40px; font-weight: bold; transition: 0.3s;}
.modal-close:hover, .modal-close:focus {color: #bbb; text-decoration: none; cursor: pointer;}
@media only screen and (max-width: 700px) {	.modal-content {width: 100%;} }
</style>

<!-- Swiper -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<!-- 캠핑장후기상세 페이지 (작성자:SJ) -->
<div class="container-md campsite-review-detail-wrap pt-2">
	<jsp:include page="/WEB-INF/views/community/communityHeading.jsp"/>
	</div>
	<hr />
	<sec:authentication property="principal" var="loginMember"/>
	<div class="d-flex px-2 review-detail-heading font-weight-bold row">
		<span class="col-md text-left ml-3">
			<i class="fa-solid fa-compass"></i>&nbsp;
			<c:if test="${not empty loginMember && loginMember.memberId eq review.memberId}">
				<a 
					class="text-decoration-none" 
					onMouseOver="this.innerHTML='마이페이지 바로가기'" 
					onMouseOut="this.innerHTML='${review.member.nickname}'" 
					href="${pageContext.request.contextPath}/mypage/info/main">
					${review.member.nickname} 
				</a>
			</c:if>
			<c:if test="${not empty loginMember && loginMember.memberId ne review.memberId}">
				<a 
					class="text-decoration-none" 
					onMouseOver="this.innerHTML='${review.member.nickname}님의 게시글 보러가기'" 
					onMouseOut="this.innerHTML='${review.member.nickname}'" 
					href="${pageContext.request.contextPath}/community/review/reviewList?searchType=nickname&searchKeyword=${review.member.nickname}">
					${review.member.nickname}
				</a>
			</c:if>
		</span>
		<span class="col-md text-right mr-3">
			<fmt:parseDate value="${review.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
			<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>&nbsp;(조회수:${review.readCount})
		</span>
	</div>
	<hr />
	<div class="review-detail-content-wrap m-auto mb-4 pb-3">
		<div class="detail-title py-3 my-2">
			<h5 class="font-weight-bold m-0">${review.title}</h5>
		</div>
		<div class="detail-content-wrap shadow p-4 bg-light rounded font-weight-bold row">
			<div class="detail-content-table col m-auto">
				<table class="table table-borderless m-0">
					<tr>
						<th>캠핑장명</th>
						<td>${review.facltNm}</td>
					</tr>
					<tr>
						<th>이용기간</th>
						<td>${review.stay}</td>
					</tr>
					<tr>
						<th>평점</th>
						<td>
						  	<div class="review-grade-list">
				        		<span class="fa fa-star-o" data-rating="1"></span>
				        		<span class="fa fa-star-o" data-rating="2"></span>
				        		<span class="fa fa-star-o" data-rating="3"></span>
				        		<span class="fa fa-star-o" data-rating="4"></span>
				        		<span class="fa fa-star-o" data-rating="5"></span>
				        		<input type="hidden" class="review-grade" id="reviewGrade" name="reviewGrade" value="${review.reviewGrade}">
				      		</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="detail-tag-list col">
				<ul class="text-center p-0 m-0">
					<c:forEach items="${review.merit}" var="merit">
						<li class="badge badge-yellow my-2">#${merit}</li>
						<br />
					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- Photo Swiper -->
		<c:if test="${not empty photoList}">
			<div class="swiper-container detail-photo-list">
				<div class="swiper-wrapper">
					<c:forEach items="${photoList}" var="photo">
						<div class="swiper-slide">
							<img class="detail-photo" src="${pageContext.request.contextPath}/resources/upload/community/review/${photo.renamedFilename}" alt="${photo.originalFilename}">
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
			</div>
			<!-- Photo Modal -->
			<div id="photoModal" class="modal photo-modal">
			  	<span class="modal-close" onclick="photoModalClose();">&times;</span>
			  	<img class="modal-content" id="photoModalContent">
			</div>
		</c:if>
		<c:if test="${empty photoList}">
			<div class="p-3 m-3"></div>
		</c:if>
		<div class="detail-content p-4 bg-light rounded">
			${review.content}
		</div>
		<form:form 
			name="reviewDeleteFrm" 
			method="POST" 
			action="${pageContext.request.contextPath}/community/review/reviewDelete">
			<input type="hidden" name="reviewNo" id="reviewNo" value="${review.reviewNo}" />
		</form:form>
		<!-- status가 'Y'일 경우 active 활성화 -->
		<c:if test="${not empty loginMember && loginMember.memberId ne review.memberId}">
			<form:form name="reviewRecommendFrm">
				<input type="hidden" name="reviewNo" id="reviewNo" value="${review.reviewNo}" />
				<input type="hidden" name="memberId" id="memberId" value="${loginMember.memberId}" />
				<div class="text-center mt-3 pt-3">
					<c:choose>
						<c:when test="${recommend.status eq 'N'}">
							<button type="button" id="recommendBtn" class="btn btn-outline-primary btn-outline-camper-blue" onclick="recommend();">
								<i class="fa-regular fa-thumbs-up"></i>&nbsp;추천하기
							</button>
						</c:when>
						<c:when test="${recommend.status eq 'Y'}">
							<button type="button" id="recommendBtn" class="btn btn-outline-primary btn-outline-camper-blue active" onclick="recommend();">
								<i class="fa-regular fa-thumbs-up"></i>&nbsp;추천완료
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" id="recommendBtn" class="btn btn-outline-primary btn-outline-camper-blue" onclick="recommend();">
								<i class="fa-regular fa-thumbs-up"></i>&nbsp;추천하기
							</button>
						</c:otherwise>
					</c:choose>
				</div>
			</form:form>
		</c:if>
	</div>
	<hr />
	<c:if test="${not empty loginMember && loginMember.memberId eq review.memberId}">
		<div class="text-center m-3 p-3">
			<input 
				type="submit" 
				class="btn btn-outline-success btn-outline-camper-color px-4" 
				onclick="location.href='${pageContext.request.contextPath}/community/review/reviewUpdate?reviewNo=${review.reviewNo}';" 
				value="후기수정">
			<input type="button" class="btn btn-outline-danger btn-outline-camper-red ml-1 px-4" onclick="reviewDelete();" value="후기삭제">
		</div>
	</c:if>
	<!-- 후기 댓글 -->
	<jsp:include page="/WEB-INF/views/community/review/reviewComment.jsp"/>
</div>
<script>
/**
 * 후기 추천
 */
const recommend = () => {
	const headers = {
		"${_csrf.headerName}" : "${_csrf.token}"
	};
		
	const inputReviewNo = document.querySelector("input[name=reviewNo]");
	const reviewNo = inputReviewNo.value;
	
	const inputMemberId = document.querySelector("input[name=memberId]");
	const memberId = inputMemberId.value;
			
	$.ajax({
		url : "${pageContext.request.contextPath}/community/review/recommend",
		type : "POST",
		headers,
		data : {
			reviewNo, memberId
		},
		success : function(response) {
			$.alert({
			    content: '후기 추천이 업데이트되었습니다.',
			    buttons: {'확인': function() {
					location.reload();
			    }}
			});
		},
		error : console.log
	});
}

/**
 * 캠핑장 후기 삭제
 */
const reviewDelete = () => {
	const bool = $.confirm({
		title: '',
	    content: '정말 삭제하시겠습니까?',
	    buttons: {
	        '확인': function () {
	        	const frm = document.reviewDeleteFrm;
	    		frm.submit();
	        },
	        '취소': function () {
	        	$.alert({
				    title: '',
				    content: '삭제를 취소했습니다.',
				    buttons: {'확인': function() {
						return;
				    }}
				});
	        }
	    }
	});
};

/**
 * 이미지 클릭시 모달창 실행
 */
let photoModal = document.getElementById("photoModal");
let photoModalContent = document.getElementById("photoModalContent");

document.querySelectorAll('.detail-photo').forEach((photo) => {
	photo.addEventListener('click', (e) => {
		photoModal.style.display = "block";
		photoModalContent.src = e.target.src;
	});
});

let modalClose = document.getElementsByClassName("modal-close")[0];
const photoModalClose = () => {
	photoModal.style.display = "none";
};

$('.photo-modal').click(function() {
	$('#photoModal').hide();
});

/**
 * 리뷰평점 개수 제어
 */
let $reviewGradeList = $('.review-grade-list .fa');

let setReviewGrade = function() {
	return $reviewGradeList.each(function() {
		if (parseInt($reviewGradeList.siblings('input.review-grade').val()) >= parseInt($(this).data('rating'))) {
			return $(this).removeClass('fa-star-o').addClass('fa-star');
		} else {
			return $(this).removeClass('fa-star').addClass('fa-star-o');
		}
	});
};

setReviewGrade();

/**
 * 후기 이미지 제어
 */
new Swiper('.swiper-container', {
	slidesPerView : 3,
	spaceBetween : 10,
	slidesPerGroup : 3,
	debugger: true,
	mousewheel: true,
	loopFillGroupWithBlank : true,
	loop : true,
	navigation : {
		nextEl : '.swiper-button-next',
		prevEl : '.swiper-button-prev'
	}
});
</script>
<script src="${pageContext.request.contextPath}/resources/js/community/review/reviewValidation.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>