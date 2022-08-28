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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
<sec:authentication property="principal" var="loginMember" scope="page"/>
<c:set var="profileFileName" value="${empty loginMember.profileImg ? 'default-profile.svg' : loginMember.profileImg}"/>
<div class="container">	
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5 mt-4" id="edit-container">
			<h4>
				회원정보관리
			</h4>
			<form:form id="memberUpdateFrm" class="shadow-sm" enctype="multipart/form-data" method="post">
	            <table  style="width: 40rem;">
				<tbody>
					<tr>
						<td rowspan="2" style="width:9.5rem;">
							<input type="file" accept="image/*" name="profileImgFile" id="file" />
							<div class="rounded-circle" id="profileImg-wrp">
	 								<img id="profileImg" alt="<sec:authentication property="principal.nickname"/>님의 프로필사진" 
											src="${pageContext.request.contextPath}/resources/upload/member/${profileFileName}"/>
									<input type="hidden" name="changeImg" value="0" />
							</div>
						</td>
						<td style="width:6.4rem;"class="font-weight-bold">
							아이디
						</td>
						<td colspan="2" style="width:14rem;">
	                            <sec:authentication property="principal.username"/>
	                            <input type="hidden" name="memberId" value="<sec:authentication property="principal.username"/>" />
						</td>
					</tr>
					<tr>
						<td class="font-weight-bold">
							이름
						</td>
						<td colspan="3">
							<sec:authentication property="principal.name"/>
	                            <input type="hidden" name="name" value="<sec:authentication property="principal.name"/>" />
						</td>
					</tr>
					<tr>
						<td class="font-weight-bold">
							닉네임
						</td>
						<td  colspan="2">
							<input type="text" class="form-control" name="nickname" id="nickname" value="<sec:authentication property="principal.nickname"/>" autocomplete="off" required>
							<input type="hidden" id="nicknameValid" value="0" /> <!-- 0-사용불가 1-사용가능 -->
						</td>
						<td style="width:6.6rem; text-align: right;">
							<button type="button" class="btn btn-outline-secondary" id="duplicateNicknameChk">중복확인</button>
						</td>
	                </tr>
	                <tr>
						<td class="font-weight-bold">
							새 비밀번호
						</td>
						<td colspan="3">
							<input type="password" class="form-control" name="password" id="password" placeholder="새 비밀번호" autocomplete="off" value="">
						</td>								
					</tr>
	                    <tr>
						<td class="font-weight-bold">
							새 비밀번호 확인
						</td>
						<td colspan="3">
							<input type="password" class="form-control" id="passwordCheck" placeholder="새 비밀번호확인" autocomplete="off" value="">
						</td>								
						</tr>
	                    <tr>
							<td class="font-weight-bold">
								이메일
							</td>
							<td colspan="2">
								<input type="email" class="form-control" value="<sec:authentication property="principal.email"/>" name="email" id="email" autocomplete="off" required>
								<input type="hidden" id="emailValid" value="0" /> <!-- 0-사용불가 1-사용가능 -->
							</td>
							<td style="width:6.6rem; text-align: right;">
								<button class="btn btn-outline-secondary" type="button" id="duplicateEmailChk">중복확인</button>
							</td>							
						</tr>
	                    <tr>
							<td class="font-weight-bold">
								전화번호
							</td>
							<td colspan="3">
								<input type="tel" class="form-control" value="<sec:authentication property="principal.tel"/>" name="tel" id="tel" maxlength="11" autocomplete="off" required>
							</td>								
						</tr>
					</tbody>
				</table>
				<button id="submitFrmBtn" class="d-none"></button>
			</form:form>
			<div style="text-align: right; ">
				<a href="${pageContext.request.contextPath}/mypage/info/withdrawal" class="btn btn-outline-secondary" type="button">회원탈퇴</a> 
			</div>
			<div style="text-align: center;">
				<button type="button" class="btn btn-success shadow-sm" id="submitBtnClickBtn">
					회원정보 수정
				</button>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/member/validation.js"></script>
<script>

$("#profileImg").click(()=>{
     $("#file").click();
 });

$("input[type=file]").on("change", function (e) {
             if (e.target.files && e.target.files[0]) {
                 var reader = new FileReader();
                 reader.onload = function (e) {
                     $('#profileImg').attr('src', e.target.result);
                 };
                 reader.readAsDataURL(e.target.files[0]);
             } else {
                 $('#profileImg').attr('src', '${pageContext.request.contextPath}/resources/upload/member/default-profile.svg');
             }
             $("input[name=changeImg]").val(1);
});
$("input[name=nickname]").change((e) =>{
     const nicknameValid = $("#nicknameValid");
     nicknameValid.val(0);
 	
});
 
$("#duplicateNicknameChk").click((e) => {
     const nicknameValid = $("#nicknameValid");
     let nicknameVal = $("#nickname").val(); 
     if(nicknameVal === "${loginMember.nickname}"){
 		$.alert({
 		    title: ' ',
 		    content: '현재 닉네임과 동일합니다.',
 		    buttons: {'확인': function() {}}
 		});
         return;
} else if(!isValidateNickname(nicknameVal)){
 		$.alert({
 		    title: ' ',
 		    content: '2 -11자 의 영문/숫자/한글로 입력해주세요.',
 		    buttons: {'확인': function() {}}
 		});
         return;
}
     
 $.ajax({
         url:'${pageContext.request.contextPath}/member/checkDuplicate',
         data : {
             value : nicknameVal,
             attribute : "nickname"
 },
     async:false,
     success(response){
     const{value, available} = response;
     if(available){
     	nicknameValid.val(1);
		    $.alert({
		    title: ' ',
		    content: '사용할 수 있는 닉네임입니다.',
		    buttons: {'확인': function() {}}
		    });
     } else{
     	$.alert({
			    title: ' ',
		    	content: '이미 사용중인 닉네임입니다.',
		    	buttons: {'확인': function() {}}
		    	})
         }
     },
         error: console.log
     });

 });	
 
$("#duplicateEmailChk").click((e) => {
    const emailValid= $("#emailValid");
    let emailVal = $("#email").val(); 
    if(emailVal === "${loginMember.email}"){
    	$.alert({
 		    title: ' ',
 		    content: '현재 이메일과 동일합니다.',
 		    buttons: {'확인': function() {}}
 		})
         return;
     } else if(!isValidateEmail(emailVal)){
     	$.alert({
 		    title: ' ',
 		    content: '이메일 주소를 다시 확인해주세요.',
 		    buttons: {'확인': function() {}}
 		})
         return;
     }
     $.ajax({
         url:'${pageContext.request.contextPath}/member/checkDuplicate',
         data : {
             value : emailVal,
             attribute : "email"
         },
         async:false,
         success(response){
             const{value, available} = response;
             if(available){
                emailValid.val(1);
             	$.alert({
		    		title: ' ',
		    		content: '사용할 수 있는 이메일입니다.',
		    		buttons: {'확인': function() {}}
		    	})
             } else{
	             $.alert({
			        title: ' ',
			        content: '이미 사용중인 이메일입니다.',
			        buttons: {'확인': function() {}}
			    	})
	             }
         },
         error: console.log
     });
 });	
 
 $("input[name=email]").change((e) =>{
 	const emailValid= $("#emailValid");
     emailValid.val(0);
 });
  
 $("#submitBtnClickBtn").click((e)=>{
     const nicknameValid = $("#nicknameValid");
     const emailValid= $("#emailValid");
     
     if($("input[name=nickname]").val() !== "${loginMember.nickname}"){
     if(nicknameValid.val() === '0') {
         $.alert({
	        title: ' ',
	        content: '닉네임의 \'중복확인\' 버튼을 눌러 사용 가능 여부를 확인해 주세요.',
	        buttons: {'확인': function() {}}
	    })
             return;
         }
     } 
     if($("input[name=password]").val()!=='') {
     	
         if(!isValidatePassword($("input[name=password]").val())){
             $.alert({
	    		    title: ' ',
	    		    content: '비밀번호는 영문자+숫자+특수문자 조합으로 8자리 이상 입력해주세요.',
	    		    buttons: {'확인': function() {}}
	    		})
             return;
         } else if($("input[name=password]").val() !== $("#passwordCheck").val()){
             $.alert({
	    		    title: ' ',
	    		    content: '새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.',
	    		    buttons: {'확인': function() {}}
	    		})
             return;
         }	
     
     } else if($("input[name=email]").val() !== "${loginMember.email}"){
         if(emailValid.val()==='0') {
             $.alert({
	    		    title: ' ',
	    		    content: '이메일의 \'중복확인\' 버튼을 눌러 사용 가능 여부를 확인해 주세요.',
	    		    buttons: {'확인': function() {}}
	    		})			                
             return;
         }
     } else if(!$("input[name=tel]").val()){
             $.alert({
	    		    title: ' ',
	    		    content: '전화번호를 입력해주세요.',
	    		    buttons: {'확인': function() {}}
	    		})
             return false;
     } else if(!isValidateTel($("input[name=tel]").val())){
             $.alert({
	    		    title: ' ',
	    		    content: '전화번호를 다시 확인해주세요.<br>전화번호는 숫자만 입력 가능합니다.',
	    		    buttons: {'확인': function() {}}
	    		})
         return false;
     }
     
     $("#submitFrmBtn").click();
 }); 

</script>