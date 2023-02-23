package com.onore.project.order.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrderInfoDTO {

	private String order_info_id;
	private String order_id;
	private String product_id;
	private String product_name;
	private Integer order_info_qty;
	private Integer order_info_size;
	private String order_info_option;
	private Integer order_info_price;
	private String ob_date;
}
