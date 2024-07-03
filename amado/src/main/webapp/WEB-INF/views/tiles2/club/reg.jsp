<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
   table#tblProdInput {
                       border-collapse: collapse; }
                       
    table#tblProdInput td {
                          padding-left: 10px;
                          height: 50px; }
                          
    .prodInputName { background-color: #ccf2ff;  
    				 text-align: center;
                    font-weight: bold; }                                                 
   
   .error {color: red; font-weight: bold; font-size: 9pt;}
   
   div.fileDrop{ display: inline-block; 
                  width: 100%; 
                  height: 100px;
                  overflow: auto;
                  background-color: #fff;
                  padding-left: 10px;}
                 
    div.fileDrop > div.fileList > span.delete{display:inline-block; width: 20px; border: solid 1px gray; text-align: center;} 
    div.fileDrop > div.fileList > span.delete:hover{background-color: #000; color: #fff; cursor: pointer;}
    div.fileDrop > div.fileList > span.fileName{padding-left: 10px;}
    div.fileDrop > div.fileList > span.fileSize{padding-right: 20px; float:right;} 
    span.clear{clear: both;} 
    


tr > td {
    border: solid 1px #cce6ff;
	background-color: white;
}

div#tableWrap {
  width: 50%;
  border: solid 1px #cce6ff;
  border-radius: 12px;
   overflow: hidden;
	  
}

table#tblProdInput {
margin: 0%;
border-style: hidden;
}

</style>
    
<div id="container" align="center" style="margin-bottom: 20px; margin-top: 10%;">

   <div style="width: 250px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px;">       
      <span style="font-size: 15pt; font-weight: bold;">제품등록&nbsp;[관리자전용]</span>   
   </div>
   <br>
   
   <%-- !!!!! ==== 중요 ==== !!!!! --%>
   <%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
        enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
   <form name="prodInputFrm" enctype="multipart/form-data"> 
      <div id="tableWrap">   
      <table id="tblProdInput" style="background-color: #ccf2ff; width: 100%;">
      <tbody>
      
      
      	 <tr>
      	 	<td class="prodInputName" width="25%">등록 제품 설정</td>
      	 	<td>
      	 	<select id="selectTag" name="searchType">
				<option value="">선택하세요</option>
				<option value="1">컵 등록</option>
				<option value="2">맛 등록</option>
			</select>
      	 </td>
      	 </tr>
      	
      	
         <tr class="product">
            <td width="25%" class="prodInputName">사이즈명</td>
            <td width="75%" align="left">
               <input placeholder="ex)파인트, 쿼터 ..."type="text" style="width: 300px;" name="productname" class="box infoData" />
               <span class="error">필수입력</span>
            </td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">제품코드</td>
            <td width="75%" align="left">
               <input placeholder="ex)P, Q, F, H ..." type="text" style="width: 300px;" name="productcodeno" class="box infoData" />
               <span class="error">필수입력</span>
            </td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">제품이미지</td>
            <td width="75%" align="left">
               <input type="file" name="pimage1" class="infoData img_file" accept='image/*' /><span class="error">필수입력</span>
            </td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">제품판매가</td>
            <td width="75%" align="left">
               <input type="text" style="width: 100px;" name="price" class="box infoData" /> 원
               <span class="error">필수입력</span>
            </td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">제품설명</td>
            <td width="75%" align="left">
               <textarea placeholder="ex)3가지 맛 선택 ..." name="productdetail" rows="5" cols="60"></textarea>
            </td>
         </tr>
         
         <%-- ==== 추가이미지파일을 마우스 드래그앤드롭(DragAndDrop)으로 추가하기 ==== --%>
          <tr class="product">
                <td width="25%" class="prodInputName">제품상세이미지</td>
                <td>
                   <span style="font-size: 10pt;">파일을 1개씩 마우스로 끌어 오세요</span>
                <div id="fileDrop" class="fileDrop border border-secondary"></div>
                </td>
          </tr>
          
          <%-- ==== 이미지파일 미리보여주기 ==== --%>
          <tr class="product">
                <td width="25%" class="prodInputName">이미지파일 미리보기</td>
                <td>
                   <img id="previewImg" width="300"/>
                </td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">맛 이름</td>
          	<td><input placeholder="ex)바람과 함께 날아가다" type="text" style="width: 300px;" name="tastename" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">이미지</td>
          	<td><input type="file" name="tasteimg" class="taste_img_file tasteData" accept='image/*' /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">맛 설명</td>
          	<td><input placeholder="ex)블루베리와 딸기로 상큼함을 더한 치즈케이크 한 조각"type="text" style="width: 500px;" name="tasteexplain" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">1회 제공량</td>
          	<td><input type="text" style="width: 100px;" name="oncesupply" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">열량(kcal)</td>
          	<td><input type="text" style="width: 100px;" name="calory" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">당류(g)</td>
          	<td><input type="text" style="width: 100px;" name="sugar" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">단백질(g)</td>
          	<td><input type="text" style="width: 100px;" name="protein" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">포화지방(g)</td>
          	<td><input type="text" style="width: 100px;" name="fat" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">나트륨(mg)</td>
          	<td><input type="text" style="width: 100px;" name="natrium" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">알레르기 성분</td>
          	<td><input type="text" style="width: 200px;" name="allergy" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">핵심 재료</td>
          	<td><input type="text" style="width: 300px;" name="ingredients" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
          <tr class="taste">
          	<td class="prodInputName">영문 이름</td>
          	<td><input placeholder="ex)Twinberry CheeseCake" type="text" style="width: 300px;" name="eng_name" class="box tasteData" /><span class="error">필수입력</span></td>
          </tr>
      </tbody>
      </table>
      </div>
         
         <div style="height: 70px;  background-color: white; margin-bottom: 10%;">
            <div colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden; padding: 50px 0;">
                <input type="button" value="제품등록" id="btnRegister" style="width: 120px;" class="btn btn-info btn-lg mr-5" /> 
                <input type="reset" value="취소"  style="width: 120px;" class="btn btn-danger btn-lg" />   
            </div>
         </div>
      
   </form>
</div>