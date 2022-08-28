<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/community.css" />

<!-- 커뮤니티 공통헤더 (작성자:SJ) -->
<div class="text-center p-3 m-3 community-heading">
	<h2 class="m-1 p-1 font-weight-bold">Community</h2>
	<h4 class="m-2 p-2"><i class="fa-solid fa-campground"></i></h4>
	<h6 class="m-1 p-1">자유롭게 캠퍼를 모집하고 후기를 나누세요.</h6>
</div>
<div class="row pb-0">
	<div class="col-md-7 float-left">
		<ul class="nav community-nav">
		  	<li class="nav-item">
		    	<a id="camper" class="nav-link" href="${pageContext.request.contextPath}/community/camper/camperList">캠퍼모집</a>
		  	</li>
		  	<li class="nav-item">
		    	<a id="review" class="nav-link active" href="${pageContext.request.contextPath}/community/review/reviewList">캠핑장후기</a>
		  	</li>
		</ul>
	</div>
	<!-- .active classList로 제어해야 함 -->