package com.kh.campervalley.member.controller;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.email.model.service.EmailService;
import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.member.model.service.MemberService;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@PropertySource("classpath:datasource.properties")
@Slf4j
public class MemberController {

	@Autowired
	MemberService memberService;

	@Autowired
	EmailService emailService;

	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	ServletContext application;
	
	@Value("${bs-info.naverId}")
	private String NAVER_ID;

	@Value("${bs-info.naverPassword}")
	private String NAVER_PASSWORD;

	@Value("${jwt.secret-key}")
	private String secretKey;
	
	@GetMapping("/enroll")
	public void memberEnroll() {
	}

	@GetMapping("/enrollSuccess")
	public void memberEnrollSuccess() {
	}

	@GetMapping("/resetPassword")
	public ModelAndView resetPassword(@RequestParam String token) throws Exception{
		
		ModelAndView mav= new ModelAndView();
		try {
			
			Key key = Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8));
			log.debug("token={}",token);
			
			Jws<Claims> jws = Jwts.parserBuilder()
								.setSigningKey(key)
								.build()
								.parseClaimsJws(token);
			
			mav.addObject("email",jws.getBody().get("email"));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return mav;
	}

	@PostMapping("/resetPassword")
	public String resetPassword(String email,String password, RedirectAttributes redirectAttr) {
		
		Map<String, Object> map = new HashMap<>();
		try {
			
			String encryptedPassword = bcryptPasswordEncoder.encode(password);
			map.put("password", encryptedPassword);
			map.put("email", email);
			
			int result = memberService.updatePassword(map);
			
			redirectAttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 로그인페이지로 이동합니다.");
			
		} catch (Exception e) {
			
			e.printStackTrace();
			redirectAttr.addFlashAttribute("msg", "비밀번호 찾기부터 다시 진행해주세요");
			return "redirect:/member/passwordSearcg";
			
		}
		return "redirect:/member/login";
	}
	
	@GetMapping("/searchId")
	public void searchId() {
	}

	@GetMapping("/searchPassword")
	public void searchPassword() {
	}

	@GetMapping("/login")
	public void login() {
	}

	@PostMapping("/enroll")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {

		try {
			
			String rawPassword = member.getPassword();
			String encryptedPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);

			int result = memberService.insertMember(member);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/member/enrollSuccess";
	}

	@GetMapping("/checkDuplicate")
	public ResponseEntity<?> checkIdDuplicate(@RequestParam String value, @RequestParam String attribute) {

		Map<String, Object> map = new HashMap<>();
		try {
			
			map.put("value", value);
			map.put("attribute", attribute);
			
			Member member = memberService.selectOneMember(map);
			
			boolean available = member == null;

			map.remove("attribute");
			map.put("available", available);
			
		} catch (Exception e) {
			
			log.error("중복검사 체크 오류", e);
			map.put("error", e.getMessage());

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
		}

		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);

	}

	@PostMapping("/searchId")
	public ResponseEntity<?> searchId(@RequestParam String name, @RequestParam String email) {
		Map<String, Object> map = new HashMap<>();

		try {
			map.put("name", name);
			map.put("email", email);
			String memberId = memberService.selectIDByNameAndEmail(map);
			
			map.clear();
			map.put("memberId", memberId);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
			
		}
		
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}

	@PostMapping("/searchPassword")
	public String searchPassword(@RequestParam String memberId,
				@RequestParam String email, RedirectAttributes redirectAttr) throws Exception{
		Map<String, Object> map = new HashMap<>();
		
		try {
			map.put("value", memberId);
			map.put("attribute", "member_id");
			Member member = memberService.selectOneMember(map);
			
			if (member != null && email.equals(member.getEmail())) {
				
				emailService.passwordResetMmailSender(email, member.getName());
				redirectAttr.addFlashAttribute("msg", "이메일로 비밀번호 재설정 링크 발송하였습니다.");
				return "redirect:/";
				
			} else {
				
				redirectAttr.addFlashAttribute("msg", "입력하신 정보와 일치하는 회원이 없습니다.");
				return "redirect:/member/searchPassword";
				
			}
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
			
		}
	}



}
