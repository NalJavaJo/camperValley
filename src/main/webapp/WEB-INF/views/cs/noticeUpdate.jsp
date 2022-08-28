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
	<h5 class="cs-header text-center">공지사항 수정</h5>                          
<form:form name="noticeUpdateFrm" action="${pageContext.request.contextPath}/cs/noticeUpdate" method="post" class="form-horizontal" enctype="multipart/form-data">

	<div class="notice-wrap" style="width: 50%; float:none; margin:0 auto"></div>
	<table class="table" id="tb-notice-enroll" style="margin-top: 47px;">

		<tr>
			<th>제목</th>                                     
			<td><input type="text" class="form-control" name="title" value="${notice.title}" required></td>
		</tr>
		<tr>
			<th>내용</th>                                    
			<td><textarea rows="10" class="form-control" name="content" style="resize: none;" required>${notice.content}</textarea></td>
		</tr>
		<tr>
			<th>작성자</th>                                    
			<td><input type="text" class="form-control" name="memberId" value="" readonly required></td>
		</tr>
		<tr>
			<th>첨부파일 삭제</th>                                    
			<td>
			
                <c:if test="${not empty notice.attachments}">
			<c:forEach items="${notice.attachments}" var="attach" varStatus="vs">
				<div class="btn-group-toggle p-0 mb-3" data-toggle="buttons">
	            	<label class="btn btn-outline-danger btn-block" title="${attach.originalFilename} 삭제">
	                	<input type="checkbox" id="delFile${vs.count}" name="delFile" value="${attach.noticeAttachNo}">
						<c:if test="${fn:length(attach.originalFilename) ge 30}">
							${fn:substring(attach.originalFilename, 0, 30)}... 삭제
						</c:if> 
						<c:if test="${fn:length(attach.originalFilename) lt 30}">
							${attach.originalFilename} 삭제
						</c:if>
	            	</label>
	        	</div>
			</c:forEach>
		</c:if>
		
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" class="custom-file-input" name="upFile" id="upFile1" style="position: absolute;"multiple>
				<label class="custom-file-label" for="upFile1" style="display: block; position: relative;">파일 선택</label>
			</td>
		</tr>
	</table>
					
	<div class="d-flex justify-content-center">
	<button class="btn btn-secondary btn-sm" type="button" style="margin-right:10px;" onclick="location.href='${pageContext.request.contextPath}/cs/noticeList';">취소</button>
	<input type="hidden" name="noticeNo" value="${notice.noticeNo}"/>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<button class="btn btn-primary btn-sm" type="submit">수정하기</button>
	</div>
</form:form>
	</div>
<script>
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

document.noticeUpdateFrm.onsubmit = (e) => {
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