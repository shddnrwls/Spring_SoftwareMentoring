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

<title>Notice Edit</title>

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

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css"
	rel="stylesheet">

</head>

<body id="page-top">
	<!-- 메뉴바 -->
	<tiles:insertAttribute name="menu" />

	<div class="container text-center"
		style="padding-top: 10%; padding-bottom: 10%;">

		<form:form method="post" modelAttribute="noticeModel">

			<form:input path="title" class="form-control"
				placeholder="제목을 입력해주세요." />
			<form:errors path="title" class="error" />

			<br />

			<div id="summernote">${ noticeModel.content }</div>
			<form:errors path="content" class="error" />
			<input type="hidden" name="content" />

		</form:form>

		<br /> <br />

		<div id="buttons">
			<a class="btn btn-success" onclick="save()">저장</a> <a
				class="btn btn-default"
				href="${R}user/noticeList?${ pagination.queryString }">목록으로</a>
		</div>

	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="${R}res/js/jquery.min.js"></script>
	<script src="${R}res/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${R}res/js/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${R}res/js/resume.min.js"></script>
	<script src="${R}res/js/notice.js"></script>

	<script src="https://use.fontawesome.com/25b35a2279.js"></script>

	<!-- include summernote css/js-->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script>

	<script>
		$(document).ready(function() {
			$('#summernote').summernote({
				height : 500
			});
		});
		function save() {
			var s = $('#summernote').summernote('code');
			$('input[name=content]').val(s);
			$('form').submit();
		}
	</script>

</body>

</html>

