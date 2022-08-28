<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- SJ start --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval var="channelIOKey" expression="@customProperties['api.channelIO']" />
<%-- SJ end --%>
	</section>
	<footer class="bg-light">
		<div class="d-flex justify-content-around px-2 py-3">
			<div id="campervalleyInfo">
				<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" />
				<div class="font-weight-bold">(주)캠퍼밸리</div>
				<div class="font-weight-bold">사업자등록번호 : 000-00-00000</div>
				<div class="font-weight-bold">사업장소재지 : 서울특별시 강남구 테헤란로00 kh빌딩 7층</div>
				<br />
				<div class="text-sm">(주)캠퍼밸리는 중개자로서 개별 판매자가 등록한 상품정보에 대해서 책임을 지지 않습니다.</div>
			</div>
			<div id="campervalleyCall" class="mt-5">
				<div style="font-size: 16px;">고객센터 &gt;</div>
				<div class="font-weight-bold" style="font-size: 25px;">1588-0000</div>
				<div>운영시간 09:00 ~ 18:00</div>
				<div>(주말/공휴일 휴무, 점심시간 12:00 ~ 13:00)</div>
			</div>
		</div>
		<div class="mx-auto text-center font-weight-bold py-4">이용약관 | 개인정보처리방침</div>
	</footer>
	<%-- SJ start --%>
	<script>
	<!-- Channel Plugin Scripts -->
	var memberIdVal = '${loginMember.memberId}';
	var nameVal = '${loginMember.name}';
	var telVal = '${loginMember.tel}';
	var emailVal = '${loginMember.email}';

	if(memberIdVal == '') {
		memberIdVal = null;
	}
	if(nameVal == '') {
		nameVal = null;
	}
	if(telVal == '') {
		telVal = null;
	}
	if(emailVal == '') {
		emailVal = null;
	}

	(function() {
		var w = window;
		if(w.ChannelIO) {
			return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
		}
		var ch = function() {
			ch.c(arguments);
		};
		ch.q = [];
		ch.c = function(args) {
			ch.q.push(args);
		};
		w.ChannelIO = ch;
		function l() {
			if(w.ChannelIOInitialized) {
				return;
			}
			w.ChannelIOInitialized = true;
			var s = document.createElement('script');
			s.type = 'text/javascript';
			s.async = true;
			s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
			s.charset = 'UTF-8';
			var x = document.getElementsByTagName('script')[0];
			x.parentNode.insertBefore(s, x);
		}
		if(document.readyState === 'complete') {
			l();
		} else if(window.attachEvent) {
			window.attachEvent('onload', l);
		} else {
			window.addEventListener('DOMContentLoaded', l, false);
			window.addEventListener('load', l, false);
		}
	})();
	ChannelIO('boot', {
		"pluginKey": "${channelIOKey}",
		"memberId": memberIdVal,
		"profile": {
			"name": nameVal,
			"mobileNumber": telVal,
			"email": emailVal
		}
	});
	<!-- End Channel Plugin -->
	</script>
	<%-- SJ end --%>
</body>
</html>
