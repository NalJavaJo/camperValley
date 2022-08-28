<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/camper/camperList.css" />
	<div class="container-md campsite-review-list-wrap pt-2">
		<jsp:include page="/WEB-INF/views/community/communityHeading.jsp"/>
			<div class="col-md float-right">
				<div class="input-group align-items-center community-search-enroll">
			    	<select id="searchType" class="custom-select btn-outline-success btn-outline-camper-color">
						<option value="" disabled selected>선택</option>
						<option value="nickname" ${param.searchType eq "nickname" ? "selected" : ""}>작성자</option>
					   	<option value="title" ${param.searchType eq "title" ? "selected" : ""}>제목</option>
					    <option value="content" ${param.searchType eq "content" ? "selected" : ""}>내용</option>
					</select>
					<input type="text" id="searchKeyword" value="${param.searchKeyword}" name="searchKeyword" class="form-control border-camper-color community-search-input" placeholder="검색어를 입력하세요." aria-label="Recipient's username" aria-describedby="communitySearchBtn">
				  	<div class="input-group-append">
				    	<button class="btn btn-outline-success btn-outline-camper-color" type="button" id="communitySearchBtn">
				    		<i class="fa-solid fa-magnifying-glass camper-color"></i>
				    	</button>
				  	</div>
				  	<c:if test="${not empty loginMember}">
						<div class="ml-1">
							<button type="button" id="communityEnrollBtn" class="btn btn-success bg-camper-color" onclick="location.href='${pageContext.request.contextPath}/community/camper/camperEnroll'">글쓰기</button>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		<div class="pl-3 d-flex justify-content-between mt-4">
			<div id="listSection">
				<label for="isChk" class="chk_box">
					<input type="checkbox" id="isChk" checked="checked" />
					<span class="on"></span>
					모집중 게시글만 조회
				</label>
				<div id="boardBoxSection">
				</div>
			</div>
			<div class="pl-5">
				<div id="detailSection" class="boardBoxSelect p-5 mb-4 d-flex flex-column justify-content-between">
					<div id="detailHeader" class="pb-3">
						<div id="title" class="font-weight-bold text-25"></div>
						<div id="nickname" class="font-weight-bold text-15 text-right py-3"></div>
						<div class="d-flex justify-content-between">
							<div>
								<div id="area" class="font-weight-bold text-13"></div>
								<div id="dates" class="font-weight-bold text-13"></div>
							</div>
							<div>
								<div id="memberCount" class="font-weight-bold text-15 text-right text-danger"></div>
								<div id="status" class="font-weight-bold text-13 text-right"></div>
							</div>
						</div>
					</div>
					<div id="detailBody">
						<div class="font-weight-bold py-2">상세내용</div>
						<div id="ctent" ></div>
						<div class="font-weight-bold py-2">모임취지</div>
						<div id="purpose" ></div>
						<div class="font-weight-bold py-2">예상비용</div>
						<div id="expectedCost"></div>
					</div>
					<div id="detailFooter" class="mt-4">
						<label for="basic-url" class="text-15">오픈채팅방에서 자유롭게 소통해요!</label>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon3">URL</span>
							</div>
							<input id="chatUrl" type="text" class="form-control bg-light" aria-describedby="basic-addon3" readonly>
							<input type="hidden" name="camperNo" />
						</div>
						<div id="loginMemberSection">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%-- update modal --%>
	<jsp:include page="/WEB-INF/views/community/camper/camperUpdate.jsp"/>
<script>
let cPage = 1;

$(document).ready(() => {
	$(review).removeClass("active");
	$(camper).addClass("active");
	const firstBoardBox = renderBoardBoxMore();
	if(firstBoardBox.length == 0) {
		// 조회된 검색결과 x
		$("#boardBoxSection").html("");
		$("#detailSection").html("").removeClass("boardBoxSelect");
		const $result = $('<div class="my-5 py-4 text-20">에 대한 검색결과가 없습니다.</div>');
		const $keyword = $('<span class="text-danger text-20">"${param.searchKeyword}"</span>');
		const $info1 = $('<div class="pt-5 pb-2 text-13">&#183;&nbsp;단어의 철자가 정확한지 확인해 보세요.</div>');
		const $info2 = $('<div class="py-2 text-13">&#183;&nbsp;한글을 영어로 혹은 영어를 한글로 입력했는지 확인해 보세요.</div>');
		const $info3 = $('<div class="py-2 text-13">&#183;&nbsp;검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요.</div>');
		$result.prepend($keyword);
		$result.append($info1, $info2, $info3);
		$("#listSection").append($result);
	} else {
		$("#detailSection").addClass("boardBoxSelect");
		renderBoardBoxDetail(firstBoardBox);
	}
});

// 검색
document.querySelector("#communitySearchBtn").addEventListener("click", (e) => {
	const searchType = $("#searchType").val();
	const searchKeyword = $("#searchKeyword").val();
	if(!searchType || ! searchKeyword) return false;
	location.href = `${pageContext.request.contextPath}/community/camper/camperList?searchType=\${searchType}&searchKeyword=\${searchKeyword}`;
});

// 모집중 게시글만 조회 toggle 클릭 시 더보기/상세보기 비동기 요청
document.querySelector(".chk_box").addEventListener('change', ()=> {
	if(!$("#boardBoxSection").html()) return; // 만족하는 게시글 없을 시 요청x
	$("#boardBoxSection").html("");
	cPage = 1;
	if(document.querySelector("#isChk").checked) {
		$(".chk_box > span").removeClass("off").addClass("on");
		renderBoardBoxDetail(renderBoardBoxMore()); // 체크/체크해제 시 chk값 분기처리 필요
	} else {
		$(".chk_box > span").removeClass("on").addClass("off");
		renderBoardBoxDetail(renderBoardBoxMore("selectAll")); // 체크/체크해제 시 chk값 분기처리 필요
	}
});

// 스크롤 시 게시글 더보기 비동기요청
const docHeight = $(document).height();
const winHeight = $(window).height();
let timer;
$(document).scroll(function () {
	if(timer) clearTimeout(timer);
	timer = setTimeout(() => {
		if(document.querySelector("#listSection").getBoundingClientRect().bottom < $(window).height()) {
			cPage++;
			if(document.querySelector("#isChk").checked) renderBoardBoxMore();
			else renderBoardBoxMore("selectAll");
		}
	}, 500);
});

// camperNo로 상세보기 비동기 요청처리
const renderBoardBoxDetail = (boardBox) => {
	$("#listSection .boardBoxSelect").removeClass("boardBoxSelect").addClass("boardBox");
	$(boardBox).removeClass("boardBox").addClass("boardBoxSelect");
	
	const $hidden = $(boardBox).find(".hidden");
	const camperNo = $hidden.data("no");
	// detailBox 비동기 요청
	$.ajax({
		url: "${pageContext.request.contextPath}/community/camper/camperDetail",
		data: {camperNo},
		success(response) {
			const {camper} = response;
			$("#title").html(camper.title);
			$("#nickname").html(camper.nickname + "님");
			$("#area").html(camper.area);
			const departureDate = camper.departureDate;
			const arrivalDate = camper.arrivalDate;
			$("#dates").html(departureDate.year + "." + f(departureDate.monthValue) + "." + f(departureDate.dayOfMonth) + " ~ " + arrivalDate.year + "." + f(arrivalDate.monthValue) + "." + f(arrivalDate.dayOfMonth));
			$("#memberCount").html(camper.memberCount + "명");
			if(camper.status === "I") {
				$("#status").html("모집중");
				$("#status").removeClass("text-danger");
			} else{
				$("#status").html("모집완료");
				$("#status").addClass("text-danger");
			}
			$("#ctent").html(camper.content);
			$("#purpose").html(camper.purpose);
			$("#expectedCost").html(camper.expectedCost);
			$("#chatUrl").val(camper.chatUrl);
			$("#loginMemberSection").html("");
			if(${not empty loginMember}) {
				if("${loginMember.memberId}" == camper.memberId) {
					const $frm = $(`<form name="deleteFrm" class="text-right" action="${pageContext.request.contextPath}/community/camper/camperDelete?camperNo=\${camperNo}" method="post"></form>`);
					const $updateBtn = $('<button type="button" class="btn btn-outline-camper-color text-13 px-4 mx-2">수정</button>');
					const $deleteBtn = $('<button type="button" class="btn btn-outline-danger text-13 px-4">삭제</button>');
					const $inputHidden = $('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>');
					$updateBtn.on("click", () => {
						const areas = (camper.area).split(" ");
						document.querySelectorAll("#sido1 option").forEach((option) => {
							if(areas[0] === $(option).val()) {
								$(option).prop("selected", true).change();
							}
						});
						document.querySelectorAll("#gugun1 option").forEach((option) => {
							if(areas[1] === $(option).val()) {
								$(option).prop("selected", true);
							}
						});
						$("#camperUpdate #departureDate").val(`\${camper.departureDate.year}-\${f(camper.departureDate.monthValue)}-\${f(camper.departureDate.dayOfMonth)}`);
						$("#camperUpdate #arrivalDate").val(`\${camper.arrivalDate.year}-\${f(camper.arrivalDate.monthValue)}-\${f(camper.arrivalDate.dayOfMonth)}`);
						$("#camperUpdate #memberCount").val(camper.memberCount);
						$("#camperUpdate #title").val(camper.title);
						$("#camperUpdate #content").val(camper.content);
						$("#camperUpdate #purpose").val(camper.purpose);
						$("#camperUpdate #expectedCost").val(camper.expectedCost);
						$("#camperUpdate #chatUrl").val(camper.chatUrl);
						$("#camperUpdate #camperNo").val(camperNo);
						
						$("#camperUpdate")
						.modal()
						.on('hide.bs.modal');
					});
					$deleteBtn.on("click", () => {
						$.confirm({
						    icon: 'fa fa-warning',
						    title: '',
						    content: '삭제하시겠습니까?',
						    buttons: {
						    	확인: function () {
									$frm.submit();
						    	},
						    	취소: function () {}
								
						    }
						});
					});
					$frm.append($updateBtn, $deleteBtn, $inputHidden);
					$("#loginMemberSection").append($frm);
				}
			}
			
		},
		error: console.log
	});
}

const renderBoardBoxMore = (isChk) => {
	$.ajax({
		url: "${pageContext.request.contextPath}/community/camper/moreCamperList",
		data: {
				cPage, isChk, 
				searchType : "${searchType}", searchKeyword : "${searchKeyword}"},
		async: false,
		success(response) {
			const {camperList} = response;
			for(let i = 0; i < camperList.length; i++) {
				const $boardBox = $('<div class="boardBox my-4 p-4" onclick="renderBoardBoxDetail(this);"></div>');
				// 현재 로그인된 아이디와 동일할 때
				if (${not empty loginMember}) {
					if("${loginMember.memberId}" == camperList[i].memberId) {
						const $dropFrm = $(`<form name="deleteFrm" action="${pageContext.request.contextPath}/community/camper/camperDelete?camperNo=\${camperList[i].camperNo}" method="post"></form>`);
						const $dropInputHidden = $('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>');
						const $drop = $('<div class="drop-down drop-down-1"></div>');
						const $dropDiv1 = $('<div class="selected text-right"></div>');
						const $dropI = $('<i class="fa-solid fa-ellipsis-vertical d-block" onclick="dropdown(this);"></i>');
						const $dropDiv2 = $('<div class="options text-right"></div>');
						const $dropUl = $('<ul class="border-top border-dark"></ul>');
						const $dropLi1 = $('<li>수정</li>');
						$dropLi1.on("click", (li) => {
							$(li).closest('ul').hide();
							const areas = camperList[i].area.split(" ");
							document.querySelectorAll("#sido1 option").forEach((option) => {
								if(areas[0] === $(option).val()) {
									$(option).prop("selected", true).change();
								}
							});
							document.querySelectorAll("#gugun1 option").forEach((option) => {
								if(areas[1] === $(option).val()) {
									$(option).prop("selected", true);
								}
							});
							$("#camperUpdate #departureDate").val(`\${camperList[i].departureDate.year}-\${f(camperList[i].departureDate.monthValue)}-\${f(camperList[i].departureDate.dayOfMonth)}`);
							$("#camperUpdate #arrivalDate").val(`\${camperList[i].arrivalDate.year}-\${f(camperList[i].arrivalDate.monthValue)}-\${f(camperList[i].arrivalDate.dayOfMonth)}`);
							$("#camperUpdate #memberCount").val(camperList[i].memberCount);
							$("#camperUpdate #title").val(camperList[i].title);
							$("#camperUpdate #content").val(camperList[i].content);
							$("#camperUpdate #purpose").val(camperList[i].purpose);
							$("#camperUpdate #expectedCost").val(camperList[i].expectedCost);
							$("#camperUpdate #chatUrl").val(camperList[i].chatUrl);
							$("#camperUpdate #camperNo").val(camperList[i].camperNo);
							
							$("#camperUpdate")
							.modal()
							.on('hide.bs.modal');
						});
						const $dropLi2 = $('<li>삭제</li>');
						$dropLi2.on("click", (li) => {
							$(li).closest('ul').hide();
							$.confirm({
							    icon: 'fa fa-warning',
							    title: '',
							    content: '삭제하시겠습니까?',
							    buttons: {
							    	확인: function () {
										$dropFrm.submit();
							    	},
							    	취소: function () {}
									
							    }
							});
						});
						$dropUl.append($dropLi1, $dropLi2);
						$dropDiv2.append($dropUl);
						$dropDiv1.append($dropI);
						$drop.append($dropDiv1, $dropDiv2);
						$dropFrm.append($dropInputHidden, $drop);
						$boardBox.append($dropFrm);
					}
				}
				const $info = $('<div class="boardBoxSelectInfo"></div>');
				const $title = $('<div class="font-weight-bold text-20 pb-4"></div>');
				$title.html(camperList[i].title);
				const $area = $('<div class="font-weight-bold text-13"></div>');
				$area.html(camperList[i].area);
				const $dates = $('<div class="font-weight-bold text-13"></div>');
				const departureDate = camperList[i].departureDate;
				const arrivalDate = camperList[i].arrivalDate;
				$dates.html(departureDate.year + "." + f(departureDate.monthValue) + "." + f(departureDate.dayOfMonth) + " ~ " + arrivalDate.year + "." + f(arrivalDate.monthValue) + "." + f(arrivalDate.dayOfMonth)); 
				const $content = $('<div class="py-4"></div>');
				camperList[i].content.length > 110 ? $content.html(camperList[i].content.substring(0, 110) + "...") : $content.html(camperList[i].content); 
				const $status = $('<div class="text-13">');
				if(camperList[i].status === "I") {
					$status.html("모집중");
				} else{
					$status.html("모집완료");
					$status.addClass("text-danger");
				}
				const $camperNo = $('<input class="hidden" type="hidden"/>');
				$camperNo.data("no", camperList[i].camperNo);
				$info.append($title, $area, $dates, $content, $status, $camperNo);
				$boardBox.append($info);
				
				$("#boardBoxSection").append($boardBox);
			}
		},
		error: console.log
	});
	// boardBoxSection의 첫번째 요소 리턴
	return $("#boardBoxSection").find(":first");
}

const f = (n) => n < 10 ? "0" + n : n;

// open 채팅방 url 클릭시 새창열기
document.querySelector("#chatUrl").addEventListener("click", (e) => {
	const urlValue = $(e.target).val();
	window.open(urlValue);
});

// dropdown toggle
const dropdown = (iTag) => {
	const $options = $(iTag).parent().siblings('.options');
    $options.find('> ul').toggle();
}
$(document).bind('click', function(e) {
    const $clicked = $(e.target);
    if (!$clicked.parents().hasClass("drop-down")){
        $(".drop-down .options ul").hide();
    }
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />