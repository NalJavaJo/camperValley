package com.kh.campervalley.campsite.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CampsiteImage {
	@NonNull
	private long serialnum;
	@NonNull
	private long contentId;
	private String imageUrl;
}
