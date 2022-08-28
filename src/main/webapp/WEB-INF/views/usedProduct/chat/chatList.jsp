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


<div class="input-group mb-3">
 	 <input type="hidden" name="no" id="no" value="${no}"/>
<%--	 <input type="text" id="msg" class="form-control" placeholder="유저에게 보내는 Message">
	 <div class="input-group-append" style="padding: 0px;">
	 	<button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
	  </div> 
	
	<div class="group">
		<ul class="list-group list-group-flush" id="msg-container"></ul>
		<c:forEach items="${chatLogList}" var="chatLog">
			<li class="list-group-item">${chatLog.memberId} : ${chatLog.msg}</li>
		</c:forEach>
	</div>	
	<br />
	<br />
	<br /> --%>
	
	<table class="table text-center"></table>
</div>

<script>
const chatroomId = '${chatroomId}';
</script>
<script>
var no = $('#no').val();
$(document).ready(function () {
var seller = "";
	
    $.ajax({
        url : '/campervalley/chat/chatList',
        type : 'GET',
        async : false,
        data : { 
        	no : no
        },
        dataType : 'json',
	   	success : function(data) {
	   		
	   		if(data.list != null) {
		   	    var html = "<table class=table text-center>";
		   	 	html += "<tr align = 'center'>";
		   		html += "<th scope=col>회원 이미지</th>";
		   		html += "<th scope=col>회원 아이디</th>";
		   		html += "<th scope=col>메세지</th>";
		   		html += "<th scope=col>안읽은 메세지 수</th>";
		   		html += "</tr>";
		   		$.each(data.list, function(key, value){
		   			html += "<tr align = 'center'>";
		   			html += "<td><img src = /campervalley/resources/images/member/" + value.memberImg + "></td>";
		   			html += "<td>" + value.memberId + "</td>";
		   			html += "<td>" + value.msg + "</td>";
		   			html += "<td>" + 0 + "</td>";
		   			html += "</tr>";
		   		});
		   		
		   		
		   		html += "</table>";
		   		$(".table").append(html);
	   			
	   		}
	   	}, 
        error : function() {
        }

      });

   $.ajax({
        type : 'GET',
        url : '/campervalley/usedProduct/product/getSellerInfo',
        data : {
           productNo : no
        },
        dataType : 'json',
        async : false,
        success : function(data) {
        	var sellerId = data.member.memberId;
            	console.log(sellerId);
            	console.log(memberId);
            
            if(sellerId == memberId) {
            	var trans = '<input type="submit" id="transaction_btn" value="거래완료"/>'
            	$(".input-group").append(trans);
            	
            	
            } else {
            	var trans = '<input type="hidden" id="transaction_btn" value=""/>'
                	$(".input-group").append(trans);
            
            
            }
        }, error : function() {
           alert('에러!');
        }
        
        
     });
        return seller;
     
});


</script>
<script src="${pageContext.request.contextPath}/resources/js/chat/chat.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>