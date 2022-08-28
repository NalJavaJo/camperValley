// ws.js

// const ws = new SockJS(`http://${location.host}/campervalley/echo`);

// ws.addEventListener('open', (e) => console.log('open :', e));
// ws.addEventListener('message', (e) => console.log('message :', e));
// ws.addEventListener('error', (e) => console.log('error :', e));
// ws.addEventListener('close', (e) => console.log('close :', e));


const ws = new SockJS(`http://${location.host}/campervalley/stomp`);
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log('open :', frame);

	// 구독신청
	stompClient.subscribe("/topic/abc", (message) => {
		console.log("/topic : ", message);
	});
	
	stompClient.subscribe("/app/def", (message) => {
		console.log("/app/def : ", message);
	});
});

