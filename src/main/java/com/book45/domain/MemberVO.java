package com.book45.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String pass;
	private String name;
	private String nickname;
	private String phone;
	private String email;
	private String zipCode;
	private String addressRoad;
	private String addressDetail;
	private String lev;
	private int point;
}
