<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/campsite/campsite.css" />
<style>
body {overflow-y: auto!important;}
</style>

<!-- Kakao 지도 Javascript API -->
<spring:eval var="kakaoMapKey" expression="@customProperties['api.kakaoMap']" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>

<!-- 캠핑장목록조회(상세검색) 페이지 (작성자:SJ) -->
<form:form name="searchDetailFrm" action="${pageContext.request.contextPath}/campsite/searchDetail" method="GET">
	<div class="d-flex justify-content-center campsite-search-wrap">
		<div class="container-md w-75 p-4 m-auto rounded campsite-search">
			<div class="row m-0">
				<div class="col search-header">상세검색</div>
				<div class="col">
					<button type="button" id="searchThemeBtn" class="btn btn-success bg-camper-color float-right">
						테마검색&nbsp;<i class="fa-solid fa-angle-right"></i>
					</button>
				</div>
			</div>
			<hr />
			<div class="row m-0">
				<div class="col-md-4">
					<label for="addr1" class="m-0">지역</label>
					<select class="custom-select btn-outline-success btn-outline-camper-color" name="sido" id="sido"></select>
					<select class="custom-select btn-outline-success btn-outline-camper-color" name="gugun" id="gugun"></select>
				</div>
				<div class="col-md-6 input-group">
					<label for="facltNm">캠핑장 검색</label>&nbsp;
					<input 
						type="text" 
						class="form-control border-camper-color facltNm-search-btn-wrap" 
						name="facltNm"
						value="${param.facltNm}"
						placeholder="캠핑장명을 입력하세요." 
						aria-label="Recipient's username" 
						aria-describedby="facltNmSearchBtn">
				  	<div class="input-group-append">
				    	<button type="submit" class="btn btn-outline-success btn-outline-camper-color" id="facltNmSearchBtn">
				    		<i class="fa-solid fa-magnifying-glass"></i>
				    	</button>
				  	</div>
				</div>
				<div class="col-md">
					<button type="button" id="conditionsBtn" class="btn btn-success bg-camper-color float-right" data-toggle="modal" data-target="#conditionsModal">
						<i class="fa-regular fa-square-plus"></i>&nbsp;상세조건
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- modal insert -->
	<div class="modal fade" id="conditionsModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="conditionsModalLabel" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
	    	<div class="modal-content">
		      	<div class="modal-header">
		        	<h5 class="modal-title font-weight-bold" id="conditionsModalLabel">상세조건</h5>
		        	<small class="ml-2">※ 실제 결과는 현장사정 및 계절에 따라 달라질 수 있습니다.</small>
		        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          	<span aria-hidden="true">&times;</span>
		        	</button>
		      	</div>
		      	<div class="modal-body">
		        	<h6 class="font-weight-bold">운영형태</h6>
		        	<div class="form-check-inline form-check d-flex m-0">
						<input type="checkbox" class="form-check-input" name="facltDivNm" id="facltDivNm0" value="지자체" ${fn:contains(searchParam.facltDivNm, '지자체') ? 'checked' : ''}>
						<label for="facltDivNm0" class="form-check-label mr-2">지자체</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="facltDivNm" id="facltDivNm1" value="국립공원" ${fn:contains(searchParam.facltDivNm, '국립공원') ? 'checked' : ''}>
						<label for="facltDivNm1" class="form-check-label mr-2">국립공원</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="facltDivNm" id="facltDivNm2" value="자연휴양림" ${fn:contains(searchParam.facltDivNm, '자연휴양림') ? 'checked' : ''}>
						<label for="facltDivNm2" class="form-check-label mr-2">자연휴양림</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="facltDivNm" id="facltDivNm3" value="국민여가" ${fn:contains(searchParam.facltDivNm, '국민여가') ? 'checked' : ''}>
						<label for="facltDivNm3" class="form-check-label mr-2">국민여가</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="facltDivNm" id="facltDivNm4" value="민간" ${fn:contains(searchParam.facltDivNm, '민간') ? 'checked' : ''}>
						<label for="facltDivNm4" class="form-check-label">민간</label>&nbsp;
					</div>
					<hr />
					<h6 class="font-weight-bold">입지구분</h6>
		        	<div class="form-check-inline form-check d-flex m-0">
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl0" value="해변" ${fn:contains(searchParam.lctCl, '해변') ? 'checked' : ''}>
						<label for="lctCl0" class="form-check-label mr-2">해변</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl1" value="섬" ${fn:contains(searchParam.lctCl, '섬') ? 'checked' : ''}>
						<label for="lctCl1" class="form-check-label mr-2">섬</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl2" value="산" ${fn:contains(searchParam.lctCl, '산') ? 'checked' : ''}>
						<label for="lctCl2" class="form-check-label mr-2">산</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl3" value="숲" ${fn:contains(searchParam.lctCl, '숲') ? 'checked' : ''}>
						<label for="lctCl3" class="form-check-label mr-2">숲</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl4" value="계곡" ${fn:contains(searchParam.lctCl, '계곡') ? 'checked' : ''}>
						<label for="lctCl4" class="form-check-label mr-2">계곡</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl5" value="강" ${fn:contains(searchParam.lctCl, '강') ? 'checked' : ''}>
						<label for="lctCl5" class="form-check-label mr-2">강</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl6" value="호수" ${fn:contains(searchParam.lctCl, '호수') ? 'checked' : ''}>
						<label for="lctCl6" class="form-check-label mr-2">호수</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="lctCl" id="lctCl7" value="도심" ${fn:contains(searchParam.lctCl, '도심') ? 'checked' : ''}>
						<label for="lctCl7" class="form-check-label">도심</label>&nbsp;
					</div>
					<hr />
					<h6 class="font-weight-bold">주요시설</h6>
		        	<div class="form-check-inline form-check d-flex m-0">
						<input type="checkbox" class="form-check-input" name="induty" id="induty0" value="일반야영장" ${fn:contains(searchParam.induty, '일반야영장') ? 'checked' : ''}>
						<label for="induty0" class="form-check-label mr-2">일반야영장</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="induty" id="induty1" value="자동차야영장" ${fn:contains(searchParam.induty, '자동차야영장') ? 'checked' : ''}>
						<label for="induty1" class="form-check-label mr-2">자동차야영장</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="induty" id="induty2" value="카라반" ${fn:contains(searchParam.induty, '카라반') ? 'checked' : ''}>
						<label for="induty2" class="form-check-label mr-2">카라반</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="induty" id="induty3" value="글램핑" ${fn:contains(searchParam.induty, '글램핑') ? 'checked' : ''}>
						<label for="induty3" class="form-check-label">글램핑</label>&nbsp;
					</div>
		      	</div>
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		        	<button type="button" class="btn btn-success btn-camper-color" id="conditionsSubmitBtn">확인</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
</form:form>
<script>
document.querySelector('#conditionsSubmitBtn').addEventListener('click', (e) => {	
	$(".modal-backdrop").remove();
	$('#conditionsModal').hide();
});

/**
 * 지역 선택
 */
$('document').ready(function() {
	var area0 = ["시/도 선택","서울","인천","대전","광주","대구","울산","부산","경기","강원","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주"];
	var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	var area3 = ["대덕구","동구","서구","유성구","중구"];
	var area4 = ["광산구","남구","동구","북구","서구"];
	var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	var area6 = ["남구","동구","북구","중구","울주군"];
	var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	var area16 = ["서귀포시","제주시","남제주군","북제주군"];
	
	$("select[name^=sido]").each(function() {
		$selsido = $(this);
		$.each(eval(area0), function() {
			$selsido.append("<option value='"+this+"'>"+this+"</option>");
		});
		$selsido.next().append("<option value=''>구/군 선택</option>");
	});
	
	$("select[name^=sido]").change(function() {
		var area = "area"+$("option",$(this)).index($("option:selected",$(this)));
		var $gugun = $(this).next();
	  	$("option",$gugun).remove();
	
	  	if(area == "area0")
	   		$gugun.append("<option value=''>구/군 선택</option>");
	  	else {
	   		$.each(eval(area), function() {
	    		$gugun.append("<option value='"+this+"'>"+this+"</option>");
	   		});
	  	}
	});
});

/**
 * 테마검색 페이지로 이동
 */
document.querySelector("#searchThemeBtn").addEventListener('click', (e) => {
	location.href = '${pageContext.request.contextPath}/campsite/searchTheme';
});

document.querySelector("#conditionsSubmitBtn").addEventListener('submit', (e) => {
	
});
</script>
<div class="d-flex bd-highlight w-100 p-3 m-auto campsite-result-wrap">
	<div class="p-2 flex-fill bd-highlight campsite-result">
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="camp" varStatus="">
				<div class="d-flex bd-highlight m-1 result-list-wrap border border-light">
					<div class="result-list-img bg-light">
						<c:if test="${not empty camp.firstImageUrl}">
							<a href="${pageContext.request.contextPath}/campsite/infoView?contentId=${camp.contentId}">
								<img src="${camp.firstImageUrl}" class="img-thumbnail" alt="${camp.facltNm} 대표이미지">
							</a>
						</c:if>
						<c:if test="${empty camp.firstImageUrl}">
							<a href="${pageContext.request.contextPath}/campsite/infoView?contentId=${camp.contentId}">
								<img src="${pageContext.request.contextPath}/resources/images/noImg.png" class="img-thumbnail" alt="${camp.facltNm} 대표이미지">
							</a>
						</c:if>
					</div>
					<div class="result-list-content">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								<h6><a href="${pageContext.request.contextPath}/campsite/infoView?contentId=${camp.contentId}">${camp.facltNm}</a></h6>
							</li>
							<li class="list-group-item border-bottom-0">
								<c:if test="${fn:length(camp.lineIntro) ge 33}">
									${fn:substring(camp.lineIntro, 0, 33)}...
			                   	</c:if> 
			                   	<c:if test="${fn:length(camp.lineIntro) lt 33}">
			                   		${camp.lineIntro}
			                   	</c:if>
							</li>
							<li class="list-group-item border-top-0">
								<span>
									<i class="fa-solid fa-location-dot campsite-yellow"></i>&nbsp;
									<c:if test="${fn:length(camp.addr1) ge 15}">
										${fn:substring(camp.addr1, 0, 15)}...
				                   	</c:if> 
				                   	<c:if test="${fn:length(camp.addr1) lt 15}">
				                   		${camp.addr1}
				                   	</c:if>
								</span>
								<c:if test="${not empty camp.tel}">
									<span class="float-right"><i class="fa-solid fa-phone campsite-yellow"></i>&nbsp;${camp.tel}</span>
								</c:if>
							</li>
						</ul>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<div class="text-center font-weight-bold my-3">
				<i class="fa-solid fa-triangle-exclamation campsite-yellow"></i>&nbsp;검색조건에 맞는 캠핑장이 없습니다.
			</div>
		</c:if>
	</div>
	<div class="p-2 flex-fill m-auto bg-light result-map" id="map"></div>
</div>
<script>
/**
 * 카카오 지도
 */
const mapContainer = document.getElementById('map'),
	mapOption = {
		<c:if test="${not empty list}">
			center: new kakao.maps.LatLng(${list[0].mapY}, ${list[0].mapX}),
		</c:if>
		<c:if test="${empty list}">
			center: new kakao.maps.LatLng(37.500786, 127.036886),
		</c:if>
		level: 11
	};

const map = new kakao.maps.Map(mapContainer, mapOption);

const mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

const zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

let positions = [];
<c:forEach items="${list}" var="camp">
	positions.push(
		{
			content: '<div class="map-facltNm"><a href="${pageContext.request.contextPath}/campsite/infoView?contentId=${camp.contentId}"><span>${camp.facltNm}</span></a></div>',
			latlng: new kakao.maps.LatLng(${camp.mapY}, ${camp.mapX})
		}
	);
</c:forEach>

for(let i = 0; i < positions.length; i ++) {	
	const markerImage = new kakao.maps.MarkerImage(
	    '${pageContext.request.contextPath}/resources/images/campsite/location-dot-solid.svg',
	    new kakao.maps.Size(20, 30),
	    {
	        alt: "마커이미지"
	    }
	);
	    
	const marker = new kakao.maps.Marker({
        map: map,
        position: positions[i].latlng,
        image : markerImage,
        clickable: true
    });
	
	const position = positions[i].latlng;
	const content = positions[i].content;
	
	const customOverlay = new kakao.maps.CustomOverlay({
	    map: map,
	    position: position,
	    content: content,
	    yAnchor: 1
	});
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>