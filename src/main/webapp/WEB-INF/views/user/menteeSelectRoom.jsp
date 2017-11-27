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

<style>
#user .avatar {
	width: 60px;
}

#user .avatar>img {
	width: 50px;
	height: 50px;
	border-radius: 10%;
}
/*Card*/
#user .panel-thumb {
	margin: 5px auto;
	text-align: center;
}

#user .panel-thumb .avatar-card {
	text-align: center;
	height: 200px;
	margin: auto;
	overflow: hidden;
}

#user .panel-thumb .avatar-card>img {
	max-width: 200px;
	max-height: 200px;
}

/* table*/
#user .panel-table {
	animation-duration: 3s;
}

#user .panel-table .panel-body .table {
	margin: 0px;
}

#user .panel-table .panel-body {
	padding: 0px;
	color: black;
}

#user .panel-table .panel-body .table-bordered>thead>tr>th {
	text-align: center;
	color: black;
}

#user .panel-table .panel-footer {
	height: 60px;
	padding: 0px;
}

.grid-header {
	background-color: #aaa;
	background-size: 34px;
	border-bottom: 1px solid #ddd;
	overflow: hidden;
	box-shadow: 0 0 3px 0;
	position: fixed;
	top: 43px;
	display: block;
	z-index: 1035;
}

.grid-header-labels {
	padding-left: 60px;
}

.grid-header-label {
	width: 120px;
	float: left;
	padding: 10px 5px;
	height: 40px;
	text-align: center;
	background: #009d97;
	color: #fff;
	cursor: pointer;
	position: relative;
}

.grid-header-label-divider {
	border-right: 1px solid #cbcbcb;
	position: static;
	right: 0;
	bottom: 0;
	height: 22px;
}

.grid-header-Clock {
	text-align: left;
	background-color: #aaa;
	width: 60px;
	height: 60px;
	position: fixed;
	left: 0;
	top: 0;
	font-size: 40px;
}

.grid-body {
	position: absolute;
	top: 40px !important;
	background: #f7f7f7;
}

.ui-block {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
}

.grid-times-holder {
	position: absolute;
	overflow: hidden;
	width: 60px;
	top: 0;
	display: block;
	z-index: 200;
	border-right: 1px solid #ddd;
	background: #eee;
	text-align: center;
}

.grid-date-holder {
	position: absolute;
	overflow: hidden;
	left: 60px;
	top: 0px;
	display: block;
	z-index: 200;
	border-right: 1px solid #ddd;
	background: #eee;
	text-align: center;
}

.day-label {
	height: 24px;
	line-height: 25px;
	border-bottom: 1px solid #a6a8ab;
	color: #57585a;
	background-color: #CBCBCB;
}

.grid-time-label {
	height: 50px;
	top: 10px;
	line-height: 20px;
	border-bottom: 1px solid #ddd;
	padding-left: 0;
}

.grid-times {
	
}

.grid-body-labels {
	padding-left: 0px;
}

.grid-body-cell {
	width: 110px;
	float: left;
	padding: 10px 5px;
	height: 50px;
	line-height: 49px;
	border-bottom: 1px solid #ddd;
	padding-left: 0;
	text-align: center;
	color: #fff;
	background-color: #fff;
	cursor: pointer;
	position: relative;
	border: 1px solid #ddd;
}

.grid-sessions {
	position: relative;
	min-width: 100%;
}

.grid-sessions-day {
	position: relative;
	height: 100px;
	background:
		url(https://farm9.staticflickr.com/8617/16121120332_0c7b48b7c4_o.png)
		60px 25px;
	min-width: 100%;
}

.grid-session-cell {
	position: absolute;
	width: 118px;
	overflow: hidden;
	border: 1px solid #bbb;
	font-size: 12px;
	cursor: pointer;
	background: rgba(0, 157, 151, .85);
	color: #fff;
	font-family: sans-serif;
}

.grid-session-icon {
	position: absolute;
	right: 10px;
	bottom: 10px;
	font-size: 24px;
}

.grid-session-title {
	padding: 9px;
	padding-right: 10px;
	font-weight: bold;
}

.grid-session-time {
	padding: 9px;
}

.twPc-div {
	background: #fff none repeat scroll 0 0;
	border: 1px solid #e1e8ed;
	border-radius: 6px;
	height: 200px;
	max-width: 340px;
	//
	orginal
	twitter
	width
	:
	290px;
}

.twPc-bg {
	background-image:
		url("https://pbs.twimg.com/profile_banners/50988711/1384539792/600x200");
	background-position: 0 50%;
	background-size: 100% auto;
	border-bottom: 1px solid #e1e8ed;
	border-radius: 4px 4px 0 0;
	height: 95px;
	width: 100%;
}

.twPc-block {
	display: block !important;
}

.twPc-button {
	margin: -35px -10px 0;
	text-align: right;
	width: 100%;
}

.twPc-avatarLink {
	background-color: #fff;
	border-radius: 6px;
	display: inline-block !important;
	float: left;
	margin: -30px 5px 0 8px;
	max-width: 100%;
	padding: 1px;
	vertical-align: bottom;
}

.twPc-avatarImg {
	border: 2px solid #fff;
	border-radius: 7px;
	box-sizing: border-box;
	color: #fff;
	height: 72px;
	width: 72px;
}

.twPc-divUser {
	margin: 5px 0 0;
}

.twPc-divName {
	font-size: 18px;
	font-weight: 700;
	line-height: 21px;
}

.twPc-divName a {
	color: inherit !important;
}

.twPc-divStats {
	margin-left: 11px;
	padding: 10px 0;
}

.twPc-Arrange {
	box-sizing: border-box;
	display: table;
	margin: 0;
	min-width: 100%;
	padding: 0;
	table-layout: auto;
}

ul.twPc-Arrange {
	list-style: outside none none;
	margin: 0;
	padding: 0;
}

.twPc-ArrangeSizeFit {
	display: table-cell;
	padding: 0;
	vertical-align: top;
}

.twPc-ArrangeSizeFit a:hover {
	text-decoration: none;
}

.twPc-StatValue {
	display: block;
	font-size: 18px;
	font-weight: 500;
	transition: color 0.15s ease-in-out 0s;
}

.twPc-StatLabel {
	color: #8899a6;
	font-size: 10px;
	letter-spacing: 0.02em;
	overflow: hidden;
	text-transform: uppercase;
	transition: color 0.15s ease-in-out 0s;
}

.well {
	background-color: white;
}

.well>h3 {
	min-width: 0;
	padding: 0;
	margin: 0;
	border: 0;
}

button.btn {
	background-color: black;
	border-color: black;
}

.delete-button {
	margin-right: 20px;
}

.schedule table {
	margin-left: 5%;
	text-align: center;
}

.schedule th {
	text-align: center;
	min-width: 100px;
}

#btn_write {
	float: right;
	margin-right: 100px;
	margin-top: 50px;
}
</style>
</head>

<body>
	<div class="navmenu navmenu-default navmenu-fixed-left offcanvas">
		<!--- Off Canvas Side Menu -->
		<div class="close" data-toggle="offcanvas" data-target=".navmenu">
			<span class="fa fa-close"></span>
		</div>

		<div class="add-margin"></div>

		<ul class="nav navmenu-nav">
			<!--- Menu -->
			<li><a href="index.html" class="page-scroll">Home</a></li>
			<li><a href="notice.html" class="page-scroll">공지사항</a></li>
			<li><a href="mento.html" class="page-scroll">멘토 신청</a></li>
			<li><a href="menteeSelect.html" class="page-scroll">멘티 신청</a></li>
			<li><a href="mentoroom.html" class="page-scroll">멘토방</a></li>
			<!-- <li><a href="question.html" class="page-scroll">문의사항</a></li> -->
			<li><a href="researchMento.html" class="page-scroll">설문조사</a></li>
			<li><a href="mypage.html" class="page-scroll">My Page</a></li>
			<li><a href="menteeSelect.html" class="page-scroll">관리자 멘토방</a></li>
			<li><a href="administrator_01.html" class="page-scroll">관리자
					페이지</a></li>
		</ul>
		<!--- End Menu -->
	</div>

	<div id="home">
		<div class="container text-center">
			<!-- Navigation -->
			<nav id="menu" data-toggle="offcanvas" data-target=".navmenu">
				<span class="fa fa-bars"></span>
			</nav>
		</div>

		<div class="container" style="margin-top: 5px;">
			<div class="row">
				<div id="user" class="col-md-12">
					<div class="panel panel-primary panel-table animated slideInDown">
						<div>
							<div>
								<center>
									<div class="content" style="color: black">
										<h4>M e n t o r R o o m</h4>
										<button type="button" class="btn btn-primary" id="delete">
											<a href="${R}user/selectTeam/${mentorRoom.id}"
												style="color: white">신청  </a>
										</button>
										<hr>
									</div>
								</center>

								<!-- code start -->
								<center>
									<div class="twPc-div">
										<a class="twPc-bg twPc-block"></a>
										<div>
											<a title="Mert Salih Kaplan" class="twPc-avatarLink"> <img
												src="img_main/team/mingood.jpg" class="twPc-avatarImg">
											</a>
											<div class="twPc-divUser">
												<div class="twPc-divName">
													<div class="twPc-button"></div>
												</div>
												<span> <a><span style="color: white">${mentorRoom.student.user.name }</span></a>
												</span>
											</div>
											<div class="twPc-divStats">
												<ul class="twPc-Arrange">
													<li class="twPc-ArrangeSizeFit"><a title="9.840 Tweet">
															<span class="twPc-StatLabel twPc-block">메일</span> <span
															class="twPc-StatValue">${mentorRoom.student.user.email }</span>
													</a></li>
													<li class="twPc-ArrangeSizeFit"><a
														title="885 Following"> <span
															class="twPc-StatLabel twPc-block">학년</span>
															${mentorRoom.student.grade}<span class="twPc-StatValue"></span>
													</a></li>

												</ul>
											</div>
										</div>
									</div>
								</center>
								<!-- code end -->
								</br>
								<center>
									<div style="color: black">
										<h5>스터디 내용</h5>
										<p style="width: 80%;">${mentorRoom.contents }</p>
										<hr>
										</br>
										<h3>멘토&멘티</h3>
										<%-- <c:forEach var="team" items="${ teamList }">
											<tr>
												<td>
												 <p>${ team.student.user.name }</p>
												 </td>
										</tr>
							            </c:forEach> --%>
										<hr>
									</div>
								</center>
							</div>
						</div>

						<div class="panel-body">
							<div class="tab-content">
								<center>
									<div role="tabpanel" class="tab-pane active" id="list">
										<table class="table table-striped table-bordered table-list"
											style="width: 80%; text-align: center;">
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
												<h3>멘토&멘티</h3>
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
												<%-- <tr class="ok">
													<td>${mentorRoom.student.user.userId }</td>
													<td>${mentorRoom.student.user.name }</td>
													<td>${mentorRoom.student.grade }학년</td>
													<td>멘토</td>
													<td>${mentorRoom.student.user.phoneNumber }</td>
													<td>${mentorRoom.student.user.email }</td>
												</tr> --%>
											</tbody>
										</table>
									</div>
									<!-- END id="list" -->
								</center>
								<div>
									<center>
										</br> </br>
										<h3>개인시간표</h3>
										<hr>
										<div class="schedule" style="padding-bottom: 40px;">
											<table style="width: 80%" class="table table-bordered">
												<thead>
													<tr>
														<th></th>
														<th>월</th>
														<th>화</th>
														<th>수</th>
														<th>목</th>
														<th>금</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<th>1교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>2교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>3교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>4교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>5교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>6교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>7교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>8교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<th>9교시</th>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</tbody>
											</table>
										</div>
									</center>
								</div>
							</div>
						</div>
					</div>
				</div>
</body>