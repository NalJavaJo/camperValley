<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/sidebar.css" />
<div class="sidebar-header">
	<h4 class="px-3 mypageTitle mypage-info">마이페이지</h4>
</div>
<ul class="sideNav navbar-nav px-3 mb-3">
    <li class="nav-item navGroup">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/info/main">회원관리</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/info/edit"">회원정보관리</a>
    </li>
    <li class="nav-item navGroup">
    	<a class="nav-link" href="">중고거래</a>
   	</li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/trade/purchased">구매내역</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/trade/selling">판매내역</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/trade/wish">관심상품</a>
    </li>
    <!--
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">나의채팅방</a>
    </li>
    -->
    <li class="nav-item navGroup">
    	<a class="nav-link" href="">커뮤니티</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/community/myCamper">캠퍼모집</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/community/myReview">작성후기</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/community/bookmark">관심캠핑장</a>
    </li>
    <li class="nav-item navGroup">
    	<a class="nav-link" href="">광고주</a>
    </li>
    <sec:authorize access="!hasRole('AD') && ${isPauseAdvertiser eq false && isAdvertiser eq false}">
	    <li class="nav-item sideNavMenu">
	    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/advertiser/register">광고주등록</a>
	    </li>
    </sec:authorize>
    <sec:authorize access="hasRole('AD') || ${isPauseAdvertiser eq true && isAdvertiser eq true }">
	    <li class="nav-item sideNavMenu">
	    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/advertiser/dashboard">광고관리</a>
	    </li>
	    <li class="nav-item sideNavMenu">
	    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/advertiser/exit">광고주해제</a>
	    </li>
    </sec:authorize>
</ul>


