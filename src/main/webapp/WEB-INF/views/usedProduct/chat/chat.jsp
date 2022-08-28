<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<script>
//ajax 통신을 위한 csrf 설정
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});

function sendMessage(form) {
	// 작성자, 내용 유효성 검사
	form.writer.value = form.writer.value.trim();
	
	if (form.writer.value.length == 0) {
		alert('작성자를 입력하세요.');
		form.writer.focus();
		return false;
	}
	
	form.body.value = form.body.value.trim();
	
	if(form.body.value.length == 0) {
		alert('내용을 입력하세요');
		form.body.focus();
		return false;
	}
	
	$.post('./addMessage', {
		writer : form.writer.value,
		body : form.body.value
	}, function(data) {
		
	}, 'json');
	
	form.body.value = '';
	form.body.focus();
}

var Chat__lastReceivedMessageId = -1;

function Chat__loadNewMessages() {
	
	$.get('./getMessages', {
	
		from : Chat__lastReceivedMessageId + 1
	
	}, function(data) {
		for(var i = 0; i < data.length; i++) {
			var message = data[i];
			
			Chat__lastReceivedMessageId = message.id;
			
			Chat__drawMessages(message);
		}
			setTimeout(Chat__loadNewMessages, 100);
	}, 'json');
}

function Chat__drawMessages(message) {
	var html = '[' + message.id + '] (' + message.writer + ') : ' + message.body;
	$('.chat-list').prepend('<div>' + html + '</div>')
	
}

$(function() {
	Chat__loadNewMessages();
});


</script>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/chat.css"/>
<meta charset="UTF-8">
<title>채팅하기</title>
</head>
<body>	
	<div class="container">
		<hr />
		<div class="chat_container">
			<div id="chatroom_container">
				<div class="info_container">
					<!-- 상단(닉네임, 아이디, 프로필) -->
					<div class="member-info_container" style="">
						<img src="" class="float-start" alt="">
						<div class="member-info_text-body">
							<div class="nickname_text">
								<p style="font-weight: 600">홍길동</p>
							</div>
							<div class="id_text">
								<p>honggd</p>
							</div>
						</div>
					</div>
					<button id="transaction_btn">거래완료</button>
				</div>
				<div id="chat_container">
					<div class="chat-box"><div class="chat"><input type="hidden"></div></div>
					<div class="my-chat-box"><div class="chat my-chat"><input type="hidden"></div></div>
				</div>
				
				<!-- 하단 (입력창) -->
				<div id="bottom_container" style="margin-top: 10.4px;">
					<!-- 메세지 입력창 -->
					<!-- autofocus -> 페이지가 로드될 때 자동으로 포커스(focus) <input> 요소로 이동 -->
					<form onsubmit="sendMessage(this); return false;">
					
					<input type="text" class="" id="writer" name="writer" placeholder="작성자" value="${loginMember.nickname}"/>
					<!--<input type="text" class="toNickname" id="toNickname" value="이름"/>  -->
					<input type="text" name="body" class="form-control" placeholder="내용" autofocus/>
					<input type="submit" id="sendBtn" value="전송"/>
					
					</form>
					<div class="chat-list"></div>
					<!-- 추가 옵션 -->
					<div class="extra-menu">
						<div class="option" id="imgOption">
							<i class="fa-solid fa-camera"></i>
							<input type="file" id="uploadImg"/>
						</div>
					</div>
				</div>
			</div>
			<!-- 채팅방 목록 -->
	 		<div class="titleText">전체목록<img src="${pageContext.request.contextPath}/resources/images/cs/arrow.png" class="float-start" alt="화살표"></div>
			<div id="chatList_container">
				<div class="chatTitle">
	 			</div>
				<div class="one_member">
					<!-- 읽지 않은 메세지 개수 -->
					<div class="unread_message">
						<div class="red_circle">
							<span class="badge badge-danger unread-count">1</span>
						</div>
					</div>
					<div class="chatRoom_profile">
						<img class="other_member_img" src="" class="rounded float-start" alt="">
					</div>
					<div class="chatRoom_content">
						<div class="other_member_nickname">
							<input type="hidden" name="fromNickname" id="fromNickname" class="form-control" value="${loginMember.nickname}" placeholder="닉네임"/>
						</div>
						<div class="last_message">
							
						</div>
					</div>
					<div class="chat_logtime">2022.08.07</div>
				</div>		
			</div>
		</div>
		<hr />
	</div>
</body>

<script>

/* 
function submitFunction() {
	var fromNickname = $('#fromNickname').val();
	var toNickname = $('#toNickname').val();
	var chatContent = $('#chatContent').val();
	
	$.ajax({
		type : 'POST',
		url : "/campervalley/chat/submit",
		data : {
			fromNickname : fromNickname,
			toNickname : toNickname,
			chatContent : chatContent
		},
		success : function(data) {
			if(data.result == 1) {
				alert('메시지 전송 성공!');
			} else if(result == 0){
				alert('메세지 전송 실패!');
			}
		}
	});
	$('#chatContent').val('');	
} */
</script><!-- 
<script>
function chatListFunction() {
	var fromNickname = $('#fromNickname').val();
	var toNickname = $('#toNickname').val();
	
	$.ajax({
		type : 'POST',
		url : "/campervalley/chat/chatList",
		data : {
			fromNickname : fromNickname,
			toNickname : toNickname,
		},
		success : function(data) {
			var parsed = JSON.parse(data.result);
			var result = parsed.result;
			for(var i = 0; i < result.length; i++) {
				addChat(result[i][0].value, result[i][2].value, result[i][3].value);
			}
		},
		error : function() {
			alert('실패');
		}
	});
}
function dfunction() {
	var fromNickname = $('#fromNickname').val();
	var toNickname = $('#toNickname').val();
	
	$.ajax({
		type : 'POST',
		url : "/campervalley/chat/dchatList",
		data : {
			fromNickname : fromNickname,
			toNickname : toNickname,
		},
		success : function(data) {
			var parsed = JSON.parse(data.result);
			var result = parsed.result;
			for(var i = 0; i < result.length; i++) {
				addChat(result[i][0].value, result[i][2].value, result[i][3].value);
			}
		},
		error : function() {
			alert('실패');
		}
	});
}
function addChat(chatName, chatContent, chatTime) {
	$('#chat_container').append('<div class="row">' +
		'<div class="clo-lg-12">' +
		'<a class="media">' +
		'<a class="pull-left" href="#">' +
		'<img class="media-object img-circle" style="width: 30px; height: 30px;" src="" alt="">' +
		'</a>' +
		'<div class="media-body">' +
		'<h4 class="media-heading">' +
		chatName +
		'<span class="small pull-right">' +
		chatTime +
		'<span/>' +
		'</h4>' +
		'<p>' +
		chatContent +
		'</p>' + 
		'</div>' +
		'</div>' +
		'</div>' +
		'</div>' +
		'<hr>');
}

function getIn() {
	setInterval(function() {
		dfunction();
	}, 3000)
}

$(document).ready(function() {
	chatListFunction();
	getIn();
}); -->

</html>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>