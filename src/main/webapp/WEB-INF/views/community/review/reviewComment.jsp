<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	pageContext.setAttribute("newLine", "\n"); 
	pageContext.setAttribute("br", "<br/>");
%>
<style>
.card-footer {
    position: relative;
    display: flex;
    padding:20px;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
}
.media img {
    width: 50px;
    height: 50px;
}
.reply a {
	text-decoration: none;
}
.reply-wrap {
	justify-content: right;
}
</style>

<div class="review-detail-comment-wrap m-auto py-5">
	<div class="card my-3">
  		<div class="card-header font-weight-bold m-0">
    		<i class="fa-solid fa-comments camper-color"></i>&nbsp;comments (${review.commentCount})
  		</div>
		<form:form name="commentEnrollFrm" action="${pageContext.request.contextPath}/community/review/commentEnroll" method="POST">
	  		<div class="card-body">
	  			<ul class="list-group list-group-flush">
					<li class="list-group-item">
						<div class="form-inline mb-2">
				    		<p class="card-text font-weight-bold">
				    			<i class="fa-solid fa-compass"></i>&nbsp;${loginMember.getNickname()}
				    		</p>
						</div>
						<textarea class="form-control" name="commentContent" cols="60" rows="3" placeholder="권리침해, 욕설 및 특정 대상을 비하하는 내용을 게시할 경우 이용약관 및 관련 법률에 의해 제재될 수 있습니다."></textarea>
						<input type="hidden" name="reviewNo" value="${review.reviewNo}" />
						<input type="hidden" name="memberId" value="${not empty loginMember ? loginMember.getMemberId() : ''}"/>
						<input type="hidden" name="commentLevel" value="1" />
						<input type="hidden" name="commentRef" value="0" />
						<button type="submit" class="btn btn-success btn-camper-color mt-3 float-right" id="commentEnrollBtn">등록</button>
				    </li>
				</ul>
	  		</div>
		</form:form>
		<c:if test="${not empty commentList}">
	  		<div class="card-footer">
				<div class="row p-4">
					<c:forEach items="${commentList}" var="comment">
						<div class="col-md-12 py-3">
							<c:if test="${comment.commentLevel eq 1}">
								<div class="media">
									<c:if test="${not empty comment.member.profileImg}">
										<img class="mr-3 rounded-circle" src="${pageContext.request.contextPath}/resources/upload/member/${comment.member.profileImg}"/>
									</c:if>
									<c:if test="${empty comment.member.profileImg}">
										<img class="mr-3 rounded-circle" src="${pageContext.request.contextPath}/resources/upload/member/default-profile.svg"/>
									</c:if>
									<div class="media-body">
										<div class="row">
											<div class="col-md-8 d-flex my-2">
										    	<span class="font-weight-bold">${not empty comment.member.nickname ? comment.member.nickname : '(탈퇴회원)'}</span>&nbsp;
										    	<span>
										    		<fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
													<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
										    	</span>
										 	</div>
										 	<div class="col-md-4 d-flex reply-wrap">
										 		<div class="reply">
										 			<button type="button" class="badge btn-outline-camper-color btn-reply" value="${comment.reviewCommentNo}"><i class="fa fa-reply"></i>&nbsp;답글</button>
										 			<c:if test="${not empty loginMember && loginMember.getMemberId() eq comment.memberId}">
											 			<button type="button" class="badge btn-ouline-camper-yellow btn-update" value="${comment.reviewCommentNo}"><i class="fa-solid fa-pen"></i>&nbsp;수정</button>
											 			<button type="button" class="badge btn-outline-camper-delete btn-delete" value="${comment.reviewCommentNo}"><i class="fa-solid fa-circle-minus"></i>&nbsp;삭제</button>
										 			</c:if>
											 	</div>
											</div>
											<div class="col-md-12">
												<c:choose>
													<c:when test="${fn:contains(comment.commentContent, '<')}">
												     	${fn:replace(comment.commentContent, '<', '&lt;')}
													</c:when>
													<c:when test="${fn:contains(comment.commentContent, '>')}">
														${fn:replace(comment.commentContent, '>', '&gt;')}
													</c:when>
													<c:when test="${fn:contains(comment.commentContent, newLine)}">
														${fn:replace(comment.commentContent, newLine, br)}
													</c:when>
													<c:otherwise>
														${comment.commentContent}
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${comment.commentLevel eq 2}">
								<div class="media pl-5">
									<c:if test="${not empty comment.member.profileImg}">
										<img class="mr-3 rounded-circle" src="${pageContext.request.contextPath}/resources/upload/member/${comment.member.profileImg}"/>
									</c:if>
									<c:if test="${empty comment.member.profileImg}">
										<img class="mr-3 rounded-circle" src="${pageContext.request.contextPath}/resources/upload/member/default-profile.svg"/>
									</c:if>
									<div class="media-body">
										<div class="row">
											<div class="col-md-8 d-flex my-2">
										    	<span class="font-weight-bold">${not empty comment.member.nickname ? comment.member.nickname : '(탈퇴회원)'}</span>&nbsp;
										    	<span>
										    		<fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
													<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
										    	</span>
										 	</div>
										 	<div class="col-md-4 d-flex reply-wrap">
										 		<div class="reply">
											 		<c:if test="${not empty loginMember && loginMember.getMemberId() eq comment.memberId}">
											 			<button type="button" class="badge btn-ouline-camper-yellow btn-update" value="${comment.reviewCommentNo}"><i class="fa-solid fa-pen"></i>&nbsp;수정</button>
											 			<button type="button" class="badge btn-outline-camper-delete btn-delete" value="${comment.reviewCommentNo}"><i class="fa-solid fa-circle-minus"></i>&nbsp;삭제</button>
											 		</c:if>
											 	</div>
											</div>
											<div class="col-md-12">
												<c:choose>
													<c:when test="${fn:contains(comment.commentContent, '<')}">
												     	${fn:replace(comment.commentContent, '<', '&lt;')}
													</c:when>
													<c:when test="${fn:contains(comment.commentContent, '>')}">
														${fn:replace(comment.commentContent, '>', '&gt;')}
													</c:when>
													<c:when test="${fn:contains(comment.commentContent, newLine)}">
														${fn:replace(comment.commentContent, newLine, br)}
													</c:when>
													<c:otherwise>
														${comment.commentContent}
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</div>
</div>
<form:form name="commentDeleteFrm">
	<input type="hidden" name="reviewCommentNo" />
	<input type="hidden" name="reviewNo" value="${review.reviewNo}" />
</form:form>
<script>
/**
 * 댓글/답글 수정폼 동적 생성
 */
document.querySelectorAll('.btn-update').forEach((btn) => {
	btn.onclick = (e) => {		
		const {value : reviewCommentNo} = e.target;
		console.log(reviewCommentNo);
				
		const frm = document.createElement("form");
        frm.name = "commentUpdateFrm";
        frm.action = "${pageContext.request.contextPath}/community/review/commentUpdate";
        frm.method = "POST";
		
        const outerDiv = document.createElement("div");
        outerDiv.className = "my-3";
        
        const inputReviewNo = document.createElement("input");
        inputReviewNo.type = "hidden";
        inputReviewNo.name = "reviewNo";
        inputReviewNo.value = "${review.reviewNo}";
        
        const inputCsrf = document.createElement("input");
        inputCsrf.type = "hidden";
        inputCsrf.name = "${_csrf.parameterName}";
        inputCsrf.value = "${_csrf.token}";
        
        const button = document.createElement("button");
        button.className = "btn btn-success btn-camper-color col-md-1 ml-1 p-1";
        button.id = "commentUpdateBtn";
        button.innerText = "수정";
        button.style.fontSize = ".8rem";
    	button.style.maxInlineSize = "max-content";
        
        const innerDiv = document.createElement("div");
        innerDiv.className = "d-flex col-md-12 p-0";
		        
        const textarea = document.createElement("textarea");
        textarea.className = "form-control";
        textarea.name = "commentContent";
        textarea.cols = "60";
        textarea.rows = "1";
        textarea.placeholder = "권리침해, 욕설 및 특정 대상을 비하하는 내용을 게시할 경우 이용약관 및 관련 법률에 의해 제재될 수 있습니다.";
        
        const inputReviewCommentNo = document.createElement("input");
        inputReviewCommentNo.type = "hidden";
        inputReviewCommentNo.name = "reviewCommentNo";
        inputReviewCommentNo.value = reviewCommentNo;
        
        innerDiv.append(textarea);
        innerDiv.append(button);
        outerDiv.append(innerDiv);
        outerDiv.append(inputReviewCommentNo);
        outerDiv.append(inputReviewNo);
        outerDiv.append(inputCsrf);
        frm.append(outerDiv);
        
		const target = e.target.parentElement.parentElement.parentElement;        
        target.insertAdjacentElement('afterend', frm);		
		e.target.onclick = null;
	};
});

/**
 * 댓글/답글 수정
 */
$('#commentUpdateBtn').click(function() {
	const commentData = $('[name=commentUpdateFrm]').serialize();
	
	$.ajax({
		url : '${pageContext.request.contextPath}/community/review/commentUpdate',
		method : "POST",
		headers,
		data : commentData,
		success(response) {
			$.alert({
			    title: '',
			    content: '${msg}',
			    buttons: {'확인': function() {
					location.reload();
			    }}
			});
		},
		error : console.log
	});
});

/**
 * 댓글/답글 삭제
 */
document.querySelectorAll('.btn-delete').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const bool = $.confirm({
			title: '',
		    content: '댓글을 삭제하시겠습니까?',
		    buttons: {
		        '확인': function () {
		        	const headers = {
	    				"${_csrf.headerName}" : "${_csrf.token}"
	    			};
	    			
	    			const reviewCommentNo = e.target.value;
	    			const inputReviewCommentNo = document.querySelector("input[name=reviewCommentNo]");
	    			inputReviewCommentNo.value = reviewCommentNo;
	    			
	    			const inputReviewNo = document.querySelector("input[name=reviewNo]");
	    			const reviewNo = inputReviewNo.value;
	    						
	    			$.ajax({
	    				url : '${pageContext.request.contextPath}/community/review/commentDelete',
	    				method : "POST",
	    				headers,
	    				data : {
	    					reviewCommentNo, reviewNo
	    				},
	    				success(response) {
	    					$.alert({
	    					    title: '',
	    					    content: '댓글 삭제가 완료되었습니다.',
	    					    buttons: {'확인': function() {
			    					location.reload();
	    					    }}
	    					});
	    				},
	    				error : console.log
	    			});
		        },
		        '취소': function () {
		        	$.alert({
					    title: '',
					    content: '댓글 삭제를 취소합니다.',
					    buttons: {'확인': function() {
							return;
					    }}
					});
		        }
		    }
		});
	});
});

/**
 * 답글 등록폼 동적 생성
 */
document.querySelectorAll('.btn-reply').forEach((btn) => {
	btn.onclick = (e) => {
		if(${empty loginMember}) {
			loginAlert();
			return;
		}
		
		const {value : commentRef} = e.target;
		console.log(commentRef);
		
		const frm = document.createElement("form");
        frm.name = "commentEnrollFrm";
        frm.action = "${pageContext.request.contextPath}/community/review/commentEnroll";
        frm.method = "POST";
        frm.onsubmit = commentEnrollHandler;
		
        const outerDiv = document.createElement("div");
        outerDiv.className = "card-body";
        
        const ul = document.createElement("ul");
        ul.className= "list-group list-group-flush";
        
        const li = document.createElement("li");
        li.className = "list-group-item";
        
        const innerDiv = document.createElement("div");
        innerDiv.className = "form-inline mb-2";
        
        const p = document.createElement("p");
        p.className = "card-text font-weight-bold";
        p.innerHTML = `<i class="fa-solid fa-compass"></i>&nbsp;${loginMember.getNickname()}`;
                
        const textarea = document.createElement("textarea");
        textarea.className = "form-control";
        textarea.name = "commentContent";
        textarea.cols = "60";
        textarea.rows = "3";
        textarea.placeholder = "권리침해, 욕설 및 특정 대상을 비하하는 내용을 게시할 경우 이용약관 및 관련 법률에 의해 제재될 수 있습니다.";
        
        const inputReviewNo = document.createElement("input");
        inputReviewNo.type = "hidden";
        inputReviewNo.name = "reviewNo";
        inputReviewNo.value = "${review.reviewNo}";
        
        const inputMemberId = document.createElement("input");
        inputMemberId.type = "hidden";
        inputMemberId.name = "memberId";
        inputMemberId.value = "${not empty loginMember ? loginMember.getMemberId() : ''}";
        
        const inputCommentLevel = document.createElement("input");
        inputCommentLevel.type = "hidden";
        inputCommentLevel.name = "commentLevel";
        inputCommentLevel.value = "2";
       	
        const inputCommentRef = document.createElement("input");
        inputCommentRef.type = "hidden";
        inputCommentRef.name = "commentRef";
        inputCommentRef.value = commentRef;
        
        const inputCsrf = document.createElement("input");
        inputCsrf.type = "hidden";
        inputCsrf.name = "${_csrf.parameterName}";
        inputCsrf.value = "${_csrf.token}";
        
        const button = document.createElement("button");
        button.className = "btn btn-success btn-camper-color mt-3 float-right";
        button.id = "commentReplyBtn";
        button.innerText = "등록";
        
        innerDiv.append(p);
        li.append(innerDiv);
        li.append(textarea);
        li.append(inputReviewNo);
        li.append(inputMemberId);
        li.append(inputCommentLevel);
        li.append(inputCommentRef);
        li.append(inputCsrf);
        li.append(button);
        ul.append(li);
        outerDiv.append(ul);
        frm.append(outerDiv);
        
		const target = e.target.parentElement.parentElement.parentElement;        
        target.insertAdjacentElement('afterend', frm);		
		e.target.onclick = null;
	};
});

/**
 * 댓글 등록
 */
const commentContent = document.querySelector("textarea[name=commentContent]");
commentContent.onfocus = (e) => {
	if(${empty loginMember}) {
		commentContent.blur();
		loginAlert();
	}
};

const commentEnrollHandler = (e) => {
	if(${empty loginMember}) {
		loginAlert();
		return false;
	}
	
	const commentContentVal = e.target.commentContent.value.trim();
	if(!/^(.|\n)+$/.test(commentContentVal)) {
		$.alert({
		    title: '',
		    content: '댓글 내용을 작성해주세요.',
		    buttons: {'확인': function() {}}
		});
		return false;
	}
};

document.commentEnrollFrm.onsubmit = commentEnrollHandler;

const loginAlert = (e) => {
	$.alert({
	    title: '',
	    content: '로그인 후 이용해주세요.',
	    buttons: {'확인': function() {}}
	});
};

/* $('#commentReplyBtn').click(function() {
const commentData = $('[name=commentReplyFrm]').serialize();
commentEnroll(commentData);
});

$('#commentEnrollBtn').click(function(e) {
	if(${empty loginMember}) {
		$.alert({
		    title: '',
		    content: '로그인 후 이용할 수 있습니다.',
		    buttons: {'확인': function() {}}
		});
		return;
	}
	
	const commentContent = document.querySelector('textarea[name=commentContent]');
	const commentContentVal = commentContent.value.trim();
	if(!/^(.|\n)+$/.test(commentContentVal)) {
		$.alert({
		    title: '',
		    content: '댓글 내용을 작성해주세요.',
		    buttons: {'확인': function() {}}
		});
	   	commentContent.focus();
		return false;
	}
	
	const commentData = $('[name=commentEnrollFrm]').serialize();
	commentEnroll(commentData);
});

function commentEnroll(commentData) {
	const headers = {
		"${_csrf.headerName}" : "${_csrf.token}"
	};
	
	$.ajax({
		url : '${pageContext.request.contextPath}/community/review/commentEnroll',
		method : "POST",
		headers,
		data : commentData,
		success(response) {
			$.alert({
			    title: '',
			    content: '댓글 등록이 완료되었습니다.',
			    buttons: {'확인': function() {
					$('[name=commentContent]').val('');
					location.reload();
			    }}
			});
		},
		error : console.log
	});
}; */
</script>