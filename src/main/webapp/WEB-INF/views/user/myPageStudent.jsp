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

<title>My page</title>

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
					href="#experience">M2</a></li>
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
				</sec:authorize>

			</ul>
		</div>
	</nav>
	<!-- 메뉴바 끝 -->

	<div style="width: 60%; margin: auto; margin-bottom: 30px;">
		<h1 style="padding-top: 5%;" align="center">MY PAGE</h1>
		<form:form method="post" modelAttribute="user" name="myPageForm"
			action="myPageStudent" enctype="multipart/form-data">
			<div class="text-center">

				<!-- 사진 이미지 자리 	-->
				<img src="image?userId=${user.id}" class="img-responsive"
					style="border-radius: 5px; width: 30%; height: 30%;"
					alt="이미지가 없습니다."> <input type="file" name="fileUpload"
					class="form-control-file" multiple> <br />

				<fieldset disabled>
					<label style="float: left;">ID(학번)</label>
					<form:input path="userId" class="form-control" />
					<br />
				</fieldset>

				<form:input type="hidden" path="userId" />
				<form:input type="hidden" path="id" />
				<form:input type="hidden" path="authority" />
				<form:input type="hidden" path="name" />
				<form:input type="hidden" path="password" />
				<form:input type="hidden" path="job" />

				<label class="form-control-label" style="float: left;">새
					비밀번호</label> <input type="password" class="form-control" name="newPassword"
					placeholder="영문 숫자조합 10자 이상" onkeyup="verify.check()"> <br />

				<label class="form-control-label" style="float: left;">새
					비밀번호 확인</label> <input type="password" class="form-control"
					name="password2" placeholder="영문 숫자조합 10자 이상"
					onkeyup="verify.check()">

				<!-- 새 비밀번호 일치불일치 확인 자바스크립트  -->
				<div id="password_result" style="float: left"></div>
				<br /> <br />

				<fieldset disabled>
					<label style="float: left;">이름</label>
					<form:input path="name" class="form-control" />
					<br />
				</fieldset>

				<label class="form-control-label" style="float: left;">e-mail</label>
				<form:input path="email" class="form-control" />
				<br /> <label class="form-control-label" style="float: left;">핸드폰
					번호</label>
				<form:input path="phoneNumber" class="form-control" />
				<br />

				<!-- 학생인경우  -->

				<fieldset disabled>
					<label class="form-control-label" style="float: left;">권한</label> <input
						class="form-control" value="${ user.authority == 1 ? "
						멘티" : (user.authority== 2 ? "멘토" : "관리자") }" />
				</fieldset>

				<%-- 
				<label style="float: left;">학과</label> 
					<form:select path="student.department.id" class="form-control w200"
						itemValue="id" itemLabel="depName"
						items="${ departments }" /> <br />
 --%>
				<br />
				<button type="submit" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-default">취소</button>

			</div>
		</form:form>
	</div>


	<!-- Bootstrap core JavaScript -->

	<!-- 새 비밀번호 일치불일치 확인 자바스크립트  -->
	<script type="text/javascript">
		function verifynotify(field1, field2, result_id, match_html,
				nomatch_html) {
			this.field1 = field1;
			this.field2 = field2;
			this.result_id = result_id;
			this.match_html = match_html;
			this.nomatch_html = nomatch_html;

			this.check = function() {
				// Make sure we don't cause an error
				// for browsers that do not support getElementById
				if (!this.result_id) {
					return false;
				}
				if (!document.getElementById) {
					return false;
				}
				r = document.getElementById(this.result_id);
				if (!r) {
					return false;
				}

				if (this.field1.value != ""
						&& this.field1.value == this.field2.value) {
					r.innerHTML = this.match_html;
				} else {
					r.innerHTML = this.nomatch_html;
				}
			}
		}

		function verifyInput() {
			verify = new verifynotify();
			verify.field1 = document.myPageForm.newPassword;
			verify.field2 = document.myPageForm.password2;
			verify.result_id = "password_result";
			verify.match_html = "";
			verify.nomatch_html = "<span style=\"color:red\">비밀번호 불일치<\/span>";

			// Update the result message
			verify.check();
		}

		// Multiple onload function created by: Simon Willison
		// http://simonwillison.net/2004/May/26/addLoadEvent/
		function addLoadEvent(func) {
			var oldonload = window.onload;
			if (typeof window.onload != 'function') {
				window.onload = func;
			} else {
				window.onload = function() {
					if (oldonload) {
						oldonload();
					}
					func();
				}
			}
		}

		addLoadEvent(function() {
			verifyInput();
		});
	</SCRIPT>

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
</body>

</html>