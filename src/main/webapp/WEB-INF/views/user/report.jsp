<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:url var="R" value="/" />
<% pageContext.setAttribute("newLineChar", "\n"); %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>User Index</title>

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

      <div align="center" style="padding: 10%;">
         <div style="width: 55%">
            <h2>보고서 제출</h2>
            <hr />


            <form:form method="post" modelAttribute="report" enctype="multipart/form-data">
               <form style="padding: 10%;">
                  <div class="form-group">
                     <label for="exampleFormControlSelect1" style="float: left;">스터디
                        날짜</label> <br />
                     <form:select path="week" name="week" class="form-control"
                        id="month">
                        <option value="1">1주차</option>
                        <option value="2">2주차</option>
                        <option value="3">3주차</option>
                        <option value="4">4주차</option>
                        <option value="5">5주차</option>
                        <option value="6">6주차</option>
                        <option value="7">7주차</option>
                        <option value="8">8주차</option>
                        <option value="9">9주차</option>
                        <option value="10">10주차</option>
                        <option value="11">11주차</option>
                        <option value="12">12주차</option>
                        <option value="13">13주차</option>
                        <option value="14">14주차</option>
                        <option value="15">15주차</option>
                     </form:select>
                  </div>
                  <br />
                  <div class="form-group">
                  <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">참여 멘티</label>
                     <form:input path="attendedMentee" name="attendedMentee" class="form-control"
                        id="formGroupExampleInput" placeholder="" />                  
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">모임 장소</label>
                     <form:input path="place" name="place" class="form-control"
                        id="formGroupExampleInput" placeholder="" />
                  </div>
                  <div class="form-group">
                     <label class="form-control-label" for="formGroupExampleInput"
                        style="float: left;">주요 내용</label>
                     <form:textarea path="contents" name="contents"
                        class="form-control" rows="5" id="comment"></form:textarea>
                  </div>

                  <span class="min-chart" id="chart-sales" data-percent="56"><span
                     class="percent"></span></span>


                  <div class="form-group">
                     <label for="exampleFormControlFile1" style="float: left;">스터디
                        증명 사진</label> <br /> <input type="file" name="fileUpload" class="form-control-file"
                        multiple>
                  </div>


                  <div class="btn-group" role="group" aria-label="Basic example"
                     style="padding-bottom: 20%">
                     <button type="submit" class="btn btn-secondary"
                        style="color: black">확인</button>
                     <button type="button" class="btn btn-secondary"
                        style="color: black"
                        onClick="location.href='report'">초기화</button>
                     <button type="button" class="btn btn-secondary"
                        style="color: black; cursor: pointer"
                        onClick="location.href='myMentorRoom'">취소</button>
                  </div>


               </form>
            </form:form>

         </div>
      </div>
   </div>

</body>
</html>