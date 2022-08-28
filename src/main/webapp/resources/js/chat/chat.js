document.querySelector("#sendBtn").addEventListener('click', (e) => {

	const msg = document.querySelector("#msg").value;
	if(!msg) return;
	
	const payload = {
		chatroomId,
		memberId,
		msg,
		time : Date.now(),
		type : 'CHAT'
	};
	
stompClient.send(`/app/chat/${chatroomId}`, {}, JSON.stringify(payload)); 
	document.querySelector("#msg").value = '';
});
