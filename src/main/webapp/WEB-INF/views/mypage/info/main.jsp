<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/info/main.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">	
	<div class="row d-flex justify-content-between">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
		</div>
		<div class="col-lg-10 mt-2">
		<%-- 본문시작 --%>
		  <div class="row justify-content-between mt-4" >
                <div class="col-md-6 align-self-center border-right pl-4">
                    <img alt="누구님의 프로필사진" src="${pageContext.request.contextPath}/resources/upload/member/oo.jpg" class="rounded-circle ml-3 mt-2" width="100px"/>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 닉네임
                    <a href="${pageContext.request.contextPath}/mypage/info/edit"  class="btn btn-camper d-block mt-3 ml-2 mb-2">
                        회원정보 수정
                    </a>
                </div>
                <div class="col-md-6 pl-4 ">
                    <h5 class="ml-3 mt-1">
                        중고거래 내역
                    </h5>
                    <div class="row text-center">
                        <div class="col-md-4 ">
                            <div class="m-4">
	                            <a href="${pageContext.request.contextPath}/mypage/trade/selling">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="#639A67" class="bi bi-currency-dollar" viewBox="0 0 16 16">
									  <path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718H4zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73l.348.086z"/>
									</svg>
								</a>
                            </div>
                            <a href="${pageContext.request.contextPath}/mypage/trade/selling">
                           		판매내역
                            </a>
                        </div>
                        <div class="col-md-4">
                            <div class="m-4">
	                            <a href="${pageContext.request.contextPath}/mypage/trade/purchased">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="#639A67" class="bi bi-bag-fill" viewBox="0 0 16 16">
									  <path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1zm3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4h-3.5z"/>
									</svg>
								</a>
                            </div>
                            <a href="${pageContext.request.contextPath}/mypage/trade/purchased">
                            	구매내역
                            </a>
                        </div>
                        <div class="col-md-4">
                            <div class="m-4">
	                            <a href="${pageContext.request.contextPath}/mypage/trade/wish">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="#639A67" class="bi bi-heart-fill" viewBox="0 0 16 16">
									  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
									</svg>
								</a>
                            </div>
                            <a href="${pageContext.request.contextPath}/mypage/trade/wish">
                            	관심상품
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-12 d-flex justify-content-between p-0  mt-5 mb-3">
                        <h5 class="mb-3">
                            즐겨찾기한 캠핑장
                        </h5> 
                        <a type="button" class="btn btn-link ">
                            >> 더보기
                        </a>
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                            <img class="rounded ml-2" width="110px" alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" />
                        </div>
                        <div class="col-md-6 text-left mt-2">
                            <h6>
                                [어디]OO캠핑장
                            </h6>
                            <br>
                            <p>
                                낭만 가득한~
                            </p>
                        </div>
                        <div class="col-md-4 text-right pr-4">
                            <p>
                                ~~도 ~~동
                            </p>
                            <br>
                            <p>
                                070-1111-1111
                            </p>
                        </div>
                    </div>
                    <hr>
    
                        <div class="row">
                            <div class="col-md-2">
                                <img class="rounded ml-2" width="110px" alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" />
                            </div>
                            <div class="col-md-6 text-left mt-2">
                                <h6>
                                    [어디]OO캠핑장
                                </h6>
                                <br>
                                <p>
                                    낭만 가득한~
                                </p>
                            </div>
                            <div class="col-md-4 text-right pr-4">
                                <p>
                                    ~~도 ~~동
                                </p>
                                <br>
                                <p>
                                    070-1111-1111
                                </p>
                            </div>
                        </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 mt-5">
                    <div class="col-md-12  d-flex justify-content-between p-0">
                        <h5 class="mb-3">
                            작성후기
                        </h5> 
                        <a type="button" class="btn btn-link">
                            >> 더보기
                        </a>
                    </div>
                </div>
                <div class="col-md-12">
                    <table class="table table-hover table-sm">
                        <thead>
                            <tr>
                                <th>
                                    번호
                                </th>
                                <th>
                                    제목
                                </th>
                                <th>
                                    작성자
                                </th>
                                <th>
                                    평점
                                </th>
                                <th>
                                    추천수
                                </th>
                                <th>
                                    조회수
                                </th>
                                <th>
                                    작성일
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    1
                                </td>
                                <td>
                                    제목제목
                                </td>
                                <td>
                                    닉네임
                                </td>
                                <td>
                                    4
                                </td>
                                <td>
                                    10
                                </td>
                                <td>
                                    1
                                </td>
                                <td>
                                    01/04/2012
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    1
                                </td>
                                <td>
                                    제목제목
                                </td>
                                <td>
                                    닉네임
                                </td>
                                <td>
                                    4
                                </td>
                                <td>
                                    10
                                </td>
                                <td>
                                    1
                                </td>
                                <td>
                                    01/04/2012
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    1
                                </td>
                                <td>
                                    제목제목
                                </td>
                                <td>
                                    닉네임
                                </td>
                                <td>
                                    4
                                </td>
                                <td>
                                    10
                                </td>
                                <td>
                                    1
                                </td>
                                <td>
                                    01/04/2012
                                </td>

                            </tr>
                            
                            
 
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row mt-3 mb-5">
                <div class="col-md-12">
                    <div class="col-md-12 d-flex justify-content-between p-0">
                        <h5 class="mb-3">
                            캠퍼모집
                        </h5> 
                        <a type="button" class="btn btn-link">
                            >> 더보기
                        </a>
                    </div>
                    <table class="table table-hover table-sm">
                        <thead>
                            <tr>
                                <th>
                                    #
                                </th>
                                <th>
                                    Product
                                </th>
                                <th>
                                    Payment Taken
                                </th>
                                <th>
                                    Status
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    1
                                </td>
                                <td>
                                    TB - Monthly
                                </td>
                                <td>
                                    01/04/2012
                                </td>
                                <td>
                                    Default
                                </td>
                            </tr>
                            <tr class="table-active">
                                <td>
                                    1
                                </td>
                                <td>
                                    TB - Monthly
                                </td>
                                <td>
                                    01/04/2012
                                </td>
                                <td>
                                    Approved
                                </td>
                            </tr>
                                                        <tr class="table-active">
                                <td>
                                    1
                                </td>
                                <td>
                                    TB - Monthly
                                </td>
                                <td>
                                    01/04/2012
                                </td>
                                <td>
                                    Approved
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
                   
                      
		<%-- 본문끝 --%>
		</div>
	</div>
</div>