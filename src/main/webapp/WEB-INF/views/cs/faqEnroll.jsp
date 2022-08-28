<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cs/cs.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<div class="container" style="width: 870px;">            
	<h5 class="cs-header text-center">FAQ 등록</h5>                          
<form:form name="faqEnrollFrm" action="${pageContext.request.contextPath}/cs/faqEnroll" method="POST" class="form-horizontal">

	<div class="notice-wrap" style="width: 50%; float:none; margin:0 auto"></div>
	<table class="table" id="tb-notice-enroll" style="margin-top: 47px;">

		<tr>
			<th>제목</th>                                     
			<td><input type="text" class="form-control" name="title" value=""></td>
		</tr>
		<tr>
			<th>내용</th>                                    
			<td><textarea rows="10" class="form-control" name="content" style="resize: none;"></textarea></td>
		</tr>
		<tr>
			<th>작성자</th>
			<sec:authentication property="principal" var="loginMember" scope="page"/>                                    
			<td><input type="text" class="form-control" value="${loginMember.nickname}" readonly></td>
		</tr>
	</table>
	<div class="d-flex justify-content-center">
	<button class="btn btn-secondary btn-sm" type="button" style="margin-right:10px;" onclick="location.href='${pageContext.request.contextPath}/cs/faq';">취소</button>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="memberId" value="${loginMember.memberId}" /> 
	<button class="btn btn-primary btn-sm" type="submit">등록하기</button>
	</div>
</form:form>
	</div>
<script>
document.faqEnrollFrm.onsubmit = (e) => {
	const frm = e.target;
	console.log(frm);
	const titleVal = frm.title.value.trim();
	if(!/^.+$/.test(titleVal)) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '제목을 입력해주세요.',
		    buttons: {
		    	'확인': function() {}
		    }
		});
		frm.title.select();
		return false;
	}
	const contentVal = frm.content.value.trim();
	if(!/^(.|\n)+$/.test(contentVal)) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '내용을 입력해주세요.',
		    buttons: {
		    	'확인': function() {}
		    }
		});
		frm.content.select();
		return false;
	}
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>