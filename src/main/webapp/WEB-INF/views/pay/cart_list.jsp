<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ONECOOK: Cart</title>

  <%@ include file="../common/head_link.jsp"%>
  <style>
.ym-input-number::-webkit-inner-spin-button, .ym-input-number::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

.ym-input-number {
	text-align: center;
	border: none;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	margin: -2px;
	width: 25px;
	height: 25px;
}

.ym-button {
	border: none;
	width: 25px;
	height: 25px;
	margin: 0px;
}

.ym-button:hover {
	background: rgb(235, 235, 235);
}

.yellow_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
	font-size: 13px;
}

.yellow_btn:hover, .yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
</head>

<body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
  <main>
    <div class="page-loader">
      <div class="loader">Loading...</div>
    </div>
    <%@ include file="../common/header.jsp"%>
    <div class="main">
      <section class="module">
        <div class="container">
          <div class="row">
            <div class="col-sm-6 col-sm-offset-3">
              <h1 class="module-title font-alt">CART</h1>
            </div>
          </div>
          <hr class="divider-w pt-20">
          <div class="row">
            <div class="col-sm-12">
              <table class="table table-striped table-border checkout-table">
                <tbody>
                  <tr>
                    <th class="col-sm-1" style="text-align:center;"><input type="checkbox" name="check_all"
                        onclick="checkBoxAll()"></th>
                    <th class="col-sm-1 hidden-xs">Image</th>
                    <th class="col-sm-3">Name</th>
                    <th class="col-sm-2 hidden-xs">Price</th>
                    <th class="col-sm-2">Count</th>
                    <th class="col-sm-2">Total</th>
                    <th class="col-sm-1">Remove</th>
                  </tr>

                  <form method="post" action="getPayment.do" id="payment_form" onsubmit="return false">
                    <c:forEach var="dto" items="${list}">
                      <input class="hid_idx" type="hidden" value="${dto.cart_idx}" />
                      <tr id="tr_${dto.cart_idx}" class="tr">
                        <td style="text-align:center;">
                          <input type="checkbox" name="check_num" id="cn_${dto.cart_idx}" class="checkClass"
                            value="${dto.cart_idx}" onclick="checkBox()">
                          <input type="hidden" class="hidcheckClass" id="cn_hid_${dto.cart_idx}">
                        </td>
                        <td class="hidden-xs" style="text-align:center;"><a href="#"><img
                              src="../resources/images/food/${dto.f_type}/${dto.f_img}" alt="list" /></a>
                          <input type="hidden" id="ftype_${dto.cart_idx}" value="${dto.f_type}">
                          <input type="hidden" id="fimg_${dto.cart_idx}" value="${dto.f_img}">
                          <input type="hidden" id="cidxarr_${dto.cart_idx}" value="${dto.cart_idx}"></td>
                        <td>
                          <h5 class="product-title font-alt" id="f_${dto.cart_idx}">${dto.f_name}</h5>
                        </td>
                        <td class="hidden-xs">
                          <h5 class="product-title font-alt"><span
                              id="price_${dto.cart_idx}">${dto.f_price}</span>&nbsp;&#8361;</h5>
                        </td>
                        <td>
                          <button class="ym-button" id="count_minus_${dto.cart_idx}"
                            onclick="count_minus(this.id)">-</button>
                          <input id="count_value_${dto.cart_idx}" class="ym-input-number" type="number"
                            value="${dto.cart_count}" min="1">
                          <button class="ym-button" id="count_plus_${dto.cart_idx}"
                            onclick="count_plus(this.id)">+</button>
                        </td>
                        <td>
                          <h5 class="product-title font-alt"><span id="num_price_${dto.cart_idx}">0</span>&nbsp;&#8361;
                          </h5>
                        </td>
                        <td class="pr-remove"><a id="del_${dto.cart_idx}" onclick="del(this.id)" title="Remove"><i
                              class="fas fa-trash-alt"></i></a></td>
                      </tr>
                    </c:forEach>
                  </form>
                </tbody>
              </table>

            </div>
          </div>
          <c:if test="${empty list}">
            <br /><br />
            <div class="row">

              <div class="features-item">
                <div class="features-icon"><span class="icon-caution" aria-hidden="true"></span></div>
                <h3 class="features-title font-alt">이런!</h3>아직 장바구니에 담긴 상품이 없네요.<br />원쿡 마켓에서 설레는 쇼핑을 시작해볼까요?
              </div>


            </div>
            <br /><br />
          </c:if>
          <div class="row">
            <div class="col-sm-2">
              <div class="form-group">
                <c:if test="${!empty list}">
                  <button class="btn btn-g btn-round" onclick="selectDel()" style="width:100%;"><i
                      class="fas fa-trash-alt"></i>&nbsp;&nbsp;선택삭제</button>
                </c:if>
                <c:if test="${empty list}">
                  <button class="btn btn-g btn-round" onclick="nullDel()" style="width:100%;"><i
                      class="fas fa-trash-alt"></i>&nbsp;&nbsp;선택삭제</button>

                </c:if>
              </div>
            </div>
            <div class="col-sm-2">
              <div class="form-group">
                <c:if test="${!empty list}">
                  <button class="btn btn-g btn-round" onclick="allDel()" style="width:100%;"><i
                      class="fas fa-trash-alt"></i>&nbsp;&nbsp;전체삭제</button>
                </c:if>
                <c:if test="${empty list}">
                  <button class="btn btn-g btn-round" onclick="nullDel()" style="width:100%;"><i
                      class="fas fa-trash-alt"></i>&nbsp;&nbsp;전체삭제</button>
                </c:if>
              </div>
            </div>
          </div>
          <hr class="divider-w pt-20">
          <div class="row mt-70">
            <div class="col-sm-5 col-sm-offset-7">
              <div class="shop-Cart-totalbox">
                <h4 class="font-alt">Cart Totals</h4>
                <h6 class="font-alt">총 <span id="checkbox_total" style="color:rgb(125,193,65);">0</span>개 중 <span
                    id="checkbox_checked" style="color:rgb(125,193,65);">0</span>개 구매 시</h6>
                <hr class="divider-w pt-20">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th>Cart Subtotal</th>
                      <td><span id="total_price">0</span>&nbsp;&#8361;</td>
                    </tr>
                    <tr>
                      <th>Delivery Fee</th>
                      <td><span id="fee_price">3000</span>&nbsp;&#8361;</td>
                    </tr>
                    <tr class="shop-Cart-totalprice">
                      <th>Total</th>
                      <td><span id="total_pay_price">0</span>&nbsp;&#8361;</td>
                    </tr>
                  </tbody>
                </table>
                <button class="yellow_btn btn btn-lg btn-block btn-round btn-d" id="order_click" type="button" style="color:black;">주문하기</button>
              </div>
            </div>
          </div>
        </div>
      </section>

      <%@ include file="../common/footer.jsp" %>
      <hr class="divider-d">

    </div>
    <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>
  </main>
  <%@ include file="../common/js_link.jsp" %>
  <script>
    $(document).ready(function () {
      //전체(n/n) 세팅해놓기 + 전부 체크한 상태로 세팅
      var total_check = $("input:checkbox[name=check_num]").length;
      $("#checkbox_total").text(total_check);
      $("#checkbox_checked").text(total_check);
      $("input:checkbox[name=check_all]").prop("checked", true);
      $("input:checkbox[name=check_num]").prop("checked", true);

      //수량*상품금액 & 상품금액 & 결제 예정금액 defalut
      var hid_idx = new Array();
      var total = 0;
      for (var i = 0; i < $(".hid_idx").length; i++) {
        hid_idx[i] = $(".hid_idx")[i].value;
        var price = $('#price_' + hid_idx[i]).text();
        var num = $('#count_value_' + hid_idx[i]).val();
        var numPrice = price * num;
        $('#num_price_' + hid_idx[i]).text(numPrice);
        $('#cn_hid_' + hid_idx[i]).attr('value', numPrice);
        total += parseInt($('#num_price_' + hid_idx[i]).text(), 10);
        console.log(total);
      }
      $('#total_price').text(total);
      var fee = parseInt($('#fee_price').text(), 10);
      var totalPay = total + fee;
      $('#total_pay_price').text(totalPay);

      //개별 상품 select box 갯수세기
      $("input:checkbox[name=check_num]").on("click", function () {
        var total_check_checked = $("input:checkbox[name=check_num]:checked").length;
        if ($(this).prop("checked")) {
          $("#checkbox_checked").text(total_check_checked);
        } else {
          $("#checkbox_checked").text(total_check_checked);
        }
      });
      //잔체 상품 select box 갯수세기
      $("input:checkbox[name=check_all]").on("click", function () {
        if ($(this).is(":checked") == true) {
          $("input:checkbox[name=check_num]").prop("checked", true);
          var total_check_checked = $("input:checkbox[name=check_num]:checked").length;
          $("#checkbox_checked").text(total_check_checked);
        } else if ($(this).is(":checked") == false) {
          $("input:checkbox[name=check_num]").prop("checked", false);
          var total_check_checked = $("input:checkbox[name=check_num]:checked").length;
          $("#checkbox_checked").text(total_check_checked);
        }
      });
      //form태그 전송	
      $("#order_click").click(function () {
        var cidxarr = [];	//cart_idx
        var farr = [];	//food arr
        var cararr = [];	//cart_count arr
        var fparr = []; 	//f_price arr
        var numparr = [];	//f_numprice(all price) arr
        var f_type = [];	//f_type arr
        var fiarr = [];		//f_img  arr

        var count = 0;
        $(".checkClass:checked").each(function (i) {
          var id = $(this).parents('tr').attr('id');
          idArr = id.split('_');

          console.log($(this).parents('tr').find("#cidxarr_" + idArr[1]).val());
          cidxarr[count] = $(this).parents('tr').find("#cidxarr_" + idArr[1]).val();

          console.log($(this).parents('tr').find("#f_" + idArr[1]).text());
          farr[count] = $(this).parents('tr').find("#f_" + idArr[1]).text();

          console.log($(this).parents('tr').find("#count_value_" + idArr[1]).val());
          cararr[count] = $(this).parents('tr').find("#count_value_" + idArr[1]).val();

          console.log($(this).parents('tr').find("#price_" + idArr[1]).text());
          fparr[count] = $(this).parents('tr').find("#price_" + idArr[1]).text();

          console.log($(this).parents('tr').find("#num_price_" + idArr[1]).text());
          numparr[count] = $(this).parents('tr').find("#num_price_" + idArr[1]).text();

          console.log($(this).parents('tr').find("#ftype_" + idArr[1]).val());
          f_type[count] = $(this).parents('tr').find("#ftype_" + idArr[1]).val();

          console.log($(this).parents('tr').find("#fimg_" + idArr[1]).val());
          fiarr[count] = $(this).parents('tr').find("#fimg_" + idArr[1]).val();

          $("#payment_form").append($('<input/>', { type: 'hidden', name: 'cidxarr', value: cidxarr[count] }));
          $("#payment_form").append($('<input/>', { type: 'hidden', name: 'farr', value: farr[count] }));
          $("#payment_form").append($('<input/>', { type: 'hidden', name: 'cararr', value: cararr[count] }));
          $("#payment_form").append($('<input/>', { type: 'hidden', name: 'fparr', value: fparr[count] }));
          $("#payment_form").append($('<input/>', { type: 'hidden', name: 'numparr', value: numparr[count] }));
          $("#payment_form").append($('<input/>', { type: 'hidden', name: 'f_type', value: f_type[count] }));
          $("#payment_form").append($('<input/>', { type: 'hidden', name: 'fiarr', value: fiarr[count] }));

          count++;
        });
        console.log(farr);
        console.log(cararr);

        console.log($("#payment_form"));
        $("#payment_form")[0].submit();
      });
    });
    //삭제할 리스트 없을때
    function nullDel() {
      swal('삭제할 상품이 없네요.');
    }
    //숫자 (,)
    function numberFormat(inputNumber) {
      return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    //수량 -- 
    var strArr = new Array();
    function count_minus(id) {
      strArr = id.split('_'); //strArr[2] == idx
      //수량
      var countStr = $('#count_value_' + strArr[2]).val();
      var countNum = parseInt(countStr, 10);
      countNum--;
      //상품 금액
      var priceStr = $('#price_' + strArr[2]).text();
      var price = parseInt(priceStr, 10);
      //배송비 
      var feeStr = $('#fee_price').text();
      var fee = parseInt(feeStr, 10);
      //수량*상품금액
      var numPrice = countNum * price;
      if (countNum <= 0) {
        swal("최소 구매수량은 1개 입니다.");
        countNum = 1;
        numPrice = countNum * price;
        return false;
      }
      if ($('#cn_' + strArr[2]).is(':checked') == true) {
        //상품금액 & 결제 예정금액 실시간 변동
        var total = parseInt($('#total_price').text());
        total -= price;
        $('#total_price').text(total);
        var totalPay = parseInt($('#total_pay_price').text());
        totalPay -= price;
        $('#total_pay_price').text(totalPay);
      }
      $('#num_price_' + strArr[2]).text(numPrice);
      $('#count_value_' + strArr[2]).attr('value', countNum);
      $('#cn_hid_' + strArr[2]).attr('value', numPrice);
    }
    //수량 ++
    function count_plus(id) {
      strArr = id.split('_'); //strArr[2] == idx
      //수량
      var countStr = $('#count_value_' + strArr[2]).val();
      var countNum = parseInt(countStr, 10);
      countNum++;
      //상품 금액
      var priceStr = $('#price_' + strArr[2]).text();
      var price = parseInt(priceStr, 10);
      //배송비 
      var feeStr = $('#fee_price').text();
      var fee = parseInt(feeStr, 10);
      //수량*상품금액
      var numPrice = countNum * price;

      // 		if(countNum>5){
      // 			alert('최대 구매수량은 5개 입니다.');
      // 			countNum = 5;
      // 			numPrice = countNum*price;
      // 			return false;	
      // 		}
      if ($('#cn_' + strArr[2]).is(':checked') == true) {
        //상품금액 & 결제 예정금액 실시간 변동
        var total = parseInt($('#total_price').text());
        total += price;
        $('#total_price').text(total);
        var totalPay = parseInt($('#total_pay_price').text());
        totalPay += price;
        $('#total_pay_price').text(totalPay);
      }
      $('#num_price_' + strArr[2]).text(numPrice);
      $('#count_value_' + strArr[2]).attr('value', countNum);
      $('#cn_hid_' + strArr[2]).attr('value', numPrice);
    }
    //개별삭제
    function del(id) {
      strArr = id.split('_');

      $.ajax({
        url: "del_each.json",
        type: "POST",
        data: { cart_idx: strArr[1] },
        success: function () {
          //체크박스가 선택이 되어있을 때에만 실시간 값 적용
          if ($("input:checkbox[id=cn_" + strArr[1] + "]").is(":checked") == true) {
            var countNum = parseInt($('#count_value_' + strArr[1]).val());
            var price = parseInt($('#price_' + strArr[1]).text());
            var numPrice = countNum * price;

            var fee = parseInt($('#fee_price').text());
            var total = parseInt($('#total_price').text());
            total -= numPrice;

            var totalPay = parseInt($('#total_pay_price').text());
            totalPay -= numPrice;

            $('#total_price').text(total);
            $('#total_pay_price').text(totalPay);
          }

          //행 제거 후 전체 숫자  (0/n) n값 출력 & 체크박스 갯수 재설정
          $('#tr_' + strArr[1]).remove();
          var len = $("input:checkbox[name=check_num]").length;
          var lenCheck = $("input:checkbox[name=check_num]:checked").length;
          $("#checkbox_total").text(len);
          $("#checkbox_checked").text(lenCheck);

          //체크박스 선택된 값이 모두 제거됐을 때 결제 예정금액 0으로 셋팅
          if ($("#total_price").text() == 0) {
            $("#total_pay_price").text(0);
          }
          swal('성공!', '선택된 상품이 삭제 되었습니다.', 'success');
        },
        error: function (err) {
          swal('Error 01', '처리 중 예외발생!', 'warning');
          console.log(err);
        }
      });
    }
    //선택삭제
    var cbox = new Array();
    function selectDel() {
      var j = 0;
      for (var i = 0; i < $(".checkClass").length; i++) {
        if ($(".checkClass")[i].checked == true) {
          cbox[j] = $(".checkClass")[i].value;
          j++;
        }
      }
      console.log(cbox);
      $.ajax({
        url: "del_select.do",
        type: "POST",
        data: { cart_idx: cbox },
        traditional: true,
        success: function () {
          for (var i = 0; i < cbox.length; i++) {
            // 상품금액 & 배송비 & 결제 예정금액 실시간 --
            var countNum = parseInt($('#count_value_' + cbox[i]).val());
            var price = parseInt($('#price_' + cbox[i]).text());
            var numPrice = countNum * price;

            var fee = parseInt($('#fee_price').text());
            var total = parseInt($('#total_price').text());
            total -= numPrice;

            var totalPay = parseInt($('#total_pay_price').text());
            totalPay -= numPrice;

            $('#total_price').text(total);
            $('#total_pay_price').text(totalPay);

            //전체 (0/n) 0값으로 초기화 + n값 새로 설정
            $('#tr_' + cbox[i]).remove();
            var len = $("input:checkbox[name=check_num]").length;
            $("#checkbox_total").text(len);
            $("#checkbox_checked").text(0);
            $('#total_pay_price').text(0);
          }
          swal('성공!', '선택된 상품들이 삭제 되었습니다.', 'success');
        },
        error: function (err) {
          swal('Error 02', '처리 중 예외발생!', 'warning');
          console.log(err);
        }
      });
    }
    //전부삭제
    function allDel() {
      $.ajax({
        url: "del_all.json",
        type: "POST",
        success: function () {
          $('#total_price').text(0);
          $('#fee_price').text(0);
          $('#total_pay_price').text(0);
          $(".tr").remove();

          $("input:checkbox[name=check_all]").prop("checked", false);
          var len = $("input:checkbox[name=check_num]").length;
          var selectlen = $("input:checkbox[name=check_num]:checked").length;
          $("#checkbox_checked").text(selectlen);
          $("#checkbox_total").text(len);
          swal('성공!', '장바구니의 모든 상품들이 삭제 되었습니다.', 'success');
        },
        error: function (err) {
          swal('Error 03', '처리 중 예외발생!', 'warning');
          console.log(err);
        }
      });
    }
    //개별 체크박스 선택 시 값변동
    function checkBox() {
      if ($("input:checkbox[name=check_all]").is(":checked") == true) {
        $("input:checkbox[name=check_all]").prop("checked", false);
      }
      var sum = 0;
      var count = $(".checkClass").length;
      var fee = parseInt($('#fee_price').text());

      for (var i = 0; i < count; i++) {
        if ($(".checkClass")[i].checked == true) {
          sum += parseInt($(".checkClass").siblings('.hidcheckClass')[i].value);
        }
      }
      console.log(sum);
      var totalSum = sum + fee;
      $('#total_price').text(sum);
      $('#total_pay_price').text(totalSum);
      if (sum == 0) {
        $('#total_pay_price').text(0);
      }
    }
    //전체 체크박스 선택 시 값변동
    function checkBoxAll() {
      if ($("input:checkbox[name=check_all]").is(":checked") == true) {
        var sum = 0;
        var count = $(".checkClass").length;
        var fee = parseInt($('#fee_price').text());

        for (var i = 0; i < count; i++) {
          sum += parseInt($(".checkClass").siblings('.hidcheckClass')[i].value);
        }
        var totalSum = sum + fee;
        $('#total_price').text(sum);
        $('#total_pay_price').text(totalSum);
      } else if ($("input:checkbox[name=check_all]").is(":checked") == false) {
        $('#total_price').text(0);
        $('#total_pay_price').text(0);
      }
    }
  </script>
</body>

</html>