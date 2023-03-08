<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>결제 페이지</title>
</head>
<style>
	body {
		/* background-image: url("/purchaseAPI/resources/images/bg_img.PNG"); */
		background-color: white;
	}

	/* 가장 큰 컨테이너 */
	.container {
		width: 800px;	
	}
	
	/* 흰색 컨테이너 */
   .container-sm  {
   	   width: 800px;
       padding: 1.5rem;
       padding-left: 1rem;
       padding-bottom: 0.5rem;
       background-color: white;
       border-top: 2px solid black;
       border-bottom: 2px solid black;
    }

	/* 컨테이너 밖 회색 공간 */
    .blank {
        background-color: white;
        height: 1rem;
    }

    /* 상품 이름 */
    /* #merchant_name {
        margin-bottom: 0;
    } */

	/* 상품 옵션 텍스트 */
	/* #merchant_options {
		font-size: small;
		margin-bottom: 0;
	} */
    
	/* 가격 (~원) */
	.form-control-plaintext {
		text-align: right;
	}
	
	/* 상품 이미지 컨테이너 */
	.img-container {
		margin-right: 1rem;
	}
	
	/* 기존 배송지 신규 배송지 */
	#shipping_address > .btn-group {
		margin-bottom: 1.5rem;
	}
	
	/* 배송지 주소 */
	#receiver_address { margin-bottom: 0.5rem;}
	
	
	/* 결제 방식 버튼 */
    #card + label, #kakao + label, #deposit + label {
    	width: 45%;
    	margin: 0.7rem;
    }
	
	/* 배너 */
	h2 {
		padding-left: 0.5rem;
	}
	
	/* 각 컨테이너의 제목 */
    h5 {
    	font-weight: bolder;
    }
	
	/* 상품 정보 테이블 */
	table, tbody {
		height: 300px;
	}
	
	/* 상품 정보들 */
	p {
		margin-bottom: 0.5rem;
	}
	
    /* 상품 이미지 */
    img {
     	width: 100px;
 		height: 100px;
        object-fit: fill;
    }

	/* 결제 버튼 컨테이너 */
    footer {
        position: fixed;
        bottom: 0;
        z-index: 2;
        margin-bottom: 1rem;
    }
    
	/* 결제 버튼 */
    footer > button, #purchase_submit {
    	height: 3.5rem;
    	position: relative;
    	right: 0.7rem;
    }
    
</style>
</head>

<body>

	<div class="container">
		<form action="<%=request.getContextPath()%>/order/result" id="order_form" method="POST">
			<div id="header" class="container-sm w-auto">
		    	<h2>ONORE</h2>
		    	<div class="blank bg-white"></div>
			</div>
			<div class="blank"></div>
			
			<div id="order_infos" class="container-sm w-auto">
		    <h5>주문 상품 (<span id="order_name">${order_name}</span>)</h5>
		    <input type="hidden" value="${order_name}" name="order_name"/>

			<table>
				<c:forEach begin="0" end="${product_type_qty-1}" var="i">
				<tr>
					<td rowspan="3">
						<div class="img-container">
							<img src="<c:url value="/resources/images/DODY.PNG"/>">
						</div>
					</td>
					<td>
						<p id="product_name" class="fs-2 fw-semibold">${product_name.get(i)}</p>
						<input type="hidden" name="product_name" value="${product_name.get(i)}"/>
					</td>
				</tr>
				<tr>
					<td>
						<p id="order_info_size" class="fs-6 text-black-50">size: ${order_info_size.get(i)} / option: ${order_info_option.get(i)}</p>
						<input type="hidden" name="order_info_size" value="${order_info_size.get(i)}"/>
						<input type="hidden" name="order_info_option" value="${order_info_option.get(i)}"/>
					</td>
				</tr>
				<tr>
					<td>
						<p class="fs-5 fw-semibold">${order_info_qty.get(i)}개 / ${order_info_price.get(i)}원</p>
						<input type="hidden" name="order_info_qty" value="${order_info_qty.get(i)}"/>
						<input type="hidden" name="order_info_price" value="${order_info_price.get(i)}"/>
					</td>
				</tr>
				</c:forEach>
			</table>
			<hr>
            <div class="mb-3 row">
				<label for="total_price" class="col-md-3 col-form-label fs-4">상품 합계</label>
				<div class="col-sm-9">
					<input type="text" readonly class="form-control-plaintext fs-4 fw-bold"
						value="${total_price}원">
				</div>
			</div>
		</div>

		<div class="blank"></div>

		<div id="buyer_info" class="container-sm w-auto">
			<h5>주문자</h5>
			<input type="hidden" id="orderer_id" name="orderer_id" value="${orderer.mem_id}"/>
			<div class="mb-3">
				<label for="orderer_name" class="col-sm-2 col-form-label">이름</label>
				<div class="col-sm">
					<input type="text" class="form-control form-control-lg"
						placeholder="이름" id="orderer_name" name="orderer_name" value="${orderer.mem_name}">
				</div>
				<div id="orderer_name_msg" class="text-danger"></div>
			</div>
			<div class="mb-3">
				<label for="orderer_phone" class="col-sm-2 col-form-label">연락처</label>
				<div class="col-sm">
					<input type="text" class="form-control form-control-lg"
						placeholder="연락처" id="orderer_phone" name="orderer_phone" value="${orderer.mem_phone}">
				</div>
				<div id="orderer_phone_msg" class="text-danger"></div>
			</div>
			<div class="mb-3">
				<label for="orderer_email" class="col-sm-2 col-form-label">이메일</label>
				<div class="col-sm">
					<input type="text" class="form-control form-control-lg"
						placeholder="이메일" id="orderer_email" name="orderer_email" value="${orderer.mem_email}">
				</div>
				<div id="orderer_email_msg" class="text-danger"></div>
			</div>
		</div>

		<div class="blank"></div>

		<div id="shipping_address" class="container-sm w-auto">
			<h5>배송지</h5>
			<input type="hidden" name="mem_id" value="${orderer.mem_id}" />
			<c:choose>
				<c:when test="${orderer.mem_address eq null}">
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="address_btn" id="btnradio1" value="default" onclick="setAddress(event)"
							autocomplete="off" disabled>
						<label class="btn btn-outline-dark" for="btnradio1">기존 배송지</label>
						<input type="radio" class="btn-check" name="address_btn" id="btnradio2" value="new" onclick="setAddress(event)"
							autocomplete="off" checked>
						<label class="btn btn-outline-dark" for="btnradio2">신규 배송지</label>
					</div>
					<div class="mb-3">
						<label for="receiver_name" class="col-sm-2 col-form-label">수령인</label>
						<input type="text" class="form-control form-control-lg"
							placeholder="수령인" id="receiver_name" name="receiver_name">
						<div id="receiver_name_msg" class="text-danger"></div>
					</div>
					<label for="receiver_postalcode" class="col-sm-2 col-form-label">우편번호</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control form-control-lg"
							placeholder="우편번호" id="receiver_zip_code" name="receiver_zip_code">
						<button class="btn btn-outline-dark" type="button"
							id="receiver_address_btn" onclick="getAddress()">검색</button>
						<div id="receiver_zip_code_msg" class="text-danger"></div>
					</div>
					<div class="mb-3">
						<label for="receiver_address" class="col-sm-2 col-form-label">주소</label>
						<input type="text" class="form-control form-control-lg"
							style="background-color: rgb(214, 214, 214);" placeholder="기본주소"
							id="receiver_address" name="receiver_address" readonly/>
						<div id="receiver_address_msg" class="text-danger"></div>
						<input type="text" class="form-control form-control-lg" placeholder="상세주소"
							id="receiver_detail_address" name="receiver_detail_address">
						<div id="receiver_detail_address_msg" class="text-danger"></div>
					</div>
					<div class="form-check">
						<input class="form-check-input" id="flexCheckDefault" type="checkbox" name="set_default_check" value="default" checked>
						<label class="form-check-label" for="flexCheckDefault"> 기본 배송지로 설정하기 </label>						
					</div>
				</c:when>
				<c:otherwise>
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="address_btn" id="btnradio1" value="default" onclick="setAddress(event)"
							autocomplete="off" checked>
						<label class="btn btn-outline-dark" for="btnradio1">기존 배송지</label>
						<input type="radio" class="btn-check" name="address_btn" id="btnradio2" value="new" onclick="setAddress(event)"
							autocomplete="off">
						<label class="btn btn-outline-dark" for="btnradio2">신규 배송지</label>
					</div>
					<div class="mb-3">
						<label for="receiver_name" class="col-sm-2 col-form-label">수령인</label>
						<input type="text" class="form-control form-control-lg"
							placeholder="수령인" id="receiver_name" name="receiver_name" value="${orderer.mem_name}">
						<div id="receiver_name_msg" class="text-danger"></div>
					</div>
					<label for="receiver_postalcode" class="col-sm-2 col-form-label">우편번호</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control form-control-lg"
							placeholder="우편번호" id="receiver_zip_code" name="receiver_zip_code" value="${orderer.mem_zip_code}">
						<button class="btn btn-outline-dark" type="button" id="receiver_address_btn">검색</button>
						<div id="receiver_zip_code_msg" class="text-danger"></div>
					</div>
					<div class="mb-3">
						<label for="receiver_address" class="col-sm-2 col-form-label">주소</label>
						<input type="text" class="form-control form-control-lg"
							style="background-color: rgb(214, 214, 214);" placeholder="기본주소"
							id="receiver_address" name="receiver_address" value="${orderer.mem_address}" readonly/>
						<div id="receiver_address_msg" class="text-danger"></div>
						<input type="text" class="form-control form-control-lg" placeholder="상세주소"
							id="receiver_detail_address" name="receiver_detail_address" value="${orderer.mem_detail_address}">
						<div id="receiver_detail_address_msg" class="text-danger"></div>
					</div>
					<div class="form-check">
						<input class="form-check-input" id="flexCheckDefault" type="checkbox" name="set_default_check" value="default">
						<label class="form-check-label" for="flexCheckDefault"> 기본 배송지로 설정하기 </label>						
					</div>
				</c:otherwise>
			</c:choose>
				<br>
				<div class="mb-3">
						<label for="receiver_phone" class="col-sm-2 col-form-label">연락처</label>
						<div class="col-md">
							<input type="text" class="form-control form-control-lg"
								placeholder="연락처" id="receiver_phone" name="receiver_phone" value="${orderer.mem_phone}">
						<div id="receiver_phone_msg" class="text-danger"></div>
						</div>
					</div>
				<div class="mb-3">
					<label for="receiver_req" class="col-sm-4 col-form-label">배송 시 요청사항</label>
					<div class="col-md">
						<input type="text" class="form-control form-control-lg"
							placeholder="요청사항" id="receiver_req" name="receiver_req">
					</div>
				</div>
			</div>

		<div class="blank"></div>

		<div id="payment_information" class="container-sm w-auto">
			<h5>결제 정보</h5>

			<div class="mb-3">
				<label for="discount_coupons" class="col-sm-2 col-form-label">할인 쿠폰</label>
				<c:choose>
					<c:when test="${coupons.size() > 0}">
						<select class="form-select form-select-lg" id="coupon" onchange="discount(this)">
							<option value="0" selected>선택하세요</option>
							<c:forEach items="${coupons}" var="coupon">
								<option value="${coupon.coupon_discount}">${coupon.coupon_name}</option>
							</c:forEach>
						</select>
					</c:when>
					<c:otherwise>
						<select class="form-select form-select-lg" id="coupon" disabled>
							<option value="0" selected>사용 가능한 쿠폰이 없습니다</option>
						</select>
					</c:otherwise>
				</c:choose>
				<input type="hidden" id="discount_coupon" name="discount_coupon"/>
			</div>
			<label for="discount_points" class="col-sm-6 col-form-label">
				적립금 (보유 적립금 <span id="mem_points">${orderer.mem_point}</span>원)
			</label>
			<div class="input-group mb-3">
				<input type="text" class="form-control form-control-lg"
					placeholder="적립금" id="discount_points" name="discount_points" value="0">
				<button class="btn btn-outline-dark" type="button" id="discount_points_btn">적용</button>
			</div>
			<div>사용 가능한 적립금 : <span id="accessible_points">${accessible_points}</span>원</div>
			<hr>
			<div class="mb-3 row">
				<label for="total_price" class="col-sm-3 col-form-label">상품 합계</label>
				<div class="col-md-9">
					<input type="text" readonly class="form-control-plaintext fw-bold"
						id="total_price" name="total_price" value="${total_price}">
				</div>
				<label for="total_discount" class="col-sm-3 col-form-label">총 할인 금액</label>
				<div class="col-md-9">
					<input type="text" readonly class="form-control-plaintext fw-bold"
						id="total_discount" name="total_discount" value="0">
				</div>
			</div>
			<hr>
			<div class="mb-3 row">
				<label for="pay_price" class="col-sm-3 col-form-label fs-4">결제 금액</label>
				<div class="col-md-9">
					<input type="text" class="form-control-plaintext fs-4 fw-bold"
					 	id="pay_price_lbl" name="pay_price" value="${total_price}" readonly/>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="paid_price" class="col-sm-4 col-form-label fs-5">결제된 금액</label>
				<div class="col-md-8">
					<input type="text" class="form-control-plaintext fs-4 fw-bold"
						id="paid_price" name="paid_price" readonly/>
				</div>
			</div>
		</div>
		
		<div class="blank"></div>
		
		<div id="payment_method" class="container-sm w-auto">
		<h5>결제 방법</h5>
			<div class="container-md text-center">
				<div class="row row-cols-2">
					<input type="radio" class="btn-check" name="pay_method" value="card" id="card" autocomplete="off" checked>
					<label class="btn btn-lg btn-outline-dark" for="card">신용/체크카드</label>
					<input type="radio" class="btn-check" name="pay_method" value="kakao" id="kakao" autocomplete="off">
					<label class="btn btn-lg btn-outline-dark" for="kakao">카카오페이</label>
	                <input type="radio" class="btn-check" name="pay_method" value="deposit" id="deposit" autocomplete="off">
					<label class="btn btn-lg btn-outline-dark" for="deposit">무통장 입금</label>
				</div>
			</div>
		</div>

        <div class="blank"></div>
        
        <br><br><br>
	        <footer id="purchased_btn_container" class="container">					
				<input type="hidden" id="payment_key" name="payment_key"/>
		      	<input type="hidden" id="order_id" name="order_id"/>
		    	<input type="hidden" id="amount" name="amount"/>		        			        		
		        <button type="button" id="purchase_btn" class="btn btn-lg btn-dark w-100 rounded-1"><span id="pay_price_btn">${total_price}</span>원 결제하기</button>
	        </footer>
        </form>
	</div>
	
	<script src="https://js.tosspayments.com/v1/payment"></script>
	<script id="order_script">
		let clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq';
	    let tossPayments = TossPayments(clientKey);
	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/order/js/tosspayments.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/order/js/purchase_btn.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/order/js/discount.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/order/js/address.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>