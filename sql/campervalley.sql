-------------------------------------------
-- campervalley.sql
-------------------------------------------

create table member (
  member_id varchar2(15) not null,
	name varchar2(30) not null,
	nickname varchar2(30) not null,
	password varchar2(300) not null,
	email varchar2(256) not null,
	tel varchar(11) not null,
	profile_img varchar2(256),
	enroll_date date not null,
	withdraw char(1) default 'N',
	enabled number default 1,

  constraint pk_member primary key(member_id),
  constraint ck_member_enabled check(enabled in (0, 1)),
  constraint ck_member_withdraw check(withdraw in ('Y', 'N'))
);

create table authority (
	auth varchar2(50) not null,
	member_id varchar2(15) not null,
    constraint pk_authority primary key(member_id, auth),
    constraint fk_authority_member_id foreign key(member_id) references member(member_id) on delete cascade
);

create table persistent_logins (
    username varchar(64) not null, 
    series varchar(64) primary key, 
    token varchar(64) not null, --username, password, expiry time을 hashing한 값
    last_used timestamp not null
);

create table notice (
	notice_no number,
	member_id varchar2(15),
	category varchar2(10) not null,
	title varchar2(100) not null,
	content varchar2(4000) not null,
	created_at date default sysdate,
	read_count number default 0,
    
    constraint pk_notice_no primary key(notice_no),
    constraint fk_notice_member_id foreign key(member_id) references member(member_id) on delete set null,
    constraint ck_notice_category check(category in ('notice', 'faq'))
);
create sequence seq_notice_no;

create table notice_attach (
	notice_attach_no number,
	notice_no number not null,
	original_filename varchar2(255),
	renamed_filename varchar2(255),
	created_at date default sysdate,
    
    constraint pk_notice_attach_no primary key(notice_attach_no),
    constraint fk_notice_attach_notice_no foreign key(notice_no) references notice(notice_no) on delete cascade
);
create sequence seq_notice_attach_no;

create table advertiser (
	advertiser_no number not null,
	member_id varchar2(15) not null,
	biz_license_no char(10) not null,
	biz_name varchar2(255) not null,
	biz_status char(1) default 'N',
	created_at date default sysdate,
	deleted_at date,
    
	constraint pk_advertiser primary key(advertiser_no),
	constraint fk_advertiser_member_id foreign key(member_id) references member(member_id),
	constraint ck_advertiser_biz_status check(biz_status in ('Y', 'N'))
);
create sequence seq_advertiser_no;

create table license_file (
	license_file_no number not null,
	advertiser_no number not null,
	original_filename varchar2(255),
	renamed_filename varchar2(255),
	created_at date default sysdate,
    
    constraint pk_license_file primary key(license_file_no),
    constraint fk_license_file_advertiser_no foreign key(advertiser_no) references advertiser(advertiser_no) on delete cascade
);
create sequence seq_license_file_no;

create table admoney (
	admoney_no number not null,
	advertiser_no number not null,
	balance number default 0 not null,
    
	constraint pk_admoney primary key(admoney_no),
	constraint fk_admoney_advertiser_no foreign key(advertiser_no) references advertiser(advertiser_no) on delete cascade
);
create sequence seq_admoney_no;

-- pk, imp_uid 자료형 수정함(8/9), pay_statement 컬럼명 수정
create table pay (
	merchant_uid varchar2(16) not null,
	advertiser_no number not null,
	imp_uid varchar2(16) not null,
	pay_method varchar2(50) not null,
	paid_amount number not null,
	status varchar2(15) not null,
	buyer_email varchar2(255),
	buyer_name varchar2(50),
	buyer_tel varchar2(11),
	paid_at number not null,
	pg_provider varchar2(20),

	constraint pk_pay primary key(merchant_uid),
	constraint fk_pay_advertiser_no foreign key(advertiser_no) references advertiser(advertiser_no) on delete cascade
);

create table advertisement (
	advertisement_no number not null,
	advertiser_no number not null,
	ad_name varchar2(500) not null,
	ad_zone varchar2(100) not null,
	ad_link varchar(2000) not null,
	ad_cpc number not null,
	ad_daily_budget number,
	ad_status number default 1,
	created_at date default sysdate,
	updated_at date,
	deleted_at date,
    
	constraint pk_advertisement primary key(advertisement_no),
	constraint fk_advertisement_advertiser_no foreign key(advertiser_no) references advertiser(advertiser_no) on delete cascade,
	constraint ck_advertisement_ad_status check(ad_status in (0, 1))
);
create sequence seq_advertisement_no;

create table ad_attach (
	ad_attach_no number not null,
	advertisement_no number not null,
	original_filename varchar2(255),
	renamed_filename varchar2(255),
	created_at date default sysdate not null,
    
	constraint pk_ad_attach primary key(ad_attach_no),
	constraint fk_ad_attach_advertisement_no foreign key(advertisement_no) references advertisement(advertisement_no) on delete cascade
);
create sequence seq_ad_attach_no;

create table ad_performance (
    ad_performance_no number not null,
    advertisement_no number not null,
    display_at date default trunc(sysdate),
    daily_click_cnt number default 0,
    daily_view_cnt number default 0,
    
    constraint pk_ad_performance primary key(ad_performance_no),
    constraint fk_ad_performance_advertisement_no foreign key(advertisement_no) references advertisement(advertisement_no) on delete cascade,
    constraint uq_ad_performance_adno_display unique(advertisement_no, display_at)
);
create sequence seq_ad_performance_no;

create table camper (
	camper_no number,
	member_id	varchar2(15) not null,
	title varchar2(100) not null,
	content varchar2(2000) not null,
	purpose varchar2(2000),
	expected_cost varchar2(2000),
	chat_url varchar2(100) not null,
	departure_date date not null,
	arrival_date date not null,
	area varchar2(100) not null,
	member_count number not null,
	read_count number default 0,
	created_at date default sysdate,
	updated_at date,
	status varchar2(20) default 'I',
  constraint pk_camper_no primary key(camper_no),
  constraint fk_camper_member_id foreign key(member_id) references member(member_id) on delete cascade,
  constraint ck_camper_status check(state in ('C', 'I'))
);
create sequence seq_camper_join_no;

create table category (
    cate_no number not null, 
    cate_name varchar2(50) not null,
    
    constraint pk_category primary key(cate_no)
);
create sequence seq_category_no;

------------------ clear

create table used_product (
	product_no number not null,
	seller_id varchar2(15) not null,
	cate_no number not null,
	product_title varchar2(100) not null,
	product_content varchar2(4000),
	product_img1 varchar2(255) not null,
	product_img2 varchar2(255),
	product_img3 varchar2(255),
	product_img4 varchar2(255),
	product_img5 varchar2(255),
	product_price varchar2(30) not null,
	product_location varchar2(400) not null,
	product_delivery_fee number not null,
	product_enroll_date varchar2(30) not null,
	product_views number not null,
	transaction_date date,
	buyer_id varchar2(15),
	is_delete char(1) default 'N',
    
    constraint pk_used_product primary key(product_no),
    constraint fk_used_product_seller_id foreign key(seller_id) references member(member_id) on delete cascade,
    constraint fk_used_product_buyer_id foreign key(buyer_id) references member(member_id),
    constraint fk_used_product_cate_no foreign key(cate_no) references category(cate_no) on delete cascade,
    constraint ck_used_product_is_delete check(is_delete in ('Y', 'N'))
);
create sequence seq_used_product_no;


create table wish_product (
	wish_no number not null,
	member_id varchar2(15) not null,
	product_no number not null,
    
    	constraint pk_wish_product primary key(wish_no),
    	constraint fk_wish_product_member_id foreign key(member_id) references member(member_id) on delete cascade,
    	constraint fk_wish_product_product_no foreign key(product_no) references used_product(product_no) on delete cascade
);
create sequence seq_wish_product_no;


create table chat_member (
	chatroom_id varchar2(50) not null,
	seller_id varchar2(15) not null,
	buyer_id varchar2(15) not null,
	last_check number default 0,
	created_at date default sysdate,
	deleted_at date,
	product_no number not null,
    
    	constraint pk_chat_member primary key(chatroom_id),
   	constraint fk_chat_member_seller_id foreign key(seller_id) references member(member_id),
    	constraint fk_chat_member_buyer_id foreign key(buyer_id) references member(member_id),
    	constraint fk_chat_member_product_no foreign key(product_no) references used_product(product_no)
);

create table chat_log (
	no number not null,
	chatroom_id varchar2(50) not null,
	seller_id varchar2(15) not null,
	buyer_id varchar2(15) not null,
	msg varchar2(4000),
	time number,
    
    constraint pk_chat_log_no primary key(no),
    constraint fk_chat_log_chatroom_id foreign key(chatroom_id) references chat_member(chatroom_id),
    constraint fk_chat_log_seller_id foreign key(seller_id) references member(member_id),
    constraint fk_chat_log_buyer_id foreign key(buyer_id) references member(member_id)
);
create sequence seq_chat_log_no;

create table trade_review (
  review_no number,
	product_no number not null,
	star_score number not null,
	content varchar2(1000) not null,
	created_at date default sysdate,
	updated_at date,
  constraint pk_trade_review_no primary key(review_no),
  constraint fk_trade_review_product_no foreign key(product_no) references used_product(product_no) on delete cascade
);
create sequence seq_trade_review_no;

create table review_report (
  report_no number,
	review_no number not null,
	category varchar2(100) not null,
	content varchar2(100) not null,
	created_at date default sysdate,
	state_yn char(1) default 'N',
  constraint pk_review_report primary key(report_no),
  constraint fk_review_report_review_no foreign key(review_no) references trade_review(review_no) on delete cascade,
  constraint ck_review_report_state_yn check(state_yn in ('Y', 'N'))
);
create sequence seq_review_report_no;

--캠핑장
create table campsite (
	content_id number not null,
	faclt_nm varchar2(100),
	line_intro varchar2(200),
	intro CLOB,
	faclt_div_nm varchar2(110),
	induty varchar2(200),
	lct_cl varchar2(100),
	addr1 varchar2(400),
	addr2 varchar2(400),
	map_x varchar2(20),
	map_y varchar2(20),
	tel varchar2(300),
	homepage varchar2(4000),
	resve_cl varchar2(110),
	oper_pd_cl varchar2(50),
	oper_de_cl varchar2(30),
	posbl_fclty_cl varchar2(300),
	thema_envrn_cl varchar2(295),
	first_image_url varchar2(300),
    
  constraint pk_campsite primary key(content_id)
);


--캠핑장시설
create table campsite_facility (
	content_id number not null,
	gnrl_site_co number,
	auto_site_co number,
	glamp_site_co number,
	carav_site_co number,
	indvdl_carav_site_co number,
	site_mg1_width number,
	site_mg2_width number,
	site_mg3_width number,
	site_mg1_vrticl number,
	site_mg2_vrticl number,
	site_mg3_vrticl number,
	site_mg1_co number,
	site_mg2_co number,
	site_mg3_co number,
	site_bottom_cl1 number,
	site_bottom_cl2 number,
	site_bottom_cl3 number,
	site_bottom_cl4 number,
	site_bottom_cl5 number,
	glamp_inner_fclty varchar2(210),
	carav_inner_fclty varchar2(210),
	trler_acmpny_at char(1) default 'N',
	carav_acmpny_at char(1) default 'N',
	toilet_co number,
	swrm_co number,
	wtrpl_co number,
	brazier_cl varchar2(50),
	sbrs_cl varchar2(250),
	sbrs_etc varchar2(250),
	extshr_co number,
	frprvt_wrpp_co number,
	frprvt_sand_co number,
	eqpmn_lend_cl varchar2(100),
	animal_cmg_cl varchar2(100),
    
  constraint pk_campsite_facility primary key(content_id),
  constraint fk_campsite_facility_content_id foreign key(content_id) references campsite(content_id) on delete cascade,
  constraint ck_campsite_facility_trler_acmpny_at check(trler_acmpny_at in ('Y', 'N')),
  constraint ck_campsite_facility_carav_acmpny_at check(carav_acmpny_at in ('Y', 'N'))
);


--캠핑장이미지
create table campsite_image (
	serialnum number not null,
	content_id number not null,
	image_url varchar2(200),
    
  constraint pk_campsite_image primary key(serialnum),
  constraint fk_campsite_image_content_id foreign key(content_id) references campsite(content_id) on delete cascade --캠핑장 삭제 시 캠핑장이미지도 삭제
);


--캠핑장후기
create table campsite_review (
	review_no number not null,
	member_id varchar2(15),
	content_id number,
	faclt_nm varchar2(100) not null,
	review_grade number not null,
	stay varchar2(100) not null,
	merit varchar2(300),
	title varchar2(1000) not null,
	content varchar2(4000) not null,
	created_at date default sysdate not null,
	updated_at date,
	read_count number default 0 not null,
    
	constraint pk_campsite_review primary key(review_no),
	constraint fk_campsite_review_member_id foreign key(member_id) references member(member_id) on delete set null, --회원탈퇴 시 작성자 nll로 변경
	constraint fk_campsite_review_content_id foreign key(content_id) references campsite(content_id) on delete set null --캠핑장삭제 시 contentId null로 변경
);
create sequence seq_campsite_review_no;


--캠핑장후기사진
create table review_photo (
	review_photo_no number not null,
	review_no number not null,
	original_filename varchar2(256) not null,
	renamed_filename varchar2(256) not null,
	created_at date default sysdate not null,
    
	constraint pk_review_photo primary key(review_photo_no),
	constraint fk_review_photo_review_no foreign key(review_no) references campsite_review(review_no) on delete cascade --원본글 삭제 시 사진도 삭제
);
create sequence seq_review_photo_no;


--캠핑장후기추천
create table review_recommend (
	recommend_no number not null,
	review_no number not null,
	member_id varchar2(15) not null,
	status char(1) default 'Y' not null,
    
	constraint pk_review_recommend primary key(recommend_no),
	constraint fk_review_recommend_review_no foreign key(review_no) references campsite_review(review_no) on delete cascade, --원본글 삭제 시 추천도 삭제
	constraint fk_review_recommend_member_id foreign key(member_id) references member(member_id) on delete cascade, --회원탈퇴 시 추천도 삭제
	constraint ck_review_recommend_status check(status in ('Y', 'N'))
);
create sequence seq_review_recommend_no; --sequence 추가


--캠핑장후기댓글
create table review_comment (
	review_comment_no number not null,
	review_no number not null,
	member_id varchar2(15),
	comment_content varchar2(2000) not null,
	comment_level number default 1 not null,
	comment_ref number,
	created_at date default sysdate not null,
	updated_at date,
    
	constraint pk_review_comment primary key(review_comment_no),
	constraint fk_review_comment_review_no foreign key(review_no) references campsite_review(review_no) on delete cascade, --원본글 삭제 시 댓글도 삭제
	constraint fk_review_comment_member_id foreign key(member_id) references member(member_id) on delete set null, --회원탈퇴 시 작성자 null로 변경
	constraint ck_review_comment_comment_level check(comment_level in (1, 2)),
	constraint fk_review_comment_ref foreign key(comment_ref) references review_comment(review_comment_no) on delete set null --원본댓글 삭제 시 답댓글 ref null로 변경
);
create sequence seq_review_comment_no; --sequence 추가


create table campsite_bookmark (
	camp_bm_no number not null,
	member_id varchar2(15) not null,
	content_id number not null,
    
    constraint pk_campsite_bookmark primary key(camp_bm_no),
    constraint fk_campsite_bookmark_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint fk_campsite_bookmark_content_id foreign key(content_id) references campsite(content_id) on delete cascade
);
create sequence seq_campsite_bookmark_no;

select * from campsite_review;
select * from review_photo;

create table todo (
    todo_no number,
    todo varchar2(4000),
    created_at date default sysdate, 
    completed_at date,
    constraint pk_todo_no primary key(todo_no)
);

create sequence seq_todo_no;
