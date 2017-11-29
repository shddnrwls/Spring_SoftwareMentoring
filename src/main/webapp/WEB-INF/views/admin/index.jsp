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
			<li class="nav-item"><a class="nav-link" id="second-tab"
				data-toggle="tab" href="#second" role="tab" aria-controls="second"
				aria-selected="false">보고서</a></li>
			<li class="nav-item"><a class="nav-link" id="third-tab"
				data-toggle="tab" href="#third" role="tab" aria-controls="third"
				aria-selected="false">설문조사 수정</a></li>
			<li class="nav-item"><a class="nav-link" id="fourth-tab"
				data-toggle="tab" href="#fourth" role="tab" aria-controls="fourth"
				aria-selected="false">설문조사 결과</a></li>
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

					<div class="pull-right">
						<button type="button" class="btn btn-success" data-toggle="modal"
							data-target="#myModal2">회원 엑셀 업로드</button>
						<button type="submit" class="btn btn-primary" data-confirm-delete>선택
							회원 삭제</button>
					</div>

				</form>

				<!-- Modal -->
				<div class="modal" id="myModal2" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true"
					style="color: black">
					<form:form action="excelUpload" method="post"
						enctype="multipart/form-data">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h3 class="modal-title" id="myModalLabel">EXCEL 파일을 등록하세요.</h3>
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

			<!-- 두번째 탭 -->
			<div class="tab-pane fade" id="second">
				<br />
				<div class="pull-right">
					<div class="input-group">
						<div class="input-group-btn search-panel">
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown">
								<span id="search_concept">필터</span> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#">날짜</a></li>
								<li><a href="#">학번</a></li>
								<li><a href="#">학년</a></li>
								<li><a href="#">학과</a></li>
								<li><a href="#">All</a></li>
							</ul>
						</div>
						<input type="hidden" name="search_param" value="all"
							id="search_param"> <input type="text"
							class="form-control" name="x" placeholder="Search Bar"> <span
							class="input-group-btn">
							<button class="btn btn-primary" type="button">검색</button>
						</span>
					</div>
				</div>

				<table class="table">
					<thead>
						<tr>
							<th><label class="form-check-label"> <input
									class="form-check-input" type="checkbox" id="allCheck" value="">All
							</label></th>
							<th>날짜</th>
							<th>학번</th>
							<th>이름</th>
							<th>학년</th>
							<th>학과</th>
							<th>보고서</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="report" items="${ reportList }">
							<tr>
								<td><label class="form-check-label"> <input
										class="form-check-input" type="checkbox" id="inlineCheckbox1"
										value="">
										<td>${ report.week }</td>
										<td>${ report.mentorRoom.student.user.userId }</td>
										<td>${ report.mentorRoom.student.user.name }</td>
										<td>${ report.mentorRoom.student.grade }</td>
										<td>${ report.mentorRoom.student.department.depName }</td>
										<td><a href="${R}admin/excelView/${report.id}"><button
													type="submit" class="btn btn-primary btn-sm">▼</button></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="pull-right">
					<a href="${R}admin/excelView"><button type="submit"
							class="btn btn-success">선택 항목 다운로드</button></a>
				</div>

			</div>

			<!-- 세번째 탭 -->
			<div class="tab-pane fade" id="third">
				<br>
				<!-- 멘토 문항 수정 -->
				<div>
					<h3 style="float: left;">&nbsp&nbsp멘토</h3>
					<br>
					<button type="button" class="btn btn-info"
						style="float: left; margin-left: 1%;">미리보기</button>
					<br>
					<table id="table_mento" class="table">
						<thead>
							<td style="width: 60%;">문항</td>
							<td style="width: 10%;">답변형식</td>
							<td style="width: 10%;"></td>
						</thead>
						<tr>
							<td><input type="text" class="form-control"
								id="formGroupExampleInput" value="1. 멘티들이 성실하게 임하였나요?">

								<div class="div_option">
									<br>
									<table id="table_option"
										style="width: 40%; background-color: rgba(255, 255, 255, 0)">
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="보통이다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
									</table>
									<button id="addTR_option"
										style="color: black; margin: 2%; float: left;" type="button"
										class="btn btn-secondary">옵션 추가</button>

								</div></td>
							<td style="vertical-align: top;"><select
								class="form-control" id="changeBox" style="color: black;">
									<option value="1">선택</option>
									<option value="2" selected>객관식</option>
									<option value="3">주관식</option>
							</select></td>
							<td style="vertical-align: top; padding-top: 1.7%;"><span>
									항목 삭제 </span></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control"
								id="formGroupExampleInput" value="2. SM사업이 본인의 학습에 도움이 되었나요?">

								<div class="div_option">
									<br>
									<table id="table_option"
										style="width: 40%; background-color: rgba(255, 255, 255, 0)">
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="보통이다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
									</table>
									<button id="addTR_option"
										style="color: black; margin: 2%; float: left;" type="button"
										class="btn btn-secondary">옵션 추가</button>

								</div></td>
							<td style="vertical-align: top;"><select
								class="form-control" id="changeBox" style="color: black;">
									<option value="1">선택</option>
									<option value="2" selected>객관식</option>
									<option value="3">주관식</option>
							</select></td>
							<td style="vertical-align: top; padding-top: 1.7%;"><span>
									항목 삭제 </span></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control"
								id="formGroupExampleInput" value="3. 프로그램 개선을 위한 의견을 적어주세요.">

								<div class="div_option">
									<br>
									<div class="form-check" style="float: left;">
										<label class="form-check-label"><input
											class="form-check-input" type="radio" name="exampleRadios"
											id="exampleRadios1" value="option1" checked>&nbsp단답형</label><br>
										<label class="form-check-label"><input
											class="form-check-input" type="radio" name="exampleRadios"
											id="exampleRadios1" value="option1">&nbsp장문형</label>
									</div>
								</div></td>
							<td style="vertical-align: top;"><select
								class="form-control" id="changeBox" style="color: black;">
									<option value="1">선택</option>
									<option value="2">객관식</option>
									<option value="3" selected>주관식</option>
							</select></td>
							<td style="vertical-align: top; padding-top: 1.7%;"><span>
									항목 삭제 </span></td>
						</tr>

					</table>

					<button id="addTR_mento"
						style="color: black; float: left; margin-left: 3%; margin-bottom: 5%;"
						type="button" class="btn btn-warning">질문 추가</button>
				</div>

				<br>
				<hr align="center" style="border: solid 1.3px #FFFFFF; width: 90%;">

				<!-- 멘티 문항 수정 -->
				<div style="padding: 3%;">
					<h3 style="float: left;">&nbsp&nbsp멘티</h3>
					<br>
					<button type="button" class="btn btn-info"
						style="float: left; margin-left: 1%;">미리보기</button>
					<br>
					<table id="table_mento" class="table">
						<thead>
							<td style="width: 60%;">문항</td>
							<td style="width: 10%;">답변형식</td>
							<td style="width: 10%;"></td>
						</thead>
						<tr>
							<td><input type="text" class="form-control"
								id="formGroupExampleInput" value="1. 멘토의 지도 방향이 본인에게 적절했나요?">

								<div class="div_option">
									<br>
									<table id="table_option"
										style="width: 40%; background-color: rgba(255, 255, 255, 0)">
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="보통이다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
									</table>
									<button id="addTR_option"
										style="color: black; margin: 2%; float: left;" type="button"
										class="btn btn-secondary">옵션 추가</button>

								</div></td>
							<td style="vertical-align: top;"><select
								class="form-control" id="changeBox" style="color: black;">
									<option value="1">선택</option>
									<option value="2" selected>객관식</option>
									<option value="3">주관식</option>
							</select></td>
							<td style="vertical-align: top; padding-top: 1.7%;"><span>
									항목 삭제 </span></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control"
								id="formGroupExampleInput" value="2. SM사업이 본인의 학습에 도움이 되었나요?">

								<div class="div_option">
									<br>
									<table id="table_option"
										style="width: 40%; background-color: rgba(255, 255, 255, 0)">
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="아니다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="보통이다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
										<tr>
											<td><input class="form-check-input" type="radio"
												name="inlineRadioOptions" id="inlineRadio1" value="option1"></td>
											<td><input type="text" class="form-control"
												id="formGroupExampleInput" placeholder="옵션명" value="매우 그렇다"
												style="margin: 2%;"></td>
											<td style="vertical-align: middle;"><span>
													&nbsp&nbsp 삭제 </span></td>
										</tr>
									</table>
									<button id="addTR_option"
										style="color: black; margin: 2%; float: left;" type="button"
										class="btn btn-secondary">옵션 추가</button>

								</div></td>
							<td style="vertical-align: top;"><select
								class="form-control" id="changeBox" style="color: black;">
									<option value="1">선택</option>
									<option value="2" selected>객관식</option>
									<option value="3">주관식</option>
							</select></td>
							<td style="vertical-align: top; padding-top: 1.7%;"><span>
									항목 삭제 </span></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control"
								id="formGroupExampleInput" value="3. 프로그램 개선을 위한 의견을 적어주세요.">

								<div class="div_option">
									<br>
									<div class="form-check" style="float: left;">
										<label class="form-check-label"><input
											class="form-check-input" type="radio" name="exampleRadios"
											id="exampleRadios1" value="option1" checked>&nbsp단답형</label><br>
										<label class="form-check-label"><input
											class="form-check-input" type="radio" name="exampleRadios"
											id="exampleRadios1" value="option1">&nbsp장문형</label>
									</div>
								</div></td>
							<td style="vertical-align: top;"><select
								class="form-control" id="changeBox" style="color: black;">
									<option value="1">선택</option>
									<option value="2">객관식</option>
									<option value="3" selected>주관식</option>
							</select></td>
							<td style="vertical-align: top; padding-top: 1.7%;"><span>
									항목 삭제 </span></td>
						</tr>

					</table>

					<button id="addTR_mento"
						style="color: black; float: left; margin-left: 3%;" type="button"
						class="btn btn-warning">질문 추가</button>
				</div>
				<br>
				<hr align="center" style="border: solid 1.3px #FFFFFF; width: 90%;">
				<center>
					<div class="btn-group" role="group" aria-label="Basic example"
						style="padding-bottom: 20%">
						<button type="button" class="btn btn-secondary"
							style="color: black">등록</button>
						<button type="button" class="btn btn-secondary"
							style="color: black">초기화</button>
						<button type="button" class="btn btn-secondary"
							style="color: black">취소</button>
					</div>
				</center>

			</div>

			<!-- 네번째 탭 -->
			<div class="tab-pane fade" id="fourth">
				<br>
				<div>
					<button type="button" class="btn btn-info"
						style="color: white; float: right;">내려받기</button>


					<select class="form-control" id=""
						style="color: black; float: left; width: 20%; margin-bottom: 1%;">
						<option value="1">지난학기 설문조사</option>
						<option value="2">2017-1</option>
						<option value="3">2016-2</option>
						<option value="3">2016-1</option>
					</select>
					<table class="table table-bordered" style="width: 100%;">
						<thead>
							<tr>
								<td style="width: 20%;"></td>
								<td style="width: 40%;">멘토</td>
								<td style="width: 40%;">멘티</td>
							</tr>
						</thead>
						<tr>
							<td>총인원</td>
							<td>7</td>
							<td>27</td>
						</tr>
						<tr>
							<td>응답인원</td>
							<td>5</td>
							<td>24</td>
						</tr>
						<tr>
							<td>응답률</td>
							<td>71%</td>
							<td>88%</td>
						</tr>
					</table>

					<div>
						<!-- 멘토 결과!!!!!!!!!!!!!!!!!! -->
						<h3 style="float: left;">&nbsp&nbsp멘토</h3>
					</div>
					<br> <br>
					<div style="margin: 3%;">
						<span style="float: left;">1. 멘티들이 성실하게 임하였나요?</span> <br>
						<div class="vGraph" style="width: 100%;">
							<ul>
								<li><span class="gTerm">매우아니다</span><span class="gBar"
									style="height: 0%"><span>0</span></span></li>
								<li><span class="gTerm">아니다</span><span class="gBar"
									style="height: 14%"><span>1</span></span></li>
								<li><span class="gTerm">보통이다</span><span class="gBar"
									style="height: 28%"><span>2</span></span></li>
								<li><span class="gTerm">그렇다</span><span class="gBar"
									style="height: 42%"><span>3</span></span></li>
								<li><span class="gTerm">매우 그렇다</span><span class="gBar"
									style="height: 14%"><span>1</span></span></li>
							</ul>
						</div>
					</div>
					<br> <br>
					<div style="margin: 3%;">
						<span style="float: left;">2. SM사업이 본인의 학습에 도움이 되었나요?</span> <br>
						<div class="vGraph" style="width: 100%;">
							<ul>
								<li><span class="gTerm">매우아니다</span><span class="gBar"
									style="height: 0%"><span>0</span></span></li>
								<li><span class="gTerm">아니다</span><span class="gBar"
									style="height: 14%"><span>1</span></span></li>
								<li><span class="gTerm">보통이다</span><span class="gBar"
									style="height: 14%"><span>1</span></span></li>
								<li><span class="gTerm">그렇다</span><span class="gBar"
									style="height: 57%"><span>4</span></span></li>
								<li><span class="gTerm">매우 그렇다</span><span class="gBar"
									style="height: 14%"><span>1</span></span></li>
							</ul>
						</div>
					</div>
					<br> <br>
					<div style="margin: 3%;">
						<span style="float: left;">3. 프로그램 개선을 위한 의견을 적어주세요.</span> <br>
						<br>
						<table class="table table-bordered" style="text-align: left;">
							<tr>
								<td>멘티들이 적극적으로 참여해줘서 좋았습니다. 다음학기도 신청하려 합니다!!</td>
							</tr>
							<tr>
								<td>지원금을 올려주세요!</td>
							</tr>
							<tr>
								<td>1주정도는 못모여도 봐주세요 ㅠㅠ</td>
							</tr>
							<tr>
								<td>사진촬영보다 동영상촬영은 어떤가요?
							</tr>
						</table>
					</div>

					<hr align="center"
						style="border: solid 1.3px #FFFFFF; width: 90%; margin-top: 5%; margin-bottom: 5%;">

					<!-- 멘티 결과!!!!!!!!!!!!!!!!!! -->
					<h3 style="float: left;">&nbsp&nbsp멘티</h3>
				</div>
				<br> <br>
				<div style="margin: 3%;">
					<span style="float: left;">1. 멘토의 지도 방향이 본인에게 적절했나요?</span> <br>
					<div class="vGraph" style="width: 100%;">
						<ul>
							<li><span class="gTerm">매우아니다</span><span class="gBar"
								style="height: 3%"><span>1</span></span></li>
							<li><span class="gTerm">아니다</span><span class="gBar"
								style="height: 7%"><span>2</span></span></li>
							<li><span class="gTerm">보통이다</span><span class="gBar"
								style="height: 25%"><span>7</span></span></li>
							<li><span class="gTerm">그렇다</span><span class="gBar"
								style="height: 40%"><span>11</span></span></li>
							<li><span class="gTerm">매우 그렇다</span><span class="gBar"
								style="height: 22%"><span>6</span></span></li>
						</ul>
					</div>
				</div>
				<br> <br>
				<div style="margin: 3%;">
					<span style="float: left;">2. SM사업이 본인의 학습에 도움이 되었나요?</span> <br>
					<div class="vGraph" style="width: 100%;">
						<ul>
							<li><span class="gTerm">매우아니다</span><span class="gBar"
								style="height: 3%"><span>1</span></span></li>
							<li><span class="gTerm">아니다</span><span class="gBar"
								style="height: 3%"><span>1</span></span></li>
							<li><span class="gTerm">보통이다</span><span class="gBar"
								style="height: 29%"><span>8</span></span></li>
							<li><span class="gTerm">그렇다</span><span class="gBar"
								style="height: 44%"><span>12</span></span></li>
							<li><span class="gTerm">매우 그렇다</span><span class="gBar"
								style="height: 18%"><span>5</span></span></li>
						</ul>
					</div>
				</div>
				<br> <br>
				<div style="margin: 3%;">
					<span style="float: left;">3. 프로그램 개선을 위한 의견을 적어주세요.</span> <br>
					<br>
					<table class="table table-bordered" style="text-align: left;">
						<tr>
							<td>멘토의 수업진행을 따라가기 어려웠습니다ㅠㅠ 다음부터는 좀 더 세분화된 난이도를 미리 공지해주세요</td>
						</tr>
						<tr>
							<td>멘티도 일정 성적 이상이되면 지원금을 주셨으면 좋겠어요</td>
						</tr>
						<tr>
							<td>처음 신청할때 보았던 스터디방향과 많이 달랐습니다. 다음부터는 가급적 동일했으면 합니다.</td>
						</tr>
						<tr>
							<td>동시에 여러 멘토링을 하고 싶어요!
						</tr>
					</table>
				</div>
				<hr align="center"
					style="border: solid 1.3px #FFFFFF; width: 90%; margin-top: 5%; margin-bottom: 5%;">
			</div>
			<!-- 네번째 탭 끝 -->

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
								<td><a href="${R}admin/mentorApply/${mentorApply.id}">
										${ mentorApply.student.user.name }</a></td>
								<td><a href="${R}admin/success/${mentorApply.id}"><button
											type="button" class="btn btn-primary" id="success">승인</button></a>
									<a href="${R}admin/delete/${mentorApply.id}"><button
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