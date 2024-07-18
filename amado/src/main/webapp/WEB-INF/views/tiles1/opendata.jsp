<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
$(document).ready(function(){
	
	let url_address = 'https://apis.data.go.kr/B551014/SRVC_API_SFMS_FACI/TODZ_API_SFMS_FACI?serviceKey=iHxLnainFcfZNq8rbqNwZXEKiRitAcctKPOav4hD5NLbpYpbDGcGAkDKZPTPlwpQ4ARzi7JC9E98k01eQmyDzg%3D%3D&pageNo=1&numOfRows=138432&resultType=json';
	
    $.ajax({
    	url: url_address,
    	dataType: "json",
    	success: function(json){

			const totalCount = json.response.body.totalCount;
			const dataArr = json.response.body.items.item;
			
			// 지역 addr_ctpv_nm
			// 지번주소  faci_addr
			// 도로명주소 faci_road_addr
			// 우편번호 faci_zip
			// 운영여부 faci_stat_nm
			// 업종 fcob_nm
			// 시설명 faci_nm
			
			dataArr.forEach(function(item, index, array){

				$.ajax({
					url: "<%=ctxPath%>/opendata/insertData.do",
					data: {"city": item.addr_ctpv_nm, 
						   "newAdd": item.faci_road_addr,
						   "oldAdd": item.faci_addr,
						   "postcode": item.faci_zip,
						   "status": item.faci_stat_nm,
						   "type": item.fcob_nm,
						   "name": item.faci_nm},
					dataType: "json",
					success: function(json){
						console.log(JSON.stringify(json));
					},
					error: function(request, status, error){
			            console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
			
			});
    		
    		
    	},
    	error: function(request, status, error){
            console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    	
    });
	
});
</script>