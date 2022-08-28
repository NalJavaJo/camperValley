package com.kh.campervalley.community.review.model.dto;

import java.time.LocalDateTime;

import com.kh.campervalley.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewComment {
	@NonNull
	private int reviewCommentNo;
	@NonNull
	private int reviewNo;
	private String memberId;
	@NonNull
	private String commentContent;
	@NonNull
	private int commentLevel;
	private int commentRef;
	@NonNull
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private Member member;
}
