package com.kh.campervalley.mypage.community.model.dto;

import com.kh.campervalley.campsite.model.dto.Campsite;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class CampsiteBookmarkExt extends CampsiteBookmark {

	private Campsite campsite;

	public CampsiteBookmarkExt(int campBmNo, String memberId, long contentId, Campsite campsite) {
		super(campBmNo, memberId, contentId);
		this.campsite = campsite;
	}

}
