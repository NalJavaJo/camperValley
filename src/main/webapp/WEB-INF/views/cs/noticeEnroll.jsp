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
<div class="container" style="width: 870px;">            
	<h5 class="cs-header text-center">공지사항 등록</h5>                          
<form:form name="noticeEnrollFrm" action="${pageContext.request.contextPath}/cs/noticeEnroll" method="post" class="form-horizontal" enctype="multipart/form-data">

	<div class="notice-wrap" style="width: 50%; float:none; margin:0 auto"></div>
	<table class="table" id="tb-notice-enroll" style="margin-top: 47px;">
		<tr>
			<th>제목</th>                                     
			<td><input type="text" class="form-control" name="title" value="" required></td>
		</tr>
		<tr>
			<th>내용</th>                                    
			<td><textarea rows="10" class="form-control" name="content" style="resize: none;" required></textarea></td>
		</tr>
		<tr>
			<th>작성자</th>                   
	        <sec:authentication property="principal" var="loginMember" scope="page"/>                 
			<td><input type="text" class="form-control" value="${loginMember.nickname}" readonly></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" class="custom-file-input" name="upFile" id="upFile1" style="width:30px; position: absolute;" multiple>
				<label class="custom-file-label" for="upFile1" style="display: block; position: relative;">파일 선택</label>
			</td>
		</tr>
	</table>
	<div class="d-flex justify-content-center">
	<button class="btn btn-secondary btn-sm" type="submit" style="margin-right:10px;" onclick="location.href='${pageContext.request.contextPath}/cs/noticeList';">취소</button>
    <input type="hidden" name="memberId" value="${loginMember.memberId}" />                   
	<button class="btn btn-primary btn-sm" type="submit">등록하기</button>
	</div>
</form:form>
	</div>
<script>

document.noticeEnrollFrm.onsubmit = (e) => {
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

document.querySelectorAll("[name=upFile]").forEach((input) => {
	input.addEventListener('change', (e) => {
		const [file] = e.target.files;
		console.log(file);
		const label = e.target.nextElementSibling;
		console.log(label);
		
		if(file) {
			const {name} = file;
			label.innerText = name;
		}
		else {
			label.innerText = "파일을 선택하세요.";
		}
	});
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>