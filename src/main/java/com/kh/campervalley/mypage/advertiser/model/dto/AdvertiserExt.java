package com.kh.campervalley.mypage.advertiser.model.dto;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class AdvertiserExt extends Advertiser implements UserDetails {

	private LicenseFile licenseFile;
	private String withdrawal;
	List<SimpleGrantedAuthority> authorities;

	public AdvertiserExt(int advertiserNo, String memberId, String bizLicenseNo, String bizName, BizStatus bizStatus,
			LocalDateTime createdAt, LocalDateTime deletedAt, @NonNull LicenseFile licenseFile, String withdrawal) {

		super(advertiserNo, memberId, bizLicenseNo, bizName, bizStatus, createdAt, deletedAt);

		this.withdrawal = withdrawal;
		if (licenseFile != null)
			this.licenseFile = licenseFile;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return getMemberId();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}

}
