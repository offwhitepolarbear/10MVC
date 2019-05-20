<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>�Ǹ� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

	
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listSalePurchase").submit();
	}
	
	$(function() { 
		
		$( ".shipping" ).on("click" , function() {
			//alert($(this).parent(this).html());
			//alert("����ϱ�"+$( ".spanCount" ).index($(this).parent(this)));
			var count = $( ".spanCount" ).index($(this).parent(this));
			//0~7 �����ϴ�~~~
			alert($($(".tranNo")[count]).text());//�ش� ĭ �ŷ���ȣ�Դϴ�
			
			//alert($($(".stock")[count]).text());
			
			var tranNoJSON = $($(".tranNo")[count]).text().trim() ;
			var toJSON = { tranNo : tranNoJSON ,
									tranCode : 2
									};
			//alert(toJSON);
			var JSONed = JSON.stringify(toJSON);
			alert(JSONed);
						
			$.ajax( 
								{
									url : "/purchase/json/updateTranCode",
									method : "POST" ,
									dataType : "json" ,
									data: JSONed,
									
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(serverData , status) {
										alert(serverData);
										$($( ".spanCount" )[count]).html("<span class = 'spanCount'>�����</span>");
									},
									error : function(request, status, error) {
										alert("ó���������� �����߻���");
										alert(status);
										
										alert(error);
									}
									
								}
							);
			
			
			
			
		}
		);
		
		$( ".orderCancel" ).on("click" , function() {
			//alert("����ϱ�"+$( ".spanCount" ).index($(this).parent(this)));
			//var count = $( ".spanCount" ).index($(this).parent(this));
			//alert($($(".stock")[count]).text());//�ش�ĭ ��Ź
			var count = $( ".spanCount" ).index($(this).parent(this));
			//0~7 �����ϴ�~~~
			alert($($(".prodNo")[count]).text());
			alert($($(".tranNo")[count]).text());//�ش� ĭ �ŷ���ȣ�Դϴ�
			//alert($($(".stock")[count]).text());
			
			var tranNoJSON = $($(".tranNo")[count]).text().trim() ;
			var stockJSON = $($(".stock")[count]).text() ;
			var prodNoJSON = $($(".prodNo")[count]).text().trim() ;
			var toJSON = { 
					tranNo : tranNoJSON ,
					stock : stockJSON ,
					purchaseProd : { prodNo: prodNoJSON },
					tranCode : 4
			};
			alert(toJSON);
			var JSONed = JSON.stringify(toJSON);
			alert(JSONed);
					
			$.ajax( 
								{
									url : "/purchase/json/orderCancel",
									method : "POST" ,
									dataType : "json" ,
									data: JSONed,
									
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(serverData , status) {
										alert(serverData);
										$($( ".spanCount" )[count]).html("<span class = 'spanCount'>�ֹ���ҵ�</span>");
									},
									error : function(request, status, error) {
										alert("ó���������� �����߻���");
										alert(status);
										
										alert(error);
									}
									
								}
							);
		
			
			
			
			
			
		}
		);
		
		
	}
	);


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/purchase/listSalePurchase" method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">�ŷ��� �����ȸ</td>
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
					<td colspan="17">��ü ${resultPage.totalCount} �Ǽ�, ����
						${resultPage.currentPage} ������</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="7%">�ŷ���ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="15%">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="10%">��ǰ��ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="10%">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="5%">���Ű���</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="7%">ȸ��ID</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="15%">����ּ�</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="10%">��ۿ�û����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b"width="20%">��ǰ��Ȳ</td>
					<td class="ct_line02"></td>
				</tr>
				<tr>
					<td colspan="17" bgcolor="808285" height="1"></td>
				</tr>
			<c:set var ="a" value="0"/>
			<c:forEach var="i" items="${list}">
			<c:set var="a" value="${a+1}"/>
				<tr class="ct_list_pop">
					<td align="center" class = "tranNo"><a href="/purchase/getPurchase?tranNo=${i.tranNo}">${i.tranNo}</a>
					</td>
					<td></td>
					<td align="left">${i.purchaseProd.prodName}</td>
					<td></td>
					<td align="left" class="prodNo">${i.purchaseProd.prodNo}</td>
					<td></td>
					<td align="left">${i.purchaseProd.price}</td>
					<td></td>
					<td align="left" class = "stock">${i.purchaseProd.stock}</td>
					<td></td>
					<td align="left"><a href="/user/getUser?userId=${i.buyer.userId}">${i.buyer.userId}</a>
					</td>
					<td></td>
					<td align="left">
					${i.divyAddr}</td>
					<td></td>
					<td align="left">
					${i.divyRequest}</td>
					<td></td>
					
					<td align="left">
					<c:if test="${i.tranCode=='1  ' }">
						<span class = "spanCount">
						<span class = "currentStatus" id="currentStatus${a-1}">���ſϷ�</span> 
						<span class = "shipping" id="shipping${a-1}">����ϱ�</span>
						<span class = "orderCancel" id="orderCancel${a-1}">�ŷ����</span>
						</span>
					</c:if>
					 <c:if test="${i.tranCode=='2  ' }">
						 <span class = "spanCount">
						�����
						</span>
					</c:if> 
					<c:if test="${i.tranCode=='3  ' }">
						<span class = "spanCount">
						��ۿϷ�
						</span>
					</c:if>
					<c:if test="${i.tranCode=='4  ' }">
						<span class = "spanCount">
						�ֹ���ҵ�
						</span>
					</c:if>
					</td>	
					
					</tr>
					<tr>
						<td colspan="17" bgcolor="D6D7D6" height="1"></td>
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