<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:url var="R" value="/" />

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>멘토 신청하는 뷰</title>

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
	<tiles:insertAttribute name="menu" />

	<div class="container-fluid p-0">

		<div align="center" style="padding: 5%;">
			<div style="width: 55%">
				<h2>멘토 신청</h2>
				<hr />
				<form:form method="post" modelAttribute="mentorApply"
					enctype="multipart/form-data">
					<fieldset disabled>
						<div class="form-group">
							<label for="disabledTextInput" style="float: left;">이름</label>
							<form:input path="student.user.name" name="student.user.name"
								type="text" id="disabledTextInput" class="form-control" />
						</div>
					</fieldset>
					<fieldset disabled>
						<div class="form-group">
							<label for="disabledTextInput" style="float: left;">학번</label>
							<form:input path="student.user.userId" name="student.user.userId"
								type="text" id="disabledTextInput" class="form-control" />
						</div>
					</fieldset>
					<fieldset disabled>
						<div class="form-group">
							<label for="disabledTextInput" style="float: left;">학년</label>
							<form:input path="student.grade" name="student.grade" type="text"
								id="disabledTextInput" class="form-control" />
						</div>
					</fieldset>
					<fieldset disabled>
						<div class="form-group">
							<label for="disabledTextInput" style="float: left;">연락처</label>
							<form:input path="student.user.phoneNumber"
								name="student.user.phoneNumber" type="text"
								id="disabledTextInput" class="form-control" />
						</div>
					</fieldset>
					<fieldset disabled>
						<div class="form-group">
							<label for="disabledTextInput" style="float: left;">email</label>
							<form:input path="student.user.email" name="student.user.email"
								type="text" id="disabledTextInput" class="form-control" />
						</div>
					</fieldset>
					<div class="form-group">
						<label for="exampleFormControlSelect1" style="float: left;">계좌번호</label>
						<form:select path="bankName" name="bankName" class="form-control"
							id="sell">
							<option>국민은행</option>
							<option>우리은행</option>
							<option>신한은행</option>
							<option>하나은행</option>
							<option>농협은행</option>
							<option>카카오뱅크</option>
						</form:select>
						<br />
						<form:input path="accountNum" name="accountNum" type="text"
							class="form-control" placeholder="'-'를 빼고 입력해주세요" />
					</div>

					<div class="form-group">
						<label class="form-control-label" for="formGroupExampleInput"
							style="float: left;">팀명</label>
						<form:input path="teamName" name="teamName" type="text"
							class="form-control" id="formGroupExampleInput" placeholder="" />
					</div>
					<div class="form-group">
						<label class="form-control-label" for="formGroupExampleInput"
							style="float: left;">주제</label>
						<form:input path="subject" name="subject" type="text"
							class="form-control" id="formGroupExampleInput" placeholder="" />
					</div>
					<div class="form-group">
						<label class="form-control-label" for="formGroupExampleInput"
							style="float: left;">스터디 목적</label>
						<form:textarea path="purpose" name="purpose" class="form-control"
							rows="5" id="comment"></form:textarea>
					</div>
					<div class="form-group">
						<label class="form-control-label" for="formGroupExampleInput"
							style="float: left;">스터디 내용(예상 결과물 포함)</label>
						<form:textarea path="contents" name="contents"
							class="form-control" rows="5" id="comment"></form:textarea>
					</div>
					<div class="form-group">
						<label class="form-control-label" for="formGroupExampleInput"
							style="float: left;">스터디 방법</label>
						<form:textarea path="method" name="method" class="form-control"
							rows="5" id="comment"></form:textarea>
					</div>
					<div class="form-group">
						<label class="form-control-label" for="formGroupExampleInput"
							style="float: left;">가능한 시간(매주 2시간 필수)</label>
						<form:input type="text" path="time" name="time"
							class="form-control" id="formGroupExampleInput" placeholder="" />
					</div>
					<div class="form-group">
						<label class="form-control-label" for="formGroupExampleInput"
							style="float: left;">해당 과목 성적(교과과정 아니라면 미입력)</label>
						<form:input type="text" path="grade" name="grade"
							class="form-control" id="formGroupExampleInput" placeholder="" />
					</div>

					<span class="min-chart" id="chart-sales" data-percent="56"><span
						class="percent"></span></span>


					<div class="form-group">
						<label for="exampleFormControlFile1" style="float: left;">자격
							증명 업로드</label> <input type="file" name="fileUpload"
							class="form-control-file" multiple> <br />
					</div>
					

					<div class="btn-group" role="group" aria-label="Basic example">
						<button type="submit" class="btn btn-primary" style="color: white">확인</button>
						<button type="button" class="btn btn-primary" style="color: white">초기화</button>
						<button type="button" class="btn btn-primary" style="color: white">취소</button>
					</div>

				</form:form>
			</div>
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