package com.kh.campervalley.email.model.service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Service
public class EmailService {
	@Value("${bs-info.naverId}")
	private String hostSMTPid;

	@Value("${bs-info.naverPassword}")
	private String hostSMTPpwd;

	@Value("${jwt.secret-key}")
	private String secretKey;
	
	private String charSet = "utf-8"; 
	private String hostSMTP = "smtp.naver.com";
	private String fromEmail = "campervalley@naver.com";
	private String fromName = "캠퍼밸리";

	public String createToken(String email) {
		
		Key key = Keys.hmacShaKeyFor(secretKey.getBytes());

		Map<String, Object> headers = new HashMap<>();
		headers.put("typ", "JWT");

		Map<String, Object> payloads = new HashMap<>();
		payloads.put("email", email);

		Date exp = new Date();
		exp.setTime(exp.getTime() + 1000 * 60L * 5);
		
		return Jwts.builder()
				.setHeaderParam("typ", "jwt")
				.setIssuer("campervalley")
				.setSubject("passwordReset")
				.setClaims(payloads)
				.setExpiration(exp)
				.setIssuedAt(new Date())
				.signWith(key)
				.compact();
	}
	
	public void passwordResetMmailSender(String emailTo, String nameTo) throws Exception{
		  
		String token = createToken(emailTo);
		  
		try { 
			HtmlEmail htmlEmail = new HtmlEmail();
			htmlEmail.setCharset(charSet);
			htmlEmail.setHostName(hostSMTP);
			htmlEmail.setSSLOnConnect(true);
			htmlEmail.setSmtpPort(465);
			htmlEmail.setAuthentication(hostSMTPid, hostSMTPpwd);
			htmlEmail.addTo(emailTo,nameTo ,charSet); 
			htmlEmail.setFrom(fromEmail, fromName, charSet);
			htmlEmail.setSubject("[캠퍼밸리] 비밀번호 재설정 안내");
			htmlEmail.setHtmlMsg("<!DOCTYPE html>\r\n"
			  		+ "<html>\r\n"
			  		+ "	<style>\r\n"
			  		+ "		body{\r\n"
			  		+ "			color: #2B380C;\r\n"
			  		+ "			font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif\r\n"
			  		+ "		}\r\n"
			  		+ "	</style>\r\n"
			  		+ "<body>\r\n"
			  		+ "	<div style=\"min-width: 350px; width: 400px; margin: auto; margin-top: 6%; font-size: 1rem;\">\r\n"
			  		+ "		<h1 style=\"font-size: 1.6rem;\">안녕하세요 <strong>캠퍼밸리</strong>입니다.</h1>\r\n"
			  		+ "		<p style=\"margin: 1rem 0 1.5rem 0;\">아래 링크를 클릭하여 비밀번호를 재설정 해주세요.<br>\r\n"
			  		+ "			개인정보 보호를 위해 아래 링크는 5분 동안만 유효합니다.</p>\r\n"
			  		+ "		\r\n"
			  		+ "		<hr>\r\n"
			  		+ "		<a href=\"http://localhost:9090/campervalley/member/resetPassword?token="+token+"\" style=\"display: block; font-weight: 700; background-color: #2B380C; margin: auto; border-radius: 4px; margin-top: 30px;\r\n"
			  		+ "			margin-bottom: 30px;font-size: 1.08rem;  text-decoration: none; color: #fff; width: 200px; padding: 11px 15px; text-align: center; \">\r\n"
			  		+ "				비밀번호 재설정\r\n"
			  		+ "		</a>\r\n"
			  		+ "		<p></p>\r\n"
			  		+ "		<hr>\r\n"
			  		+ "	</div>\r\n"
			  		+ "	\r\n"
			  		+ "</body>\r\n"
			  		+ "</html>"
			  		);  
			htmlEmail.send(); 
	  
		} catch (Exception e) { 
			e.printStackTrace();
			throw e;
		}
	}
}
