<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tradereview/reviewUpdate.css" />
<div class="modal fade" id="reviewUpdate">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content px-5 py-2">
				<div class="modal-header">
					<div>
						<div class="text-20">거래후기</div>
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form:form action="${pageContext.request.contextPath}/tradereview/reviewUpdate" name="reviewUpdateFrm" method="POST">
					<div class="modal-body">
						<div class="text-13 text-secondary">&#183; 작성하신 후기는 다른 회원들에게 공개됩니다.</div>
						<div class="text-13 text-secondary">&#183; 개인정보 및 광고, 비속어가 포함된 내용의 후기는 신고의 대상이 될 수 있습니다.</div>
						<table class="mt-3">
							<tbody>
								<tr>
									<td class="label col-md-2 px-0 py-2">
										<div>별점</div>
									</td>
									<td class="col-md-10 px-0 py-2">
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star pr-2"></i>
										<span><input id="starScore" name="starScore" type="text" value="5" readonly/>점</span>
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 py-2">
										<label for="ctent">내용</label>
									</td>
									<td class="col-md-10 px-0 py-2">
										<textarea id="ctent" class="p-2" maxlength="60" name="content" cols="100" rows="3" style="width:100%" placeholder="내용을 입력하세요." spellcheck="false"></textarea>
										<div class="text-13 text-right"><span id="wordCount">0</span>/60자</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
                    <div class="modal-footer justify-content-center">
						<div>
							<button type="submit" class="btn btn-outline-camper-color px-4 py-0 m-2">수정</button>
							<button id="deleteBtn" type="button" class="btn btn-outline-danger py-0 px-4 my-2">삭제</button>
						</div>
	                </div>
	                <input class="reviewNo" name="reviewNo" type="hidden" />
				</form:form>
				<form:form name="reviewDeleteFrm" action="${pageContext.request.contextPath}/tradereview/reviewDelete" method="post">
	                <input class="reviewNo" name="reviewNo" type="hidden" />
				</form:form>
			</div>
		</div>
	</div>
</body>
<script>
document.querySelectorAll("#reviewUpdate .fa-star").forEach((star) => {
	star.addEventListener("click", (e) => {
		$("#reviewUpdate .fa-star").css("color", "rgb(235, 235, 235)");
		const index = $(e.target).index();
		for(let i = 0; i < 5; i++) {
			if(i <= index) $(`.fa-star:nth-child(\${i+1})`).css("color", "rgb(230, 185, 20)");
		}
		$("#reviewUpdate #starScore").val(`\${index + 1}`);
	});
});

document.querySelector("#reviewUpdate #ctent").addEventListener("keyup", () => {
	$("#reviewUpdate #wordCount").html($("#reviewUpdate #ctent").val().length);
});


const updateFrm = document.reviewUpdateFrm;
updateFrm.addEventListener("submit", (e) => {
	if(!updateFrm.content.value) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '내용을 입력해주세요.',
		    buttons: {'확인': function() {}}
		});
		e.preventDefault();
	}
});
const deleteFrm = document.reviewDeleteFrm;

document.querySelector("#reviewUpdate #deleteBtn").addEventListener("click", () => {
	$.alert({
		icon: 'fa fa-warning',
	    title: '',
	    content: '삭제하시겠습니까?',
	    buttons: {
	    	'삭제': function() {
	    		deleteFrm.submit();
	    	},
	    	'취소': function() {}
		}
	});
});
</script>
</html>