<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:url var="R" value="/" />

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>관리자 멘토방 세부 정보 뷰</title>

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

<!-- 우리가 만든 CSS -->
<link href="${R}res/css/imgShape.css" rel="stylesheet">

<style>
body {
	color: black;
}
</style>

</head>

<body id="page-top">

	<!-- 메뉴바 -->
	<tiles:insertAttribute name="menu" />

	<div class="container-fluid p-5">

		<div class="text-center" style="width: 80%; margin: auto;">
			<h3>${ mentorRoom.student.user.name }'s
				<em>MentorRoom</em>
			</h3>
			<div>${ mentorRoom.student.user.email }</div>
			<hr />
			<img class="mentor"
				src="/mentoringNew/user/image?userId=${ mentorRoom.student.user.id }" alt="이미지가 없습니다.">
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
						<th>팀원삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="team" items="${ teamList }">
						<tr>
							<td>${ team.student.user.userId }</td>
							<td>${ team.student.user.name }</td>
							<td>${ team.student.grade }학년</td>
							<td>${ team.student.user.authority == "1" ? "멘티" : (team.student.user.authority == "2" ? "멘토" : "관리자") }</td>
							<td>${ team.student.user.phoneNumber }</td>
							<td>${team.student.user.email }</td>
							<td><a href="${R}admin/teamDelete?id=${team.id}">삭제 </a></td>

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
		<div class="text-center">
			<a href="${R}admin/mentorRoomDelete?id=${mentorRoom.id}"><button
					type="button" class="btn btn-danger" id="delete">삭제</button> </a>
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