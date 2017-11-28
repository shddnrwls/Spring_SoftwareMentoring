<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:url var="R" value="/" />

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>소속된 멘토방</title>

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

<style>
body {
	color: black;
}

.mentor {
	min-width: 300px;
	max-width: 300px;
	min-height: 300px;
	max-height: 300px;
	border-radius: 50% !important;
}
</style>

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
							type="button" class="btn btn-outline-light btn-sm">로그아웃</button></a>
					<hr /></li>

				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/index">home</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/noticeList">공지사항</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/mentorApply">멘토 신청</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/menteeSelect">멘티 신청</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/myMentorRoom">멘토방</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#awards">M6</a>
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

	<div class="container-fluid p-5">

		<div class="text-center" style="width: 80%; margin: auto;">
			<h3>${ mentorRoom.student.user.name }'s
				<em>MentorRoom</em>
			</h3>
			<div>${ mentorRoom.student.user.email }</div>
			<hr />
			<img class="mentor" src="${R}res/img/2.jpg" alt="">
			<hr />
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">팀명</th>
						<th scope="col">주제</th>
						<th scope="col">학점</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${ mentorRoom.teamName }</td>
						<td>${ mentorRoom.subject }</td>
						<td>${ mentorRoom.grade }</td>
					</tr>
				</tbody>
			</table>
			<hr />
			<br />
			<h3>멘토&멘티</h3>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>학번</th>
						<th>이름</th>
						<th>학년</th>
						<th>멘토&멘티</th>
						<th>핸드폰번호</th>
						<th>E-Mail</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="team" items="${ teamList }">
						<tr>
							<td>${ team.student.user.userId }</td>
							<td>${ team.student.user.name }</td>
							<td>${ team.student.grade }학년</td>
							<td>권한</td>
							<td>${ team.student.user.phoneNumber }</td>
							<td>${team.student.user.email }</td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr />
			<br />
			<h3>스터디 목적</h3>
			<div class="card card-body">${ mentorRoom.purpose }</div>
			<br />
			<hr />
			<br />
			<h3>스터디 내용</h3>
			<div class="card card-body">${ mentorRoom.contents }</div>
			<br />
			<hr />
			<br />
			<h3>스터디 방법</h3>
			<div class="card card-body">${ mentorRoom.method }</div>
			<br />
			<hr />
			<br />
		</div>
	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="${R}res/js/jquery.min.js"></script>
	<script src="${R}res/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${R}res/js/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${R}res/js/resume.min.js"></script>

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