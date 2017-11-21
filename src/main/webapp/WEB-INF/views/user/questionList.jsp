<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>
<c:url var="R" value="/" />

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>문의사항</title>

<!-- Favicons
    ================================================== -->
<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
<link rel="apple-touch-icon" href="img/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="img/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="img/apple-touch-icon-114x114.png">

<link rel="stylesheet" type="text/css"
	href="${R}res/css_main/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="${R}res/font-awesome-4.2.0_main/css/font-awesome.css">
<link rel="stylesheet" type="text/css"
	href="${R}res/css_main/jasny-bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${R}res/css_main/animate.css">
<link href="${R}res/css_main/owl.carousel.css" rel="stylesheet"
	media="screen">
<link href="${R}res/css_main/owl.theme.css" rel="stylesheet"
	media="screen">
<link rel="stylesheet" type="text/css" href="${R}res/css_main/style.css">
<link rel="stylesheet" type="text/css"
	href="${R}res/css_main/responsive.css">
<link rel="stylesheet" type="text/css"
	href="${R}res/css_main/notice.css">

<link
	href='http://fonts.googleapis.com/css?family=Montserrat:400,700|Acme'
	rel='stylesheet' type='text/css'>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="${R}res/js_main/jquery.1.11.1.js"></script>
<script type="text/javascript" src="${R}res/js_main/bootstrap.js"></script>
<script type="text/javascript" src="${R}res/js_main/SmoothScroll.js"></script>
<script type="text/javascript"
	src="${R}res/js_main/jasny-bootstrap.min.js"></script>
<script src="${R}res/js_main/owl.carousel.js"></script>
<script src="${R}res/js_main/typed.js"></script>
<script type="text/javascript" src="${R}res/js_main/main.js"></script>
<script type="text/javascript" src="${R}res/js_main/notice.js"></script>
<script type="text/javascript" src="${R}res/js_main/modernizr.custom.js"></script>

</head>

<body>
	<!--- Off Canvas Side Menu -->
	<div class="navmenu navmenu-default navmenu-fixed-left offcanvas">
		<div class="close" data-toggle="offcanvas" data-target=".navmenu">
			<span class="fa fa-close"></span>
		</div>
		<div class="add-margin"></div>
		<ul class="nav navmenu-nav">
			<!--- Menu -->
			<li style="color: orange; font-size: 14pt"><sec:authentication
					property="user.name" /></li>
			<li><a href="${R}user/logout_processing" class="page-scroll">로그아웃</a></li>
			<li><a href="${R}user/index" class="page-scroll">Home</a></li>

			<li><a href="${R}user/notice" class="page-scroll">공지사항</a></li>
			<li><a href="${R}user/mentorApply" class="page-scroll">멘토 신청</a></li>
			<li><a href="" class="page-scroll">멘티 신청</a></li>
			<li><a href="" class="page-scroll">멘토방</a></li>
			<li><a href="" class="page-scroll">문의사항</a></li>
			<li><a href="" class="page-scroll">설문조사</a></li>
			<li><a href="" class="page-scroll">My Page</a></li>

			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="" class="page-scroll">관리자 멘토방</a></li>
				<li><a href="${R}admin/index" class="page-scroll">관리자 페이지</a></li>
			</sec:authorize>
			<!--- End Menu -->
		</ul>
	</div>
	<!--- End Off Canvas Side Menu -->

	<!-- Home Section -->
	<div id="home">
		<div class="container text-center">
			<!-- Navigation -->
			<nav id="menu" data-toggle="offcanvas" data-target=".navmenu">
				<span class="fa fa-bars"></span>
			</nav>

			<div class="content">
				<h1>문의사항</h1>
				<form:form method="get" modelAttribute="pagination" class="form-inline mb5">
					<form:hidden path="pg" value="1" />
					<span>순서:</span>
					<form:select path="ob" class="form-control autosubmit" itemValue="value" itemLabel="label" items="${ orderBy }" />
					<form:select path="sb" class="form-control ml20" itemValue="value" itemLabel="label" items="${ searchBy }" />
					<form:input path="st" class="form-control" placeholder="검색문자열" />
					<button type="submit" class="btn btn-default">
						<i class="glyphicon glyphicon-search"></i> 검색
					</button>
					<c:if test="${ pagination.sb > 0 || pagination.ob > 0}">
						<a class="btn btn-default" href="list?pg=1"> <i
							class="glyphicon glyphicon-ban-circle"></i> 검색취소
						</a>
					</c:if>
					<div class="pull-right">
						<span>페이지 크기:</span>
						<form:select path="sz" class="form-control autosubmit">
							<form:option value="10" /><form:option value="15" /><form:option value="30" />
						</form:select>
						
						<div class="pull-right">
							<a class="btn btn-primary" href="${R}user/questionCreate?${ pagination.queryString }">새글작성</a>
						</div>	
						
					</div>
				</form:form>
				
				<br/>
				
				<table id="notices" class="table table-bordered">
					<thead>
						<tr>
							<th class="text-center" style="width: 80px;">no</th>
							<th>제목</th>
							<th class="text-center">글쓴이</th>
							<th class="text-center">작성일</th>
							<th class="text-center">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="question" items="${ list }">
							<tr data-url="questionView?id=${ question.id }&${ pagination.queryString }">
								<td class="text-center">${ question.no }</td>
								<td>${ question.title }</td>
								<td>${ question.student.user.name }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${ question.date }" /></td>
								<td>${ question.hit }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<my:pagination pageSize="${ pagination.sz }" recordCount="${ pagination.recordCount }" />

			</div>
		</div>
	</div>

	<nav id="footer">
		<div class="container">
			<div class="pull-left">
				<p>2017 © SKHU SW. All Rights Reserved.</p>
			</div>
			<div class="pull-right">
				<a href="#home" class="page-scroll">Back to Top <span
					class="fa fa-angle-up"></span></a>
			</div>
		</div>
	</nav>

</body>
</html>
