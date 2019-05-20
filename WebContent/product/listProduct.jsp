<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>

��ǰ ��� ��ȸ

</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
	
	function fncOrderBy(input) {
		document.getElementById("orderBy").value = input;
		fncGetUserList(1);
	}
	
	function fncListSale(input) {
		document.getElementById("listSale").value = input;
		fncGetUserList(1);
	}
	
	function h3Killer(){
		$("h3").remove();
	}

	/*
	function resetCart(input){
		alert(input);
		alert($(".cart"+input).html().trim());
		var cartTag = "<span class = 'cart"+input+"'>��ٱ���</span>";
		$(".cart"+input).text("�ٱ��ϰ��ٲ�");
	}
*/
	
		
$(function() {

	
		$(".hiddenInfo").hide();
 		$(".hiddenImage").hide();
		$(".hiddenStock").hide();
				
		$( ".ct_list_pop td:nth-child(5)" ).on("mouseenter" , function() {
		var count = $( ".ct_list_pop td:nth-child(5)" ).index(this);
		var prodNo = $($( ".ct_list_pop td:nth-child(3)" )[$( ".ct_list_pop td:nth-child(5)" ).index(this)]).text();
		$( "#"+prodNo+"" ).show();
		$("#hidden"+count+"").show();
			}
		); 
	
		$( ".ct_list_pop td:nth-child(5)" ).on("mouseleave" , function() {
			var prodNo = $($( ".ct_list_pop td:nth-child(3)" )[$( ".ct_list_pop td:nth-child(5)" ).index(this)]).text();
			$( "#"+prodNo+"" ).hide();
			var count = $( ".ct_list_pop td:nth-child(5)" ).index(this);
			$("#hidden"+count+"").hide();
				}	
			);
	
		//�Ǹ��� �� �������� ���°���� �˾� �ߴ� ���
		$("span[class^='cart'").on("click" , function() {
			var count = $("span[class^='cart'").index(this);
			//alert(count);
			var status = $($( ".ct_list_pop td:nth-child(13):contains('�Ǹ���')")[count]).text();
			
			//alert (status);
			
			var target = $($( ".ct_list_pop td:nth-child(13):contains('�Ǹ���')")[count]);
			alert(target.html());
			if (status.indexOf('īƮ��')==-1){
				var stockTag = "<input type='text' name='stockCart' value='' class='stockCart' style='width:100px; height:19px'  maxLength='10' ><span id = 'cartIn"+count+"'>īƮ�� �ֱ�</span>";
				
				//$(this).append(stockTag);
				target.append(stockTag)
				
			}
			else{

				//$(this).html("<span class = 'cart${a-1}'>��ٱ���</span>");
				target.html("�Ǹ��� <span class = 'cart"+count+"'>��ٱ���</span>");
				//$($( ".ct_list_pop td:nth-child(13)" )[count]).unbind("click");
			}
				
			/*
			$( ".ct_list_pop td:nth-child(13)" ).bind("click" , function() {
				$($(".cart"+count)).html();
			});
			*/
			
		}
		);
				
		$( ".ct_list_pop td:nth-child(13)" ).on("mouseenter" , function() {		
			var count = $( ".ct_list_pop td:nth-child(13)" ).index(this);		
			$("#hidden"+count+"").show();
			$("#hiddenStock"+count+"").show();
		});
		
		
		$( ".ct_list_pop td:nth-child(13)" ).on("mouseleave" , function() {
			var count = $( ".ct_list_pop td:nth-child(13)" ).index(this);		
			$("#hidden"+count+"").hide();
			$("#hiddenStock"+count+"").hide();
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
								<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
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
							<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
							<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
							<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>����</option>
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
									href="javascript:fncGetUserList('1');">�˻�</a></td>
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
					<td colspan="15">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>

					<input type="hidden" id="menu" 	name="menu" value="${menu}" />
					<input type="hidden" id="orderBy" 	name="orderBy" value="${ !empty search.orderBy ? search.orderBy : ""}"/>
					<input type="hidden" id="listSale" 	name="listSale" value="${ !empty search.listSale ? search.listSale : 0}"/>
					<input type="button" value="�Ѱͺ���" onclick="javascript:fncOrderBy(1); ">
					<input type="button" value="��Ѱͺ���" onclick="javascript:fncOrderBy(2); ">
					&nbsp;&nbsp;
					<input type="button" value="�ȸ��� ����" onclick="javascript:fncListSale(1); ">
					<input type="button" value="�ȸ��� ����" onclick="javascript:fncListSale(2); ">
			</tr>										

				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">��ǰNo</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">������</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�������</td>
				</tr>
				<tr>
					<td colspan="15" bgcolor="808285" height="1"></td>
				</tr>
	<c:set var ="a" value="0"/>
	<c:forEach var="i" items="${list}">
	<c:set var="a" value="${a+1}"/>
					<tr class="ct_list_pop">
						<td align="center" class='countNo'>${a}</td>
						
						<td></td>
						
						<td align="center" class='prodNo'>${i.prodNo}</td>
						
						<td></td>
					
						<td align="left" class='prodName'>
						<a href="/product/getProduct?prodNo=${i.prodNo}&menu=${menu}">
						${i.prodName}</a>
						</td>
						
						<td></td>
						
						<td align="left">${i.price}</td>
						<td></td>
						
						<td align="left">${i.prodDetail}</td>
						
						<td></td>
						
						<td align="left">${i.regDate}</td>
						
						<td></td>
						
						<td align="left" class="multiplay">
							<c:if test="${i.stock>0}">
							�Ǹ��� <span class = 'cart${a-1}'>��ٱ���</span>
							</c:if>
							<c:if test="${i.stock==0}">
							ǰ��
							</c:if>
						</td>
					</tr>
					<tr>
						<td class = "hiddenInfo" id="hidden${a-1}" colspan="15" bgcolor="D6D7D6" height="1">
						<img src="/images/uploadFiles/${i.fileName}" 
						class = "hiddenImage"
						id = "${i.prodNo}"
						style=" width: auto; height:100px;"/>
						<h4 class = "hiddenStock" id="hiddenStock${a-1}" >��� : ${i.stock}</h4>						
						</td>
					</tr>
				</c:forEach>
			</table>

			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
				
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /><jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>
</div>

</body>
</html>