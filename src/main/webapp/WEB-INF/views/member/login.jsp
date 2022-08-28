<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<style>
.bg-container{
    height: 35rem;
}

</style>

</head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/login.css" />

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="bg-container"></div>
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered px-5" role="document">
			<div class="modal-content px-2">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title mt-2 font-weight-bold" id="loginModalLabel">&nbsp;&nbsp;&nbsp;로그인</h4>
				</div>
				<form:form method="post">
					<div class="modal-body">
						<c:if test="${param.error != null}">
							  <span class="text-danger">아이디 또는 비밀번호가 일치하지 않습니다.</span>
						</c:if>
						<input 
							type="text" class="form-control mt-2" name="memberId"
							placeholder="아이디" required> 
						
						<input
							type="password" class="form-control" name="password"
							placeholder="비밀번호" required>
					</div>
	                <div class="modal-footer">
					<div class="justify-content-between">
						<div>
							<input type="checkbox" class="form-check-input" name="remember-me" id="remember-me" />
							<label for="remember-me" class="form-check-label">자동로그인</label>
						</div>				
						<div>
	                        <a href="${pageContext.request.contextPath}/member/searchId">아이디찾기</a> /
	                        <a href="${pageContext.request.contextPath}/member/searchPassword">비밀번호찾기</a>
						</div>
	                </div>
	                <div>				
						<div>
	                        <button type="submit" class="btn btn-camper-color">로그인</button>
	                    </div>
	                    <div>
							<a href="${pageContext.request.contextPath}/member/enroll" type="button" class="btn btn-outline-camper-color bg-white btn-block" >회원가입</a>
						</div>
					</div>
	            </div>
				</form:form>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
$("#loginModal")
.modal()
.on('hide.bs.modal', (e) => {
	<c:if test="${empty header.referer || fn:contains(header.referer, '/member/memberLogin.do')}">
		location.href = '${pageContext.request.contextPath}';
	</c:if>
	<c:if test="${not fn:contains(header.referer, '/member/memberLogin.do')}">
		location.href = '${header.referer}';
	</c:if>
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>