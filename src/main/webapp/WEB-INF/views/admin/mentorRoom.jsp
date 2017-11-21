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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Page</title>

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
	href="${R}res/css_main/admin1kil.css">
<link rel="stylesheet" type="text/css"
	href="${R}res/css_main/admin1uk.css">

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
<script type="text/javascript" src="${R}res/js_main/admin1hyuk.js"></script>

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
			<li><a href="/" class="page-scroll">Home</a></li>
			<li><a href="notice.html" class="page-scroll">공지사항</a></li>
			<c:if test="${ optionList.mentorActive == 'on' }">
				<li><a href="user/mentorApply" class="page-scroll">멘토 신청</a></li>
			</c:if>
			<c:if test="${ optionList.menteeActive == 'on' }">
				<li><a href="menteeSelect.html" class="page-scroll">멘티 신청</a></li>
			</c:if>
			<li><a href="mentoroom.html" class="page-scroll">멘토방</a></li>
			<li><a href="question.html" class="page-scroll">문의사항</a></li>
			<c:if test="${ optionList.surveyActive == 'on' }">
				<li><a href="researchMento.html" class="page-scroll">설문조사</a></li>
			</c:if>
			<li><a href="mypage.html" class="page-scroll">My Page</a></li>
			<li><a href="menteeSelect.html" class="page-scroll">관리자 멘토방</a></li>
			<li><a href="sm/admin1" class="page-scroll">관리자 페이지</a></li>
			<!--- End Menu -->
		</ul>
	</div>
	<!--- End Off Canvas Side Menu -->

	<!-- Home Section -->
	<div id="home_mentee">
		<div class="container text-center">
			<!-- Navigation -->
			<nav id="menu" data-toggle="offcanvas" data-target=".navmenu">
				<span class="fa fa-bars"></span>
			</nav>

			<!-- About Us Section -->
			<div id="about-us">
				<div class="container">
					<div class="row text-center">
						<div class="col-md-8 col-md-offset-2">
							<div class="section-title">
								<h2 style="color: white;">관리자멘토방</h2>
								<hr>
							</div>
						</div>
					</div>
					<div class="space"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="row">
								<!-- Mentor modal 1 -->
								<c:forEach var="mentorRoom" items="${ mentorList }">
									<a href=" ${R}admin/adminMentorRoom/${ mentorRoom.id }">
										<div class="col-md-4 col-sm-4">
											<div class="team_mentee">
												<img src="${R}/res/img_main/team/cho.jpg"
													class="img-responsive img-circle" alt="…"> <br>
												<p class="p_mentee">${ mentorRoom.student.user.name }</p>
												<p class="p_mentee">${ mentorRoom.subject}</p>
												<hr>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>

						</div>
					</div>
				</div>
			</div>
</body>
</html>