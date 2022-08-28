package com.kh.campervalley.community.review.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CampsiteReview {
	@NonNull
	private int reviewNo;
	private String memberId;
	private int contentId;
	@NonNull
	private String facltNm;
	@NonNull
	private int reviewGrade;
	@NonNull
	private String stay;
	private String[] merit;
	@NonNull
	private String title;
	@NonNull
	private String content;
	@NonNull
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	@NonNull
	private int readCount;
}
