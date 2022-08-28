package com.kh.campervalley.community.review.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewPhoto {
	@NonNull
	private int reviewPhotoNo;
	@NonNull
	private int reviewNo;
	@NonNull
	private String originalFilename;
	@NonNull
	private String renamedFilename;
	@NonNull
	private LocalDateTime createdAt;
}
