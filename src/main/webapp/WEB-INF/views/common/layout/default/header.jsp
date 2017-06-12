<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(document).ready(function() {
	//gnb
    $('.gnb > li').mouseleave(function() {
    	$('.gnb ul').hide();
    	$('.gnb > li.active').find('ul').show();
    	$('.gnb > li.active').children('a:first').addClass('on');
    });
	
});
</script>



<div class="row-header" id="headerNav">
    <h1>STUDY</h1>
    <ul class="gnb">
      <c:set var="forCnt" value="0"/>
	  <c:forEach items="${headerMenuList }" var="i" varStatus="status">
	  		<c:if test="${not empty PARAM_MENU_ID }">
	  			<li ${i.MENU_ID eq PARAM_MENU_ID ?  'class="active"'  :  '' }><a href="javascript:;" ${i.MENU_ID eq PARAM_MENU_ID ?  'class="on"'  :  '' } onclick="menuObj.subAddLeftMenu('${i.MENU_ID }','${i.MENU_NM }',this);" data-menuid="${i.MENU_ID }" ><c:out value="${i.MENU_NM }"/></a></li>
	  		</c:if>
	  		<c:if test="${empty PARAM_MENU_ID }">
	  			<li ${status.first eq true ?  'class="active"'  :  '' }><a href="javascript:;"  ${status.first eq true ?  'class="on"'  :  '' } onclick="menuObj.subAddLeftMenu('${i.MENU_ID }','${i.MENU_NM }',this);" data-menuid="${i.MENU_ID }" ><c:out value="${i.MENU_NM }"/></a></li>
	  		</c:if>
	  </c:forEach>
    </ul>
    <!-- // gnb -->
    <ul class="util-menu">
        <li><span class="user-name"><c:out value="${ADMIN_LOGIN_KEY.ADMIN_ID}"/></span><span class="user-grade"><c:out value="${ADMIN_LOGIN_KEY.ADMIN_NM}"/></span></li>
        <li><a href="/admin/logout">로그아웃</a></li>      
    </ul>
    <!-- // util-menu -->
</div>
<!-- // row-header -->
