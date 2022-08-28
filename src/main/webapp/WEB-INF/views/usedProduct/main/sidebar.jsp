<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/sidebar.css"/>

<!-- 사이드 배너 시작 -->
<div class="navBanner">
	<!-- 찜 하트 수 -->
	<sec:authorize access="isAuthenticated()">
		<div class="favorites">
			<div class="favoritesText" style="font-weight: 600; font-size: 14px;">관심상품</div>
			<div class="favoritesCount">
				<p id="toFavorites" class="toFavorites">
					<i class="fas fa-heart" style="color: red;"></i>&nbsp; <span id="wishProduct">${wishCnt}</span>
				</p>
			</div>
			<!-- faboritesCount -->
			<br>
		</div>
	</sec:authorize>
	<!-- 찜 끝 -->
	
	<!-- 최근 본 상품 -->
	<div class="recently">
		<!-- <div class="recentlyText">최근본상품</div>
		<div class="recentlyProduct" style="text-align: center;">
			<span id="recentlyCnt"></span>
			<div id="recentlyArea">
				<a id="recentlyList"> </a>
				최근본상품
				<a id="noList"></a>
			</div>
		</div>
		<div id="recentlyPaging">
			<button id="recentlySubPage" class="btn subpage" onclick=""></button>
			<a id="currentPage"></a>
			
			<button id="recentlyAddPage" class="btn addpage" onclick=""></button>
		</div> -->
	</div>
</div>