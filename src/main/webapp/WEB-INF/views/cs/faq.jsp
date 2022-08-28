<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cs/cs.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
.bar-faq {color: black !important;}
.container {padding: 0px;}
.cs-bar {margin-bottom: 0px;}

</style>
			
<h5 class="cs-header text-center">자주 묻는 질문</h5>

<div class="notice-wrap" style="width: 85%; float:none; margin:0 auto">
	
	<div class="cs-bar float-left">
		<a href="${pageContext.request.contextPath}/cs/noticeList" class="bar-notice">공지사항</a>
		<a href="${pageContext.request.contextPath}/cs/faq" class="bar-faq">자주 묻는 질문</a>
	</div>

	
		<div class="search-group float-right">
		<select id="search-type">
            <option value="title" ${map.searchType eq 'title' ? 'selected' : ''}>제목</option>
            <option value="content" ${map.searchType eq 'content' ? 'selected' : ''}>내용</option>
        </select>
			<input type="hidden" name="searchType" value="title">
			<input type="hidden" name="searchType" value="content">
			<input class="input-search" type="text" placeholder="검색어를 입력하세요." name="searchKeyword" id="searchKeyword">
			<button class="btn-search" type="button" id="searchButton">
				<i class="fa fa-search"></i>
			</button>
		</div>
	

<div class="container">
<div class="faq">
			
			<p class="test-div" style="color: #FFF; margin-bottom:-12px;">.</p>
				
				<ul class="faqBody" style="display: inline;">
				<c:if test="${empty list}">
						<div class="text-center mt-4">등록된 글이 없습니다.</div>
					</c:if>
				<c:forEach var="list" items="${list}">
                    <li class="article" id="a1" >
                        <p class="q"><a href="#a1">
                        <span class="icon_q ml-2" style="padding: 1px; padding-left: 2px;">Q.</span>
                        <span style="margin-left : 20px; font-size: 0.9rem;">${fn:replace(list.title, replaceChar, "</br>")}</span>
                        <span class="q_img"><img src="${pageContext.request.contextPath}/resources/images/cs/arrow.png" style="width: 15px;" alt="" class="mt-1 mr-2"></span>
                        </a></p>

                        <div class="a">
                        <span class="icon_a ml-2" style="padding: 1px; padding-left: 2px; font-weight: bold;">A.</span>
                        <div style="margin-left: 67px; margin-top: -26px; font-size: 0.9rem; margin-bottom:10px;">${fn:replace(list.content, replaceChar, "</br>")}</div>
                         <sec:authorize access="hasRole('ADMIN')">
                        <div class="faq-btn mt-3 mb-2" style="text-align: center;">
								<button class="btn-update btn btn-outline-primary btn-sm" value="${list.noticeNo}">수정</button>
								<button class="btn-delete btn-sm btn btn-outline-danger" data-notice-no="${list.noticeNo}">삭제</button>	
							</div>
						</sec:authorize>
                        </div>
                    </li>
                    </c:forEach>
                </ul>

		
</div>
 <sec:authorize access="hasRole('ADMIN')">
<button type="button" class="mr-2 btn btn-primary btn-sm float-right" onclick="location.href='${pageContext.request.contextPath}/cs/faqEnroll';">글등록</button>
</sec:authorize>
</div> 
</div>
<c:if test="${not empty list}">
    	<div class="mt-5" id="pageBar">${pagebar}</div>
</c:if>
<form action="${pageContext.request.contextPath}/cs/faqDelete" method="POST" name="deleteFaqFrm">
<input type="hidden" name="noticeNo" id="deleteNo" />
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<script>
document.querySelectorAll('.btn-delete').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		//if(confirm("등록한 질문을 삭제하시겠습니까?"))
		document.deleteFaqFrm.noticeNo.value = e.target.dataset.noticeNo;
		document.deleteFaqFrm.submit();
	})
});

document.querySelectorAll('.btn-update').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		location.href = `${pageContext.request.contextPath}/cs/faqUpdate?noticeNo=\${e.target.value}`;
		
	})
})

document.querySelectorAll('.btn-search').forEach((btn) => {
	btn.addEventListener('click', (e) => {
		let keyword = document.getElementById('searchKeyword').value;
		let searchType = document.getElementById('search-type').value;

		let url = "${pageContext.request.contextPath}/cs/faq";
		url = url + "?searchType=" + searchType;
		url = url + "&searchKeyword=" + keyword;
		location.href = url;
		console.log(url);
		
	})
})
</script>

<script>
    jQuery(function($){
        var article = $('.faq>.faqBody>.article');
        article.addClass('hide');
        article.find('.a').hide();
        $('.faq>.faqBody>.article>.q>a').click(function(){
            var myArticle = $(this).parents('.article:first');
            if(myArticle.hasClass('hide')){
                article.addClass('hide').removeClass('show');
                article.find('.a').slideUp(260);
                myArticle.removeClass('hide').addClass('show');
                myArticle.find('.a').slideDown(260);
            } else {
                myArticle.removeClass('show').addClass('hide');
                myArticle.find('.a').slideUp(260);
            }
            return false;
        });
        $('.faq>.faqHeader>.showAll').click(function(){
            var hidden = $('.faq>.faqBody>.article.hide').length;
            if(hidden > 0){
                article.removeClass('hide').addClass('show');
                article.find('.a').slideDown(260);
            } else {
                article.removeClass('show').addClass('hide');
                article.find('.a').slideUp(260);
            }
        });
    });
    </script>
    
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>