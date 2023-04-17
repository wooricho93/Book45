package com.book45.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderListDTO {

   private String orderNum;
   private String id;
   private String name;
   private String phone;
   private Date orderDate;
   private String zipCode;
   private String addressRoad;
   private String addressDetail;
   private String orderState;
   private int deliveryCost;
   private int usePoint;
   
   private int price;
   private String title;
   private String pictureUrl;
   private Long isbn;
   
   private int albumPrice;
   private String albumTitle;
   private String albumPictureUrl;
   private Long productNum;
   
   private int amount;
}