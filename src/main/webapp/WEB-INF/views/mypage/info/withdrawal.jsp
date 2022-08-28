<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/info/edit.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">	
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5 mt-2" id="edit-container">
			<h4 class="">
				회원탈퇴
			</h4>
			<div class=" px-2 border-top border-bottom my-4 pt-4 mr-5">
				<h6 class="font-weight-bold">
	            회원탈퇴 신청 전 확인해 주세요.
	            </h6>
	            <p class="mt-3 pb-3" style="font-size: 14px;">
	            	탈퇴 후 회원정보 및 이용 기록은 모두 삭제되며, 다시 복구할 수 없습니다.
	                작성하신 게시글 및 댓글은 탈퇴시 자동으로 삭제되지 않습니다. 삭제를원하시는 게시글이 있다면 반드시 탈퇴 전 삭제하시기 바랍니다.
	                이상의 내용에 동의하여 탈퇴를 원하실 경우, 아래의 "<strong>회원 탈퇴</strong>" 버튼을 클릭해주세요. 
	            </p>
			</div>
	        <div class="text-center">
	        	<form:form style="display:contents">
		            <button class="btn btn-success px-4">
		            	회원탈퇴
		            </button>
	        	</form:form>
	    	</div>
        </div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />