<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<c:url var="R" value="/" />
<%
	pageContext.setAttribute("newLineChar", "\n");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Error Page</title>

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
				<li><a href="${R}logout_processing" class="page-scroll"><button
							type="button" class="btn btn-outline-light btn-sm">로그아웃</button></a>
					<hr /></li>

				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/index">home</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/noticeList">공지사항</a></li>
				<c:if test="${ optionList.mentorActive == 'on' }">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${R}user/mentorApply">멘토 신청</a></li>
				</c:if>
				<c:if test="${ optionList.menteeActive == 'on' }">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${R}user/menteeSelect">멘티 신청</a></li>
				</c:if>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/myMentorRoom">멘토방</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/questionList">문의사항</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/myPage">My Page</a>
					<hr /></li>

				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						data-toggle="modal" data-target="#adminModal"><button
								type="button" class="btn btn-outline-light btn-sm">설명
								수정</button></a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${R}admin/index"><button type="button"
								class="btn btn-outline-light btn-sm">관리자 페이지</button></a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${R}admin/allMentorRoom"><button type="button"
								class="btn btn-outline-light btn-sm">관리자 멘토방</button></a></li>
				</sec:authorize>

			</ul>
		</div>
	</nav>
	<!-- 메뉴바 끝 -->

	<div class="container-fluid p-0">

		<section class="resume-section p-3 p-lg-5 d-flex d-column" id="main">
			<div class="my-auto">
				<h1 class="mb-0">
					<span class="fa fa-book"> </span>SW <span class="text-primary">Mentoring</span>
				</h1>
				<h2>
					<font color="gray">사용자의 요청이 실패했습니다.</font>
				</h2>
				<h4 style="color: gray;">Error Code: 500</h4>
				<h4 style="color: gray;">다른 요청을 시도해주시기 바랍니다.</h4>
			</div>
		</section>

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