package com.kh.campervalley.tradereview.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TradeReview {
	
	private int reviewNo;
	private int productNo;
	private int starScore;
	private String content;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
}
