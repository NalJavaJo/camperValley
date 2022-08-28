package com.kh.campervalley.cs.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeAttach {
	private int noticeAttachNo;
	private int noticeNo;
	private String originalFilename; 
	private String renamedFilename;
	private LocalDateTime createdAt;
	

}
