<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:url var="R" value="/" />

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Admin Index</title>

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

<link href="${R}res/css/adminKil.css" rel="stylesheet">

</head>

<body id="page-top">
	<!-- 메뉴바 -->
	<tiles:insertAttribute name="menu" />

	<div class="container-fluid p-5">

		<ul class="nav nav-tabs">

			<li class="nav-item"><a class="nav-link active" id="first-tab"
				data-toggle="tab" href="#first" role="tab" aria-controls="first"
				aria-selected="true">전체회원</a></li>
			<li class="nav-item"><a class="nav-link" id="third-tab"
				data-toggle="tab" href="#third" role="tab" aria-controls="third"
				aria-selected="false">설문조사 관리</a></li>
			<li class="nav-item"><a class="nav-link" id="five-tab"
				data-toggle="tab" href="#five" role="tab" aria-controls="five"
				aria-selected="false">게시판 설정</a></li>
			<li class="nav-item"><a class="nav-link" id="six-tab"
				data-toggle="tab" href="#six" role="tab" aria-controls="six"
				aria-selected="false">멘토 승인</a></li>
		</ul>

		<div class="tab-content">
			<!-- 첫번째 탭 -->
			<div class="tab-pane fade show active" id="first">
				<br />
				<div class="pull-right">
					<form:form method="get" modelAttribute="pagination"
						class="form-inline">
						<form:hidden path="pg" value="1" />
						<form:select path="ob" class="form-control" itemValue="value"
							itemLabel="label" items="${ orderBy }" />
						<form:select path="sb" class="form-control ml20" itemValue="value"
							itemLabel="label" items="${ searchBy }" />
						<form:input path="st" class="form-control" placeholder="검색문자열" />
						<button type="submit" class="btn btn-info">검색</button>
						<c:if test="${ pagination.sb > 0 || pagination.ob > 0}">
							<a class="btn btn-light" href="index?pg=1">검색취소</a>
						</c:if>
					</form:form>
				</div>
				<br />
				<form name="check"
					action="${R}admin/deleteUser?${ pagination.queryString }"
					method="post">
					<table class="table">
						<thead>
							<tr>
								<th>선택</th>
								<th>분류</th>
								<th>학번(교번)</th>
								<th>이름</th>
								<th>e-mail</th>
								<th>핸드폰 번호</th>
								<th>권한</th>

							</tr>
						</thead>
						<tbody>
							<c:forEach var="user" items="${ userList }">
								<tr>
									<td><input type="checkbox" name="deleteUserIds"
										value="${ user.id }" /></td>
									<td>${ user.job == 1 ? "학생" : (user.job == 2 ? "교수" : "직원") }</td>
									<td>${ user.userId }</td>
									<td>${ user.name }</td>
									<td>${ user.email }</td>
									<td>${ user.phoneNumber }</td>
									<td><input type="radio" name="${user.id}" value="1"
										onclick="changeRadio('${user.id}', '1', '${user.authority}', '${ pagination.queryString }');"
										${ user.authority == 1 ? "checked=checked" : "" }>멘티 <input
										type="radio" name="${user.id}" value="2"
										onclick="changeRadio('${user.id}', '2', '${user.authority}', '${ pagination.queryString }');"
										${ user.authority == 2 ? "checked=checked" : "" }>멘토 <input
										type="radio" name="${user.id}" value="3"
										onclick="changeRadio('${user.id}', '3', '${user.authority}', '${ pagination.queryString }');"
										${ user.authority == 3 ? "checked=checked" : "" }>관리자

									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div style="margin: 0 auto" ; align="center" ; padding="5px";>
						<my:pagination pageSize="${ pagination.sz }"
							recordCount="${ pagination.recordCount }" />
					</div>

					<!-- <input type='button' onclick='check_all();' value='모두 선택' /> 
                             <input type='button' onclick='uncheck_all();' value='모두 해제' /> -->

					<div class="btn-group pull-left" role="group"
						aria-label="Basic example">
						<button type="button" class="btn btn-success" data-toggle="modal"
							data-target="#myModal2">학생 업로드</button>&nbsp
						<button type="button" class="btn btn-success" data-toggle="modal"
							data-target="#myModal3">교수 업로드</button>&nbsp
						<button type="button" class="btn btn-success" data-toggle="modal"
							data-target="#myModal4">직원 업로드</button>
					</div>
					<div class="pull-right">
						<button type="submit" class="btn btn-primary" data-confirm-delete>선택
							회원 삭제</button>
					</div>

				</form>

				<!-- 학생 Modal -->
				<div class="modal" id="myModal2" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true"
					style="color: black">
					<form:form action="excelUpload" method="post"
						enctype="multipart/form-data">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h3 class="modal-title" id="myModalLabel">학생 엑셀 업로드</h3>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<input type="file" name="excelFile" class="form-control-file" />
								</div>

								<div class="modal-footer">
									<button type="submit" class="btn btn-success">업로드</button>
									<button type="button" class="btn btn-default"
										data-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>

				<!-- 교수 Modal -->
				<div class="modal" id="myModal3" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true"
					style="color: black">
					<form:form action="excelUploadPro" method="post"
						enctype="multipart/form-data">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h3 class="modal-title" id="myModalLabel">교수 엑셀 업로드</h3>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<input type="file" name="excelFile" class="form-control-file" />
								</div>

								<div class="modal-footer">
									<button type="submit" class="btn btn-success">업로드</button>
									<button type="button" class="btn btn-default"
										data-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>

				<!-- 직원 Modal -->
				<div class="modal" id="myModal4" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true"
					style="color: black">
					<form:form action="excelUploadEmp" method="post"
						enctype="multipart/form-data">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h3 class="modal-title" id="myModalLabel">직원 엑셀 업로드</h3>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<input type="file" name="excelFile" class="form-control-file" />
								</div>

								<div class="modal-footer">
									<button type="submit" class="btn btn-success">업로드</button>
									<button type="button" class="btn btn-default"
										data-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>

			</div>

			<!-- 세번째 탭 : 설문조사 등록 -->
			<div class="tab-pane fade" id="third">
				<div
					style="width: 60%; margin: auto; margin-bottom: 30px; margin-top: 30px;">
					<a href="https://www.google.com/intl/ko_kr/forms/about/"
						target="_blank"> <img src="../res/img/googleForm.jpg" />
					</a> <br />
					<h3>1. 이미지를 클릭하여 설문조사를 작성</h3>
					<h3>2. 작성한 설문지의 인터넷주소값(URL)을 아래에 입력.</h3>

					<br /> <br />

					<form:form method="post" modelAttribute="surveyURL"
						action="editSurveyURL">
						<label class="form-control-label" style="float: left;">멘티
							설문조사</label>
						<form:input path="menteeURL" class="form-control" />
						<br />
						<label class="form-control-label" style="float: left;">멘토
							설문조사</label>
						<form:input path="mentorURL" class="form-control" />
						<br />

						<button type="submit" class="btn btn-primary">수정</button>
					</form:form>

				</div>

			</div>
			<!-- 세번째 탭 끝 -->

			<!-- 다섯번째 탭 시작 -->
			<div class="tab-pane fade" id="five">
				<center>
					<form:form method="post" modelAttribute="updateAdminOption">
						<br />
						<br />
						<label><font size=4>멘토 신청</font></label>
						<div class="onoffswitch">
							<input type="checkbox" path="mentorActive" name="onoffswitch1"
								class="onoffswitch-checkbox" id="myonoffswitch1"
								${ optionList.mentorActive == 'on' ? 'checked' : '' } /> <label
								class="onoffswitch-label" for="myonoffswitch1"> <span
								class="onoffswitch-inner"></span>
							</label>
						</div>
						<br />

						<label><font size=4>멘티 신청</font></label>
						<div class="onoffswitch">
							<input type="checkbox" path="menteeActive" name="onoffswitch2"
								class="onoffswitch-checkbox" id="myonoffswitch2"
								${ optionList.menteeActive == 'on' ? 'checked' : '' } /> <label
								class="onoffswitch-label" for="myonoffswitch2"> <span
								class="onoffswitch-inner"></span>
							</label>
						</div>
						<br />

						<label><font size=4>설문조사</font></label>
						<div class="onoffswitch">
							<input type="checkbox" path="surveyActive" name="onoffswitch3"
								class="onoffswitch-checkbox" id="myonoffswitch3"
								${ optionList.surveyActive == 'on' ? 'checked' : '' } /> <label
								class="onoffswitch-label" for="myonoffswitch3"> <span
								class="onoffswitch-inner"></span>
							</label>
						</div>
						<br />

						<label><font size=4>최대멘티인원</font></label>
						<input type="text" name="menteeMaxNum" class="form-control"
							style="width: 60px; text-align: center;"
							value="${ optionList.menteeMaxNum }">
						<br />
						<br />
						<button type="submit" class="btn btn-primary">수정</button>
					</form:form>
				</center>
			</div>
			<!-- 다섯번째 탭 끝 -->

			<!-- 여섯번째 탭 시작  -->
			<div class="tab-pane fade" id="six">
				<table class="table">
					<thead>
						<tr>
							<th>이름</th>
							<th>승인</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="mentorApply" items="${ mentorList }">
							<tr>
								<td><a href="${R}admin/mentorApply?id=${mentorApply.id}">
										${ mentorApply.student.user.name }</a></td>
								<td><a href="${R}admin/success?id=${mentorApply.id}"><button
											type="button" class="btn btn-primary" id="success">승인</button></a>
									<a href="${R}admin/delete?id=${mentorApply.id}"><button
											type="button" class="btn btn-primary" id="delete">거부</button></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
			<!-- 여섯번째 탭 끝 -->
		</div>

	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="${R}res/js/jquery.min.js"></script>
	<script src="${R}res/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="${R}res/js/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="${R}res/js/resume.min.js"></script>

	<script src="${R}res/js/adminIndex.js"></script>

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