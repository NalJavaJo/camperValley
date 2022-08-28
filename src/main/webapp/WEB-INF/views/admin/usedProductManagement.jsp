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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<div class="container" style="display: flex;" id="admin-container">
	<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />
	<div class="admin-content" style="width: 80%;">
		<h5 class="admin-hd">캠핑용품 거래 관리</h5>
		<div class="product-hd" style="margin-top:40px;">
				<div class="float-right">
					<button type="button" class="btn-delete btn btn-danger btn-sm">선택삭제
					</button>
				</div>
					<div class="search-group float-left mb-2">
					<select id="search-type">
						<option value="product_title" ${map.searchType eq 'product_title' ? 'selected' : ''}>제목</option>
						<option value="product_content" ${map.searchType eq 'product_content' ? 'selected' : ''}>내용</option>
					</select>
						<input class="input-search" type="text" placeholder="검색어 입력" name="searchKeyword" id="searchKeyword">
						<button class="btn-search" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div> <!--product-hd-->
					
			<table class="table table-hover text-center" id="tb-admin">
				<thead>
					<tr>
						<th class="col-md-1"><input name="checkAll" id="checkAll" type="checkbox" /></th>
						<th class="col-md-1">No.</th>
						<th class="col-md-6">제목</th>
						<th>아이디</th>
						<th>작성일</th>
					</tr>
				</thead>
				<c:if test="${empty list}">
						<td colspan="5">등록된 글이 없습니다.</td>
					</c:if>
				<tbody>
				<form action="${pageContext.request.contextPath}/admin/usedProductDelete" method="post" name="deleteProductFrm">
				<c:forEach items="${list}" var="list" varStatus="vs">
					<tr>
						<td><input name="deleteList" type="checkbox" class="deleteList" value="${list.productNo}" /></td>
						<td>${list.productNo}</td>
						<td><a href="${pageContext.request.contextPath}/usedProduct/product/productDetail?no=${list.productNo}">${list.productTitle}</a></td>
						<td>${list.sellerId}</td>
						<td>
							<fmt:parseDate value="${list.productEnrollTime}" pattern="yyyy-MM-dd HH:mm:ss" var="productEnrollTime"/>
							<fmt:formatDate value="${productEnrollTime}" pattern="yyyy-MM-dd"/>
						</td>
						
					</tr>
					</c:forEach>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				</tbody>
			</table>
<c:if test="${not empty list}">
    	<div class="mt-5" id="pageBar">${pagebar}</div>
</c:if>
	</div>
</div>


<!-- 모달창 -->
<div class="modal fade" id="adminProductModal" tabindex="-1" role="dialog" aria-labelledby="#adminProductModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
			  <div class="modal-header">
				<h5 class="modal-title" id="adminProductModalLabel">캠핑용품거래 관리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				  <span aria-hidden="true" style="color:#fff">&times;</span>
				</button>
			  </div>
			  <div class="modal-body pb-1">
				 <form name="adminProductUpdateFrm">
					<table class="table" id="tb-modal">
					<tr>
						<td>제목</td>
						<td><input class="form-control"></td>
					</tr>
					<tr>
						<td>카테고리</td>
						<td>
							<select class="modal-category ml-0">
								<option value="">선택</option>
								<option value="">?</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>거래지역</td>
						<td><input class="form-control"></td>
					</tr>
					<tr>
						<td>가격</td>
						<td><input class="form-control"></td>
					</tr>
					<tr>
						<td>설명</td>
						<td><textarea name="" id="" cols="30" rows="10" class="form-control" style="height:150px;"></textarea></td>
					</tr>
				  </table>
				</div>
				  </form>
			  <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="btn-update">수정</button>
			  </div>
			</div>
		  </div>
		</div>
		
<script>
document.querySelectorAll('.btn-search').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		let keyword = document.getElementById('searchKeyword').value;
		let searchType = document.getElementById('search-type').value;

		let url = "${pageContext.request.contextPath}/admin/usedProductManagement";
		url = url + "?searchType=" + searchType;
		url = url + "&searchKeyword=" + keyword;
		location.href = url;
		console.log(url);
		
	})
})

document.querySelectorAll('.btn-delete').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		document.deleteProductFrm.submit();
	})
});

$(document).ready(function() {
    $("input:checkbox[name='checkAll']").click(function() {
        if($("input:checkbox[name='checkAll']").is(":checked") == true) {
            $("input:checkbox[name='deleteList']").prop("checked", true);
        } else {
            $("input:checkbox[name='deleteList']").prop("checked", false);
        }
    });

    $("input:checkbox[name='deleteList']").click(function() {
        var allCnt = $("input:checkbox[name='deleteList']").length;         
        var selCnt = $("inupt:checkbox[name='deleteList']:checked").length; 

        if(allCnt != selCnt) {
            $("input:checkbox[name='checkAll']").prop("checked", false);
        }
    });
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>