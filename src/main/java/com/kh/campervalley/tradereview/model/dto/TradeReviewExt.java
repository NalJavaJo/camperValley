package com.kh.campervalley.tradereview.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TradeReviewExt extends TradeReview {

	private String sellerId;
	private String buyerId;
	private String nickname;
	private String profileImg;
	private int reportNo;
}
