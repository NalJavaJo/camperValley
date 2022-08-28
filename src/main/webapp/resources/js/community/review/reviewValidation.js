/**
 * 캠핑장후기 검색폼 유효성 검사
 */
if(document.reviewSearchFrm != null) {
	document.reviewSearchFrm.onsubmit = (e) => {
		const frm = e.target;
		
		const searchTypeVal = frm.searchType.value.trim();
		if(searchTypeVal == "") {
			$.alert({
			    title: '',
			    content: '검색타입을 선택하세요.',
			    buttons: {'확인': function() {}}
			});
			return false;
		}
		
		const searchKeywordVal = frm.searchKeyword.value.trim();
		if(searchKeywordVal == "") {
			$.alert({
			    title: '',
			    content: '검색어를 입력하세요.',
			    buttons: {'확인': function() {}}
			});
			return false;
		}
		
	}
}