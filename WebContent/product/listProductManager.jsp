<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>운영자용 상품관리메뉴</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/product/listProductManager")
				.submit();
	}
	
	function fncOrderBy(input) {
		document.getElementById("orderBy").value = input;
		fncGetUserList(1);
	}

	function fncListSale(input) {
		document.getElementById("listSale").value = input;
		fncGetUserList(1);
	}
	
	function abc(prodNo){
		$("form").attr("method", "POST").attr("action", "/product/restockView/"+prodNo)
		.submit();
	}

	$(function() {

		$(".ct_list_pop td:nth-child(13)").on(
				"click",
				function() {
					var prodNo = $(
							$(".ct_list_pop td:nth-child(3)")[$(
									".ct_list_pop td:nth-child(13)")
									.index(this)]).text();

					$.ajax({
						url : "/product/json/getProduct/" + prodNo,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {

							//Debug...
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);

							var displayValue = "<h3 onClick='javascript:abc("+JSONData.prodNo+");'>" + "재고 : "
									+ JSONData.stock + " (클릭시 재고관리 메뉴로 연결됩니다.)<br/>" + "</h3>";
							//Debug...									
							//alert(displayValue);
							$("h3").remove();
							$("#" + prodNo + "").html(displayValue);
						}
					});

				});

	
	

		$("td.multiplay:contains('배송하기')").on(
				"click",
				function() {
					//Debug..
					//alert($("td.multiplay").index(this)+"???");
					//alert($(this).text());
					//alert($($(".prodNo")[$("td.multiplay").index(this)]).text());
					//alert("/purchase/updateTranCode.do?prodNo="+$($(".prodNo")[$("td.multiplay").index(this)]).text()+"&tranCode=2");
					var uri = "/purchase/updateTranCode/"
							+ $($(".prodNo")[$("td.multiplay").index(this)])
									.text() + "/2/manage";

					$("form").attr("method", "GET").attr("action", uri)
							.submit();
				});
	});
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">운영자용 상품관리</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>제품번호</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>제품명</option>
							<option value="2"
								${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>가격</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
						class="ct_input_g" style="width: 200px; height: 20px"
						onKeypress="javascript:if(event.keyCode==13) fncGetUserList(1);"></td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetUserList('1');">검색</a></td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="15">전체 ${resultPage.totalCount} 건수, 현재
						${resultPage.currentPage} 페이지</td>

					<input type="hidden" id="menu" name="menu" value="${menu}" />
					<input type="hidden" id="orderBy" name="orderBy"
						value="${ !empty search.orderBy ? search.orderBy : " "}"/>
					<input type="hidden" id="listSale" name="listSale"
						value="${ !empty search.listSale ? search.listSale : 0}" />
					<input type="button" value="싼것부터"
						onclick="javascript:fncOrderBy(1); ">
					<input type="button" value="비싼것부터"
						onclick="javascript:fncOrderBy(2); "> &nbsp;&nbsp;
					<input type="button" value="판매중"
						onclick="javascript:fncListSale(1); ">
					<input type="button" value="안판매중"
						onclick="javascript:fncListSale(2); ">
				</tr>

				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">제품No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상세정보</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재상태</td>
				</tr>
				<tr>
					<td colspan="15" bgcolor="808285" height="1"></td>
				</tr>
				<c:set var="a" value="0" />
				<c:forEach var="i" items="${list}">
					<c:set var="a" value="${a+1}" />
					<tr class="ct_list_pop">
						<td align="center" class='countNo'>${a}</td>

						<td></td>
						<td align="center" class='prodNo'>${i.prodNo}</td>

						<td></td>
						<c:if test="${user.role!='admin'}">
							<td align="left" class='prodName'><a
								href="/product/getProduct?prodNo=${i.prodNo}&menu=${menu}">
									${i.prodName}</a>
						</c:if>
						<c:if test="${user.role=='admin' && i.stock == 0 }">
							<td align="left"><a
								href="/product/getProduct?prodNo=${i.prodNo}&menu=${menu}">
									${i.prodName}</a>
						</c:if>
						<c:if test="${user.role=='admin' && i.stock != 0}">
							<td align="left"><a
								href="/product/updateProduct?prodNo=${i.prodNo}&menu=${menu}">
									${i.prodName}</a>
						</c:if>

						</td>
						<td></td>
						<td align="left">${i.price}</td>
						<td></td>
						<td align="left">${i.prodDetail}</td>
						<td></td>
						<td align="left">${i.regDate}</td>
						<td></td>
						<td align="left" class="multiplay"><c:if test="${i.stock>0}">
						판매중
						</c:if> <c:if test="${i.stock==0}">
						품절
						</c:if></td>
					</tr>
					<tr>
						<td id="${i.prodNo}" colspan="15" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>

					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /><jsp:include
							page="../common/pageNavigator.jsp" /></td>
				</tr>
			</table>
			<!-- PageNavigation End... -->

		</form>
	</div>

</body>
</html>