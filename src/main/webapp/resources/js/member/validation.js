const isValidateEmail = (email) => {
	return /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/i.test(email);		
}
const isValidateNickname = (nickname) => {
	return /^[a-z0-9가-힣]{2,11}$/i.test(nickname);		
}
const isValidatePassword = (password) => {
	return /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,}$/.test(password);		
}
const isValidateTel = (tel) => {
	return /^\d{9,11}$/.test(tel);		
}
const isValidateMemberID = (memberId) => {
	return /^\w{5,15}$/.test(memberId);		
}
const isValidateName = (name) => {
	return /^[가-힣]{2,10}$/.test(name);		
}
