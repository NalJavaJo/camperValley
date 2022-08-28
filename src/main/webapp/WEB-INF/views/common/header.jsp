<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- ajax 통신을 위한 meta tag -->
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>campervalley</title>
	<!-- favicon_io -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon/favicon.ico">
    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
    <link rel="manifest" href="/site.webmanifest">
	<!-- jquery js -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- alert js -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
	<!-- bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<!-- 사용자작성 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
	<!-- font awesome -->
	<spring:eval var="fontawesomeKey" expression="@customProperties['api.fontawesome']" />
	<script src="https://kit.fontawesome.com/${fontawesomeKey}.js" crossorigin="anonymous"></script>
	<script>
	<c:if test="${not empty msg}">
		$.alert({
		    title: ' ',
		    content: '${msg}',
		    buttons: {'확인': function() {}}
		});
	</c:if>
	</script>
</head>
<body class="mx-auto">
	<header class="container p-0 fixed-top">
		<nav class="navbar navbar-expand-lg navbar-light p-0" id="navbarMain">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse p mr-0" id="navbarText">
				<img class="col-md-3 mr-4 pl-5 pr-5" style="width:100" src="${pageContext.request.contextPath}/resources/images/logo.png" onclick="location.href='${pageContext.request.contextPath}'" alt="logo" />
				<ul class="navbar-nav col-md-6 p-0 pr-4 mt-4 justify-content-center">
					<!-- 선택시 active -->
					<li class="nav-item"><a class="mainMenu nav-link text-dark px-3" href="${pageContext.request.contextPath}/campsite/searchDetail">캠핑장</a></li>
					<li class="nav-item"><a class="mainMenu nav-link text-dark px-3" href="${pageContext.request.contextPath}/usedProduct/main/mainPage">캠핑용품거래</a></li>
					<li class="nav-item"><a class="mainMenu nav-link text-dark px-3" href="${pageContext.request.contextPath}/community/camper/camperList">커뮤니티</a></li>
					<li class="nav-item"><a class="mainMenu nav-link text-dark px-3" href="${pageContext.request.contextPath}/cs/noticeList">고객센터</a></li>
					<sec:authorize access="isAuthenticated()">
						<li class="nav-item"><a class="mainMenu nav-link text-dark px-3" href="${pageContext.request.contextPath}/mypage/info/main">마이페이지</a></li>
					</sec:authorize>
					<sec:authorize access="hasRole('ADMIN')">
						<li class="nav-item"><a class="mainMenu nav-link text-dark px-3" href="${pageContext.request.contextPath}/admin/dashboard">관리자페이지</a></li>
					</sec:authorize>

				</ul>
				    <sec:authorize access="isAnonymous()">
						<ul class="navbar-nav col-md-3 mt-4 ml-5">
							<li class="nav-item"><a class="nav-link small text-dark" href="${pageContext.request.contextPath}/member/login"><i class="fa-regular fa-user"></i>&nbsp;로그인</a></li>
							<li class="nav-item"><a class="nav-link small text-dark" href="${pageContext.request.contextPath}/member/enroll"><i class="fa-solid fa-user-plus"></i>&nbsp;회원가입</a></li>
						</ul>
			    	</sec:authorize>
					<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="loginMember" scope="session"/>
						<form action="${pageContext.request.contextPath}/member/logout" method="post" style="display:contents;">
							<ul class="navbar-nav col-md-3 mt-4 ml-5">
								<li class="nav-item pt-2"><span class="camper-color"><i class="fa-solid fa-user fa-1x"></i>&nbsp;[<sec:authentication property="principal.nickname"/>]</span>님</li>
								<li class="nav-item ml-4"><button class="nav-link small btn btn-link" href="${pageContext.request.contextPath}/member/logout"><i class="fa-solid fa-arrow-right-from-bracket" style="font-size:11px;"></i>&nbsp;<span id="logout" >로그아웃</span></button></li>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</ul>
						</form>
			   		</sec:authorize>
			</div>
		</nav>
		<nav class="navbar navbar-light p-2 justify-content-center bg-camper-color" id="navbarSub"></nav>
		
		<sec:authorize access="!hasRole('AD') && ${isPauseAdvertiser eq false}">
			<c:set var="moveToAderEnroll" value="true" />
		</sec:authorize>
		<sec:authorize access="hasRole('AD') || ${isPauseAdvertiser eq true}">
			<c:set var="moveToAderEnroll" value="false" />
		</sec:authorize>
		
		<script>
		const $subNavbar = $(navbarSub);
		$(document).ready(() => {
			$subNavbar.hide();
			console.log($(".mainMenu").length);
		});
		
		
		// // 서브메뉴바보여주기 - mouseenter event
		$(".mainMenu").mouseenter((menu) => {
		  	const mainMenu = menu.target.innerHTML;
		  	let comPosition;
		  	let csPosition;
		  	let myPosition;
		  	switch($(".mainMenu").length) {
		  	case 4 : 
		  		comPosition = 0.7;
		  		csPosition = 1.4;
		  		break;
		  	case 5 :
		  		comPosition = 0.2;
		  		csPosition = 0.9;
		  		myPosition = 1.8;
		  		break;
		  	case 6 :
		  		comPosition = -0.35;
		  		csPosition = 0.3;
		  		myPosition = 1.3;
		  		break;
		  	}
		  	
		  	switch(mainMenu) {
			case "커뮤니티" : renderSubMenu(comPosition, "캠퍼모집", "캠핑장후기"); break;
			case "고객센터" : renderSubMenu(csPosition, "공지사항", "FAQ"); break;
			case "마이페이지" : renderSubMenu(myPosition, "회원정보", "중고거래", "커뮤니티", "광고주"); break;
			case "관리자페이지" : renderSubMenu(2.5, "회원관리", "게시판관리", "신고내역관리", "1:1문의관리"); break;
			default : $subNavbar.stop().slideUp('fast');
		  	}
		});
	
		const renderSubMenu = function(index, ...subMenuList) {
			$subNavbar.html("");
			for(let i = 0; i < subMenuList.length; i++) {
				const aTag = document.createElement("a");
				aTag.className = "navbar-brand p-0 mr-3 ml-3 text-light position-relative";
				aTag.style.left = `\${index * 100}px`;
				
				aTag.innerHTML = subMenuList[i];
				
				switch(aTag.innerHTML) {
					case "캠퍼모집" 	: aTag.href = "${pageContext.request.contextPath}/community/camper/camperList"; break;
					case "캠핑장후기" 	: aTag.href = "${pageContext.request.contextPath}/community/review/reviewList"; break;
					case "회원정보" 	: aTag.href = "${pageContext.request.contextPath}/mypage/info/main"; break;
					case "중고거래" 	: aTag.href = "${pageContext.request.contextPath}/mypage/trade/purchased"; break;
					case "커뮤니티" 	: aTag.href = "${pageContext.request.contextPath}/mypage/community/myCamper"; break;
					case "광고주" 	:
						if("${moveToAderEnroll}" == "true") {
							aTag.href = "${pageContext.request.contextPath}/mypage/advertiser/register";
						} else if ("${moveToAderEnroll}" == "false") {
							aTag.href = "${pageContext.request.contextPath}/mypage/advertiser/dashboard";							
						}
						break;
					case "공지사항" 	: aTag.href = "${pageContext.request.contextPath}/cs/noticeList"; break;
					case "FAQ" 		: aTag.href = "${pageContext.request.contextPath}/cs/faq"; break;
					case "회원관리" 	: aTag.href = "${pageContext.request.contextPath}/admin/memberList"; break;
					case "게시판관리" 	: aTag.href = "${pageContext.request.contextPath}/admin/camperManagement"; break;
					case "신고내역관리"	: aTag.href = "${pageContext.request.contextPath}/admin/reportManagement"; break;
					case "1:1문의관리" : aTag.href = "https://desk.channel.io/#/channels/101441/user_chats/630499697ab1cf221c2b"; break;
				}
				
				$subNavbar.append(aTag);
				if(i != subMenuList.length - 1) {
					const spanTag = document.createElement("span");
					spanTag.className = "bar text-light position-relative";
					spanTag.innerHTML = "|";
					spanTag.style.left = `\${index * 100}px`;
					$subNavbar.append(spanTag);
				}
			}
			$subNavbar.stop().slideDown('fast');
		};
	
		// 서브메뉴바숨기기 - scroll event
		$(window).scroll(() => {
		  	$subNavbar.stop().slideUp('fast');
		});
		</script>
		
	</header>
	<section id="content" class="mx-auto">
