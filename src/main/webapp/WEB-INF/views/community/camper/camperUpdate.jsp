<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/camper/camperUpdate.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/datepicker.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/advertiser/jquery-ui.css" />
<link href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<div class="modal fade" id="camperUpdate">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content px-5 py-2">
				<div class="modal-header">
					<div class="d-flex justify-content-start">
						<div class="text-20">캠퍼모집 수정</div>
						<div class="text-danger text-13 pl-4 pt-1">*표시는 필수 입력사항입니다.</div>
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form:form action="${pageContext.request.contextPath}/community/camper/camperUpdate" name="camperEnrollFrm" method="POST">
					<div class="modal-body">
						<table>
							<tbody>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="area">캠핑지역<span class="text-danger">*</span></label>
									</td>
									<td class="col-md-10 px-0">
										<select name="sido1" id="sido1" class="input p-2"></select>
										<select name="gugun1" id="gugun1" class="input p-2 ml-3"></select>
										<input type="hidden" name="area"></button>
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="dates">캠핑기간<span class="text-danger">*</span></label>
									</td>
									<td class=" px-0 form-row align-items-center mx-0">
										<div class="form-group mb-0">
											<input id="departureDate" type="text" class="input form-control form-control-sm input-daterange" style="margin: 10px 5px 10px 20px; width:95%;" name="departureDate" autocomplete="off" placeholder="0000-00-00" readonly />
										</div>
										<div>
											<span class="ml-3">-</span>
										</div>
										<div class="form-group mb-0">
											<input id="arrivalDate" type="text" class="input form-control form-control-sm input-daterange" style="margin: 10px 5px 10px 3px; width:104%;" name="arrivalDate" autocomplete="off" placeholder="0000-00-00" readonly />
										</div>
										<!-- <input type="text" name="dates" class="input" style="width:40%" placeholder="0000년 00월 00일 ~ 0000년 00월 00일"/> -->
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="memberCount">모집인원<span class="text-danger">*</span></label>
									</td>
									<td class="col-md-10 px-0">
										<input id="memberCount" type="number" name="memberCount" class="input" style="width:20%"/> &nbsp;명
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="title">제목<span class="text-danger">*</span></label>
									</td>
									<td class="col-md-10 px-0">
										<input id="title" type="text" name="title" class="input" style="width:98%" spellcheck="false"/>
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="content">상세내용<span class="text-danger">*</span></label>
									</td>
									<td class="col-md-10 px-0">
										<textarea id="content" name="content" cols="30" rows="5" style="width:98%" spellcheck="false"></textarea>
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="purpose">모임취지<span class="text-danger">*</span></label>
									</td>
									<td class="col-md-10 px-0">
										<textarea id="purpose" name="purpose" cols="30" rows="2" style="width:98%" spellcheck="false"></textarea>
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="expectedCost">예상비용<span class="text-danger">*</span></label>
									</td>
									<td class="col-md-10 px-0">
										<textarea id="expectedCost" name="expectedCost" cols="30" rows="2" style="width:98%" spellcheck="false"></textarea>
									</td>
								</tr>
								<tr>
									<td class="label col-md-2 px-0 pt-2">
										<label for="chatUrl">오픈채팅 URL<span class="text-danger" spellcheck="false">*</span></label>
									</td>
									<td class="col-md-10 px-0">
										<input id="chatUrl" type="text" name="chatUrl" class="input" style="width:98%"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
                    <div class="modal-footer p-0">
						<div class="text-right">
							<button type="submit" class="btn btn-outline-camper-color px-5 m-4">수정</button>
							<button type="button" class="btn btn-outline-danger px-5 my-4" onclick="$('#camperUpdate').modal('hide')">취소</button>
						</div>
	                </div>
	                <input id="camperNo" name="camperNo" type="hidden"/>
				</form:form>
			</div>
		</div>
	</div>
<script>
$(function(){
   $('.input-daterange').datepicker({
		dateFormat: 'yy-mm-dd',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    yearSuffix: '년',
		todayHighlight: true,
		showMonthAfterYear: true,
		startDate: '0d',
   });
});
$('document').ready(function() {
	const area0  = ["시/도","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
	const area1  = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	const area2  = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	const area3  = ["대덕구","동구","서구","유성구","중구"];
	const area4  = ["광산구","남구","동구",     "북구","서구"];
	const area5  = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	const area6  = ["남구","동구","북구","중구","울주군"];
	const area7  = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	const area8  = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	const area9  = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	const area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	const area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	const area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	const area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	const area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	const area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	const area16 = ["서귀포시","제주시","남제주군","북제주군"];

	// 시/도 선택 박스 초기화
	$("select[name^=sido]").each(function() {
		$selsido = $(this);
		$.each(eval(area0), function() {
			$selsido.append("<option value='"+this+"'>"+this+"</option>");
		});
		$selsido.next().append("<option value=''>시/군/구</option>");
	});

	// 시/도 선택시 구/군 설정
	$("select[name^=sido]").change(function() {
		const area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
		const $gugun = $(this).next(); // 선택영역 군구 객체
		$("option",$gugun).remove(); // 구군 초기화
	
		if(area == "area0")
			$gugun.append("<option value=''>시/군/구</option>");
		else {
			$.each(eval(area), function() {
				$gugun.append("<option value='"+this+"'>"+this+"</option>");
			});
		}
	});
});

const frm = document.camperEnrollFrm;
frm.addEventListener("submit", (e) => {
	frm.area.value = frm.sido1.value + " " + frm.gugun1.value;
	
	if(!frm.area.value || !frm.memberCount.value || !frm.title.value || !frm.content.value || !frm.chatUrl.value) {
		$.alert({
			icon: 'fa fa-warning',
		    title: '',
		    content: '필수항목을 모두 입력해주세요.',
		    buttons: {'확인': function() {}}
		});
		e.preventDefault();
		return;
	}
});

</script>
</html>