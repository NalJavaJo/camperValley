package com.kh.campervalley.chat.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class ChatMember {

	@NonNull
	private String chatroomId;
	@NonNull
	private String sellerId;
	@NonNull
	private String buyerId;
	private String buyerImg;
	private String sellerLastCheck;
	private String buyerLastCheck;
	private int productNo;
	private LocalDateTime createdAt;
	private LocalDateTime deletedAt;
}
