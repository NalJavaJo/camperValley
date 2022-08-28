package com.kh.campervalley.mypage.community.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CampsiteBookmark {

	private int campBmNo;
	private String memberId;
	private long contentId;

}
