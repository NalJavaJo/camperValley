<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tradereview/reportEnroll.css" />
<div class="modal fade" id="reportEnroll">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content px-5 py-2">
				<div class="modal-header">
					<div>
						<div class="text-20">
						<i class="fa-solid fa-circle-exclamation fa-lg pr-1" style="color:#d9bf77;"></i>
						<span>신고하기</span>
						</div>
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form:form id="reportEnrollFrm" action="${pageContext.request.contextPath}/tradereview/reportEnroll" name="reportEnrollFrm" method="POST">
					<div class="modal-body px-0 my-3">
						<div class="gubun gubun-first px-3 py-2">
							<div class="d-flex justify-content-between">
								<div class="py-1 text-15">언어 폭력(욕설 및 성희롱)</div>
							 	<div class="sliding"><i class="fa-solid fa-angle-down pt-2"></i></div>
							</div>
							<div>
								<textarea id="language" class="p-2" cols="45" rows="5" placeholder="신고내용을 적어주세요." spellcheck="false"></textarea>
							</div>
						</div>
						<div class="gubun px-3 py-2">
							<div class="d-flex justify-content-between">
								<div class="py-1 text-15">광고</div>
							 	<div class="sliding"><i class="fa-solid fa-angle-down pt-2"></i></div>
							</div>
							<div>
								<textarea id="ad" class="p-2" cols="45" rows="5" placeholder="신고내용을 적어주세요." spellcheck="false"></textarea>
							</div>
						</div>
						<div class="gubun px-3 py-2">
							<div class="d-flex justify-content-between">
								<div class="py-1 text-15">게시글과 무관</div>
							 	<div class="sliding"><i class="fa-solid fa-angle-down pt-2"></i></div>
							</div>
							<div>
								<textarea id="relation" class="p-2" cols="45" rows="5" placeholder="신고내용을 적어주세요." spellcheck="false"></textarea>
							</div>
						</div>
						<div class="gubun px-3 py-2">
							<div class="d-flex justify-content-between">
								<div class="py-1 text-15">기타</div>
							 	<div class="sliding"><i class="fa-solid fa-angle-down pt-2"></i></div>
							</div>
							<div>
								<textarea id="etc" class="p-2" cols="45" rows="5" placeholder="신고내용을 적어주세요." spellcheck="false"></textarea>
							</div>
						</div>
					
					</div>
                    <div class="modal-footer justify-content-center">
						<div>
							<button type="submit" class="btn btn-outline-camper-color px-5 m-2">등록</button>
							<button type="button" class="btn btn-outline-danger px-5 m-2" data-dismiss="modal" onclick="cancle();">취소</button>
						</div>
	                </div>
	                <input id="category" name="category" type="hidden" />
	                <input id="reviewNo" name="reviewNo" type="hidden" />
	                <input id="productNo" name="productNo" type="hidden" />
				</form:form>
			</div>
		</div>
	</div>
</body>
<script>
$(document).ready(() => {
	$("textarea").hide();
});
document.querySelectorAll(".sliding i").forEach((i) => {
	i.addEventListener("click", (e) => {
		$("#reportEnrollFrm textarea").val("");
		const iTag = e.target;
		const category = $(iTag).attr('id');
		
		if($(iTag).hasClass("fa-angle-down")) {
			$("textarea").stop().hide();
			$(".gubun i").removeClass("fa-angle-up").addClass("fa-angle-down");
			$(".gubun").css("backgroundColor", "white");
		
			$(iTag).removeClass("fa-angle-down").addClass("fa-angle-up");
			$(iTag).parent().parent().parent().css("backgroundColor", "rgb(245, 245, 245)");
			$(iTag).parent().parent().next().children("textarea").stop().slideDown('fast');
			
		} else {
			$(iTag).removeClass("fa-angle-up").addClass("fa-angle-down");
			$(iTag).parent().parent().parent().css("backgroundColor", "white");
			$(iTag).parent().parent().next().children("textarea").stop().slideUp('fast');
		}
	});
});

const frm = document.reportEnrollFrm;
frm.addEventListener("submit", (e) => {
	$("textarea").removeAttr('name');
	e.preventDefault();
	if(!$("#language").val() && !$("#ad").val() && !$("#relation").val() && !$("#etc").val()) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '신고내용을 입력해주세요.',
		    buttons: {'확인': function() {}}
		});
		e.preventDefault();
		return;
	}
	if($("#language").val()) {
		$("#category").val("language");
		$("#language").attr('name', 'content');
	}
	if($("#ad").val()) {
		$("#category").val("ad");
		$("#ad").attr('name', 'content');
	}
	if($("#relation").val()) {
		$("#category").val("relation");
		$("#relation").attr('name', 'content');
	}
	if($("#etc").val()) {
		$("#category").val("etc");
		$("#etc").attr('name', 'content');
	}
	$.alert({
	    title: ' ',
	    content: '신고하시겠습니까?',
	    buttons: {
	    	'확인': function() {
	    		frm.submit();
	    	},
	    	'취소' : function() {}
	    }
	});
});

const cancle = () => {
	$.alert({
	    title: ' ',
	    content: '등록이 취소되었습니다.',
	    buttons: {
	    	'확인': function() {}
	    }
	});
}

</script>
</html>