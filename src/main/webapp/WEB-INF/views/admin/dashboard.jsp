<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- chartJs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<div class="container" style="display: flex;" id="admin-container">
	<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />
	<div class="admin-content" style="width: 80%;">
		<h5 class="admin-hd">관리자 대시보드</h5>

		<div class="camper-hd" style="margin-top: 40px;">


			<div class="container" style="color: #777;">
				<div class="row">
					<div class="col-md-6 se-box">
						<h2 class="a-title">신규 회원 추이</h2>
						<div>
							<canvas id="member-graph"></canvas>
						</div>

					</div>
					<div class="col-md-5 se-box">
						<h2 class="a-title">1주간 게시판별 글 등록 수</h2>
						<div>
							<canvas id="board-graph" width="360" height="200"></canvas>
						</div>
					</div>

					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12 se-box">
								<h2 class="a-title">애드머니 결제 현황</h2>
								<div>
									<canvas id="money-graph"></canvas>
								</div>
							</div>
							<div class="col-md-12 se-box">
								<h2 class="a-title">To Do List</h2>
								<div class="to-do">
								
								<div class="todolist">
								<form action="${pageContext.request.contextPath}/admin/insertTodo" class="form-inline mb-1" method="post">
								 <input type="text" class="form-control ml-2 todo-input" name="todo" placeholder="할 일을 입력하세요." style="width: 375px; font-size: 15px;" required/>
        							<button class="btn-hover color-5 btn btn-outline-success" type="submit" ><i class="fa-solid fa-plus"></i></button> 
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								</form>
								</div>

									<table class="table tb-todo" style="color: #777;">
										<c:forEach items="${todo}" var="todo" varStatus="vs">
										<tr>
											<th class="col-md-1"><input type="checkbox" value="${todo.todoNo}" class="isCompleted" ${not empty todo.completedAt ? 'checked' : ''}></th>
											<td style="font-size: 0.92rem; font-weight: bold;">${todo.todo}</td>
											<td class="col-md-1">
											<button class="x-icon btn-delete" data-todo-no="${todo.todoNo}">
													X
												</button></td>
										</tr>
										</c:forEach>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-5 se-box" style="margin-left: 30px;">
						<h2 class="a-title">관리자 최근 작성글</h2>
						<div class="write-div">
							<ul class="write-ul">
											<c:forEach items="${list}" var="list" varStatus="vs">
							
								<li>
									<h2 class="sub-title">
										<span class="timeline"></span>
							<c:if test="${list.category eq 'NOTICE'}">
										<a href="${pageContext.request.contextPath}/cs/noticeDetail?noticeNo=${list.noticeNo}">${list.title}</a>
							</c:if>
							<c:if test="${list.category eq 'FAQ'}">
										<a href="${pageContext.request.contextPath}/cs/faq">${list.title}</a>
							</c:if>
									</h2>
									<%-- <p class="write-content">${list.content}</p> --%>
									
									
									<p class="write-content">
									<c:choose>
									        <c:when test="${fn:length(list.content) > 140}">
									        ${fn:substring(list.content, 0, 139)}...
									        </c:when>
									        <c:otherwise>
									        ${list.content}
									        </c:otherwise>
									</c:choose>
										</p>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form action="${pageContext.request.contextPath}/admin/updateTodo" name="todoUpdateFrm" method="post">
	<input type="hidden" name="todoNo" />
	<input type="hidden" name="isCompleted" />
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<form action="${pageContext.request.contextPath}/admin/deleteTodo" name="todoDeleteFrm" method="post">
<input type="hidden" name="todoNo" />
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<script>
document.querySelectorAll('.btn-delete').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		document.todoDeleteFrm.todoNo.value = e.target.dataset.todoNo;
		document.todoDeleteFrm.submit();
	})
});

document.querySelectorAll(".isCompleted").forEach((checkbox) => {
	checkbox.addEventListener('change', (e) => {
		const {value, checked} = e.target;
		const frm = document.todoUpdateFrm;
		frm.todoNo.value = value;
		frm.isCompleted.value = checked;
		frm.submit();
	});
});


var now = new Date();
var sysdate = now.getDate();
var minus1 = now.getDate() -1;
var minus2 = now.getDate() -2;
var minus3 = now.getDate() -3;
var minus4 = now.getDate() -4;
var minus5 = now.getDate() -5;
var minus6 = now.getDate() -6;

var month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
	  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
	];

var m = new Date();

var contextMember = document.getElementById('member-graph').getContext('2d');
var memberGraph = new Chart(contextMember, {
	type : 'bar', 
	data : { 
		labels : [
		month[m.getMonth()] +' '+ minus6, month[m.getMonth()] +' '+ minus5, month[m.getMonth()] +' '+ minus4, month[m.getMonth()] +' '+ minus3, month[m.getMonth()] +' '+ minus2, month[m.getMonth()] +' '+ minus1, month[m.getMonth()] +' ' + sysdate],
		datasets : [ { 
			label : '회원가입 수', 
			fill : false, 
			data : [ ${minus6}, ${minus5}, ${minus4}, ${minus3}, ${minus2}, ${minus1}, ${sysdate} 
			],
			backgroundColor : [
			"#209e91", "#0e8174", "#639A67", "#005562", "#9DC183",
					"#4B5320", "#8A9A5B" ],
			borderColor : [
			"#209e91", "#0e8174", "#639A67", "#005562", "#9DC183",
					"#4B5320", "#8A9A5B" ],
			borderWidth : 1
		} ]
	},
	options : {
		legend : {
			display : false
		},
		scales : {
			yAxes : [ {
				ticks : {
					beginAtZero : true
				}
			} ]
		}
	}
});

// 애드머니 결제 현황
var contextAd = document.getElementById('money-graph').getContext('2d');
var moneyGraph = new Chart(contextAd, {
	type : 'line', 
	data : { 
		labels : ['5일전', '4일전', '3일전', '2일전', '1일전', '오늘' ],
		datasets : [{ 
			label : '총 결제금액',
			fill : true, 
			data : [ ${adMinus5}, ${adMinus4}, ${adMinus3}, ${adMinus2}, ${adMinus1}, ${adSysdate} 
			],
			backgroundColor : [
			'rgba(32, 158, 145, 0.5);', 'rgba(54, 162, 235, 0.2)' ],
			borderColor : [
			'rgba(32, 158, 145, 0.5);' ],
			borderWidth : 1
		}]
	},
	options : {
		responsive: true,
		legend : {
			display : false
		},
		scales : {
			yAxes : [{
				ticks : {
					beginAtZero : true
				}
			}]
		}
	}
});

// 등록글 수
var contextBoard = document.getElementById('board-graph').getContext('2d');
var boardGraph = new Chart(contextBoard,
		{
			type : 'doughnut',
			data : {
				labels : [ "캠퍼모집", "캠핑장 후기", "캠핑용품거래" ],
				datasets : [ {
					labels : [ "캠퍼모집", "캠핑장 후기", "캠핑용품거래" ],
					fill : true,
					data : [${camper}, ${review}, ${product}],
					backgroundColor : [ "#005562", "#0e8174", "#b9f2a1"],
					borderColor : [ "#005562", "#0e8174", "#b9f2a1"],
					borderWidth : 1
				} ]
			},
			options : {
				legend : {
					display : true,
					position : "right"
				},

				responsive : false,

			},

		});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>