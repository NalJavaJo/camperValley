<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/enroll.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">	
	<div id="enroll-container" class="mx-auto text-center" style="width: 33rem;">
		<div class="row">
			<div class="col-md-12" >
				<div class="header">
					<h4>
						회원가입
					</h4>
					<div class="line"></div>
				</div>
				<form:form name="enrollMemberFrm" method="POST" >
					<table class="mx-auto">
						<tr>
							<th><span class="text-danger">* </span>아이디</th>
						</tr>
						<tr>
							<td>
								<div id="memberIdContainer">
									<input type="text" 
										class="form-control" 
										placeholder="아이디"
										name="memberId" 
										id="memberId"
										autocomplete="off"
										required>
			 						<span class="text-danger guide-id-empty my-2 pl-1 d-none">필수 입력항목입니다.</span>
									<span class="text-danger guide-id-duplicate my-2 pl-1 d-none">이미 사용 중이거나 탈퇴한 아이디입니다.</span>
									<span class="text-danger guide-id-invalidation my-2 pl-1 d-none">아이디는 5-15자의 영문/숫자만 가능합니다.</span>
									<span class="camper-color guide-id-ok my-2 pl-1 d-none">사용할 수 있는 아이디입니다.</span>
									<input type="hidden" id="idValid" value="0" /> <!-- 0-사용불가 1-사용가능 -->
								</div>
							</td>
						</tr>
						<tr>
							<th><span class="text-danger">* </span>이름</th>
						</tr>
						<tr>
							<td>	
								<div id="nameContainer">
									<input type="text" class="form-control" name="name" id="name" placeholder="이름" autocomplete="off" required>
									<span class="text-danger guide-name-empty my-2 pl-1 d-none">필수 입력항목입니다.</span>
									<span class="text-danger guide-name-invalidation my-2 pl-1 d-none">2-10자의 한글만 가능합니다.</span>
								</div>
							</td>
						</tr>
						<tr>
							<th><span class="text-danger">* </span>닉네임</th>
						</tr>
						<tr>
							<td>	
								<div id="nicknameContainer">
									<input type="text" class="form-control" name="nickname" id="nickname" placeholder="닉네임" autocomplete="off" required>
									<input type="hidden" id="nicknameValid" value="0" /> <!-- 0-사용불가 1-사용가능 -->
									<span class="text-danger guide-nickname-empty my-2 pl-1 d-none">필수 입력항목입니다.</span>
									<span class="text-danger guide-nickname-duplicate my-2 pl-1 d-none">이미 사용 중인 닉네임입니다.</span>
									<span class="text-danger guide-nickname-invalidation1 my-2 pl-1 d-none">2자 이상의 영문/숫자/한글로 입력해주세요.</span>
									<span class="text-danger guide-nickname-invalidation2 my-2 pl-1 d-none">글자 수가 너무 깁니다.</span>
									<span class="camper-color guide-nickname-ok my-2 pl-1 d-none">사용할 수 있는 닉네임입니다.</span>
								</div>
							</td>
						</tr>
						<tr>
							<th><span class="text-danger">* </span>패스워드</th>
						</tr>
						<tr>
							<td>
								<div id="passwordContainer">
									<input type="password" class="form-control" name="password" id="password" placeholder="비밀번호" autocomplete="new-password" required>
									<input type="hidden" id="passwordValid" value="0" /> <!-- 0-사용불가 1-사용가능 -->
									<span class="text-danger guide-pw-empty my-2 pl-1 d-none">필수 입력항목입니다.</span>
									<span class="text-danger guide-pw-invalidation my-2 pl-1 d-none">영문자+숫자+특수문자 조합으로 8자리 이상 입력해주세요.</span>
									<span class="camper-color guide-pw-ok my-2 pl-1 d-none">사용할 수 있는 비밀번호 입니다.</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>	
								<div id="passwordConfirmContainer">
									<input type="password" class="form-control" id="passwordCheck" placeholder="비밀번호확인" autocomplete="off" required>
									<span class="text-danger guide-pw-ck-empty my-2 pl-1 d-none">필수입력항목입니다.</span>
									<span class="text-danger guide-pw-ck-invalidation my-2 pl-1 d-none">비밀번호와 일치하지 않습니다.</span>
								</div>
							</td>
						</tr>  
						<tr>
							<th><span class="text-danger">* </span>이메일</th>
						</tr>
						<tr>
							<td>	
								<div id="emailContainer">
									<input type="email" class="form-control " placeholder="이메일" name="email" id="email" required autocomplete="off" >
									<input type="hidden" id="emailValid" value="0" />
									<span class="text-danger guide-email-empty my-2 pl-1 d-none">필수입력항목입니다.</span>
									<span class="text-danger guide-email-Invalidation my-2 pl-1 d-none">이메일 주소를 다시 확인해주세요.</span>
									<span class="text-danger guide-email-duplicate my-2 pl-1 d-none">이미 사용 중인 이메일입니다.</span>
									<span class="camper-color guide-email-ok my-2 pl-1 d-none">사용할 수 있는 이메일 입니다.</span>
								</div>
							</td>
						</tr>
						<tr>
							<th><span class="text-danger">* </span>전화번호</th>
						</tr>
						<tr>
							<td>	
								<div id="telContainer">
									<input type="tel" class="form-control" placeholder="-없이 입력하세요" name="tel" id="tel" maxlength="11" autocomplete="off" required>
									<span class="text-danger guide-tel-empty my-2 pl-1 d-none">필수입력항목입니다.</span>
									<span class="text-danger guide-tel-invalidation my-2 pl-1 d-none">전화번호를 다시 확인해주세요.</span>
								</div>
							</td>
						</tr>
					</table>
					<br>
					<div class="checkbox">	 
						<div class="line"></div>
						<label>
							<input type="checkbox" name="agreeAll" />&nbsp;전체 동의
						</label>
						<hr class="m-0 mb-3">
							<input type="checkbox" id="checkAge" name="agree"/> <label class="pointer">&nbsp;만 14세 이상입니다.(필수)</label>
						<br>
							<input type="checkbox" name="agree"/> <label class="pointer" data-toggle="modal" data-target="#terms-use-modal">&nbsp;이용약관(필수)</label>  
						<br>
							<input type="checkbox" name="agree"/> <label class="pointer" data-toggle="modal" data-target="#terms-privacy-modal">&nbsp;개인정보수집 및 이용동의(필수)</label> 
						<div class="line"></div>
					</div> 
						<button type="submit" class="btn btn-camper-color w-100 mt-3"> 가입 </button>
						<a href="javascript:window.history.back();" type="reset" class="btn btn-outline-camper-color w-100 my-2"> 취소 </a>
				</form:form>
			</div>
		</div>
	</div>	
</div>

<!-- Modal1 -->
<div class="modal fade" id="terms-use-modal" tabindex="-1" aria-labelledby="terms-modal-label" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="terms-modal-label">이용약관</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		제1장 총 칙
		<br>
		제1조 (목적)
		<br>
		이 약관(이하 “약관”이라 합니다)은 (주)캠퍼밸리 (이하 “회사”라 합니다)와 이용 고객(이하 “회원”이라 합니다)간에 회사가 제공하는 서비스(이하 “서비스”라 합니다)를 이용함에 있어 회원과 회사간의 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.
		<br><br><br>
		제2조 (용어의 정의)
		<br>
		본 약관에서 사용되는 용어의 정의는 다음과 같습니다.
		<br>
		(1) “서비스” : 회사가 제공하는 상품(숙박 등으로 이에 한정되지 않음) 관련 상품∙용역∙서비스 등(이하 “상품등”이라 합니다)에 대한 예약∙구매∙정보제공∙추천 등을 위한 온라인 플랫폼 서비스를 의미합니다. 서비스는 구현되는 장치나 단말기(PC, TV, 휴대형 단말기 등의 각종 유무선 장치를 포함하며 이에 한정되지 않음)와 상관 없이 캠퍼밸리 및 캠퍼밸리 관련 웹(Web)∙앱(App) 등의 제반 서비스를 의미하며, 회사가 공개한 API를 이용하여 제3자가 개발 또는 구축한 프로그램이나 서비스를 통하여 이용자에게 제공되는 경우를 포함합니다.
		<br>
		(2) “회원” : 서비스에 접속하여 본 약관에 따라 회사와 이용계약을 체결하고 회사가 제공하는 서비스를 이용하는 고객을 말하며, 회원계정(ID/PW)을 생성하지 않은 일반 고객(일명 비회원 고객)도 포함됩니다.
		<br>
		(3) “판매자” : 회사가 제공하는 서비스를 이용하여 자신의 상품∙용역∙서비스 등을 판매하는 자를 의미하며, 회사로부터 예약∙판매 대행, 광고 서비스 등을 제공받는 자를 말합니다.
		<br>
		(4) “게시물” : 회원 및 이용 고객이 서비스에 게시 또는 등록하는 부호(URL 포함), 문자, 음성, 음향, 영상(동영상 포함), 이미지(사진 포함), 파일 등을 말합니다.
		
		<br><br><br>
		
		제3조 (약관의 효력 및 변경)
		<br>
		①    본 약관은 서비스를 이용하고자 하는 모든 회원에 대하여 그 효력을 발생합니다. 단, 일부 특정 서비스'의 경우 본 약관이 아닌 회사에 해당 서비스를 제공하는 사업자의 약관이 적용됩니다(자세한 안내는 각 서비스 영역에 별도 표시).
		<br><br>
		②    본 약관은 회원이 서비스 가입 시 열람 할 수 있으며, 회사는 회원이 원할 때 언제든지 약관을 열람 할 수 있도록 회사 홈페이지 또는 앱 내에 게시합니다.
		<br><br>
		③     회사는 『약관의 규제에 관한 법률』, 『전자상거래 등에서의 소비자보호에 관한 법률』, 『정보통신망 이용촉진 및 정보보호(이하 “정보통신망법”이라 합니다)』, , 『소비자기본법』, 『전자문서 및 전자거래 기본법』 등 관련법에 위배되지 않는 범위 내에서 본 약관을 개정할 수 있습니다.
		<br><br>
		④     회사가 약관을 변경할 경우에는 적용일자, 변경사유를 명시하여 적용일로부터 7일 이전부터 공지합니다. 다만, 회원에게 불리한 약관 변경인 경우에는 그 적용일로부터 30 전부터 위와 같은 방법으로 공지하고, E-mail 등으로 회원에게 개별 통지합니다. 단, 회원의 연락처 미기재, 변경 후 미수정 등으로 인하여 개별 통지가 어려운 경우 공지를 개별 통지로 간주합니다.
		<br><br>
		⑤     회사가 제4항에 따라 개정약관을 공지 또는 통지하면서, 회원에게 약관 변경 적용일 까지 거부의사를 표시하지 않으면 약관의 변경에 동의한 것으로 간주한다는 내용을 공지 또는 통지하였음에도 회원이 명시적으로 약관 변경에 대한 거부의사를 표시하지 아니하는 경우 회원이 개정약관에 동의한 것으로 간주합니다.
		<br><br>
		⑥     회원은 변경된 약관에 동의하지 아니하는 경우 서비스의 이용을 중단하고 이용계약을 해지할 수 있습니다.
		<br><br>
		⑦     회원은 약관 변경에 대하여 주의의무를 다하여야 하며, 변경된 약관의 부지로 인한 회원의 피해는 회사가 책임지지 않습니다.
		<br><br><br>
		제4조 (약관 외 준칙 및 관련법령과의 관계)
		<br>
		①    본 약관 또는 개별약관에서 정하지 않은 사항은 『전기통신사업법』, 『전자문서 및 전자거래 기본법』, 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』, 『전자상거래 등에서의 소비자보호에 관한 법률』, 『개인정보보호법』 등 관련 법의 규정 및 회사가 정한 서비스의 세부이용지침 등의 규정에 따릅니다. 또한 본 약관에서 정한 회사의 책임
		<br>
		 제한 규정은 관련 법령이 허용하는 최대한도의 범위 내에서 적용됩니다.
		<br><br>
		② 회사는 필요한 경우 서비스 내의 개별항목에 대하여 개별약관 또는 운영원칙을 정할 수 있으며, 본 약관과 개별약관 또는 운영원칙의 내용이 상충되는 경우에는 개별약관 또는 운영원칙의 내용이 우선 적용됩니다.
		<br><br><br><br><br><br>
		제2장 이용계약의 체결
		<br>
		제5조 (이용계약의 성립)
		<br>
		① 이용계약은 회원이 되고자 하는 자(이하 “가입신청자”)가 약관의 내용에 동의를 하고, 회사가 정한 가입 양식에 따라 회원정보를 기입하여 회원가입신청을 하고 회사가 이러한 신청에 대하여 승인함으로써 체결됩니다.
		<br>
		② 회원은 다수의 아이디(ID)를 생성하여 사용할 수 있으나, 본인인증이 필요한 일부 서비스의 경우에는 최초 본인인증된 1개 아이디(ID)로만 이용이 가능합니다.
		<br><br><br>
		제6조 (이용계약의 유보 및 거절)
		<br>
		①     회사는 다음 각 호에 해당하는 신청에 대하여는 승인 하지 않거나 사후에 이용계약을 해지할 수 있습니다.
		<br>
		  (1) 가입신청서의 내용을 허위로 기재하거나 기재누락∙오기가 있는 경우
		<br>
		  (2) 다른 사람의 명의, E-mail, 연락처 등을 이용한 경우
		<br>
		  (3) 관계법령에 위배되거나 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우
		<br>
		  (4) 가입신청자가 본 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 단 회사의 사전재가입 승낙을 얻은 경우에는 예외로 함
		<br>
		  (5) 회원의 귀책사유로 인하여 승인이 불가능한 경우
		<br>
		  (6) 이미 가입된 회원과 전화번호나 E-mail 정보가 동일한 경우
		<br>
		  (7) 부정한 용도 또는 영리를 추구할 목적으로 본 서비스를 이용하고자 하는 경우
		<br>
		  (8) 기타 본 약관에 위배되거나 위법 또는 부당한 이용신청임이 확인된 경우 및 회사가 합리적인 판단에 의하여 필요하다고 인정하는 경우
		<br>
		  (9) 만 14세 미만의 아동이 신청할 경우
		<br><br><br>
		②     제1항에 따른 신청에 있어 회사는 전문기관을 통한 휴대전화번호 인증 내지 실명확인을 통한 본인인증을 요청할 수 있습니다.
		<br><br>
		③     회사는 아래 각 호에 해당하는 경우에는 회원등록의 승낙을 유보할 수 있습니다.
		<br>
		  (1) 제공서비스 설비용량에 현실적인 여유가 없는 경우
		<br>
		  (2) 서비스를 제공하기에는 기술적으로 문제가 있다고 판단되는 경우
		<br>
		  (3) 회사가 재정적, 기술적으로 필요하다고 인정하는 경우
		<br>
		  (4) 제2항에 따른 실명확인 및 본인인증 절차를 진행 중인 경우
		<br><br>
		④     제1항과 제3항에 따라 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, 회사는 승낙거절 또는 유보 사실을 가입신청자에게 회사가 정하는 방법에 따라 통지합니다.
		<br><br>
		⑤     이용계약의 성립 시기는 회사가 ‘가입완료’ 사실을 신청절차 상에 표시하거나 별도로 통지한 시점으로 합니다.
		<br><br><br>​
		제7조 (회원 정보의 관리)
		<br>
		①    회원은 웹사이트 또는 앱 내에 구비된 정보수정 기능 내지 고객센터 등을 통해 개인정보를 열람∙변경∙수정 할 수 있습니다. 다만, 일부 개인정보의 경우 본인인증 절차가 필요할 수 있습니다.
		<br><br>
		②     회원은 등록한 E-mail 주소 또는 연락처가 변경된 경우 회원정보의 최신성 유지를 위해 제1항에 따라 변경해야 하며 이를 변경하지 않아 발생 할 수 있는 모든 불이익은 회원이 부담합니다.
		<br><br><br>
		​제8조 (계정정보의 관리책임)
		<br>
		①    아이디, 비밀번호 등 계정정보의 관리책임은 회원에게 있으며, 회원은 계정정보를 타인에게 양도 내지 대여할 수 없습니다.
		<br><br>
		②    회사는 회사의 귀책사유로 인한 경우를 제외하고 계정정보의 유출, 양도, 대여, 공유 등으로 인한 손실이나 손해에 대하여 아무런 책임을 지지 않습니다.
		<br><br>
		③    회원은 제3자가 본인의 계정을 사용하고 있음(대여 포함)을 인지한 경우에는 즉시 비밀번호를 수정하는 등의 조치를 취하고 이를 회사에 통보하여야 합니다. 회원이 본 항에 따른 통지를 하지 아니하여 발생하는 모든 불이익에 대한 책임은 회원에게 있습니다.
		<br><br><br>
		제9조 (회원정보의 수집과 보호)
		<br>
		​①     회사는 서비스를 제공함에 있어 개인정보 관련 법령을 준수하고 그에 따라 회원 정보를 수집∙이용∙보관∙제공합니다.
		<br><br>
		②    회사는 회원이 서비스 이용 과정에서 직접 제공한 정보 외에도 개인정보 보호 등 관련 법령에서 정한 절차에 따라 그밖의 정보를 수집 및 이용 또는 제3자에게 제공할 수 있습니다. 이 경우 회사는 관련 법령에 따라 회원으로부터 필요한 동의를 받거나 관련 법령에서 정한 절차를 준수합니다.
		<br><br>
		③    회사는 개인정보 보호 관련 법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력하며, 회사의 개인정보 처리에 관한 자세한 사항은 개인정보처리방침을 통해 언제든지 확인할 수 있습니다.
		<br><br>
		④    회사의 공식 사이트 또는 앱 이외에 링크된 사이트에서는 회사의 개인정보처리방침이 적용되지 않습니다. 링크된 사이트 및 서비스를 제공하는 제3자의 개인정보 처리에 대해서는 해당 사이트 및 제3자의 개인정보처리방침을 확인할 책임이 회원에게 있으며, 회사는 이에 대하여 책임을 부담하지 않습니다.
		<br><br><br><br><br><br>
		제3장 서비스 이용
		<br>
		​제10조 (서비스의 이용 개시)
		<br>
		회원은 회사가 이용신청을 승낙한 때부터 서비스를 사용할 수 있고 회사는 위 승낙한 때부터 본약관에 따라 서비스를 제공합니다.
		<br><br><br><br><br><br>
		제11조 (서비스의 이용시간)
		<br>
		①     서비스는 회사의 업무상 또는 기술상 특별한 사유가 없는 한 연중무휴 1일 24시간 제공함을 원칙으로 합니다. 회사는 서비스를 일정범위로 분할하여 각 범위 별로 이용가능시간을 별도로 지정할 수 있습니다.
		<br><br>
		②     회사는 서비스의 제공에 필요한 경우 정기점검 내지 수시점검을 실시할 수 있으며, 정기점검 내지 수시점검 시간은 서비스 제공화면에 공지가 불가할 수 있습니다
		<br><br><br>
		제12조 (서비스의 내용)
		<br>
		①     서비스는 제2조 제1호에서 정의한 바에 따라 회사가 회원에게 제공하는 여가 관련 온라인 플랫폼 서비스를 말합니다. 서비스는 현재 제공되는 상품 등에 한정되지 않으며, 향후 추가로 개발되거나 다른 회사와의 제휴 등을 통해 추가∙변경∙수정될 수 있고, 이 과정에서 일부 서비스의 경우 본인 인증 절차를 요구할 수 있습니다.
		<br><br>
		②     회사는 회원 감소 등으로 인한 원활한 서비스 제공의 곤란 및 수익성 악화, 기술 진보에 따른 차세대 서비스로의 전환 필요성, 서비스 제공과 관련한 회사 정책의 변경 등 기타 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 서비스를 변경 또는 중단할 수 있습니다.
		<br><br>
		③     서비스의 내용, 이용방법, 이용시간에 대하여 변경 또는 서비스 중단이 있는 경우에는 변경 또는 중단될 서비스의 내용 및 사유와 일자 등은 그 변경 또는 중단 전에 회사 홈페이지 또는 서비스 내 "공지사항" 화면 등 회원이 충분히 인지할 수 있는 방법으로 30일의 기간을 두고 사전에 공지합니다.
		<br><br>
		④     무료로 제공되는 서비스의 특성상 본조에 따른 서비스의 전부 또는 일부 종료 시 관련법령에서 특별히 정하지 않는 한 회원에게 별도의 보상을 하지 않습니다.
		<br><br>
		⑤     서비스 이용에 관한 개별 안내, 상품 등에 대한 정보, 예약 시 유의사항, 취소∙환불정책 등은 개별 서비스 이용안내∙소개 등을 통해 제공하고 있습니다.
		<br><br>
		⑥     회원은 전항의 안내∙소개 등을 충분히 숙지하고 서비스를 이용하여야 합니다. 회사는 통신판매중개자로서 통신판매의 당사자가 아니고, 판매자가 상품 등 이용에 관한 이용정책이나 예약에 관한 취소∙환불정책을 별도로 운영하는 경우가 있을 수 있으므로, 회원은 상품 등 이용 또는 예약 시 반드시 그 내용을 확인해야 합니다. 회원이 이 내용을 제대로 숙지하지 못해 발생한 피해에 대해서는 회사가 책임을 부담하지 않습니다.
		<br><br><br>
		제13조 (서비스의 변경 및 중지)
		<br>
		①     회사는 변경될 서비스의 내용 및 제공일자를 본 약관 제22조에서 정한 방법으로 회원에게 고지하고 서비스를 변경하여 제공할 수 있습니다.
		<br><br>
		②    회사는 다음 각 호에 해당하는 경우 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다.
		<br>
		  (1) 일부 서비스를 이용함에 있어 요구되는 본인인증 절차를 거치지 않거나, 본인인증 정보가 위조·변조·허위의 정보임이 확인된 경우
		<br>
		  (2) 회원이 회사의 영업활동을 방해하는 경우
		<br>
		  (3) 시스템 정기점검, 서버의 증설 및 교체, 네트워크의 불안정 등의 시스템 운영상 필요한 경우
		<br>
		  (4) 정전, 서비스 설비의 장애, 서비스 이용폭주, 기간통신사업자의 설비 보수 또는 점검∙중지 등으로 인하여 정상적인 서비스 제공이 불가능한 경우
		<br>
		  (5) 기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우
		<br>
		  (6) 기타 천재지변, 국가비상사태 등 불가항력적 사유가 있는 경우
		<br><br>
		③    제2항에 의한 서비스 중단의 경우 회사는 제22조에서 정한 방법으로 회원에게 통지합니다. 다만, 회사가 통제할 수 없는 사유로 인한 서비스의 중단(운영자의 고의∙과실이 없는 장애, 시스템다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다.
		<br><br>
		④    회사는 제2항에 따른 서비스의 변경, 중지로 발생하는 문제에 대해서 어떠한 책임도 지지 않습니다.
		<br><br>​<br>
		제14조 (정보 제공 및 광고의 게재)
		<br>
		①     회사가 회원에게 서비스를 제공할 수 있는 서비스 투자기반의 일부는 광고 게재를 통한 수익으로부터 나옵니다. 이에 회원은 서비스 이용 시 서비스 화면 상 노출되는 광고 게재에 대해 동의합니다.
		<br><br>
		②    회사는 회원의 게시물 내용, 검색 내용뿐만 아니라 언어, 쿠키 및 기기정보, IP 주소, 브라우저 유형, 운영체제 및 요청 일시와 같은 표준 로그 정보 등을 활용한 맞춤광고를 제공합니다. 이에 대한 자세한 사항은 "개인정보처리방침"을 참고하시기 바랍니다.
		<br><br>
		③    회원이 서비스상에 게재되어 있는 광고를 이용하거나 서비스를 통한 광고주의 판촉활동에 다른 상품 등을 이용하는 경우, 이는 전적으로 회원과 광고주 간의 법률관계이므로, 그로 인해 발생한 회원과 광고주간 분쟁 등 제반 문제는 회원과 광고주간에 직접 해결하여야 하며, 이와 관련하여 회사는 어떠한 책임도 지지 않습니다.
		<br><br>
		④    회사는 회원으로부터 수집한 개인정보를 통해 회원의 서비스 이용 중 필요하다고 판단되는 다양한 마케팅 정보를 SMS(LMS), 스마트 폰 알림 (Push 알림), E-mail, 카카오 톡 등을 활용하여 발송할 수 있으며, 회원은 이에 동의합니다. 다만, 회원은 거래관련정보 및 고객문의 등에 대한 답변을 제외하고 관련법에 따라 언제든지 마케팅 수신 동의를 철회하실 수 있으며, 이 경우 회사는 전단의 마케팅 정보 등을 제공하는 행위를 중단합니다(단, 시스템 반영에 시차가 있을 수 있음).
		<br><br><br>
		제15조 (게시물에 대한 권리)
		<br>
		①     게시물의 저작권은 회원에게 있습니다. 다만 회사는 게시∙전달∙공유 목적으로 회원이 작성한 게시물을 이용∙편집∙수정하여 이용할 수 있고, 회사의 다른 서비스 또는 연동채널∙판매채널에 이를 게재하거나 활용할 수 있습니다.
		<br><br>
		​②     회사가 서비스 내 게재 이외의 목적으로 게시물을 사용할 경우 게시물에 대한 게시자를 반드시 명시해야 합니다. 단, 게시자를 알 수 없는 익명 게시물이나 비영리적인 경우에는 그러하지 아니합니다.
		<br><br>
		③     회원은 게시물을 작성할 때 타인의 저작권 등 지식재산권을 포함하여 여타 권리를 침해하지 않아야 하고, 회사는 그에 대한 어떠한 책임도 부담하지 않습니다. 만일 회원이 타인의 권리 등을 침해하였음을 이유로 타인이 회사를 상대로 이의신청, 손해배상청구, 삭제요청 등을 제기한 경우 회사는 그에 필요한 조치를 취할 수 있으며, 그에 따른 모든 비용이나 손해배상책임은 회원이 부담합니다.
		<br><br>
		④     회사는 회원이 이용계약을 해지하고 사이트를 탈퇴하거나 적법한 사유로 해지된 경우 해당 회원이 게시하였던 게시물을 삭제할 수 있습니다.
		<br><br>
		⑤     회원이 작성한 게시물에 대한 모든 권리 및 책임은 이를 게시한 회원에게 있으며, 회사는 회원이 게시하거나 등록한 게시물이 다음 각 호에 해당한다고 판단되는 경우에 사전통지 없이 삭제 또는 임시 조치할 수 있고, 이에 대하여 회사는 어떠한 책임도 지지 않습니다.
		<br>
		  (1) 다른 회원 또는 제3자를 비방하거나 명예를 손상시키는 내용인 경우
		<br>
		  (2) 공공질서 및 미풍양속에 위반되는 내용을 유포하거나 링크시키는 경우
		<br>
		  (3) 불법복제 또는 해킹을 조장하는 내용인 경우
		<br>
		  (4) 회사로부터 사전 승인 받지 않고 상업광고, 판촉 내용을 게시하는 경우
		<br>
		  (5) 개인 간 금전거래를 요하는 경우
		<br>
		  (6) 범죄적 행위에 결부된다고 인정되는 경우
		<br>
		  (7) 회사의 저작권, 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우
		<br>
		  (8) 타인의 계정정보, 성명 등을 무단으로 도용하여 작성한 내용이거나, 타인이 입력한 정보를 무단으로 위*변조한 내용인 경우
		<br>
		  (9) 사적인 정치적 판단이나 종교적 견해의 내용으로 회사가 서비스 성격에 부합하지 않는다고 판단하는 경우
		<br>
		  (10) 동일한 내용을 중복하여 다수 게시하는 등 게시의 목적에 어긋나는 경우
		<br>
		  (11) 회사에서 규정한 게시물 원칙에 어긋나거나, 게시물을 작성하는 위치에 부여된 성격에 부합하지 않는 경우
		<br>
		  (12) 사업주 변경 또는 인테리어 공사 등에 따른 권리자(사업주)의 게시물 중단 또는 삭제 요청이 있는 경우
		<br>
		(13) 사실과 어긋난 허위적인 내용이 기재되어 있는 경우
		<br>
		(14) 기타 관계법령에 위배된다고 판단되는 경우
		<br><br>
		⑥ 	회원의 게시물이 정보통신망 법 및 저작권법 등 관련법에 위반되는 내용을 포함하는 경우, 권리자는 관련법이 정한 절차에 따라 해당 게시물의 게시중단 및 삭제 등을 요청할 수 있으며, 회사는 관련법에 따라 조치를 취하여야 합니다.
		<br><br>
		⑦      회사는 본 조 제2항에 따른 권리자의 요청이 없는 경우라도 권리침해가 인정될 만한 사유가 있거나 기타 회사 정책 및 관련법에 위반되는 경우에는 관련법에 따라 해당 "게시물"에 대해 임시조치 등을 취할 수 있습니다.
		<br><br>
		⑧ 본 조에 따른 세부절차는 정보통신망 법 및 저작권법이 규정한 범위 내에서 회사가 정한 게시중단요청서비스에 따릅니다. 
		<br>
		- 게시 중단요청 :campervalley.gmail.com
		<br><br><br>
		제16조 (권리의 귀속)
		<br>
		①    서비스에 대한 저작권 및 지식재산권은 회사에 귀속됩니다. 단, 게시물 및 제휴계약에 따라 제공된 저작물 등은 제외합니다.
		<br><br>
		②    회사가 제공하는 서비스의 디자인, 회사가 만든 텍스트, 스크립트(script), 그래픽, 회원 상호간 전송 기능 등 회사가 제공하는 서비스에 관련된 모든 상표, 서비스 마크, 로고 등에 관한 저작권 기타 지적재산권은 대한민국 및 외국의 법령에 기하여 회사가 보유하고 있거나 회사에게 소유권 또는 사용권이 있습니다.
		<br><br>
		③    회원은 본 이용약관으로 인하여 서비스를 소유하거나 서비스에 관한 저작권을 보유하게 되는 것이 아니라, 회사로부터 서비스의 이용을 허락받게 되는 바, 서비스는 정보취득 또는 개인용도로만 제공되는 형태로 회원이 이용할 수 있습니다.
		<br><br>
		④    회원은 명시적으로 허락된 내용을 제외하고는 서비스를 통해 얻어지는 회원 상태정보를 영리 목적으로 사용, 복사, 유통하는 것을 포함하여 회사가 만든 텍스트, 스크립트, 그래픽의 회원 상호간 전송기능 등을 복사하거나 유통할 수 없습니다.
		<br><br>
		⑤    회사는 서비스와 관련하여 회원에게 회사가 정한 이용조건에 따라 계정, ID, 콘텐츠 등을 이용할 수 있는 이용권만을 부여하며, 회원은 이를 양도, 판매, 담보제공 등의 처분행위를 할 수 없습니다.
		<br><br>
		⑥    회원은 서비스를 이용하는 과정에서 얻은 정보를 회사의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송, 편집, 재가공 등 기타 방법에 의하여 영리 목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
		<br><br><br><br><br><br>
		제4장 계약당사자의 의무
		<br>
		제17조 (회사의 의무)
		<br>
		①     회사는 관련법과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 서비스를 제공하기 위하여 최선을 다하여 노력합니다.
		<br><br>
		②    회사는 회원이 안전하게 서비스를 이용할 수 있도록 개인정보보호를 위해 보안시스템을 갖추어야 하며 개인정보처리방침을 공시하고 준수하며, 회원의 개인정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않고, 이를 보호하기 위하여 노력합니다.
		<br><br>
		③    회사는 서비스이용과 관련하여 회원으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 그에 필요한 조치를 취하여야 합니다.
		<br><br>
		④    회사가 제공하는 서비스로 인하여 회원에게 손해가 발생한 경우 그러한 손해가 회사의 고의나 과실에 의해 발생한 경우에 한하여 회사에서 책임을 부담하며, 그 책임의 범위는 통상손해에 한합니다.
		<br><br><br>
		제18조 (회원의 의무)
		<br>
		①    회원은 기타 관계 법령, 본 약관의 규정, 이용안내 및 서비스상에 공지한 주의사항, 회사가 통지하는 사항 등을 준수하여야 하며, 기타 회사의 업무에 방해되는 행위를 하여서는 아니 됩니다.
		<br><br>
		②    회원은 서비스의 이용권한, 기타 서비스 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며 이를 담보로 제공할 수 없습니다.
		<br><br>
		③    회원은 서비스 이용과 관련하여 다음 각 호의 행위를 하여서는 안됩니다.
		<br>
		  (1) 서비스 신청 변경, 본인인증 등 서비스 이용과정에서 허위내용을 기재·등록·전송 등을 하는 행위
		<br>
		  (2) 다른 회원의 아이디 및 비밀번호를 도용하여 부당하게 서비스를 이용하거나, 정보를 도용하는 행위
		<br>
		  (3) 타인의 계좌번호 및 신용카드번호 등 타인의 허락 없이 타인의 결제정보를 이용하여 회사의 유료서비스를 이용하는 행위
		<br>
		  (4) 정당한 사유 없이 당사의 영업을 방해하는 내용을 기재하는 행위
		<br>
		  (5) 회사가 게시한 정보를 변경하는 행위
		<br>
		  (6) 회사가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등을 송신 또는 게시하는 행위
		<br>
		  (7) 회사와 기타 제3자의 저작권 등 지적재산권을 침해하는 행위
		<br>
		  (8) 회사 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
		<br>
		  (9) 외설 또는 폭력적인 메시지, 화상, 음성 기타 공공질서 미풍양속에 반하는 정보를 공개 또는 게시하는 행위
		<br>
		  (10) 회사의 동의 없이 영리를 목적으로 서비스를 사용하는 행위
		<br>
		  (11) 회사의 직원이나 서비스의 관리자를 가장하거나 사칭하여 또는 타인의 명의를 도용하여 글을 게시하거나 메일을 발송하는 행위
		<br>
		  (12) 서비스와 관련된 설비의 오동작이나 정보 등의 파괴 및 혼란을 유발시키는 컴퓨터 바이러스, 기타 다른 컴퓨터 코드, 파일, 프로그램 자료를 등록 또는 유포하는 행위
		<br>
		  (13) 회사가 제공하는 소프트웨어 등을 개작하거나 리버스 엔지니어링, 디컴파일, 디스어셈블 및 기타 일체의 가공행위를 통하여 서비스를 복제, 분해 또는 모방 기타 변형하는 행위
		<br>
		  (14) 자동 접속 프로그램 등을 사용하는 등 정상적인 용법과 다른 방법으로 서비스를 이용하여 회사의 서버에 부하를 일으켜 회사의 정상적인 서비스를 방해하는 행위
		<br>
		  (15) 다른 회원의 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위
		<br>
		  (16) 기타 불법적이거나 회사에서 정한 규정을 위반하는 행위
		<br><br>
		④    회사는 회원이 제1항의 행위를 하는 경우 해당 게시물 등을 삭제 또는 임시 삭제할 수 있으며 서비스의 이용을 제한하거나 일방적으로 본 계약을 해지할 수 있습니다.
		<br><br>
		⑤    회원은 회원정보, 계정정보에 변경이 있는 경우 제7조에 따라 이를 즉시 변경하여야 하며, 더불어 비밀번호를 철저히 관리하여야 합니다. 회원의 귀책으로 말미암은 관리소홀, 부정사용 등에 의하여 발생하는 모든 결과에 대한 책임은 회원 본인이 부담하며, 회사는 이에 대한 어떠한 책임도 부담하지 않습니다.
		<br><br>​
		⑥    만 14세 미만 아동의 경우 본 서비스를 이용할 수 없습니다.
		<br><br>
		⑦    회원은 회사에서 공식적으로 인정한 경우를 제외하고는 서비스를 이용하여 상품을 판매하는 영업 활동을 할 수 없으며, 특히 해킹, 광고를 통한 수익, 음란사이트를 통한 상업행위, 상용소프트웨어 불법배포 등을 할 수 없습니다. 이를 위반하여 발생한 영업 활동의 결과 및 손실, 관계기관에 의한 구속 등 법적 조치 등에 관해서는 회사가 책임을 지지 않으며, 회원은 이와 같은 행위와 관련하여 회사에 대하여 손해배상 의무를 집니다.
		<br><br>
		⑧    회원은 직접 본인의 정보로 본인인증을 하여야 하고 이를 타인으로 하여금 하게 하거나 인증번호 등의 정보를 노출하여서는 안됩니다.
		<br><br><br><br>
		제19조 (회원에 대한 통지)
		<br>
		① 회사가 회원에 대한 통지를 하는 경우 본 약관에 별도 규정이 없는 한 회원이 기재한 E-mail로 할 수 있습니다.
		<br>
		② 회사는 불특정 다수 회원에 대한 통지의 경우 서비스 게시판 등에 게시함으로써 개별 통지에 갈음할 수 있습니다.
		<br><br><br>
		제20조 (서비스 이용 해지)
		<br>​
		①    회원이 이용계약을 해지하고자 하는 때에는 사이트 또는 앱을 통해 안내된 해지방법에 따라 해지를 신청할 수 있습니다.
		<br><br>
		②    회사는 등록 해지신청이 접수되면 회원이 원하는 시점에 해당 회원의 서비스 이용을 해지하여야 합니다.
		<br><br>
		​③    회원이 계약을 해지할 경우, 관련법 및 개인정보처리방침에 따라 회사가 회원정보를 보유할 수 있는 경우를 제외하고 회원의 개인정보는 해지 즉시 삭제됩니다.
		<br><br><br>
		제21조 (서비스 이용 제한)
		<br>
		① 회사는 이용제한정책에서 정하는 바에 따라 회원이 본 약관상 의무를 위반하거나 서비스의 정상적인 운영을 방해한 경우, 경고∙일시적 이용정지∙영구적 이용정지 등의 단계로 서비스 이용을 제한하거나 이용계약을 해지할 수 있습니다. 단, 회원에게 제6조 제1항의 사유가 있음이 확인되거나 회원이 서비스 이용과 관련하여 불법행위를 하거나 조장∙방조한 경우에는 즉시 영구적 이용정지 조치 또는 이용계약 해지를 할 수 있습니다.
		<br><br>
		② 회사는 회원이 계속해서 1년 이상 서비스를 이용하지 않은 경우에는, 정보통신망 법에 따라 필요한 조치를 취할 수 있고, 회원정보의 보호 및 운영의 효율성을 위해 이용을 제한할 수 있습니다.
		<br><br>
		③ 본 조에 따라 서비스 이용을 제한하거나 계약을 해지하는 경우에는 회사는 제20조에 따라 회원에게 통지합니다.
		<br><br>
		④ 회원은 본 조에 따른 서비스 이용정지 기타 서비스 이용과 관련된 이용제한에 대해 회사가 정한 절차에 따라 이의신청을 할 수 있으며, 회사는 회원의 이의신청이 정당하다고 판단되는 경우 즉시 서비스 이용을 재개합니다.
		<br><br><br><br><br><br>
		제5장 기타
		<br><br><br>
		제22조 (손해 배상)
		<br>
		① 회원이 본 약관의 규정을 위반함으로 인하여 회사에 손해가 발생하게 되는 경우, 본 약관을 위반한 회원은 회사에 발생하는 모든 손해를 배상하여야 합니다.
		<br><br>
		② 회원이 서비스를 이용하는 과정에서 행한 불법행위나 본 약관 위반행위로 인하여 회사가 당해 회원 이외의 제3자로부터 손해배상 청구 또는 소송을 비롯한 각종 이의제기를 받는 경우 당해 회원은 자신의 책임과 비용으로 회사를 면책시켜야 하며, 회사가 면책되지 못한 경우 당해 회원은 그로 인하여 회사에 발생한 모든 손해를 배상하여야 합니다.
		<br><br><br>
		제23조 (면책사항)
		<br>
		①     회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면책됩니다.
		<br><br>
		②    회사는 회원의 귀책사유로 인한 서비스의 이용장애에 대하여 책임을 지지 않습니다.
		<br><br>
		③    회사는 회원이 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며 그 밖에 서비스를 통하여 얻은 자료로 인한 손해 등에 대하여도 책임을 지지 않습니다. 회사는 회원이 게재한 게시물(이용후기, 숙소평가 등 포함)의 정확성 등 내용에 대하여는 책임을 지지 않습니다.
		<br><br>
		④    회사는 회원 상호간 또는 회원과 제3자 상호간에 서비스를 매개로 발생한 분쟁에 대해서는 개입할 의무가 없으며 이로 인한 손해를 배상할 책임도 없습니다.
		<br><br>
		⑤    상품 등은 판매자의 책임 하에 관리∙운영되고, 회사는 통신판매중개자로서 서비스 운영 상의 문제를 제외한 상품 등의 하자∙부실 등으로 인한 책임은 판매자에게 귀속되며 회사는 어떠한 책임도 부담하지 않습니다.
		<br><br>
		⑥    회사는 제3자가 서비스 내 화면 또는 링크된 웹사이트를 통하여 광고한 제품 또는 서비스의 내용과 품질에 대하여 감시할 의무가 없으며 그로 인한 어떠한 책임도 지지 아니합니다.
		<br><br>
		⑦    회사는 회사 및 회사의 임직원 그리고 회사 대리인의 고의 또는 중대한 과실이 없는 한 다음 각 호의 사항으로부터 발생하는 손해에 대해 책임을 지지 아니합니다.
		<br>
		  (1) 회원정보 등의 허위 또는 부정확성에 기인하는 손해
		<br>
		  (2) 서비스에 대한 접속 및 서비스의 이용과정에서 발생하는 개인적인 손해
		<br>
		  (3) 서버에 대한 제3자의 모든 불법적인 접속 또는 서버의 불법적인 이용으로부터 발생하는 손해
		<br>
		  (4) 서버에 대한 전송 또는 서버로부터의 전송에 대한 제3자의 모든 불법적인 방해 또는 중단행위로부터 발생하는 손해
		<br>
		  (5) 제3자가 서비스를 이용하여 불법적으로 전송, 유포하거나 또는 전송, 유포되도록 한 모든 바이러스, 스파이웨어 및 기타 악성 프로그램으로 인한 손해
		<br>
		  (6) 전송된 데이터의 오류 및 생략, 누락, 파괴 등으로 발생되는 손해
		<br>
		  (7) 회원 간의 회원 상태정보 등록 및 서비스 이용 과정에서 발생하는 명예훼손 기타 불법행위로 인한 각종 민∙형사상 책임
		<br><br><br>
		제24조 (분쟁 조정 및 관할법원)
		<br>​
		본 약관과 회사와 회원 간에 발생한 분쟁 등에 관하여는 대한민국 법령이 적용되며, 회사의 주소지를 관할하는 법원을 관할법원으로 합니다.
		<br>
		* 부 칙
		<br>
		1. 본 약관은 2022년 8월 29일부터 시행됩니다.
		<br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-camper-color w-100" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="terms-privacy-modal" tabindex="-1" aria-labelledby="terms-privacy-modal-label" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg">
	    <div class="modal-content">
    		<div class="modal-header">
        		<h5 class="modal-title" id="terms-privacy-modal-label">개인정보 수집 및 이용 동의</h5>
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
        			<span aria-hidden="true">&times;</span>
        		</button>
     		</div>
			<div class="modal-body">
				<pre>
제 1장 총칙

제 1조 (목적)

㈜캠퍼밸리(이하 “회사”)는  회사가 제공하는 서비스(이하 “서비스”)를 이용하는 회원의 개인정보 보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.

회사는 개인정보 보호 관련 주요 법률인 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다)을 비롯한 모든 개인정보 보호에 관련 법률 규정 및 국가기관 등이 제정한 고시, 훈령, 지침 등을 준수합니다.

본 개인정보처리방침은 회사의 서비스를 이용하는 회원에 대하여 적용되며, 회원이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보 보호를 위하여 회사가 어떠한 조치를 취하고 있는지 알립니다. 또한 개인정보와 관련하여 회사와 회원간의 권리 및 의무 관계를 규정하여 회원의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.



제 2장 개인정보의 처리

제 2조 (개인정보의 수집·이용에 대한 동의)

회사는 적법하고 공정한 방법에 의하여 서비스 이용계약의 성립 및 이행에 필요한 최소한의 개인정보를 수집하며 이용자의 개인 식별이 가능한 개인정보를 수집하기 위하여 회원가입시 개인정보수집·이용 동의에 대한 내용을 제공하고 회원이 '동의' 버튼을 클릭하면 개인정보 수집·이용에 대해 동의한 것으로 봅니다.


제 3조 (수집하는 개인정보의 항목범위 및 수집 방법)

① 회원가입, 상담, 서비스 신청 등 서비스 제공 및 계약이행을 위해 회원가입 시점에 회사가 회원으로부터 수집하는  개인정보는 아래와 같습니다.
1) 아이디(이메일 주소), 비밀번호, sns를 통한 가입 시 이메일, 이름, 생년월일, 연령, 성별, 프로필 사진, 식별token, 회원번호(sns 연동 또는 제휴요금제 이용 회원에 한함)를 수집하며 만약 회원의 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.

② 서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
1) 회사는 회원이 유료 서비스를 이용하고자 하는 경우 결제 시점에 아래와 같이 결제에 필요한 정보를 수집할 수 있습니다.
- 결제수단 소유자 정보(이름), 카드정보, 휴대전화번호, 유선전화번호, 결제건별 발행되는 거래 ID, 결제상품코드 
2) 회사는 회원이 이벤트, 프로모션에 참여하는 경우 아래의 정보를 수집할 수 있습니다.
- 이름, 이메일 주소, 휴대전화번호, 주소, 생년월일
3) 연령에 따른 콘텐츠 및 상품의 이용/구매 제한, 서비스 부정 이용 방지를 위해 본인인증이 진행되며 이름, 생년월일, 성별, 내/외국인 여부, 휴대전화번호, 연계정보(CI), 중복확인정보(DI)를 수집할 수 있습니다.
4) 현금 환불 시 예금주명, 계좌은행명, 계좌번호, 관계증명서류(필요 시)를 수집할 수 있습니다.
5) 고객센터로 문의 시 정확한 안내를 위해 이메일 주소, 휴대전화번호, 이름, 생년월일, 결제정보 등의 정보를 수집할 수 있습니다.
6) 회원 대상 맞춤형 추천 서비스 제공을 목적으로 이용자를 특정할 수 없는 이용한 서비스의 정보, 접속시간 및 빈도 등의 행태 정보를 수집할 수 있습니다.

③서비스 이용과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다.
1) PC : PC MacAddress, PC 사양정보, 브라우저 정보, 기타 서비스 이용 시 사용되는 프로그램 버전 정보
2) 휴대전화(스마트폰) &amp; 스마트OS 탑재 모바일 기기(Tablet PC 등) : 모델명, 기기별 고유번호(UDID,IMEI 등), OS정보, 이동통신사, 구글/애플 광고 ID
3) 기타 정보 : 서비스 이용(정지) 기록, 접속 로그, 쿠키, 접속 IP정보

5항. 회사는 다음과 같은 방식으로 개인정보를 수집합니다.
1) 회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우 개인정보를 수집합니다.
2) 온라인, 오프라인에서 진행되는 이벤트 등을 통해 개인정보가 수집될 수 있습니다.
3) 제휴 회사로부터의 제공을 통해 개인정보가 수집될 수 있습니다.
4) 고객센터를 통한 상담 과정에서 웹페이지, 메일, 팩스, 전화 등을 통해 개인정보가 수집될 수 있습니다.
5) 기기정보와 같은 생성정보는 PC웹, 모바일 웹/앱 이용 과정에서 자동으로 생성되어 수집될 수 있습니다.

6항. 회사는 기본적 인권침해의 우려가 있는 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 및 성생활 등)를 요구하지 않으며, 위의 항목 이외에 다른 어떠한 목적으로도 수집, 사용하지 않습니다.


제 4조 (개인정보의 자동 수집 장치의 설치, 운영 및 그 거부에 관한 사항)

① 쿠키란 웹 서버가 웹 브라우저에 보내어 저장했다가 서버의 부가적인 요청이 있을 때 다시 서버로 보내주는 문자열 정보(텍스트 파일)로 회원의 컴퓨터 하드디스크에 저장되며 쿠키 (cookie)에는 사용한 웹사이트의 정보 및 이용자의 개인정보가 담길 수 있습니다.
1) 회사에서 운영하는 서비스는 인터넷을 통하여 회원의 정보를 저장하고 수시로 찾아내는 쿠키(cookie)를 설치, 운용하고 있습니다. 회원이 웹사이트에 접속을 하면 회원의 브라우저에 있는 쿠키의 내용을 읽고, 추가정보를 찾아 접속에 따른 성명 등의 추가 입력없이 서비스를 제공할 수 있습니다.
2) 회원은 쿠키 설치에 대한 선택권을 가지고 있으며 회원은 웹브라우저에서 옵션을 설정함으로서 모든 쿠키를 허용하거나, 또는 쿠키가 저장될 때마다 확인을 거치거나, 혹은 모든 쿠키의 저장을 거부할 수도 있습니다. 다만, 회원이 쿠키 설치를 거부하는 경우 서비스 제공에 어려움이 발생할 수도 있습니다.
3) 회사가 쿠키를 통해 수집하는 정보는 회원의 고유번호에 한하며, 그 외의 다른 정보는 수집하지 않습니다. 회사가 쿠키(cookie)를 통해 수집한 회원의 고유번호는 다음의 목적을 위해 사용될 수 있습니다.
가. 개인의 관심 분야에 따라 차별화 된 정보를 제공
나. 서비스 이용 내역을 추적하여 분석을 통한 추후 개인 맞춤 서비스를 제공 및 서비스 개편 등의 척도로 활용

크롬: 설정&gt;쿠키 및 기타 사이트 데이터 에서 쿠키 설정


제 5조 (개인정보의 수집목적 및 이용목적)

① 회사는 수집한 개인정보를 다음의 목적으로 활용합니다.
1) 서비스 제공에 관한 계약 이행 유료 서비스 제공에 따른 요금정산
- 콘텐츠 제공, 유료 서비스 이용에 대한 과금, 구매 및 요금 결제, 본인인증, 물품배송 또는 청구서 등 발송, 요금 추심
2) 회원관리
- 회원제 서비스 이용에 따른 본인확인, 개인식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 중복가입확인, 가입의사 확인, 연령확인, 만 14세 미만 아동 개인정보 수집 시 법정대리인 동의 여부 확인 및 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 계정 정보 변경 등 고지사항 전달
3) 마케팅 및 광고에 활용
- 신규 서비스 개발 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 서비스 유효성 확인, 접속 빈도 파악, 회원의 서비스 이용에 대한 통계, 이벤트 및 광고성 정보와 참여기회 제공
4) 맞춤 서비스 제공, 서비스 유지·관리 및 품질 향상, 신규 서비스 요소 발굴 및 개선 등
- 회사는 본 서비스의 일환으로 회원에게 앱푸시 등의 방법으로 맞춤형 콘텐츠를 추천할 수 있습니다. 회원은 언제든지 앱푸시 설정을 통하여 이를 거절할 수 있습니다.


제 6조 (개인정보의 제3자 제공 및 위탁)

① 회사는 회원의 개인정보를 본 개인정보처리방침에서 명시된 범위를 초과하여 이용하거나 회원의 동의 없이 본 개인정보처리방침에 명시된 제공 대상자 외의 제3자(타인 또는 타기 업 기관)에 제공하지 않습니다. 다만, 다음 각호의 어느 하나에 해당하는 경우에는 예외로 합니다.
1) 관계법령에 의하여 수사, 재판 또는 행정상의 목적으로 관계기관으로부터 요구가 있을 경우
2) 금융실명거래 및 비밀보장에 관한 법률, 신용정보의 이용 및 보호에 관한 법률, 전기통신기본법, 전기통신사업법, 지방세법, 소비자보호법, 한국은행법, 형사소송법 등 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우

② 영업의 전부 또는 일부를 양도하거나, 합병/상속 등으로 서비스제공자의 권리, 의무를 이전 승계하는 경우 개인 정보보호 관련 회원의 권리를 보장하기 위하여 반드시 그 사실을 회원에게 통지합니다.

③보다 나은 서비스 제공을 위하여 회사가 귀하의 개인정보를 타 기업 등 제3자에게 제공하는 것이 필요한 경우 회사는 사전에 제휴사가 누구인지, 제공 또는 공유되어야 하는 개인정보항목이 무엇인지, 제공 또는 공유되는 개인정보의 이용목적, 그리고 언제까지 공유되며 어떻게 보호 관리되는지에 대하여 회원에게 고지하여 동의를 구하는 절차를 거칠 것이며, 회원이 동의하지 않는 정보는 제3자에 제공하거나 제3자와 공유하지 않습니다. 회사는 개인정보처리방침에서 정한 본래의 수집목적 및 이용목적에 반하여 무분별하게 회원의 개인 정보가 제공되지 않도록 최대한 노력하겠습니다.

④ 회사는 서비스 제공을 위하여 필요한 업무 중 일부를 외부 업체에 위탁하고 있으며, 위탁받은 업체가 정보통신망법에 따라 개인정보를 안전하게 처리하도록 필요한 사항을 규정하고 관리/감독을 하고 있습니다. 회사가 수탁업체에 위탁하는 업무와 관련된 서비스를 이용하지 않는 경우, 이용자의 개인정보가 수탁업체에 제공되지 않습니다.


제 7조 (개인정보의 처리 위탁 및 국외 이전)

① 개인정보의 처리 위탁은 아래와 같습니다.

1) 신용카드를 통한 결제 대행
- 수탁업체: (주) KG 이니시스
- 위탁업무 내용: 서비스 계약 이용을 위한 결제 처리 및 결제 도용 방지


제 8조 (회원 및 법정 대리인의 권리와 그 행사방법)

① 회원은 언제든지 자신의 개인정보를 조회, 수정, 삭제할 수 있습니다. 만 14세 미만의 아동의 개인정보는 그 법정대리인(이하 본 조에서 “법정대리인”이라고 합니다)이 아동을 대리하여 위와 같은 권리를 행사할 수 있습니다. 

② 회원 및 법정대리인은 제14조에 기재된 고객센터에 웹 문의, 서면, 전화, 전자우편의 방법으로 본인(법정대리인의 경우는 아동)의 개인정보의 조회, 수정, 삭제를 요청할 수 있습니다. 고객센터는 회원 또는 법정대리인의 권리 행사에 대하여 지체없이 조치하고 처리 결과를 안내합니다. 

③ 회원은 웹, 전용 애플리케이션의 [설정] 메뉴에서 등록되어 있는 개인정보를 직접 조회, 수정할 수 있으며, 즉시 결과를 확인할 수 있습니다. 

④ 회원 및 법정대리인이 위 제2, 3항의 조회, 수정, 삭제 요청의 처리 결과에 대해 이의가 있을 경우 고객센터에 연락할 수 있으며, 회사는 이의제기 내용을 검토하여 처리 결과를 안내합니다.

⑤ 회원 또는 만 14세 미만 아동의 법정대리인은 서비스 이용계약해지(회원탈퇴)를 통하여 개인정보의 수집 및 이용동의에 대한 동의를 철회할 수 있습니다. 

⑥ 개인정보의 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다. 단, 다음과 같은 경우에는 예외적으로 개인정보의 열람 및 정정을 제한할 수 있습니다. 
1) 본인 또는 제 3 자의 생명, 신체, 재산 또는 권익을 현저하게 해할 우려가 있는 경우 
2) 당해 서비스 제공자의 업무에 현저한 지장을 미칠 우려가 있는 경우 
3) 법령에 위반하는 경우 

⑦ 회사는 삭제 또는 회원 탈퇴 요청이 있을 경우, 개인정보 및 개인 데이터를 삭제 또는 제거합니다. 단, 회사는 제9조 "개인정보의 보관기간 및 이용기간"에 명시된 바에 같이 법령에 따른 기간 동안 회원의 개인정보를 보관할 수 있습니다. 

⑧ 회사는 회원이 타인의 개인정보를 도용하여 회원가입 등을 하였음을 알게 된 때 지체없이 해당 아이디에 대한 서비스 이용정지 또는 회원탈퇴 및 개인정보 삭제 등 필요한 조치를 취합니다. 또한 자신의 개인정보 도용을 인지한 회원이 해당 아이디에 대한 서비스 이용정지 또는 회원탈퇴 및 개인정보 삭제를 요구하는 경우에도 회사는 즉시 조치를 취합니다.


제 9조 (개인정보의 보관기간 및 이용기간)

① 회원의 개인정보는 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기됩니다. 회원이 회원탈퇴를 하거나 개인정보 허위기재로 인해 회원 ID 삭제 처분을 받은 경우 수집된 개인정보는 완전히 삭제되며 어떠한 용도로도 이용할 수 없도록 처리됩니다. 

② 또한 명의 도용 등 분쟁 발생시 본인확인을 위해 제출 받은 신분증 사본은 본인확인 후 즉시 파기합니다. 

③회원의 개인정보는 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기되나, 아래 각 항목에 해당하는 경우에는 명시한 기간 동안 보관할 수 있으며, 그 외 다른 목적으로는 사용하지 않습니다.
1) 불건전한 서비스 이용으로 서비스에 물의를 일으킨 이용자의 경우 사법기관 수사의뢰를 하거나 다른 회원을 보호할 목적으로 1년간 해당 개인정보를 보관할 수 있습니다.
2) 관계법령의 규정에 의하여 보관할 필요가 있는 경우 회사는 개인정보 수집 및 이용 목적 달성 후에도 관계법령 에서 정한 일정 기간 동안 회원의 개인정보를 보관할 수 있습니다.
가. 계약 또는 청약철회 등에 관한 기록: 5년
나. 대금결제 및 재화의 공급에 관한 기록: 5년
다. 소비자의 불만 또는 분쟁처리에 관한 기록: 3년
라. 표시, 광고에 관한 기록: 6개월
마. 웹사이트 방문기록: 3개월
3) 회사는 ‘개인정보 유효기간제’에 따라 1년간 서비스를 이용하지 않은 회원의 개인정보를 별도로 분리 보관하여 관리합니다.


제 10조 (개인정보의 파기절차 및 방법)

회사는 수집한 개인정보의 이용목적이 달성된 후 별도의 DB로 옮겨 보관기간 및 이용기간에 따라 해당 정보를 지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.

① 파기절차
회원이 서비스 가입 등을 위해 기재한 개인정보는 서비스 해지 등 이용목적이 달성된 후 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라 일정기간(개인정보 보관기간 및 이용기간 참조) 동안 저장 보관된 후 삭제하거나 파기합니다.

② 파기방법
서면양식에 기재하거나, 종이에 출력된 개인정보는 분쇄기로 분쇄하여 파기하고, 전자적 파일형태로 저장된 개인 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.


제 11조 (회원의 권리와 의무)

회원은 본인의 개인정보를 최신의 상태로 정확하게 입력하여 불의의 사고를 예방해주시기 바랍니다. 회원이 입력한 부정확한 정보로 인해 발생하는 사고의 책임은 회원 자신에게 있으며 타인 정보의 도용 등 허위정보를 입력할 경우 계정의 이용이 제한될 수 있습니다.
회사가 운영하는 서비스를 이용하는 회원은 개인정보를 보호받을 권리와 함께 스스로를 보호하고 타인의 정보를 침해하지 않을 의무도 가지고 있습니다. 회원은 아이디(ID), 비밀번호를 포함한 개인정보가 유출되지 않도록 조심하여야 하며, 게시물을 포함한 타인의 개인정보를 훼손하지 않도록 유의해야 합니다. 만약 이 같은 책임을 다하지 못하고 타인의 정보 및 타인의 존엄성을 훼손할 경우에는 정보통신망법 등에 의해 처벌 받을 수 있습니다.


제 (12조 고지의 의무)

현 「개인정보처리방침」 내용의 추가, 삭제 및 수정이 있을 시에는 개정 최소 7일 전부터 홈페이지의 '공지사항'을 통해 고지하고, 개정 내용이 회원에게 불리할 경우에는 개정 30일전부터 고지할 것입니다. 변경 관련 문의는 고객센터를 통해 할 수 있습니다.


제 13조 개인정보보호책임자 및 담당자

회사는 회원의 개인정보보호를 가장 중요시하며, 회원의 개인정보가 훼손, 침해 또는 누설되지 않도록 최선을 다하고 있습니다. 서비스를 이용하시면서 발생하는 모든 개인정보보호 관련 민원은 고객센터에 신고하시면 신속하게 답변해 드리도록 하겠습니다.
[개인정보보호책임자]
성 명: 김캠퍼
소 속: 개인정보보호팀
전자우편: camper@campervalley.com
[개인정보관리담당자]
성 명: 이밸리
소 속: 개인정보보호팀
전자우편: valley@campervalley.com


제 14조 (개인정보 침해 관련 상담 및 신고)

회사는 회원의 의견을 소중하게 생각합니다.
회사가 운영중인 서비스에 대하여 문의사항이 있을 경우 고객센터 등에 문의하시면 신속/정확한 답변을 드리겠습니다. 회사는 원활환 의사소통을 위해 고객상담센터를 운영하고 있으며 연락처는 다음과 같습니다.

[고객상담센터]
- 전자우편: cs@campervalley.com

기타 개인정보에 관한 상담이 필요한 경우에는 정보통신부 산하 공공기관인 한국인터넷진흥원(KISA) 개인정보침해신고센터, 경찰청 사이버테러대응센터, 대검찰청 사이버범죄수사단으로 문의하시기 바랍니다.

[한국인터넷진흥원 개인정보침해신고센터]
전화번호 : 국번없이 118

링크 사이트
회사는 운영중인 서비스 홈페이지를 통하여 회원에게 다른 회사의 웹사이트 또는 자료에 대한 링크를 제공할 수 있습니다. 이 경우 해당 사이트의 「개인정보처리방침」은 회사가 운영중인 서비스의 「개인정보처리방침」과 무관하므로 새로 방문한 사이트의 「개인정보처리방침」을 확인하시기 바랍니다.


* 부 칙

1. 본 약관은 2022년 8월 29일부터 시행됩니다.
        
	        	</pre>
			</div>
			<div class="modal-footer">
	       		 <button type="button" class="btn btn-camper-color w-100" data-dismiss="modal">닫기</button>
	     	 </div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/js/member/validation.js"></script>
<script>

$('form[name=enrollMemberFrm]').submit((e) =>{

	if(!validateId($("input[name=memberId]").val()) || $("#idValid").val() === '0'){ 
		$("input[name=memberId]").focus();
		return false;
	} else if(!validateName($("input[name=name]").val())){ 
		$("input[name=name]").focus();
		return false;
	} else if(!validateNickname($("input[name=nickname]").val()) || $("#nicknameValid").val() === '0'){
		$("input[name=nickname]").focus();
		return false;
	} else if(!validatePw($("input[name=password]").val())){
		$("input[name=password]").focus();
		return false;
	} else if(!validatePwCheck($("input[name=password]").val(),$("#passwordCheck").val())){
		$("#passwordCheck").focus();
		return false;	
	} else if(!validateEmail($("input[name=email]").val()) || $("#emailValid").val() === '0'){
		$("input[name=email]").focus();
		return false;
	} else if(!validateTel($("input[name=tel]").val())){
		$("input[name=tel]").focus();
		return false;
	} else if($("#checkAge").prop("checked") === false){
		alert("14세 미만은 서비스 이용이 불가능합니다.")
		return false;			
	} else if($("input[name=agreeAll]").prop("checked") === false){
		alert("이용약관과 개인정보 수집 및 이용 동의는 필수 입니다.")
		return false;
	}	
});

$("input[name=memberId]").focusout((e)=>{
	validateId($("input[name=memberId]").val());
})
$("input[name=name]").focusout((e)=>{
	validateName($("input[name=name]").val());
})
$("input[name=nickname]").focusout((e)=>{
	validateNickname($("input[name=nickname]").val());
})
$("input[name=password]").focusout((e)=>{
	validatePw($("input[name=password]").val());
})
$("#passwordCheck").focusout((e)=>{
	validatePwCheck($("input[name=password]").val(),$("#passwordCheck").val());
})
$("input[name=email").focusout((e)=>{
	validateEmail($("input[name=email]").val());
})
$("input[name=tel").focusout((e)=>{
	validateTel($("input[name=tel]").val());
})


function validateId(memberId){
	const idValid = $("#idValid"); //id라 지워도 될듯?
	const guideIdEmpty = $('.guide-id-empty');
	const guideIdDuplicate = $('.guide-id-duplicate');
	const guideIdInvalidation = $('.guide-id-invalidation');
	const guideIdOk = $('.guide-id-ok');
	const guides = $('#memberIdContainer span');
	
	idValid.val(0);
	
	let result = "";
	
	guides.removeClass('d-block'); 
	if(memberId == ""){
		addClassDBlock(guideIdEmpty);
		return false;
	} else if(!isValidateMemberID(memberId)){
		addClassDBlock(guideIdInvalidation);
		return false;
	} 
	$.ajax({
		url:'${pageContext.request.contextPath}/member/checkDuplicate',
		async:false,
		data : {
			value : memberId,
			attribute : "member_id"
		},
		success(response){
			const{value, available} = response;
			if(available){
				addClassDBlock(guideIdOk);
				idValid.val(1);
			} else{
				addClassDBlock(guideIdDuplicate);
			}
		},
		error: console.log
	});
	return true;
}

function validateName(name){
	const guideNameEmpty= $(".guide-name-empty");
	const guideNameInvalidation = $(".guide-name-invalidation");
	const guides = $('#nameContainer span');
	
	guides.removeClass('d-block'); 
	if(name == ""){
		addClassDBlock(guideNameEmpty);
		return false;
	} else if(!isValidateName(name)){
		addClassDBlock(guideNameInvalidation);
		return false;
	}
	return true;
}

function validateNickname(nickname){
	const nicknameValid = $("#nicknameValid");
	const guideNicknameEmpty= $(".guide-nickname-empty");
	const guideNicknameInvalidation1 = $(".guide-nickname-invalidation1");
	const guideNicknameInvalidation2 = $(".guide-nickname-invalidation2");
	const guideNicknameDuplicate = $(".guide-nickname-duplicate");
	const guideNicknameOk = $(".guide-nickname-ok");
	const guides = $('#nicknameContainer span');
	
	nicknameValid.val(0);
	guides.removeClass('d-block'); 
	if(nickname == ""){
		addClassDBlock(guideNicknameEmpty);
		return false;
	}  else if(/^[a-zA-Z0-9가-힣]{11,}$/.test(nickname)){
		addClassDBlock(guideNicknameInvalidation2);
		return false;
	} else if(!isValidateNickname(nickname)){
		addClassDBlock(guideNicknameInvalidation1);
		return false;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/member/checkDuplicate',
		data : {
			value : nickname,
			attribute : "nickname"
		},
		async:false,
		success(response){
			const{value, available} = response;
			if(available){
				addClassDBlock(guideNicknameOk);
				nicknameValid.val(1);
			} else{
				addClassDBlock(guideNicknameDuplicate);
			}
		},
		error: console.log
	});
	return true;
}

function validatePw(password){
	const guidePwEmpty= $(".guide-pw-empty");
	const guidePwInvalidation = $(".guide-pw-invalidation");
	const guidePwOk = $(".guide-pw-ok");
	const guides = $('#passwordContainer span');
	
	guides.removeClass('d-block'); 
	if(password == ""){
		addClassDBlock(guidePwEmpty);
		return false;
	} else if(!isValidatePassword(password)){
		addClassDBlock(guidePwInvalidation);
		return false;
	} else{
		addClassDBlock(guidePwOk);
	}
	return true;
}

function validatePwCheck(password, passwordCheck){
	const guidePwCkEmpty= $(".guide-pw-ck-empty");
	const guidePwCkInvalidation = $(".guide-pw-ck-invalidation");
	const guides = $('#passwordConfirmContainer span');
	
	guides.removeClass('d-block'); 
	if(passwordCheck == ""){
		addClassBlock(guidePwCkEmpty);
		return;
	} else if(password !== passwordCheck){
		addClassDBlock(guidePwCkInvalidation);
		return false;
	}
	return true;
}	

function validateEmail(email){
	const emailValid = $("#emailValid")
	const guideEmailEmpty= $(".guide-email-empty");
	const guideEmailInvalidation = $(".guide-email-invalidation");
	const guideEmailOk = $(".guide-email-ok");
	const guideEmailDuplicate = $(".guide-email-duplicate");
	const guides = $('#emailContainer span');
	emailValid.val(0);
	
	guides.removeClass('d-block'); 
	if(email == ""){
		addClassDBlock(guideEmailEmpty);
		return false;
	} else if(!isValidateEmail(email)){
		addClassDBlock(guideEmailInvalidation);
		return false;
	}
	$.ajax({
		url:'${pageContext.request.contextPath}/member/checkDuplicate',
		data : {
			value : email,
			attribute : "email"
		},
		async:false,
		success(response){
			const{value, available} = response;
			if(available){
				addClassDBlock(guideEmailOk);
				emailValid.val(1);
			} else{
				addClassDBlock(guideEmailDuplicate);
			}
		},
		error: console.log
	});
	return true;
}

function validateTel(tel){
	const guideTelEmpty = $(".guide-tel-empty");
	const guideTelInvalidation = $(".guide-tel-invalidation");
	const guides = $('#telContainer span');
	
	guides.removeClass('d-block'); 
	if(tel == ""){
		addClassDBlock(guideTelEmpty);
		return false;
	} else if(!isValidateTel(tel)){
		addClassDBlock(guideTelInvalidation);
		return false;
	}
	return true;
}

$("input[name=agreeAll]").click((e)=>{
	const agrees = $("input[name=agree]")
	if($(e.target).prop("checked")){
		agrees.prop("checked", true);
	} else {
		agrees.prop("checked", false)
	}
});
$("input[name=agree]").click((e)=>{
	const agreeAll = $("input[name=agreeAll]");
	const agrees = $("input[name=agree]");
	if(agreeAll.prop("checked") === true){
		agreeAll.prop("checked", false);
	} else{
		if(agrees.length == $("input[name=agree]:checked").length){
			agreeAll.prop("checked", true);
		}
	}

});

function addClassDBlock(elem){
	elem.addClass('d-block');
}

</script>