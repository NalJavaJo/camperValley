package com.kh.campervalley.community.review.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.campervalley.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class CampsiteReviewExt extends CampsiteReview {
	private int commentCount;
	private int recommendCount;
	private List<ReviewPhoto> photos = new ArrayList<>();
	private List<ReviewRecommend> recommends = new ArrayList<>();
	private List<ReviewComment> comments = new ArrayList<>();
	private Member member;
	
	public CampsiteReviewExt(@NonNull int reviewNo, String memberId, int contentId, @NonNull String facltNm,
			@NonNull int reviewGrade, @NonNull String stay, String[] merit, @NonNull String title,
			@NonNull String content, @NonNull LocalDateTime createdAt, LocalDateTime updatedAt,
			@NonNull int readCount, int commentCount, int recommendCount) {
		super(reviewNo, memberId, contentId, facltNm, reviewGrade, stay, merit, title, content, createdAt, updatedAt,
				readCount);
		this.commentCount = commentCount;
		this.recommendCount = recommendCount;
	}
	
	public void addReviewPhoto(@NonNull ReviewPhoto photo) {
		photos.add(photo);
	}
	
	public void addReviewRecommend(ReviewRecommend recommend) {
		recommends.add(recommend);
	}
	
	public void addReviewComment(@NonNull ReviewComment comment) {
		comments.add(comment);
	}

}
