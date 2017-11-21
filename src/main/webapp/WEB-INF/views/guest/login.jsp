<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:url var="R" value="/" />

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Login</title>

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

		<div class="collapse navbar-collapse" id="navbarSupportedContent">

		</div>
	</nav>
	<!-- 메뉴바 끝 -->

	<div class="container-fluid p-0">
		<center>
			<section class="resume-section p-3 p-lg-5 d-flex d-column" id="main">
				<div class="my-auto">
					<h1 class="mb-0">
						<span class="fa fa-book"> </span>SW <span class="text-primary">Mentoring</span>
					</h1>
					<br />
					<form method="post" action="login_processing">
						<div class="form-group">
							<input type="text" name="userId" class="form-control w200"
								placeholder="아이디" />
						</div>
						<div class="form-group">
							<input type="password" name="passwd" class="form-control w200"
								placeholder="비밀번호" />
						</div>
						<hr />
						<div>
							<button type="submit" class="btn btn-primary">로그인</button>
						</div>
					</form>

					<c:if test="${ param.error != null }">
						<div class="mt5">로그인 실패</div>
					</c:if>
				</div>
			</section>
		</center>

	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="${R}res/js/jquery.min.js"></script>
	<script src="${R}res/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${R}res/js/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${R}res/js/resume.min.js"></script>

</body>

</html>