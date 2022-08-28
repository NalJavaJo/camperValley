package com.kh.campervalley.member.model.dto;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class Member implements UserDetails{

	@NonNull
	private String memberId;
	@NonNull
	private String name;
	@NonNull
	private String nickname;
	@NonNull
	private String password;
	@NonNull
	private String email;
	@NonNull
	private String tel;
	private String profileImg;
	private LocalDateTime enrollDate;
	private LocalDateTime updatedAt;
	private Withdrawal withdrawal;
	private boolean enabled;
	
	List<SimpleGrantedAuthority> authorities;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}
	@Override
	public String getUsername() {
		return memberId;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

}
