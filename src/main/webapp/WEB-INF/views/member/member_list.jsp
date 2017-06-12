<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	.layer {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:100;}
		.layer .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
		.layer .pop-layer {display:block;}

	.pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: 800px; height:auto;  background-color:#fff; border: 5px solid #3571B5; z-index: 10;}	
	.pop-layer .pop-container {padding: 20px 25px;}
	.pop-layer p.ctxt {color: #666; line-height: 25px;}
	.pop-layer .btn-r {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}

	a.cbtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}	
 	a.cbtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;} 
	
	.add-list::after{content:'';display:block;clear:both; width:100%}
	.add-list li{float:left;width:23%;margin-left:2%}
	.add-list li:first-child{width:25%;margin-left:0}
	.add-list li span{display:inline-block;width:30%}
	.add-list li input{width:70%}
</style>

<script type="text/javascript">

var pageNum = 1;
var pageMaxNum = 0;
var pageNextNum = 0;
var pageMaxNextNum = 0;
var onePage = 3;


// $(document).ajaxStop(function() {
// });

	$(document).ready(function() {

		// 	$(document).on('click', 'input:checkbox', function() {
		// 		console.log("input:checkbox");
		// 	      if ( $(this).prop('checked') ) {
		// 	        $(this).parent().addClass("on");
		// 	      } else {
		// 	        $(this).parent().removeClass("on");
		// 	      }
		// 	    });
 		
 		searchObj.searchAction();
		
		$('#select-limit').change(function(){
			setFirstPage();
			searchObj.searchAction();
		});
		
		$(document).on('click', '.pagination a', function(){
			if($(this).attr('class') == "next"){
				console.log("pageMaxNextNum : "+pageMaxNextNum+", pageNextNum : "+pageNextNum);
				if(pageMaxNextNum == pageNextNum+1){
					return;
				}
				pageNextNum++;
				pageNum = (onePage*pageNextNum)+1;
			} else if($(this).attr('class') == "prev"){
				if(pageNextNum == 0){
					return;
				}
				pageNextNum--;
				pageNum = (onePage*pageNextNum)+onePage;
			} else if($(this).attr('class') == "first"){
				setFirstPage();
			} else if($(this).attr('class') == "last"){
				pageNum = pageMaxNum;
				pageNextNum = pageMaxNextNum-1;
			}else {
				pageNum = $(this).text();
			}
			
			$("#pageNum a").removeClass("on");
			
			resetCheckAll();
			
			searchObj.searchAction();
			
// 			$(document).on('removeClass')
// 			$(this).addClass("on");
		});
		
		$("#check-all").click(function(){
			console.log("check-all");
// 			$("#check-member").addClass("on");
// 			$('.checkbox').prop('checked', this.checked);
// 			$("#check-test").attr("class", "on");
// 			$("input[name=chk]:checkbox").attr("checked", true);
// 			$('.ab:input[name=chk]:checkbox').prop( 'checked', true );
// 			$('.ab').addClass("on");


// 			$("input[name='chk']").each(function (i) {
					 //$(".checkbox").prop('checked', true);
// 				 });


			
			if($(this).children('input').is(':checked')){
				$(".checkbox").prop('checked', true);
				
				$("label[name='check-member']").each(function (i) {
					$("label[name='check-member']").eq(i).addClass("on");
				 });
			} else {
				$("label[name='check-member']").each(function (i) {
					$(".checkbox").prop('checked', false);
					
					 $("label[name='check-member']").eq(i).removeClass();
				 });
			}

			

// 			 $("#check-test").each(function (i) {
				 
// 	                console.log("type2: "+$("#check-test").eq(i).addClass("on"));
// 			 });
		});
		
// 		$(".pagination a").on("click",function(){
// //			console.log($(this).text());
// 			pageNum = $(this).text();
// 			searchObj.searchAction();
			
// 			$(".pagination a").removeClass("on");
// 			$(this).addClass("on");
// 		});		

	});
	
	function setFirstPage(){
		pageNum = 1;
		pageNextNum = 0;
		resetCheckAll();
	}
	
	function resetCheckAll(){
		$("#check-all").removeClass();
		$(".check-all").prop('checked', false);
	}

	function searchMember(){
		setFirstPage();
		
		
		searchObj.searchAction();
	}
	
	var searchObj = {
		searchAction : function() {
			var data = $('#search-form').serializeObject();
			data.limit = $('#select-limit').val();
			data.pageNum = pageNum;
			console.log(data);
			searchAjax(data);
		}
	};

	function searchAjax(data) {
		$.ajax({
			url : "/admin/select.json",
			dataType : "json",
			type : "POST",
			data : data,
// 			async : false,
			success : function(data, textStatus, jqXHR) {
				// 결과값 처리
				resetCheckAll();
				console.log(data);
				createTable(data);
				addPageNum(data.memCnt);
			},

			error : function() {
				alert('에러');
			}
		});
	}

	function createTable(data) {

			$('#tbl-1-body').empty();

		if (data.listAdminInfo == null || data.listAdminInfo.length == 0) {

			var row = "<tr>";
			row += "<td colspan=\"11\" style=\"text-align:center\">조회되는 데이터가 없습니다.</td>";
			row += "</tr>";

			$("#tbl-1").append(row);

		} else {
			for (var i = 0; i < data.listAdminInfo.length; i++) {

				var row = "<tr>";
				row += "<td><span class=\"checkbox-w\" id=\"checkbox-w\"><label name=\"check-member\"><input class=\"checkbox\" type=\"checkbox\" name=\"selectbox_"+i+"\" value=\""+data.listAdminInfo[i].ADMIN_ID+"\"></label></span></td>";
				row += "<td>12</td>";
				row += "<td>" + data.listAdminInfo[i].ADMIN_NM + "</td>";
				row += "<td>" + data.listAdminInfo[i].ADMIN_ID + "</td>";
				row += "<td>" + data.listAdminInfo[i].TEL_NO + "</td>";
				row += "<td>" + data.listAdminInfo[i].MOBILE_NO + "</td>";
				row += "<td>" + data.listAdminInfo[i].EMAIL + "</td>";
				row += "<td>" + data.listAdminInfo[i].USE_YN + "</td>";
				row += "<td>" + data.listAdminInfo[i].LOGIN_FAIL_CNT + "</td>";
				row += "<td>" + data.listAdminInfo[i].CRE_DT + "</td>";
				row += "<td>" + data.listAdminInfo[i].MOD_DT + "</td>";
				row += "</tr>";
				
				
				$("#tbl-1").append(row);
			}
		}
	}
	
	function addPageNum(memCnt)
	{
		$('#pageNum').empty();
		
		var selectLimit = $('#select-limit').val();
		
		pageMaxNum = Math.ceil(memCnt/selectLimit)
		var pageCnt = pageMaxNum - (onePage * pageNextNum);
		pageMaxNextNum = Math.ceil(pageMaxNum/onePage);
		
// 		console.log("pageMaxNum : "+pageMaxNum+", pageMaxNextNum : "+pageMaxNextNum);
		
// 		if(pageMaxNum <= onePage){
// 			pageMaxNextNum = 0;
// 		}
		
		var addTag = "";
		
		if(pageCnt > onePage){
			pageCnt = onePage;
		}
		
		var addPageNum = 0;
		
		for(var i = 0; i < pageCnt; i++){
			
			addPageNum = ((i+1)+(onePage*pageNextNum));
// 			console.log("addPageNum : "+addPageNum);
			if(i == 0){
				if(addPageNum == pageNum){
					addTag += "<a href=\"#none\" class=\"on\">"+addPageNum+"</a>";
				} else {
					addTag += "<a href=\"#none\">"+addPageNum+"</a>";
				}
				
			} else if(addPageNum == pageNum){
				addTag += "<a href=\"#none\" class=\"on\" style=\"margin-left:4px\">"+addPageNum+"</a>";
			}
			else {
				addTag += "<a href=\"#none\" style=\"margin-left:4px\">"+addPageNum+"</a>";
			} 
		}
		
		$("#pageNum").append(addTag);
	}

	var addObj = {
		submitFlag : true,
		addAction : function() {
			var data = $('#add-form').serializeObject();
// 			data.abc = "abc";
			console.log(data);
			$.ajax({
				url : "/admin/insert.json",
				dataType : "json",
				type : "POST",
				data : data,
				success : function(data, textStatus, jqXHR) {
					alert('추가 완료');

					$('#add-form')[0].reset();
					
					searchObj.searchAction();
				},

				error : function() {
					alert('추가에 실패 했습니다.');
				}
			});
		}
	};
	
	var deleteObj = {
		submitFlag : true,
		deleteAction : function() {
			if (confirm("정말 삭제 하시겠습니까?")){
				var data = $('#form-tbl-1').serializeObject();
//		 		data.abc = "abc";
				console.log("delete data : "+data);
				$.ajax({
					url : "/admin/delete.json",
					dataType : "json",
					type : "POST",
					data : data,
					success : function(data, textStatus, jqXHR) {
						alert('삭제 완료');
						
						setFirstPage();
						
						searchObj.searchAction();
					},
					error : function() {
						alert('삭제를 실패 했습니다.');
					}
				});
			} else {
			    return;
			}
		}
	};

	function layer_open(el) {

		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg'); //dimmed 레이어를 감지하기 위한 boolean 변수

		if (bg) {
			$('.layer').show(); //'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		} else {
			temp.show();
		}

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height())
			temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
		else
			temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width())
			temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
		else
			temp.css('left', '0px');

		$('#close-layer').on('click', function() {
			if (bg) {
				$('.layer').hide(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
			} else {
				temp.dhie();
			}
// 			e.preventDefault()
			
			$('#add-form')[0].reset();
	    });
		
// 		temp.find('a.cbtn').click(function(e) {
// 			if (bg) {
// 				$('.layer').hide(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
// 			} else {
// 				temp.dhie();
// 			}
// 			e.preventDefault();
// 		});

		$('.layer .bg').click(function(e) { //배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
			$('.layer').hide();
			e.preventDefault();
		});

	}
	
	var downObj = {
		submitFlag : true,
		downAction : function() {
			var data = $('#search-form').serializeObject();
	//			 data.abc = "abc";
			console.log(data);
			$.ajax({
				url : "/admin/excel.json",
				dataType : "json",
				type : "POST",
				data : data,
				success : function(data, textStatus, jqXHR) {
					alert('엑셀 저장을 성공 하였습니다.');
				},
				error : function() {
					alert('엑셀 저장을 실패 했습니다.');
				}
			});
		}
	};
	
	function downTest(){
		var popup = window.open("/admin/excel", "hiddenframe", "width=0, height=0, top=0, statusbar=no, scrollbars=no, toolbar=no");
		  popup.focus(); 
	}
</script>

<h1 class="page-tit">회원정보조회</h1>
<div class="search-set">
	<strong class="tit">회원검색</strong>
	<form id="search-form">
	<select class="select" id="select-item" name="select-item">
		<option value="all">전체</option>
		<option value="name">이름</option>
		<option value="id">아이디</option>
		<option value="deleteMember">탈퇴회원</option>
	</select>
    <input type="text" class="text" name="keyword"/>
    <a href="#none" class="btn-type1" onclick="searchMember();">검색</a>
    <span class="checkbox-w txt-1">
		<label><input type="checkbox">탈퇴회원 제외</label>
	</span>
	</form>
</div>
<div class="result-wrap">
    <p class="total-feed">전체 : <em>12,528</em>명 (일반회원 : <em>9200</em>명, 휴먼회원 : <em>3328</em>명)</p>
    <div class="btn-wrap">
        <a class="btn-type4" href="#none" onclick="downTest();">Excel 다운로드</a>
    </div>
</div>

<div class="result-wrap">
    <p class="total-feed">
        <em>324</em> Page<em>1</em> /<em>33</em>
        <span class="total">총 M머니 : <em class="sum">524,300</em> 원</span>
    </p>
    <div class="select-wrap">
<!--     	<form id="search-form"> -->
        <select class="select" id="select-limit">
            <option value="3">20개씩 보기</option>
            <option value="5">30개씩 보기</option>
            <option value="7">50개씩 보기</option>
            <option value="100">100개씩 보기</option>
        </select>
<!--         </form> -->
    </div>
</div>

<form id="form-tbl-1">
<table id="tbl-1" class="tbl-1">
	<colgroup>
	    <col style="width: 4%">
		<col style="width: 6%">
		<col style="width: 10%">
		<col style="width: 10%">
		<col style="width: 10%">
		<col style="width: 10%">
		<col style="width: 16%">
		<col style="width: 7%">
		<col style="width: 7%">
		<col style="width: 10%">
		<col style="width: 10%">
	</colgroup>
	<thead>
	    <tr>
	    	<th><span class="checkbox-w"><label id="check-all"><input class="check-all" type="checkbox"></label></span></th>
	        <th><span>번호</span></th>
	        <th><span>이름 </span></th>
	        <th><span>아이디</span></th>
	        <th><span>전화번호</span></th>
	        <th><span>핸드폰번호</span></th>
	        <th><span>이메일</span></th>
	        <th><span>사용가능</span></th>
	        <th><span>로그인<br/>실패<br/>횟수</span></th>
	        <th><span>가입일</span></th>
	        <th><span>수정일</span></th>
	    </tr>
	</thead>
	<tbody id="tbl-1-body">
<!-- 	<tr> -->
<!-- 	<td><span class="checkbox-w"><label id="check-test"><input class="ab" name="chk" type="checkbox" value="1"></label></span></td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 	<td><span class="checkbox-w"><label id="check-test"><input class="ab" name="chk" type="checkbox" value="2"></label></span></td> -->
<!-- 	</tr> -->
		
    </tbody>
</table>
</form>

<div class="layer">
	<div class="bg"></div>
	<div id="layer2" class="pop-layer">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<div>
					<form id="add-form">
						<ul class="add-list">
							<li ><span>아이디:</span><input type="text" name="memId" ></li>
							<li ><span>비밀번호:</span><input type="password" name="memPass"  ></li>
							<li ><span>이름:</span><input type="text" name="memName" ></li>
							<li ><span>전화번호:</span><input type="text" name="memTelNo" ></li>
						</ul>
						<ul class="add-list" style="margin-top:10px">
						<li><span>핸드폰:</span><input type="text" name="memMobileNo"></li>
							<li><span>이메일:</span><input type="text" name="memEmail"></li>
							</ul>
					</form>
				</div>
				<div class="btn-r">
					<a href="#" onclick="addObj.addAction();" class="cbtn" id="addMember">추가</a>
					<a href="#" class="cbtn" id="close-layer">닫기</a>
				</div>
				<!--// content-->
			</div>
		</div>
	</div>
</div>



<div class="pop-btn-wrap">
  <button type="button" class="btn-type3" data-dismiss="modal" onclick="layer_open('layer2');return false;">추가</button>
  <button type="button" class="btn-type2" onclick="deleteObj.deleteAction();">삭제</button>
</div>
<div class="pagination" >
<!-- <form id="search-form"> -->
    <a href="#none" class="first">첫페이지로 이동</a>
    <a href="#none" class="prev">이전 페이지로 이동</a>
<!--     <a href="#none" class="on">1</a> -->
<!--     <a href="#none">2</a> -->
<!--     <a href="#none">3</a> -->
<!--     <a href="#none">4</a> -->
    <span id="pageNum">
<!-- 		<a href="#none">2</a> -->
<!-- 		<a href="#none">3</a> -->
	</span>
    <a href="#none" class="next">다음 페이지로 이동</a>
    <a href="#none" class="last">마지막 페이지로 이동</a>
<!-- </form> -->
</div>
<iframe width=0 height=0 name="hiddenframe" style="display:none;"></iframe>
