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

<title>문의사항</title>

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
	<div class="container text-center" style="padding-top: 7%;">

		<form:form method="get" modelAttribute="pagination"
			class="form-inline mb5"
			style="float:right; margin-top:10px; margin-bottom:10px;">
			<form:hidden path="pg" value="1" />
			<form:select path="ob" class="form-control" itemValue="value"
				itemLabel="label" items="${ orderBy }" />&nbsp
				<form:select path="sb" class="form-control ml20" itemValue="value"
				itemLabel="label" items="${ searchBy }" />&nbsp
				<form:input path="st" class="form-control" placeholder="검색문자열" />&nbsp
				<button type="submit" class="btn btn-default">검색</button>&nbsp
				<c:if test="${ pagination.sb > 0 || pagination.ob > 0}">
				<a class="btn btn-default" href="noticeList?pg=1">검색취소</a>&nbsp
				</c:if>

			<div class="pull-right">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<div class="pull-right">
						<a class="btn btn-primary"
							href="${R}user/noticeCreate?${ pagination.queryString }">새글작성</a>
					</div>
				</sec:authorize>

			</div>
		</form:form>

		<table class="table table-bordered">
			<thead class="text-center">
				<tr>
					<th scope="col">No</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="question" items="${ list }">
					<tr
						data-url="questionView?id=${ question.id }&${ pagination.queryString }">
						<td class="text-center">${ question.no }</td>
						<td>${ question.title }</td>
						<td class="text-center">${ question.student.user.name }</td>
						<td class="text-center"><fmt:formatDate
								pattern="yyyy-MM-dd HH:mm" value="${ question.date }" /></td>
						<td class="text-center">${ question.hit }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<my:pagination pageSize="${ pagination.sz }"
			recordCount="${ pagination.recordCount }" />

	</div>

	<!-- Bootstrap core JavaScript -->
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