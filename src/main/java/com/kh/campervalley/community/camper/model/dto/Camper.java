package com.kh.campervalley.community.camper.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Camper {

	@NonNull
	private int camperNo;
 	private String memberId;
	@NonNull
	private String title;
	@NonNull
	private String content;
	@NonNull
	private String purpose;
	@NonNull
	private String expectedCost;
	@NonNull
	private String chatUrl;
	@NonNull
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate departureDate;
	@NonNull
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate arrivalDate;
	@NonNull
	private String area;
	@NonNull
	private int memberCount;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private Status status;
}
