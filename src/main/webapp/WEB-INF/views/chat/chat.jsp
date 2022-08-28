<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedProduct/chat.css"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- sockjs, stomp, ws -->
<sec:authorize access="isAuthenticated()">
	<script>
	const memberId = '<sec:authentication property="principal.username"/>';
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="${pageContext.request.contextPath}/resources/js/chat/ws.js"></script>
</sec:authorize>

<div id="sellerId"></div>
<!-- <script>
var sl = "";
$(document).ready(function () {


$.ajax({
    type : 'GET',
    url : '/campervalley/usedProduct/product/getSellerInfo',
    data : {
       productNo : no
    },
    dataType : 'json',
    async : false,
    success : function(data) {

        var seller = '<input type="hidden" name="seller" id="seller" value="' + data.member.memberId + '"/>';
        $('#sellerId').append(seller);
        
    	sl = $(seller).val();
    	
        if(sellerId == memberId) {

            var trans = '<input type="submit" id="transaction_btn" value="거래완료"/>'
            $(".div-trans").append(trans);
            
        } else {
            var trans = '<input type="hidden" id="transaction_btn" value=""/>'
            $(".div-trans").append(trans);
        }

    }, error : function() {
       alert('에러!');
    }


 }); 
 


});
</script> -->

	<div id="section" style="width: 98%; margin:40px auto; height: 600px;">
		<input type="hidden" name="no" id="no" value="${no}"/>
		<div class="chat_container">
			<div id="chatroom_container">
			<c:if test="${sellerId eq loginMember.memberId}">
				<input type="submit" id="transaction_btn" value="거래완료"/>
			</c:if>
			<c:if test="${sellerId ne loginMember.memberId}">
				<input type="hidden" id="transaction_btn" value=""/>
			</c:if>
			
        
			<div class="info_container">
			<c:if test="${sellerId ne loginMember.memberId}">
					<!-- 상단(닉네임, 아이디, 프로필) -->
					<div class="member-info_container">
						<img src="" class="float-start" alt="">
						<div class="member-info_text-body">
						</div>
					</div>
			</c:if>
			<c:if test="${sellerId eq loginMember.memberId}"><p>없음</p></c:if>
			</div>
			<div id="chat_container">
				<div class="msg_history">
					<ul class="list-group list-group-flush" id="msg-container">
						<c:forEach items="${chatLogList}" var="chatLog">
							<li class="list-group-item">${chatLog.memberId} : ${chatLog.msg}</li>
						</c:forEach>	
					</ul>	
				</div>
			</div>	
		<div class="input-group mb-3">
		  <input type="text" id="msg" class="form-control" placeholder="유저에게 보내는 Message" />
		  <div class="input-group-append" style="padding: 0px;">
		    <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
		  </div>
		</div>		
		</div>
		</div>
 		<div class="titleText">전체목록<img src="${pageContext.request.contextPath}/resources/images/cs/arrow.png" class="float-start" alt="화살표"></div>
		<div id="chatList_container">
		<table class="table text-center" id="tbl-chat-list">
			<thead>
				<tr>
					<th scope="col">회원아이디</th>
					<th scope="col">메세지</th>
					<th scope="col">안읽은 메세지수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="chatLog">
					<tr data-chatroom-id="${chatLog.chatroomId}" data-member-id="${chatLog.memberId}">
						<td>${chatLog.memberId}</td>
						<td class="msg">${chatLog.msg}</td>
						<td class="unread">
							<span class="badge badge-danger unread-count ${chatLog.unreadCount eq 0 ? 'd-none' : '' }">${chatLog.unreadCount}</span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
<script>
const chatroomId = '${chatroomId}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/chat/chat.js"></script>

<script>
/* const ws = new SockJS(`http://${location.host}/campervalley/stomp`);
const stompClient = Stomp.over(ws); */

stompClient.connect({}, (frame) => {
	console.log('connect : ', frame);
	
	const sellerId;
	const buyerId;
	
	if('${sellerId}' == memberId) {
		sellerId = memberId;
		buyerId = '${buyerId}';
		
	} else {
		buyerId = memberId;
		sellerId = '${sellerId}';
	}

	const lastCheck = () => {
		console.log('lastCheck!');
		let payload = {
			chatroomId,
			sellerId,
			buyerId,
			lastCheck : Date.now(),
			type : "LAST_CHECK"
		};
		
		stompClient.send("/app/chat/lastCheck", {}, JSON.stringify(payload)); 
	}
	
	lastCheck();
	
	setTimeout(() => {
		const container = document.querySelector('#msg-container');
		
		stompClient.subscribe(`/app/chat/${chatroomId}`, (message) => {
			console.log("여기!!!!");
			console.log(`/app/chat/${chatroomId} : `, message);
			
	        const {'content-type' : contentType} = message.headers;
	        console.log('contentType : ', contentType);
	        if(!contentType) return;
	        
	        const {memberId, msg, time} = JSON.parse(message.body);
	        console.log("memberId = ", memberId);
	        console.log("msg = ", msg);
	        const html = `<li class="list-group-item">\${memberId} : \${msg}</li>`;
	        console.log("html = ", html);
	        container.insertAdjacentHTML('beforeend', html);
			
		});
		
		// 채팅리스트
		stompClient.subscribe("/app/chat/chatList", (message) => {
			console.log('/app/chat/chatList : ', message);
			const {chatroomId, memberId, msg, type} = JSON.parse(message.body);
			console.log(chatroomId, msg);
			const tbody = document.querySelector("#tbl-chat-list tbody");
			
			let tr = document.querySelector(`tr[data-chatroom-id=\${chatroomId}]`);
			if(tr) {
				const span = tr.querySelector("span.unread-count");
				switch(type) {
				case "LAST_CHECK" :
					span.innerText = 0;
					span.classList.add('d-none');
					break;
				case "CHAT" : 
					// 기존 채팅방 메세지
					tr.querySelector(".msg").innerHTML = msg;
					if(memberId != '${sellerId}') {
						let unreadCount = Number(span.innerText);
						span.innerText = unreadCount + 1;
						span.classList.remove('d-none');
					}
					// 끌어올리기
					tbody.insertAdjacentElement('afterbegin', tr);
					break;
				}
			} else {
				// 신규 채팅방 메세지
				tr = document.createElement('tr');
				tr.dataset.chatroomId = chatroomId;
				tr.dataset.memberId = memberId;
				const td1 = document.createElement('td');
				td1.append(memberId);
				const td2 = document.createElement('td');
				td2.classList.add('msg');
				td2.append(msg);
				const td3 = document.createElement('td');
				td3.classList.add('unread');
				const span = document.createElement('span');
				span.classList.add('badge', 'badge-danger', 'unread-count');
				span.append(1);
				td3.append(span);
				tr.append(td1, td2, td3);
				
				// 끌어올리기
				tbody.insertAdjacentElement('afterbegin', tr);
			}
		});	
	}, 500);
	
	window.addEventListener('focus', (e) => {
		lastCheck();
	});
	
	
});
	
	

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>