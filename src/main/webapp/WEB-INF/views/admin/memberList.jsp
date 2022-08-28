<%@page import="org.springframework.security.core.authority.SimpleGrantedAuthority"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.campervalley.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css" />
<link href="/path/to/bootstrap.min.css" rel="stylesheet">
<link href="dist/css/component-custom-switch.css" rel="stylesheet">
<style>
.col-form-label {
	width: 80px;
	margin-left: 100px;
	}
.toggle-btn {
  width: 40px;
  height: 21px;
  background: grey;
  border-radius: 50px;
  padding: 3px;
  cursor: pointer;
}

.toggle-btn > .inner-circle {
  width: 15px;
  height: 15px;
  background: #fff;
  border-radius: 50%;
}

.toggle-btn.active {
  background: #639A67 !important;
}

.toggle-btn.active > .inner-circle {
  margin-left: 19px !important;
}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<div class="container" style="display: flex;" id="admin-container">
	<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />
	<div class="admin-content" style="width: 80%;">
		<h5 class="admin-hd">회원 관리</h5>
		<div class="search-box" style="display: flex;">
			<input class="ad-input-search" type="text" placeholder="회원 아이디 검색" name="searchKeyword" id="searchKeyword">
			<button class="ad-btn-search" type="button">
				<i class="fa fa-search"></i>
			</button>
		</div>
		<table class="table table-hover text-center" id="tb-admin">
			<thead>
				<tr>
					<th>권한</th>
					<th>아이디</th>
					<th>이름</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>회원가입일</th>
					<th>상태</th>
					<th class="col-sm-1"></th>
				</tr>
			</thead>
			<c:if test="${empty list}">
						<td colspan="8">조회된 회원이 없습니다.</td>
					</c:if>
			<tbody>
			<c:forEach items="${list}" var="list" varStatus="vs">
				<tr data-member-id="${list.memberId}" data-name="${list.name}" data-nickname="${list.nickname}" data-email="${list.email}" data-tel="${list.tel}" data-authorities="${list.authorities}">
					<td>
						 <c:if test = "${fn:contains(list.authorities, 'ROLE_ADMIN')}">관리자</c:if>
					     <c:if test="${!fn:contains(list.authorities, 'ROLE_ADMIN')}">사용자</c:if>
					</td>
					<td>${list.memberId}</td>
					<td>${list.name}</td>
					<td>${list.nickname}</td>
					<td>${list.email}</td>
					<td>
						<fmt:parseDate value="${list.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
						<fmt:formatDate value="${enrollDate}" pattern="yyyy-MM-dd"/>
					</td>
					<td>
						<c:if test = "${fn:contains(list.authorities, 'ROLE_BLACK')}">블랙</c:if>
				     	<c:if test="${!fn:contains(list.authorities, 'ROLE_BLACK')}">일반</c:if>
					</td>
					<td style="padding: 6px;">
						<button type="button" class="btn btn-outline-camper-color btn-sm btn-update" name="btn-update" data-toggle="modal" data-target="#adminMemberModal" value="">
							수정</button>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
<c:if test="${not empty list}">
    	<div class="mt-5" id="pageBar">${pagebar}</div>
</c:if>
	</div>
</div>
<!-- 모달창 -->
<div class="modal fade" id="adminMemberModal" tabindex="-1" role="dialog" aria-labelledby="#adminMemberModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
	<div class="modal-content">
	  <div class="modal-header">
		<h5 class="modal-title" id="adminMemberModalLabel">회원정보</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		  <span aria-hidden="true" style="color:#fff">&times;</span>
		</button>
	  </div>
		<form:form name="adminMemberUpdateFrm" method="post" action="${pageContext.request.contextPath}/admin/memberUpdate" >
	  <div class="modal-body pb-1">
			<div class="form-group mt-4">
			  <label for="memberId" class="col-form-label">아이디</label>
			  <input type="text" class="input-member pt-1 pb-1 pl-2" name="memberId" id="memberId" value="" readonly>
			</div>
			<div class="form-group">
			  <label for="name" class="col-form-label">이름</label>
			  <input type="text" class="input-member pt-1 pb-1 pl-2" name="name" id="name" value="" readonly></input>
			</div>
			<div class="form-group">
			  <label for="nickname" class="col-form-label">닉네임&nbsp;<span style="color:red;">*</span></label>
			  <input type="text" class="input-member pt-1 pb-1 pl-2" name="nickname" id="nickname" value=""></input>
			</div>
			<div class="form-group">
			  <label for="email" class="col-form-label">이메일&nbsp;<span style="color:red;">*</span></label>
			  <input type="text" class="input-member pt-1 pb-1 pl-2" name="email" id="email" value=""></input>
			</div>
			<div class="form-group">
			  <label for="tel" class="col-form-label">전화번호&nbsp;<span style="color:red;">*</span></label>
			  <input type="text" class="input-member pt-1 pb-1 pl-2" name="tel" id="tel" value=""></input>
			</div>
			  <div class="form-group">
						<label for="role" class="col-form-label">권한&nbsp;<span style="color:red;">*</span></label>
						<input type="checkbox" name="ROLE_USER" id="user" checked="checked" onclick="return false"/>
						<label for="user">사용자</label>
						&nbsp;
						<input type="checkbox" name="ROLE_ADMIN" id="admin"/>
						<label for="admin">관리자</label>
		  </div>	
			<div class="form-group">
			  <p class="form-check form-check-inline mr-4 ml-6" style="margin-left: 100px;">블랙리스트&nbsp;<span style="color:red;">*</span></p>
			  
			  <div class="form-check form-check-inline" style="top: -15px;">
					   <div class="custom-control custom-switch" style="margin-left: -15px;">
					    <input type="checkbox" class="custom-control-input" id="black" name="ROLE_BLACK">
					    <label class="custom-control-label" for="black"></label>
					  </div>
				</div> 
			</div>
			
		</div>
		

	  <div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		<button type="submit" class="btn btn-primary btn-member-update" id="modalSubmit">수정</button>
	  </div>
	</div>
		  </form:form>
  </div>
</div>
<script>
document.adminMemberUpdateFrm.onsubmit = (e) => {
	const frm = e.target;
	const nicknameVal = frm.nickname.value.trim();
	if(!/^.+$/.test(nicknameVal)) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '닉네임을 입력해주세요.',
		    buttons: {
		    	'확인': function() {}
		    }
		});
		frm.nickname.select();
		return false;
	}
	const emailVal = frm.email.value.trim();
	if(!/^(.|\n)+$/.test(emailVal)) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '이메일을 입력해주세요.',
		    buttons: {
		    	'확인': function() {}
		    }
		});
		frm.email.select();
		return false;
	}
	const telVal = frm.tel.value.trim();
	if(!/^(.|\n)+$/.test(telVal)) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '전화번호을 입력해주세요.',
		    buttons: {
		    	'확인': function() {}
		    }
		});
		frm.tel.select();
		return false;
	}
}

document.querySelectorAll('.ad-btn-search').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		let keyword = document.getElementById('searchKeyword').value;

		let url = "${pageContext.request.contextPath}/admin/memberList";
		url = url + "?searchKeyword=" + keyword;
		location.href = url;
		console.log(url);
		
	})
})

$(document).ready(function(){

	$('.toggle-btn').click(function() {
	$(this).toggleClass('active').siblings().removeClass('active');
	});

	});
	
document.querySelectorAll(".btn-update").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		console.log(e.target);
		const tr = e.target.parentElement.parentElement;
		console.log(tr);

		const memberId = tr.dataset.memberId;
		const name = tr.dataset.name;		
		const nickname = tr.dataset.nickname;
		const email = tr.dataset.email;
		const tel = tr.dataset.tel;
		
		const authorities = tr.dataset.authorities;

		if(authorities.includes('ROLE_USER')) {
			document.getElementById("user").checked = true;
			//console.log(document.getElementById("user").checked);
		} else {
			document.getElementById("user").checked = false;
		}
		 if(authorities.includes('ROLE_ADMIN')) {
			document.getElementById("admin").checked = true;
			//console.log(document.getElementById("admin").checked);
		} else {
			document.getElementById("admin").checked = false;
		}
		 if(authorities.includes('ROLE_BLACK')) {
			document.getElementById("black").checked = true;
			console.log(document.getElementById("black").checked);
		} else {
			document.getElementById("black").checked = false;
		}
		 
		document.querySelector("#memberId").value = memberId;
		document.querySelector("#name").value = name;
		document.querySelector("#nickname").value = nickname;
		document.querySelector("#email").value = email;
		document.querySelector("#tel").value = tel;
		
	});
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>