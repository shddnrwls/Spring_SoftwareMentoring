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
<title>문의 사항 수정</title>

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
	href="${R}res/summernote/summernote.css">


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
<script type="text/javascript" src="${R}res/js_main/modernizr.custom.js"></script>
<script src="${R}res/summernote/summernote.js"></script>
<script type="text/javascript" src="${R}res/js_main/notice.js"></script>

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
				<h2>${ question.title }</h2>
				<hr />
				<form:form method="post" modelAttribute="questionModel">
				
					<form:input path="title" class="form-control" placeholder="제목을 입력해주세요."/>
					<form:errors path="title" class="error" />
					
					<br />
					
					<div id="summernote">${ questionModel.content }</div>
					<form:errors path="content" class="error" />
					<input type="hidden" name="content" />
					
				</form:form>

				<br />
				<br />

				<div id="buttons">
					<a class="btn btn-success" onclick="save()">저장</a> <a
						class="btn btn-default"
						href="${R}user/questionList?${ pagination.queryString }">목록으로</a>
				</div>

				<br />
				<br />

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

	<script>
		$('#summernote').summernote({
			height : 300
		});
		function save() {
			var s = $('#summernote').summernote('code');
			$('input[name=content]').val(s);
			$('form').submit();
		}
	</script>

</body>
</html>
