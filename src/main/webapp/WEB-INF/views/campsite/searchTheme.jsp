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

<!-- Kakao 지도 Javascript API -->
<spring:eval var="kakaoMapKey" expression="@customProperties['api.kakaoMap']" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>

<!-- 캠핑장목록조회(테마검색) 페이지 (작성자:SJ) -->
<form:form name="searchThemeFrm" action="${pageContext.request.contextPath}/campsite/searchTheme" method="GET">
	<div class="d-flex justify-content-center campsite-search-wrap">
		<div class="container-md w-75 p-4 m-auto rounded campsite-search">
			<div class="row m-0">
				<div class="col search-header">테마검색</div>
				<div class="col">
					<button type="button" id="searchDetailBtn" class="btn btn-success btn-camper-color float-right">
						상세검색&nbsp;<i class="fa-solid fa-angle-right"></i>
					</button>
				</div>	
			</div>
			<hr />
			<div class="row m-0 text-center">
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl0" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl0" value="일출명소" ${fn:contains(searchParam.themaEnvrnCl, '일출명소') ? 'checked' : ''}>#일출명소
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl1" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl1" value="일몰명소" ${fn:contains(searchParam.themaEnvrnCl, '일몰명소') ? 'checked' : ''}>#일몰명소
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl2" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl2" value="수상레저" ${fn:contains(searchParam.themaEnvrnCl, '수상레저') ? 'checked' : ''}>#수상레저
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl3" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl3" value="항공레저" ${fn:contains(searchParam.themaEnvrnCl, '항공레저') ? 'checked' : ''}>#항공레저
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl4" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl4" value="스키" ${fn:contains(searchParam.themaEnvrnCl, '스키') ? 'checked' : ''}>#스키
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl5" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl5" value="낚시" ${fn:contains(searchParam.themaEnvrnCl, '낚시') ? 'checked' : ''}>#낚시
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl6" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl6" value="액티비티" ${fn:contains(searchParam.themaEnvrnCl, '액티비티') ? 'checked' : ''}>#액티비티
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl7" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl7" value="봄꽃여행" ${fn:contains(searchParam.themaEnvrnCl, '봄꽃여행') ? 'checked' : ''}>#봄꽃여행
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl8" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl8" value="여름물놀이" ${fn:contains(searchParam.themaEnvrnCl, '여름물놀이') ? 'checked' : ''}>#여름물놀이
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl9" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl9" value="가을단풍명소" ${fn:contains(searchParam.themaEnvrnCl, '가을단풍명소') ? 'checked' : ''}>#가을단풍명소
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl10" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl10" value="겨울눈꽃명소" ${fn:contains(searchParam.themaEnvrnCl, '겨울눈꽃명소') ? 'checked' : ''}>#겨울눈꽃명소
				  	</label>
				</div>
				<div class="btn-group-toggle col-md-2 px-0 py-1" data-toggle="buttons">
				  	<label for="themaEnvrnCl11" class="btn btn-outline-success btn-outline-camper-color">
				    	<input type="checkbox" name="themaEnvrnCl" id="themaEnvrnCl11" value="걷기길" ${fn:contains(searchParam.themaEnvrnCl, '걷기길') ? 'checked' : ''}>#걷기길
				  	</label>
				</div>
			</div>
			<div class="row mx-3 p-3 float-right">
				<button type="submit" id="selectThemeBtn">테마검색하기&nbsp;&gt;</button>
			</div>
		</div>
	</div>
</form:form>
<script>
/**
 * 상세검색 페이지로 이동
 */
document.querySelector("#searchDetailBtn").addEventListener('click', (e) => {
	location.href = '${pageContext.request.contextPath}/campsite/searchDetail';
});
</script>
<div class="d-flex bd-highlight w-100 p-3 m-auto campsite-result-wrap">
	<div class="p-2 flex-fill bd-highlight campsite-result">
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="camp">
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