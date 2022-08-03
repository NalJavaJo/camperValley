<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/sidebar.css" />
	<nav id="sidebar">
		<div class="sidebar-header">
			<h3 class="admin-info">
				<a href="${pageContext.request.contextPath}/admin/dashboard" style="color: #777;">CAMPERVALLEY<br>ADMIN<br>PAGE</a>
			</h3>
		</div>
		<ul class="list-unstyled components">

			<li class="active"><a href="#homeSubmenu" data-toggle="collapse"
				aria-expanded="false" class="dropdown-toggle">회원 관리</a>
				<ul class="collapse list-unstyled" id="homeSubmenu">
					<li><a href="${pageContext.request.contextPath}/admin/memberList">회원관리</a></li>
					<li><a href="#">광고주회원관리</a></li>
				</ul></li>

			<li><a href="#pageSubmenu" data-toggle="collapse"
				aria-expanded="false" class="dropdown-toggle">게시판 관리</a>
				<ul class="collapse list-unstyled" id="pageSubmenu">
					<li><a href="#">공지사항</a></li>
					<li><a href="#">자주묻는질문</a></li>
					<li><a href="#">캠핑용품거래</a></li>
					<li><a href="#">캠퍼모집</a></li>
				</ul></li>
			<li><a href="#">신고 내역 관리</a></li>
		</ul>
	</nav>