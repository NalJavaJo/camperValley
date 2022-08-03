<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/sidebar.css" />
<div class="sidebar-header">
	<h4 class="px-2 mypageTitle mypage-info">마이페이지</h4>
</div>
<ul class="sideNav navbar-nav px-2">
    <li class="nav-item navGroup">
    	<a class="nav-link" href="">회원관리</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">회원정보관리</a>
    </li>
    <li class="nav-item navGroup">
    	<a class="nav-link" href="">중고거래</a>
   	</li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">구매내역</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">판매내역</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">관심상품</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">나의채팅방</a>
    </li>
    <li class="nav-item navGroup">
    	<a class="nav-link" href="">커뮤니티</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">캠퍼모집</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">작성후기</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="">관심캠핑장</a>
    </li>
    <li class="nav-item navGroup">
    	<a class="nav-link" href="">광고주</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/advertiser/register">광고주등록</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/advertiser/exit">광고주해제</a>
    </li>
    <li class="nav-item sideNavMenu">
    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage/advertiser/dashboard">광고관리</a>
    </li>
</ul>


