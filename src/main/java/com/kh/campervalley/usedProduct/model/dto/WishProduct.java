package com.kh.campervalley.usedProduct.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class WishProduct {
	
	private int wishNo;
	private String memberId;
	private int productNo;
}
