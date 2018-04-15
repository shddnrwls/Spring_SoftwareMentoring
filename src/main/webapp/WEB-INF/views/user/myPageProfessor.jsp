<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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

<!-- 우리가 만든 CSS -->
<link href="${R}res/css/imgShape.css" rel="stylesheet">

</head>

<body id="page-top">
	<!-- 메뉴바 -->
	<tiles:insertAttribute name="menu" />
	<div style="width: 60%; margin: auto; margin-bottom: 30px;">
		<h1 style="padding-top: 5%;" align="center">MY PAGE</h1>
		<form:form method="post" modelAttribute="professor" name="myPageForm"
			action="myPageProfessor" enctype="multipart/form-data">
			<div class="text-center">

				<!-- 사진 이미지 자리    -->
				<img class="mentor" src="image?userId=${professor.user.id}"
					class="img-responsive" alt="이미지가 없습니다."> <input type="file"
					name="fileUpload" class="form-control-file" multiple> <br />

				<fieldset disabled>
					<label style="float: left;">ID(학번)</label>
					<form:input path="user.userId" class="form-control" />
					<br />
				</fieldset>

				<form:input type="hidden" path="id" />

				<form:input type="hidden" path="user.userId" />
				<form:input type="hidden" path="user.id" />
				<form:input type="hidden" path="user.authority" />
				<form:input type="hidden" path="user.name" />
				<form:input type="hidden" path="user.job" />

				<label class="form-control-label" style="float: left;">새
					비밀번호</label> <input type="password" class="form-control" name="newPassword"
					placeholder="영문 숫자조합 10자 이상" onkeyup="verify.check()"
					onblur="checkvalue()"> <br /> <label
					class="form-control-label" style="float: left;">새 비밀번호 확인</label> <input
					type="password" class="form-control" name="password2"
					placeholder="영문 숫자조합 10자 이상" onkeyup="verify.check()"
					onblur="checkvalue()">

				<!-- 새 비밀번호 일치불일치 확인 자바스크립트  -->
				<div id="password_result" style="float: left"></div>
				<br /> <br />

				<fieldset disabled>
					<label style="float: left;">이름</label>
					<form:input path="user.name" class="form-control" />
					<br />
				</fieldset>

				<label class="form-control-label" style="float: left;">e-mail</label>
				<form:input path="user.email" class="form-control" />
				<br /> <label class="form-control-label" style="float: left;">핸드폰
					번호</label>
				<form:input path="user.phoneNumber" class="form-control" />
				<br /> <label class="form-control-label" style="float: left;">연구실
					번호</label>
				<form:input path="labNumber" class="form-control" />

				<br /> <label class="form-control-label" style="float: left;">연구실
					전화번호</label>
				<form:input path="labPhoneNumber" class="form-control" />
				<br /> <br />
				<button type="submit" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-default">취소</button>

			</div>
		</form:form>
	</div>

	<!-- 새 비밀번호 일치불일치 확인 자바스크립트  -->
	<script src="${R}res/js/mypage.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${R}res/js/jquery.easing.min.js"></script>
	<script src="${R}res/js/jquery.min.js"></script>
	<script src="${R}res/js/bootstrap.bundle.min.js"></script>


	<!-- Custom scripts for this template -->
	<script src="${R}res/js/resume.min.js"></script>
	<script src="${R}res/js/notice.js"></script>

	<!-- Bootstrap core JavaScript -->
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