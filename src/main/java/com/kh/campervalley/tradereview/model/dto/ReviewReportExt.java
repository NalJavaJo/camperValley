package com.kh.campervalley.tradereview.model.dto;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewReportExt extends ReviewReport implements UserDetails{
	
	private String sellerId;
	private String memberId; // buyerId
	private String productNo;
	private String review;
	
	List<SimpleGrantedAuthority> authorities;
	
	public ReviewReportExt(int reportNo, int reviewNo, String category, String content, LocalDateTime createdAt,
			ReportStatus stateYn, String sellerId, String memberId, String productNo, String review) {
		super(reportNo, reviewNo, category, content, createdAt, stateYn);
		this.sellerId = sellerId;
		this.memberId = memberId;
		this.productNo = productNo;
		this.review = review;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return getMemberId();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}

	
}
