<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%
	pageContext.setAttribute("comma", ","); 
	pageContext.setAttribute("commaChange", " · ");
	pageContext.setAttribute("plus", "+"); 
	pageContext.setAttribute("plusChange", " + ");
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/campsite/campsite.css" />
<style>
.campsite-img {border-radius: 5px; cursor: pointer; transition: 0.3s;}
.campsite-img:hover {opacity: 0.7;}
.campsite-img-modal {display: none;	position: fixed; z-index: 2000;	padding-top: 100px;	left: 0; top: 0; width: 100%; height: 100%;	overflow: auto;	background-color: rgb(0,0,0); background-color: rgba(0,0,0,0.9);}
.modal-content {margin: auto; display: block; width: 80%; max-width: fit-content; animation-name: zoom;	animation-duration: 0.6s;}
@keyframes zoom { from {transform: scale(0)} to {transform: scale(1)} }
.modal-close {position: absolute; top: 15px; right: 35px; color: #f1f1f1; font-size: 40px; font-weight: bold; transition: 0.3s;}
.modal-close:hover, .modal-close:focus {color: #bbb; text-decoration: none;	cursor: pointer;}
@media only screen and (max-width: 700px) { .modal-content {width: 100%;} }
</style>

<!-- Swiper -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<!-- Kakao 지도 Javascript API -->
<spring:eval var="kakaoMapKey" expression="@customProperties['api.kakaoMap']" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>

<!-- 캠핑장상세조회 페이지 (작성자:SJ) -->
<div class="container-md campsite-basic-info-wrap p-3">
	<div class="w-100 p-4 m-auto rounded campsite-info-view-wrap">
		<div class="row m-0">
			<div class="col-md info-view-title">
				<h4 class="font-weight-bold m-0">${campsite.facltNm}</h4>
			</div>
			<div class="col-md info-view-back-btn">
				<button class="btn btn-success float-right bg-camper-color" onclick="history.go(-1);">
					<i class="fa-solid fa-arrow-rotate-left"></i>&nbsp;목록으로 돌아가기
				</button>
			</div>
		</div>
		<hr />
		<div class="row m-0 basic-info-wrap p-3 justify-content-center">
			<div class="col-md basic-info-img bg-light mr-3">
				<c:if test="${not empty campsite.firstImageUrl}">
					<img src="${campsite.firstImageUrl}" class="img-thumbnail" alt="${campsite.facltNm} 대표이미지">
				</c:if>
				<c:if test="${empty campsite.firstImageUrl}">
					<img src="${pageContext.request.contextPath}/resources/images/noImg.png" class="img-thumbnail" alt="${campsite.facltNm} 대표이미지">
				</c:if>
			</div>
			<div class="col-md ml-3">
				<table class="table basic-info-table mb-0">
			    	<tr>
			      		<th scope="row">주소</th>
	      				<td>
		      				${not empty campsite.addr1 ? campsite.addr1 : '-'}
		      				${not empty campsite.addr2 ? campsite.addr2 : ''}
	      				</td>
			    	</tr>
			    	<tr>
			      		<th scope="row">문의처</th>
			      		<td>${not empty campsite.tel ? campsite.tel : '-'}</td>
			    	</tr>
			    	<tr>
			      		<th scope="row">캠핑장 유형</th>
			      		<td>
			      			<c:if test="${not empty campsite.induty}">
				      			<c:if test="${fn:contains(campsite.induty, comma)}">
							     	${fn:replace(campsite.induty, comma, commaChange)}
								</c:if>
								<c:if test="${!fn:contains(campsite.induty, comma)}">
									${campsite.induty}
								</c:if>
			      			</c:if>
			      			<c:if test="${empty campsite.induty}">
			      				-
			      			</c:if>
			      		</td>
			    	</tr>
			    	<tr>
			      		<th scope="row">운영기간</th>
			      		<td>
			      			<c:if test="${not empty campsite.operPdCl}">
				      			<c:if test="${fn:contains(campsite.operPdCl, comma)}">
							     	${fn:replace(campsite.operPdCl, comma, commaChange)}
								</c:if>
								<c:if test="${!fn:contains(campsite.operPdCl, comma)}">
									${campsite.operPdCl}
								</c:if>
			      			</c:if>
			      			<c:if test="${empty campsite.operPdCl}">
			      				-
			      			</c:if>
			      		</td>
			    	</tr>
			    	<tr>
			      		<th scope="row">운영일</th>
			      		<td>
			      			<c:if test="${not empty campsite.operDeCl}">
				      			<c:if test="${fn:contains(campsite.operDeCl, plus)}">
							     	${fn:replace(campsite.operDeCl, plus, plusChange)}
								</c:if>
								<c:if test="${!fn:contains(campsite.operDeCl, plus)}">
							     	${campsite.operDeCl}
								</c:if>
			      			</c:if>
			      			<c:if test="${empty campsite.operDeCl}">
			      				-
			      			</c:if>
			      		</td>
			    	</tr>
			    	<tr>
			      		<th scope="row">홈페이지</th>
			      		<td>
			      			<c:if test="${not empty campsite.homepage}">
			      				<a target="_blanck" href="${campsite.homepage}">홈페이지 바로가기</a>
			      			</c:if>
			      			<c:if test="${empty campsite.homepage}">
			      				-
			      			</c:if>
			      		</td>
			    	</tr>
			    	<tr>
			      		<th scope="row">예약방법</th>
			      		<td>${not empty campsite.resveCl ? campsite.resveCl : '-'}</td>
			    	</tr>
			    	<tr>
			    		<!-- 캠핑장 즐겨찾기 -->
			    		<td scope="col" colspan="2" class="pb-0">
			    			<%-- EJ start --%>
                            <sec:authorize access="isAuthenticated()">
                                <c:if test="${isBookmark eq false}">
                                    <button type="button" id="bookmarkBtn" class="btn btn-outline-success btn-outline-camper-color font-weight-bold">
                                        <i class="fa-solid fa-star"></i>&nbsp;관심캠핑장
                                    </button>
                                </c:if>
                                <c:if test="${isBookmark eq true}">
                                    <button type="button" id="bookmarkCancelBtn" class="btn bg-camper-color btn-outline-success btn-outline-camper-color font-weight-bold">
                                        <i class="fa-solid fa-star"></i>&nbsp;관심캠핑장
                                    </button>
                                </c:if>
                            </sec:authorize>
                            <%-- EJ end --%>
			    		</td>
			    	</tr>
			    </table>
			</div>
		</div>
	</div>
</div>
<div class="container campsite-info-tab-wrap p-3">
	<ul class="row nav nav-pills nav-justified" id="infoViewTab" role="tablist">
	  	<li class="nav-item" role="presentation">
	  	  <button class="col nav-link active" id="campsite-info-tab" data-toggle="tab" data-target="#campsiteInfo" type="button" role="tab" aria-controls="campsiteInfo" aria-selected="true">캠핑장소개</button>
	  	</li>
	  	<li class="nav-item" role="presentation">
	    	<button class="col nav-link" id="facility-info-tab" data-toggle="tab" data-target="#facilicyInfo" type="button" role="tab" aria-controls="facilicyInfo" aria-selected="false">시설정보</button>
	  	</li>
	  	<li class="nav-item" role="presentation">
	   	 	<button class="col nav-link" id="location-info-tab" data-toggle="tab" data-target="#locationInfo" type="button" role="tab" aria-controls="locationInfo" aria-selected="false">위치정보</button>
	  	</li>
	</ul>
	<div class="tab-content" id="infoViewTabContent">
	  	<div class="tab-pane fade show active p-4" id="campsiteInfo" role="tabpanel" aria-labelledby="campsite-info-tab">
	  		<ul class="list-group list-group-flush">
			  	<li class="list-group-item">				  
		  			<h6>
			  			<i class="fa-solid fa-circle-chevron-right"></i>&nbsp;${campsite.facltNm} 소개
		  			</h6>
			  	</li>
			  	<li class="list-group-item pt-5 pb-3">
			  		<c:if test="${not empty campsite.lineIntro}">
				  		<div class="text-center font-weight-bold"><i class="fa-solid fa-quote-left"></i> ${campsite.lineIntro} <i class="fa-solid fa-quote-right"></i></div>
			  		</c:if>
			  		<!-- Photo Swiper -->
			  		<c:if test="${not empty campsiteImageList}">
						<div class="swiper-container campsite-img-list my-3">
							<div class="swiper-wrapper">
					  			<c:forEach items="${campsiteImageList}" var="campsiteImage" varStatus="vs">
									<div class="swiper-slide">
										<img class="campsite-img" src="${campsiteImage.imageUrl}" alt="${campsite.facltNm} 이미지${vs.count}">
									</div>
					  			</c:forEach>
							</div>
							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
						</div>
			  		</c:if>
					<!-- Photo Modal -->
					<div id="campsiteImgModal" class="modal campsite-img-modal">
					  	<span class="modal-close" onclick="campsiteImgModalClose();">&times;</span>
					  	<img class="modal-content" id="campsiteImgModalContent">
					</div>
					<c:if test="${not empty campsite.intro}">
				  		<div>${campsite.intro}</div>
					</c:if>
			  	</li>
			</ul>
	  	</div>
	  	<div class="tab-pane fade" id="facilicyInfo" role="tabpanel" aria-labelledby="facility-info-tab">
	  		<div class="tab-pane fade show active p-4" id="campsiteInfo" role="tabpanel" aria-labelledby="campsite-info-tab">
		  		<ul class="list-group list-group-flush">
				  	<li class="list-group-item">				  
			  			<h6>
				  			<i class="fa-solid fa-circle-chevron-right"></i>&nbsp;${campsite.facltNm} 시설
			  			</h6>
				  	</li>
				  	<li class="list-group-item">
				  		<table class="table table-borderless">
				  			<thead>
				  				<tr>
				  					<th colspan="2"><i class="fa-solid fa-tents camper-color"></i>&nbsp;기본시설정보</th>
				  				</tr>
				  			</thead>
				  			<tbody>
			  					<c:if test="${not empty campsite.posblFcltyCl}">
						  			<tr>
						  				<th class="col-md-2">시설정보개요</th>
						  				<td>
						  					<c:if test="${fn:contains(campsite.posblFcltyCl, comma)}">
										     	${fn:replace(campsite.posblFcltyCl, comma, commaChange)}
											</c:if>
						  					<c:if test="${!fn:contains(campsite.posblFcltyCl, comma)}">
										     	${campsite.posblFcltyCl}
											</c:if>
						  				</td>
						  			</tr>
					  			</c:if>
					  			<c:if test="${facility.gnrlSiteCo gt 0 || facility.autoSiteCo gt 0 || facility.glampSiteCo gt 0 || facility.caravSiteCo gt 0 || facility.indvdlCaravSiteCo gt 0}">
						  			<tr>
						  				<th class="col-md-2">캠핑시설<small>(면)</small></th>
						  				<td>
							  				<c:if test="${facility.gnrlSiteCo gt 0}">
							  					<span class="mr-3">일반야영장(${facility.gnrlSiteCo})</span>
									  		</c:if>
									  		<c:if test="${facility.autoSiteCo gt 0}">
										  		<span class="mr-3">자동차야영장(${facility.autoSiteCo})</span>
									  		</c:if>
									  		<c:if test="${facility.glampSiteCo gt 0}">
										  		<span class="mr-3">글램핑(${facility.glampSiteCo})</span>
									  		</c:if>
										  		<c:if test="${facility.caravSiteCo gt 0}">
										  		<span class="mr-3">카라반(${facility.caravSiteCo})</span>
									  		</c:if>
									  		<c:if test="${facility.indvdlCaravSiteCo gt 0}">
										  		<span>개인 카라반(${facility.indvdlCaravSiteCo})</span>
									  		</c:if>
						  				</td>
						  			</tr>
					  			</c:if>
					  			<c:if test="${facility.siteBottomCl1 gt 0 || facility.siteBottomCl2 gt 0 || facility.siteBottomCl3 gt 0 || facility.siteBottomCl4 gt 0 || facility.siteBottomCl5 gt 0}">
						  			<tr>
						  				<th class="col-md-2">바닥형태<small>(개)</small></th>
						  				<td>
							  				<c:if test="${facility.siteBottomCl1 gt 0}">
						  						<span class="mr-3">잔디(${facility.siteBottomCl1})</span>
									  		</c:if>
							  				<c:if test="${facility.siteBottomCl2 gt 0}">
									  			<span class="mr-3">파쇄석(${facility.siteBottomCl2})</span>
									  		</c:if>
							  				<c:if test="${facility.siteBottomCl3 gt 0}">
									  			<span class="mr-3">데크(${facility.siteBottomCl3})</span>
									  		</c:if>
									  		<c:if test="${facility.siteBottomCl4 gt 0}">
									  			<span class="mr-3">자갈(${facility.siteBottomCl4})</span>
									  		</c:if>
							  				<c:if test="${facility.siteBottomCl5 gt 0}">
										  		<span>맨흙(${facility.siteBottomCl5})</span>
									  		</c:if>
						  				</td>
						  			</tr>
					  			</c:if>
					  			<c:if test="${facility.siteMg1Co gt 0 || facility.siteMg2Co gt 0 || facility.siteMg3Co gt 0}">
						  			<tr>
						  				<th class="col-md-2">사이트 수<small>(개)</small></th>
						  				<td>
						  					<c:if test="${facility.siteMg1Co gt 0}">
							  					<span class="mr-3">${facility.siteMg1Width} &times; ${facility.siteMg1Vrticl} (${facility.siteMg1Co})</span>
						  					</c:if>
						  					<c:if test="${facility.siteMg2Co gt 0}">
						  						<span class="mr-3">${facility.siteMg2Width} &times; ${facility.siteMg2Vrticl} (${facility.siteMg2Co})</span>
						  					</c:if>
						  					<c:if test="${facility.siteMg3Co gt 0}">
						  						<span>${facility.siteMg3Width} &times; ${facility.siteMg3Vrticl} (${facility.siteMg3Co})</span>
						  					</c:if>
					  					</td>
						  			</tr>
					  			</c:if>
					  			<c:if test="${not empty facility.trlerAcmpnyAt || not empty facility.caravAcmpnyAt || not empty facility.animalCmgCl}">
						  			<tr>
						  				<th class="col-md-2">기타정보</th>
						  				<td>
						  					<c:if test="${not empty facility.trlerAcmpnyAt}">
						  						<span class="mr-3">개인 트레일러 동반 여부 : ${facility.trlerAcmpnyAt eq 'Y' ? '가능' : '불가능'}</span>
						  					</c:if>
						  					<c:if test="${not empty facility.caravAcmpnyAt}">
						  						<span class="mr-3">개인 카라반 동반 여부 : ${facility.caravAcmpnyAt eq 'Y' ? '가능' : '불가능'}</span>
						  					</c:if>
						  					<c:if test="${not empty facility.animalCmgCl}">
						  						<span>애완동물출입 : ${facility.animalCmgCl}</span>
						  					</c:if>
						  				</td>
						  			</tr>
					  			</c:if>
					  		</tbody>
				  		</table>
				  	</li>
				  	<li class="list-group-item">
				  		<table class="table table-borderless">
				  			<thead>
				  				<tr>
				  					<th colspan="2"><i class="fa-solid fa-tents camper-color"></i>&nbsp;기타시설정보</th>
				  				</tr>
				  			</thead>
				  			<tbody>
			  					<c:if test="${not empty facility.sbrsCl}">
						  			<tr>
						  				<th class="col-md-2">부대시설</th>
						  				<td>
						  					<c:if test="${fn:contains(facility.sbrsCl, comma)}">
										     	${fn:replace(facility.sbrsCl, comma, commaChange)}
											</c:if>
						  					<c:if test="${!fn:contains(facility.sbrsCl, comma)}">
										     	${facility.sbrsCl}
											</c:if>
						  				</td>
						  			</tr>
					  			</c:if>
			  					<c:if test="${not empty facility.sbrsEtc}">
						  			<tr>
						  				<th class="col-md-2">기타 부대시설</th>
						  				<td>${facility.sbrsEtc}</td>
						  			</tr>
					  			</c:if>
					  			<c:if test="${facility.toiletCo gt 0 || facility.swrmCo gt 0 || facility.wtrplCo gt 0}">
						  			<tr>
						  				<th class="col-md-2">샤워시설<small>(개)</small></th>
						  				<td>
						  					<c:if test="${facility.toiletCo gt 0}">
						  						<span class="mr-3">화장실(${facility.toiletCo})</span>
						  					</c:if>
						  					<c:if test="${facility.swrmCo gt 0}">
						  						<span class="mr-3">샤워실(${facility.swrmCo})</span>
						  					</c:if>
						  					<c:if test="${facility.wtrplCo gt 0}">
						  						<span>개수대(${facility.wtrplCo})</span>
						  					</c:if>
						  				</td>
						  			</tr>
					  			</c:if>
			  					<c:if test="${not empty facility.eqpmnLendCl}">
						  			<tr>
						  				<th class="col-md-2">캠핑장비대여</th>
						  				<td>
						  					<c:if test="${fn:contains(facility.eqpmnLendCl, comma)}">
										     	${fn:replace(facility.eqpmnLendCl, comma, commaChange)}
											</c:if>
						  					<c:if test="${!fn:contains(facility.eqpmnLendCl, comma)}">
										     	${facility.eqpmnLendCl}
											</c:if>
						  				</td>
						  			</tr>
			  					</c:if>
			  					<c:if test="${not empty facility.brazierCl}">
						  			<tr>
						  				<th class="col-md-2">화로대</th>
						  				<td>${facility.brazierCl}</td>
						  			</tr>
			  					</c:if>
			  					<c:if test="${facility.extshrCo gt 0 || facility.frprvtWrppCo gt 0 || facility.frprvtSandCo gt 0}">
						  			<tr>
						  				<th class="col-md-2">안전시설<small>(개)</small></th>
						  				<td>
						  					<c:if test="${facility.extshrCo gt 0}">
							  					<span class="mr-3">소화기(${facility.extshrCo})</span>
						  					</c:if>
						  					<c:if test="${facility.frprvtWrppCo gt 0}">
						  						<span class="mr-3">방화수(${facility.frprvtWrppCo})</span>
						  					</c:if>
						  					<c:if test="${facility.frprvtSandCo gt 0}">
						  						<span>방화사(${facility.frprvtSandCo})</span>
						  					</c:if>
						  				</td>
						  			</tr>
			  					</c:if>
					  			<c:if test="${not empty facility.glampInnerFclty}">
						  			<tr>
						  				<th class="col-md-2">글램핑내부시설</th>
						  				<td>
						  					<c:if test="${fn:contains(facility.glampInnerFclty, comma)}">
										     	${fn:replace(facility.glampInnerFclty, comma, commaChange)}
											</c:if>
						  					<c:if test="${!fn:contains(facility.glampInnerFclty, comma)}">
										     	${facility.glampInnerFclty}
											</c:if>
						  				</td>
						  			</tr>
			  					</c:if>
					  			<c:if test="${not empty facility.caravInnerFclty}">
						  			<tr>
						  				<th class="col-md-2">카라반내부시설</th>
						  				<td>
						  					<c:if test="${fn:contains(facility.caravInnerFclty, comma)}">
										     	${fn:replace(facility.caravInnerFclty, comma, commaChange)}
											</c:if>
						  					<c:if test="${!fn:contains(facility.caravInnerFclty, comma)}">
										     	${facility.caravInnerFclty}
											</c:if>
						  				</td>
						  			</tr>
			  					</c:if>
					  		</tbody>
				  		</table>
				  	</li>
				</ul>
		  	</div>
	  	</div>
	  	<div class="tab-pane fade" id="locationInfo" role="tabpanel" aria-labelledby="location-info-tab">
	  		<div class="tab-pane fade show active p-4" id="campsiteInfo" role="tabpanel" aria-labelledby="campsite-info-tab">
		  		<ul class="list-group list-group-flush">
				  	<li class="list-group-item">				  
			  			<h6>
				  			<i class="fa-solid fa-circle-chevron-right"></i>&nbsp;${campsite.facltNm} 위치
			  			</h6>
				  	</li>
				</ul>
		  		<div class="p-2 m-auto location-info-map" id="map"></div>
		  	</div>
	  	</div>
	</div>
</div>
<%-- EJ start --%>
<sec:authentication property="principal" var="loginMember" scope="page"/>
<script>
<sec:authorize access="isAuthenticated()">
	const headers = {
		"${_csrf.headerName}" : "${_csrf.token}"
	};
	
	if(document.querySelector('#bookmarkBtn') != null) {
		document.querySelector('#bookmarkBtn').addEventListener('click', (e) => {
			$.ajax({
				url : '${pageContext.request.contextPath}/campsite/addBookmark',
				type : 'POST',
				headers,
				data : {
					contentId : ${param.contentId},
					memberId : '${loginMember.memberId}'
				},
				success(response) {
					location.reload();
				},
				error : console.log
			});
		});
	}
	
	if(document.querySelector('#bookmarkCancelBtn') != null) {
		document.querySelector('#bookmarkCancelBtn').addEventListener('click', (e) => {
			console.log(e.target);
			$.ajax({
				url : '${pageContext.request.contextPath}/campsite/deleteBookmark',
				type : 'POST',
				headers,
				data : {
					contentId : ${param.contentId},
					memberId : '${loginMember.memberId}'
				},
				success(response) {
					location.reload();
				},
				error : console.log
			});
		});
	}
</sec:authorize>
</script>
<%-- EJ end --%>
<script>
/**
 * 이미지 클릭시 모달창 실행
 */
let campsiteImgModal = document.getElementById("campsiteImgModal");
let campsiteImgModalContent = document.getElementById("campsiteImgModalContent");

document.querySelectorAll('.campsite-img').forEach((img) => {
	img.addEventListener('click', (e) => {
		campsiteImgModal.style.display = "block";
		campsiteImgModalContent.src = e.target.src;
	});
});

let modalClose = document.getElementsByClassName("modal-close")[0];
const campsiteImgModalClose = () => {
	campsiteImgModal.style.display = "none";
};

$('.campsite-img-modal').click(function() {
	$('#campsiteImgModal').hide();
});

/**
 * 후기 이미지 제어
 */
new Swiper('.swiper-container', {
	slidesPerView : 3,
	spaceBetween : 10,
	slidesPerGroup : 3,
	debugger: true,
	mousewheel: true,
	loopFillGroupWithBlank : true,
	loop : true,
	navigation : {
		nextEl : '.swiper-button-next',
		prevEl : '.swiper-button-prev'
	}
});

/**
 * 캠핑장 위치 정보 지도 렌더링
 */
const mapX = ${campsite.mapX};
const mapY = ${campsite.mapY};
const facltNm = '${campsite.facltNm}';

const mapContainer = document.getElementById('map'),
mapOption = {
    center: new kakao.maps.LatLng(mapY, mapX),
    level: 1
};

const map = new kakao.maps.Map(mapContainer, mapOption);

const mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

const zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

const markerImage = new kakao.maps.MarkerImage(
    '${pageContext.request.contextPath}/resources/images/campsite/location-dot-solid.svg',
    new kakao.maps.Size(30, 40),
    {
        alt: "마커이미지"
    }
);

const ps = new kakao.maps.services.Places(); 
ps.keywordSearch(facltNm, placesSearchCB);

function placesSearchCB(data, status, pagination) {
    if(status === kakao.maps.services.Status.OK) {
		const bounds = new kakao.maps.LatLngBounds();
        for(let i = 0; i < data.length; i++) {
            displayMarker(data[i]);
            bounds.extend(new kakao.maps.LatLng(data[0].y, data[0].x));
        }       
        map.setBounds(bounds);
    }
}

function displayMarker(place) {
	const marker = new kakao.maps.Marker({
		map: map,
		position: new kakao.maps.LatLng(place.y, place.x),
		image : markerImage,
		text: facltNm
	});
	kakao.maps.event.addListener(marker, 'click', function () {
		const position = this.getPosition();
		const url = 'http://map.kakao.com/link/map/' + place.id;
		window.open(url, '_blank');
	});
}

// 사용자가 외부에서 영역을 변경하게 되면 API 내부에서 알 수 없기 때문에
// 지도 표시 영역이 완전히 스타일이 잡히고 난 이후에 map.relayout()을 호출하는 것
document.querySelector('#location-info-tab').addEventListener('click', (e) => {
	setTimeout(function() {
	    map.relayout();
	    map.setCenter(new kakao.maps.LatLng(mapY, mapX));
	    map.setLevel(1);
	}, 1000);
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>