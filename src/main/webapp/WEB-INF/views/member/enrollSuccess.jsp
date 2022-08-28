<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
	#content .box{
		margin: 200px 0;
	 }
	 
	#content .btn{
	  width: 200px;
	  border: 2px #639A67 solid;
	}
	
	#content .btn:hover{
	  background-color: #2B380C;
	  border: 2px #2B380C solid;
	  color: white;
	}
	
	#content p{
	 font-size: 22px;
	}
</style>

<div id="container" class="my-5">
	<section id="content">
    	<div class="mx-auto text-center my-5" style="width: 640px;">
        	<div class="box">
            	<p class="font-weight-bold m-1 mt-3 my-5">회원가입이 완료되었습니다.</p>
                <div class="my-4">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-camper-color btn-lg m-3 border-2" >홈으로 이동</a>
                    <a href="${pageContext.request.contextPath}/member/login" class="btn btn-outline-camper-color btn-lg m-3 border-2">로그인</a> 
                </div>
            </div>
        </div>
	</section>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>