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
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Notice View</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Bootstrap core CSS -->
<link href="${R}res/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="${R}res/font-awesome/font-awesome.min.css" rel="stylesheet">
<link href="${R}res/devicons/devicons.min.css" rel="stylesheet">
<link href="${R}res/icons/simple-line-icons.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${R}res/css/resume.min.css" rel="stylesheet">

</head>

<body id="page-top">
	<!-- 메뉴바 -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top"
		id="sideNav">
		<a class="navbar-brand js-scroll-trigger" href="#page-top"> <span
			class="d-block d-lg-none">Mentoring</span> <span
			class="d-none d-lg-block"> <img
				class="img-fluid img-profile rounded-circle mx-auto mb-2"
				src="img/profile.jpg" alt="">
		</span>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav">
				<li style="color: white; font-size: 14pt"><sec:authentication
						property="user.name" /></li>
				<li><a href="logout_processing" class="page-scroll"><button
							type="button" class="btn btn-outline-light btn-sm">로그아웃</button></a><hr/></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/index">home</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#experience">M2</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#education">M3</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#skills">M4</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#interests">M5</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#awards">M6</a><hr/></li>

				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						data-toggle="modal" data-target="#adminModal"><button
								type="button" class="btn btn-outline-light btn-sm">설명
								수정</button></a></li>
				</sec:authorize>

			</ul>
		</div>
	</nav>
	<!-- 메뉴바 끝 -->

	<div class="container pull-left" style="padding-top: 10%;">

		<h3>${ notice.title }</h3>
		<span class="fa fa-user-circle"></span> 관리자 <span
			class="fa fa-clock-o"></span>
		<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${ notice.date }" />
		<hr />

		<div class="text-center">
			<div>${ notice.content }</div>
		</div>

		<hr />
		<div class="pull-right">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a class="btn btn-primary btn-sm"
					href="${R}user/noticeEdit?id=${ notice.id }&${ pagination.queryString }">수정</a>
				<a class="btn btn-danger btn-sm"
					href="${R}user/noticeDelete?id=${ notice.id }&${ pagination.queryString }"
					data-confirm-delete>삭제</a>
			</sec:authorize>
			<a class="btn btn-success btn-sm"
				href="${R}user/noticeList?${ pagination.queryString }">목록으로</a>
		</div>

	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="${R}res/js/jquery.min.js"></script>
	<script src="${R}res/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${R}res/js/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${R}res/js/resume.min.js"></script>
	<script src="${R}res/js/notice.js"></script>

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"
		integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"
		integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"
		crossorigin="anonymous"></script>
	
	<script src="https://use.fontawesome.com/25b35a2279.js"></script>

</body>

</html>
