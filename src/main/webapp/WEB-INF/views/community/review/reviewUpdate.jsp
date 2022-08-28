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
<%
	CampsiteReviewExt review = (CampsiteReviewExt) request.getAttribute("review");
	String[] merits = review.getMerit();
	List<String> meritList = merits != null ? Arrays.asList(merits) : null;
	pageContext.setAttribute("meritList", meritList);
%>
<style>
body {overflow-y: auto!important;}
</style>

<!-- Date Range Picker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- jQuery UI -->
<script
	src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"
	integrity="sha256-xLD7nhI62fcsEZK2/v8LsBcb4lG7dgULkuXoXB/j91c="
	crossorigin="anonymous"></script>
<script
	src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"
	integrity="sha256-lSjKY0/srUM9BE3dPm+c4fBo1dky2v27Gdjm2uoZaL0="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<!-- 캠핑장후기수정 페이지 (작성자:SJ) -->
<div class="container-md campsite-review-update-wrap pt-2">
	<jsp:include page="/WEB-INF/views/community/communityHeading.jsp"/>
	</div>
	<hr />
	<div class="d-flex px-2 review-update-heading">
		<h5 class="font-weight-bold m-0">캠핑장 후기 수정</h5>
		<span class="ml-3 required-red">* 표시가 된 곳은 필수 입력사항입니다.</span>
	</div>
	<hr />
	<div class="review-update-form-wrap mb-4 pb-4">
		<form:form 
			name="reviewUpdateFrm" 
			method="POST" 
			action="${pageContext.request.contextPath}/community/review/reviewUpdate"
			enctype="multipart/form-data">
			<div class="form-group row">
				<div class="form-group col display-contents">
				  	<label for="name" class="col-md-1 col-form-label font-weight-bold">작성자</label>
				  	<div class="col-md-5">
				  		<sec:authentication property="principal" var="loginMember"/>
				    	<input type="text" class="form-control" id="nickname" name="nickname" value="${loginMember.nickname}" readonly>
				  		<input type="hidden" name="memberId" id="memberId" value="${loginMember.memberId}"/>
				  	</div>
				</div>
				<div class="form-group col display-contents">
				  	<label for="reviewGrade" class="col-md-1 col-form-label font-weight-bold">
				  		평점<sup class="required-red">*</sup>
				  	</label>
				  	<div class="col-md-5 review-grade-list">
		        		<span class="fa fa-star-o" data-rating="1"></span>
		        		<span class="fa fa-star-o" data-rating="2"></span>
		        		<span class="fa fa-star-o" data-rating="3"></span>
		        		<span class="fa fa-star-o" data-rating="4"></span>
		        		<span class="fa fa-star-o" data-rating="5"></span>
		        		<input type="text" class="review-grade" id="reviewGrade" name="reviewGrade" value="${review.reviewGrade}" required>
		      		</div>
				</div>
			</div>
			<div class="form-group row">
				<div class="form-group col display-contents">
				  	<label for="facltNm" class="col-md-1 col-form-label font-weight-bold">
				  		캠핑장명<sup class="required-red">*</sup>
				  	</label>
				  	<div class="col-md-5">
				  		<input 
				  			type="text" 
				  			class="form-control text-left" 
				  			id="facltNm" 
				  			name="facltNm" 
				  			value="${review.facltNm}"
				  			placeholder="이용하신 캠핑장을 선택해주세요."
				  			data-toggle="modal" 
				  			data-target="#facltNmModal"
				  			required/>
				  		<input type="hidden" class="contentId" id="contentId" name="contentId" value="${review.contentId}">
				  	</div>
				</div>
				<!-- facltNmModal start -->
				<div class="modal fade" id="facltNmModal" tabindex="-1" aria-labelledby="facltNmModalLabel" aria-hidden="true">
				  	<div class="modal-dialog modal-dialog-centered">
				    	<div class="modal-content">
				      		<div class="modal-header">
				        		<h5 class="modal-title" id="facltNmModalLabel">캠핑장 선택</h5>
				        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          			<span aria-hidden="true">&times;</span>
				        		</button>
				      		</div>
					      	<div class="modal-body">
					        	<div>
								    <label for="autoComplete">캠핑장명</label>
								    <input type="text" class="form-control" id="autoComplete" aria-describedby="autoComplete" placeholder="이용하신 캠핑장명을 입력하세요.">
								</div>
					      	</div>
					      	<div class="modal-footer">
					        	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					        	<button type="button" class="btn btn-success btn-camper-color" id="facltNmSelect">선택</button>
					      	</div>
				    	</div>
				  	</div>
				</div>
				<!-- facltNmModal end -->
				<div class="form-group col display-contents">
				  	<label for="name" class="col-md-1 col-form-label font-weight-bold">
				  		이용기간<sup class="required-red">*</sup>
				  	</label>
				  	<div class="col-md-5">
						<div class="mb-0">
						    <input 
						    	class="form-control form-control-solid" 
						    	id="stay"
						    	name="stay" 
						    	value="${review.stay}"
						    	placeholder="이용기간을 선택하세요."
						    	required/>
						</div>
				  	</div>
				</div>
			</div>
			<div class="form-group col text-center my-3">
				<label class="col col-form-label font-weight-bold">이런 점이 좋았어요.</label>
				<div class="col py-3">
					<div class="form-check form-check-inline">
				  		<input class="form-check-input" type="checkbox" name="merit" id="merit0" value="시설물이 깨끗해요." ${meritList.contains('시설물이 깨끗해요.') ? 'checked' : ''}>
				  		<label class="form-check-label" for="merit0">시설물이 깨끗해요.</label>
					</div>
					<div class="form-check form-check-inline">
				  		<input class="form-check-input" type="checkbox" name="merit" id="merit1" value="사장님이 친절해요." ${meritList.contains('사장님이 친절해요.') ? 'checked' : ''}>
				  		<label class="form-check-label" for="merit1">사장님이 친절해요.</label>
					</div>
					<div class="form-check form-check-inline">
				  		<input class="form-check-input" type="checkbox" name="merit" id="merit2" value="매너타임이 잘 준수되고 있어요." ${meritList.contains('매너타임이 잘 준수되고 있어요.') ? 'checked' : ''}>
				  		<label class="form-check-label" for="merit2">매너타임이 잘 준수되고 있어요.</label>
					</div>
					<div class="form-check form-check-inline">
				  		<input class="form-check-input" type="checkbox" name="merit" id="merit3" value="가족/아이들과 함께 이용하기 좋아요." ${meritList.contains('가족/아이들과 함께 이용하기 좋아요.') ? 'checked' : ''}>
				  		<label class="form-check-label" for="merit3">가족/아이들과 함께 이용하기 좋아요.</label>
					</div>
					<div class="form-check form-check-inline">
				  		<input class="form-check-input" type="checkbox" name="merit" id="merit4" value="놀이시설이 많아요." ${meritList.contains('놀이시설이 많아요.') ? 'checked' : ''}>
				  		<label class="form-check-label" for="merit4">놀이시설이 많아요.</label>
					</div>
				</div>
			</div>
			<hr class="my-4" />
		    <div class="form-group row">
			  	<label for="title" class="col-md-1 col-form-label font-weight-bold">
			  		제목<sup class="required-red">*</sup>
			  	</label>
			  	<div class="col-md-11">
			    	<input 
			    		type="text" 
			    		class="form-control" 
			    		id="title" 
			    		name="title" 
			    		placeholder="제목을 입력해주세요." 
			    		value="${review.title}" 
			    		required>
			  	</div>
			</div>
			<div class="form-group row">
			  	<label for="name" class="col-md-1 col-form-label font-weight-bold">
			  		내용<sup class="required-red">*</sup>
			  	</label>
			  	<div class="col-md-11">
			    	<textarea class="form-control" name="content" placeholder="내용을 입력해주세요." required>${review.content}</textarea>
			  	</div>
			</div>
			<div class="form-group row">
			  	<label for="name" class="col-md-1 col-form-label font-weight-bold">첨부파일</label>
				<div class="form-group col-md-5 mx-3 mb-0">
					<div class="input-group row mb-3">
					  	<div class="custom-file">
					    	<input type="file" class="custom-file-input" name="upFile" id="upFile" accept="image/*" multiple>
				    		<label class="custom-file-label" for="upFile">첨부파일을 선택해주세요.</label>
					  	</div>
					</div>
					<div class="input-group row mb-3">
						<c:forEach items="${review.photos}" var="photo" varStatus="vs">
							<c:if test="${not empty photo.originalFilename}">
								<div class="btn-group-toggle" data-toggle="buttons">
									<label class="btn btn-outline-danger btn-outline-camper-red delete-file-ckb-wrap" title="${photo.originalFilename} 삭제">
										<input type="checkbox" id="delFile${vs.count}" name="delFile" value="${photo.reviewPhotoNo}">
										<c:if test="${fn:length(photo.originalFilename) ge 20}">
											<span class="float-left">${fn:substring(photo.originalFilename, 0, 20)}...</span>
											<span class="float-right">삭제</span>
					                   	</c:if>
										<c:if test="${fn:length(photo.originalFilename) lt 20}">
											<span class="float-left">${photo.originalFilename}</span>
											<span class="float-right">삭제</span>
					                   	</c:if>
									</label>
				                </div>
			                </c:if>
		                </c:forEach>
		            </div>
				</div>
			</div>
			<hr />
			<div class="text-center m-3 p-3">
				<input type="hidden" name="reviewNo" value="${review.reviewNo}"/>
				<input type="button" class="btn btn-outline-secondary px-4" onclick="location.href='${pageContext.request.contextPath}/community/review/reviewDetail?reviewNo=${review.reviewNo}';" value="수정취소">
				<input type="submit" class="btn btn-outline-success btn-outline-camper-color ml-1 px-4" value="수정등록" >
			</div>
		</form:form>
	</div>
</div>
<script>
/**
 * 파일명 가져오기
 */
window.onload = function() {
	const target = document.getElementById('upFile');
	const label = target.nextElementSibling;
	target.addEventListener('change', () => {
		let upFileList = '';
		if(upFileList != null) {
	        for(i = 0; i < target.files.length; i++) {
	        	upFileList += target.files[i].name + ' ';
	        }
	        label.innerText = upFileList;
		}
		else {
			label.innerText = '첨부파일을 선택해주세요.';
		}
    });
}

/**
 * 캠핑장 조회 자동완성
 */
$('#autoComplete').autocomplete({
	source : function(request, response) {
		const headers = {
			"${_csrf.headerName}" : "${_csrf.token}"
		};
		
		$.ajax({
			url : "${pageContext.request.contextPath}/community/review/autoComplete",
	        type : "POST",
	        dataType : "JSON",
	        headers,
	        data : {value : request.term},
	        success : function(data) {
				response(
					$.map(data.resultList, function(item) {
						return {
							label : item.FACLT_NM,
	                        value : item.FACLT_NM,
							idx : item.CONTENT_ID
						};
					})
				);
			},
			error : console.log
		});
	},
	focus : function(event, ui) {	
		return false;
	},
	minLength: 2,
	delay: 100,
	select : function(evt, ui, idx) {
		$('#facltNmSelect').on('click', function() {
			$('#facltNm').val(ui.item.label);
			$('#contentId').val(ui.item.idx);
			$("#facltNmModal").removeClass("in");
			$(".modal-backdrop").remove();
			$("#facltNmModal").hide();
		});
	}
});

/**
 * 이용기간 선택
 */
let nowDate = new Date();
let today = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate(), 0, 0, 0, 0);
$("#stay").daterangepicker({
	autoUpdateInput: false,
	maxDate: today, // 오늘 이후 선택 금지 처리
	locale: {
		applyLabel: "선택",
        cancelLabel: "취소",
		format: "YYYY-MM-DD (ddd)",
		daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
		monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	}
}, 
function(start, end) {
	$("#stay").val(start.format("YYYY-MM-DD (ddd)") + " - " + end.format("YYYY-MM-DD (ddd)"));
});

$('#stay').on('cancel.daterangepicker', function() {
    return $(this).val('');
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

$reviewGradeList.on('click', function() {
	$reviewGradeList.siblings('input.review-grade').val($(this).data('rating'));
  	return setReviewGrade();
});

setReviewGrade();
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>