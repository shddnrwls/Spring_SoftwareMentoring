<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<c:url var="R" value="/" />


<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>User Index</title>

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
							type="button" class="btn btn-outline-light btn-sm">로그아웃</button></a>
					<hr /></li>

				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/index">home</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/noticeList">공지사항</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#education">M3</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#skills">M4</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#interests">M5</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#awards">M6</a>
					<hr /></li>

				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						data-toggle="modal" data-target="#adminModal"><button
								type="button" class="btn btn-outline-light btn-sm">설명
								수정</button></a></li>
					<li><a href="${R}admin/index" class="page-scroll"><button
								type="button" class="btn btn-outline-light btn-sm">관리자
								페이지</button></a></li>
				</sec:authorize>

			</ul>
		</div>
	</nav>
	<!-- 메뉴바 끝 -->

	<div class="container-fluid p-0">

		<div align="center" style="padding: 10%;">
			<div style="width: 55%">
				<h2>보고서 제출</h2>
				<hr />


				<form:form method="post" modelAttribute="report">
					<form style="padding: 10%;">
						<div class="form-group">
							<label for="exampleFormControlSelect1" style="float: left;">스터디
								날짜</label> <br />
							<form:select path="week" name="week" class="form-control"
								id="month">
								<option>1주차</option>
								<option>2주차</option>
								<option>3주차</option>
								<option>4주차</option>
								<option>5주차</option>
								<option>6주차</option>
								<option>7주차</option>
								<option>8주차</option>
								<option>9주차</option>
								<option>10주차</option>
								<option>11주차</option>
								<option>12주차</option>
								<option>13주차</option>
								<option>14주차</option>
								<option>15주차</option>
							</form:select>
						</div>
						<br />

						<div class="form-group">
							<label class="form-control-label" for="formGroupExampleInput"
								style="float: left;">모임 장소</label>
							<form:input path="place" name="place" class="form-control"
								id="formGroupExampleInput" placeholder="" />
						</div>
						<div class="form-group">
							<label class="form-control-label" for="formGroupExampleInput"
								style="float: left;">주요 내용</label>
							<form:textarea path="contents" name="contents"
								class="form-control" rows="5" id="comment"></form:textarea>
						</div>

						<span class="min-chart" id="chart-sales" data-percent="56"><span
							class="percent"></span></span>


						<div class="form-group">
							<label for="exampleFormControlFile1" style="float: left;">스터디
								증명 사진</label> <br /> <input type="file" class="form-control-file"
								id="exampleFormControlFile1">
						</div>


						<div class="btn-group" role="group" aria-label="Basic example"
							style="padding-bottom: 20%">
							<button type="submit" class="btn btn-secondary"
								style="color: black">확인</button>
							<button type="button" class="btn btn-secondary"
								style="color: black">초기화</button>
							<button type="button" class="btn btn-secondary"
								style="color: black; cursor: pointer"
								onClick="location.href='url'">취소</button>
						</div>


					</form>
				</form:form>

			</div>
		</div>
	</div>

</body>
</html>