<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/searchInfo.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberCommon.css" />
<style>
div.jconfirm-box div.jconfirm-buttons{
	width: 100%;
	display: flex;
	justify-content: center;
}
div.jconfirm-box div.jconfirm-buttons > button{
	width: 40%;
}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
<div class="mx-auto mt-5 container p-5 shadow-sm border"  id="search-my-info">
	<div  class="d-flex justify-content-center" >
		<a href="${pageContext.request.contextPath}/member/searchId" class="btn btn-block font-weight-bold pb-3 camper-color">아이디 찾기</a>
		<a href="${pageContext.request.contextPath}/member/searchPassword" class="btn btn-block m-0 font-weight-bold pb-3">비밀번호 찾기</a>
	</div>
	<form:form name="searchIdFrm" method="POST" >
		<div class="mt-4 pt-4 input-group-lg">
			<input 
				type="text" class="form-control mb-3" name="name"
				placeholder="이름" autocomplete="off" required>
			<input
				type="email" class="form-control my-3 input-lg" name="email"
				placeholder="이메일" autocomplete="off" required >
		</div>
	    <button class="btn btn-camper-color btn-block btn-lg font-weight-bold" type="button">확인</button>
		<p class="pt-4">&nbsp;-&nbsp;&nbsp;&nbsp;가입시 등록한 이름과 이메일을 입력해주세요.</p>					
	</form:form>
</div>
<script>
	$("button").on('click', function () {
		const headers = {
				"${_csrf.headerName}" : "${_csrf.token}"
			};
		if($("input[name=name]").val() === ''){
            $.alert({
            	columnClass: 'col-md-9',
    		    title: '',
    		    content: '이름을 입력해 주세요.',
    		    buttons: {
    		    	'확인': function() {}
    		    }
    		})
    		return;
		}
		else if($("input[name=email]").val() ==='') {
            $.alert({
            	columnClass: 'col-md-9',
    		    title: '',
    		    content: '이메일을 입력해 주세요.',
    		    buttons: {
    		    	'확인': function() {}
    		    }
    		})
    		return;
		}
		$.ajax({
			url:'${pageContext.request.contextPath}/member/searchId',
			method:"post",
			headers,
			async:false,
			data : {
				name : $("input[name=name]").val(),
				email: $("input[name=email]").val()
			},
			success(response){
				if(response.memberId === null){
                    $.alert({
                    	columnClass: 'col-md-9',
		    		    title: '<h4 class="pb-3">아이디 찾기</h4>',
		    		    content: '입력하신 정보와 일치하는 회원이 없습니다.',
		    		    buttons: {
		    		    	'확인': function() {}
		    		    }
		    		})		
				}else{
                        $.confirm({
	                        columnClass: 'col-md-9',
	                        closeIcon: true,
	                        title: '<h4 class="pb-3">아이디 찾기</h4>',
	                        content: '입력하신 정보로 조회된 아이디는 <strong>'+ response.memberId +'</strong> 입니다.<br><br>',
	                        buttons: {
	                            login: {
	                                text: '로그인',
	                                btnClass:'btn btn-camper-color d-inline w-50',
	                                action: function (login) {
	                                	location.href = '${pageContext.request.contextPath}/member/login';
	                                }
	                            },
	                            searchPw:{
	                                text: '비밀번호 찾기',
	                                btnClass:'btn btn-camper-outline-color border w-50 border-camper-color text-center',
	                                action: function (searchPw) {
	                                	location.href = '${pageContext.request.contextPath}/member/searchPassword';
	                                }
	                            } 
	                    	}
                        });
				}
			},
			error: console.log
		}); 
		return false;
	});
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>