<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:url var="R" value="/" />

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MentorApply</title>

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

   <!-- Off Canvas Navigation
    ================================================== -->
   <div class="navmenu navmenu-default navmenu-fixed-left offcanvas">
      <!--- Off Canvas Side Menu -->
      <div class="close" data-toggle="offcanvas" data-target=".navmenu">
         <span class="fa fa-close"></span>
      </div>
      <div class="add-margin"></div>
      <ul class="nav navmenu-nav">
			<!--- Menu -->
			<li style="color: orange; font-size: 14pt"><sec:authentication property="user.name" /></li>
			<li><a href="${R}user/logout_processing" class="page-scroll">로그아웃</a></li>
			<li><a href="/" class="page-scroll">Home</a></li>
			<li><a href="notice.html" class="page-scroll">공지사항</a></li>
			<c:if test="${ optionList.mentorActive == 'on' }">
				<li><a href="${R}user/mentorApply" class="page-scroll">멘토 신청</a></li>
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
			<li><a href="${R}admin/index" class="page-scroll">관리자 페이지</a></li>
			<!--- End Menu -->
		</ul>
      <!--- End Menu -->
   </div>
   <!--- End Off Canvas Side Menu -->

   <!-- Home Section -->
   <div id="home">
      <div class="container text-center">
         <!-- Navigation -->
         <nav id="menu" data-toggle="offcanvas" data-target=".navmenu">
            <span class="fa fa-bars"></span>
         </nav>
         <div align="center">
            <div style="width: 55%">
               <h1>멘토 신청</h1>
               <hr />
               <form:form method="post" style="padding: 10%;" modelAttribute="mentorApply">

                  </br>
                  <fieldset disabled>
                     <div class="form-group">
                        <label for="disabledTextInput" style="float: left;">이름</label>
                        <form:input path="student.user.name" name="student.user.name" type="text" id="disabledTextInput"
                           class="form-control" />
                     </div>
                  </fieldset>
                  <fieldset disabled>
                     <div class="form-group">
                        <label for="disabledTextInput" style="float: left;">학번</label>
                        <form:input path="student.user.userId" name="student.user.userId" type="text" id="disabledTextInput"
                           class="form-control"  />
                     </div>
                  </fieldset>
                  <fieldset disabled>
                     <div class="form-group">
                        <label for="disabledTextInput" style="float: left;">학년</label>
                        <form:input path="student.grade" name="student.grade" type="text" id="disabledTextInput"
                           class="form-control"  />
                     </div>
                  </fieldset>
                  <fieldset disabled>
                     <div class="form-group">
                        <label for="disabledTextInput" style="float: left;">연락처</label>
                        <form:input path="student.user.phoneNumber" name="student.user.phoneNumber" type="text" id="disabledTextInput"
                           class="form-control"  />
                     </div>
                  </fieldset>
                  <fieldset disabled>
                     <div class="form-group">
                        <label for="disabledTextInput" style="float: left;">email</label>
                        <form:input path="student.user.email" name="student.user.email" type="text" id="disabledTextInput"
                           class="form-control"  />
                     </div>
                  </fieldset>
                  <div class="form-group">
                     <label for="exampleFormControlSelect1" style="float: left;">계좌번호</label>
                     <form:select path="bankName" name="bankName" class="form-control" id="sell">
                        <option>국민은행</option>
                        <option>우리은행</option>
                        <option>신한은행</option>
                        <option>하나은행</option>
                        <option>농협은행</option>
                        <option>카카오뱅크</option>
                     </form:select> <br /> 
                     <form:input path="accountNum" name="accountNum" type="text" class="form-control"
                        placeholder="'-'를 빼고 입력해주세요" />
                  </div>
                  
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">팀명</label> 
                        <form:input path="teamName" name="teamName" type="text"
                        class="form-control" id="formGroupExampleInput" placeholder=""/>
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">주제</label> <form:input path="subject" name="subject" type="text"
                        class="form-control" id="formGroupExampleInput" placeholder=""/>
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">스터디 목적</label>
                     <form:textarea path="purpose" name="purpose" class="form-control" rows="5" id="comment"></form:textarea>
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">스터디 내용(예상 결과물 포함)</label>
                     <form:textarea path="contents" name="contents" class="form-control" rows="5" id="comment"></form:textarea>
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">스터디 방법</label>
                     <form:textarea path="method" name="method" class="form-control" rows="5" id="comment"></form:textarea>
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">가능한 시간(매주 2시간 필수)</label> <form:input
                        type="text" path="time" name="time" class="form-control" id="formGroupExampleInput"
                        placeholder=""/>
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">해당 과목 성적(교과과정 아니라면 미입력)</label> <form:input
                        type="text" path="grade" name="grade" class="form-control" id="formGroupExampleInput"
                        placeholder=""/>
                  </div>

                  <span class="min-chart" id="chart-sales" data-percent="56"><span
                     class="percent"></span></span>


                  <div class="form-group">
                     <label for="exampleFormControlFile1" style="float: left;">자격
                        증명 업로드</label> <form:input path="file" name="file" type="file" class="form-control-file"
                        id="exampleFormControlFile1"/>
                  </div>

                  <div class="btn-group" role="group" aria-label="Basic example"
                     style="padding-bottom: 20%">
                     <button type="submit" class="btn btn-primary"
                        style="color: white">확인</button>
                     <button type="button" class="btn btn-primary"
                        style="color: white">초기화</button>
                     <button type="button" class="btn btn-primary"
                        style="color: white">취소</button>
                  </div>

               </form:form>
            </div>
         </div>



      </div>
   </div>

</body>

</html>