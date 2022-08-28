<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/trade/trade.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">	
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 px-5">
		<h3 class="mt-1 mb-5">판매내역</h3>
	    <div class="border-bottom mb-4 d-flex ">
	        <a href="${pageContext.request.contextPath}/mypage/trade/selling" class="d-block btn btn-dark">판매중</a>
	        <a href="${pageContext.request.contextPath}/mypage/trade/sold" class="d-block btn btn-outline-dark">판매완료</a>
	    </div>
		    <div class="list-container">
		    	<c:forEach items="${list}" var="product" varStatus="vs">
		       		<div class="d-flex justify-content-between mt-4 mb-4 list">
			            <div class="d-flex">
			            	<a href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=${product.productNo}"><img src="${pageContext.request.contextPath}/resources/upload/usedProduct/${product.productImg1}" alt="${product.productTitle}대표 이미지" width="120px" class="mr-3 ml-3"></a>
			                <div class="d-flex">
			                    <ul class="list-unstyled mt-2">
			                        <li>
			                            <a href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=${product.productNo}" class="text-dark font-weight-bold">${product.productTitle}</a>
			                        </li>
			                        <li><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원</li>
			                        <br>
			                        <li>${product.productLocation}</li>
			                    </ul>
			                </div>
			            </div>
	                    <div>
		                	<button class="btn btn-camper-color btn-sm align-self-center mr-3 my-2 d-block btn-delete" onclick="fillModal(${product.productNo});" data-toggle="modal" data-target="#buyerEnrollModal">판매완료 처리</button>
			                <a href="${pageContext.request.contextPath}/usedProduct/product/productUpdate?no=${product.productNo}" class="btn btn-camper-color btn-sm align-self-center mr-3 my-2 d-block" >게시글 수정</a>
	                        <form:form action="${pageContext.request.contextPath}/mypage/trade/productDelete" style="display:contents">
			                	<button class="btn btn-outline-camper-color btn-sm align-self-center mr-3 my-2 d-block btn-delete">삭제</button>
			                	<input type="hidden" name="productNo" value="${product.productNo}" />
			                </form:form>
	                    </div>
			        </div>
			        <hr />
				</c:forEach>
		    </div>
		</div>
	</div>
</div>
<div class="d-flex justify-content-center mt-3">
  <div class="spinner-border d-none" role="status">
    <span class="sr-only">Loading...</span>
    <input type="hidden" name="addNum" value="0" />
  </div>
</div>

<%-- EJ start --%>
<div class="modal fade" id="buyerEnrollModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">판매완료하기</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form:form action="" onsubmit="return false;" name="buyerUpdateFrm">
				<div class="modal-body mx-4">
					<input type="hidden" name="productNo" class="form-control form-control-sm">
					<input type="hidden" name="userExistResult" value="false" class="form-control form-control-sm">
					<label for="buyerId">구매자 ID 입력</label>
					<div class="input-group">
						<input type="text" name="buyerId" id="buyerId" class="form-control form-control-sm col">
						<div class="input-group-append">
							<button type="button" id="checkUserExistBtn" class="btn btn-sm btn-outline-camper-color">확인</button>
						</div>
					</div>
					<small class="resultMsg hide" id="buyerIdMsg"></small>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">뒤로가기</button>
					<button type="button" onclick="submitbuyerUpdateFrm();" class="btn btn-sm btn-camper-color">판매완료하기</button>
				</div>
			</form:form>
		</div>
	</div>
</div>
<script>
const fillModal = (productNo) => {
	document.buyerUpdateFrm.productNo.value = productNo;
};

const headers = {
	"${_csrf.headerName}" : "${_csrf.token}"
};

const checkBuyerId = () => {
	const buyerId = document.querySelector("#buyerId").value;
	if(buyerId === '${loginMember.memberId}'){
		document.buyerUpdateFrm.userExistResult.value = "false";
		return;
	}
	
		
	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/trade/buyerExist',
		type: 'POST',
		headers,
		data : {
			buyerId
		},
		success(response) {
			const {result} = response;
			if(result) {
				document.buyerUpdateFrm.userExistResult.value = "true";
			} else {
				document.buyerUpdateFrm.userExistResult.value = "false";				
			}
		},
		error: console.log
	});
};

document.querySelector("#checkUserExistBtn").addEventListener('click', (e) => {
	checkBuyerId();
	userExistResultValidation();
});

document.querySelector("#buyerId").addEventListener('change', (e) => {
	checkBuyerId();
});

const userExistResultValidation = () => {
	const frm = document.buyerUpdateFrm;
	const msgSmall = document.querySelector('#buyerIdMsg');
	const buyerId = document.querySelector("#buyerId").value;
	
	if(buyerId === '${loginMember.memberId}'){
		msgSmall.innerHTML = "판매자 아이디와 동일할 수 없습니다.";
	    msgSmall.classList.add('failMsg');
	    msgSmall.classList.remove('SuccessMsg');
	    msgSmall.classList.remove('hide');
	}
	else if(frm.userExistResult.value != "true") {
		msgSmall.innerHTML = "구매자 아이디가 유효하지 않습니다.";
	    msgSmall.classList.add('failMsg');
	    msgSmall.classList.remove('SuccessMsg');
	    msgSmall.classList.remove('hide');
	} else {
		msgSmall.innerHTML = "회원 정보를 찾았습니다.";
	    msgSmall.classList.add('SuccessMsg');
		msgSmall.classList.remove('failMsg');
	    msgSmall.classList.remove('hide');
	}
}

const submitbuyerUpdateFrm = () => {
	const frm = document.buyerUpdateFrm;
	const msgSmall = document.querySelector('#buyerIdMsg');
	
	if(frm.buyerId.value == "") {
		msgSmall.innerHTML = "구매자 아이디를 입력해주세요.";
	    msgSmall.classList.add('failMsg');
	    msgSmall.classList.remove('SuccessMsg');
	    msgSmall.classList.remove('hide');
	    return;
	} else {
		msgSmall.innerHTML = "";
	}
	
	userExistResultValidation();
	if(frm.userExistResult.value != "true") return;
	
	const productNo = Number(frm.productNo.value);
	const buyerId = frm.buyerId.value;

	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/trade/buyerUpdate',
		type: 'POST',
		headers,
		data: {
			productNo,
			buyerId
		},
		success(response) {
			const {result} = response;
			if(result) {
				$.confirm({
					title: '판매완료',
					content: '판매완료 상품으로 변경되었습니다.',
					buttons: {
						OK: function () {
							location.reload();
						}
					}
				});
			}
		},
		error: console.log
	});
};
</script>
<%-- EJ end--%>

<script>

const io = new IntersectionObserver((entries, observer) => {
	entries.forEach((entry) => {
  		$('div.spinner-border').removeClass("d-none");
	    if (entry.isIntersecting) {
	    	let list = null;
	    	observer.disconnect();
	    	 
	        $.ajax({
	        	url:'${pageContext.request.contextPath}/mypage/trade/moreSellingProduct',
	        	async: false,
	        	data:{
	        		offset: $('.list').length,
	        		},
	        	success(response){
	        		const {list} = response;
	        		$('input[name=addNum]').val(list.length) ;
	        		list.forEach((product) =>{
					const $prdDetailLink = '<a href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no='+product.productNo+'"></a>';  	        			
					const $br = '<br>';
					const $a = '<a></a>';
	        			
	        		$('.list-container').append('<div class="d-flex justify-content-between mt-4 mb-4 list"></div>');
	        		$('.list').last().append('<div class="d-flex"></div>');
	        		$('.list .d-flex').last().append($prdDetailLink, '<div class="d-flex"></div>');
	        		$('.list .d-flex a').last().append('<img src="${pageContext.request.contextPath}/resources/upload/usedProduct/' + product.productImg1 +'" alt="'+ product.productTitle +'대표 이미지" width="120px" class="mr-3 ml-3">');
	        		$('.list .d-flex').last().append('<ul class="list-unstyled mt-2"></ul>');
	        		$('.list ul.list-unstyled').last().append('<li></li>');
	        		$('.list li').last().append($prdDetailLink);
	        		$('.list a').last().prop({
	        			innerHTML:product.productTitle,
	        			className: 'font-weight-bold text-dark'
	        		});
	        		$('.list ul.list-unstyled').last().append('<li>'+ product.productPrice +'원</li>', $br, '<li>'+ product.productLocation +'</li>');
	        		$('.list').last().append('<div></div>');
	        		$('.list div').last().append('<button class="btn btn-camper-color btn-sm align-self-center mr-3 my-2 d-block btn-delete" onclick="fillModal('+product.productNo+');" data-toggle="modal" data-target="#buyerEnrollModal">판매완료 처리</button>');
	        		$('.list div').last().append($a,'<form action="${pageContext.request.contextPath}/mypage/trade/productDelete" style="display:contents" method="post"></form>');
	        		$('.list a').last().prop({
	        			innerHTML: '게시글 수정',
	        			className: 'btn btn-camper-color btn-sm align-self-center mr-3 my-2 d-block',
	        			href:'${pageContext.request.contextPath}/usedProduct/product/productUpdate?no=' + product.productNo
	        		});
	        		$('.list div form').last().append('<button></button>','<input type="hidden" name="productNo" value="' + product.productNo + '" />','<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>');
	        		$('.list button').last().prop({
	        			innerHTML: '삭제',
	        			className: 'btn btn-outline-camper-color btn-sm align-self-center mr-3 d-block',
	        		});
	        		$('.list-container').append($('<hr>'));
	        		} );
	        	},
  	    		error: console.log
	        });
	        
	    	$('div.spinner-border').addClass("d-none");
	  	    	if($('input[name=addNum]').val() !== '0')
					io.observe($('.list').get($('.list').length-1));
			  	return;
		}
	});
});

io.observe($('.list').get($('.list').length-1));

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />