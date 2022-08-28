package com.kh.campervalley.community.review.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewRecommend {
	@NonNull
	private int recommendNo;
	@NonNull
	private int reviewNo;
	@NonNull
	private String memberId;
	@NonNull
	private String status;
}
