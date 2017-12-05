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
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Admin Report</title>

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

<script>
 function OnloadImg(url){
  var img=new Image();
  img.src=url;
  var img_width=img.width;
  var win_width=img.width;
  var height=img.height;
  var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+height+', menubars=no, scrollbars=auto');
  OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
 }
</script>

</head>
<body>

   <tiles:insertAttribute name="menu" />
   
   <div class="container-fluid p-5">
   
   <div>
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
                     <a class="btn btn-light" href="adminReport?pg=1">검색취소</a>
                  </c:if>
               </form:form>
            </div>
            <br />
             
            <table class="table">
               <thead>
                  <tr>
                     <th><label class="form-check-label"> <input
                           class="form-check-input" type="checkbox" id="allCheck" value="">All
                     </label></th>
                     <th>날짜</th>
                     <th>학번</th>
                     <th>이름</th>
                     <th>학과</th>
                     <th>참여멘티</th>
                     <th>연도</th>
                     <th>보고서</th>
                  </tr>
               </thead>
               <tbody>
               
               
                  <c:forEach var="pastReport" items="${ pastReportList }">
                     <tr>
                        <td><label class="form-check-label"> <input
                              class="form-check-input" type="checkbox" id="inlineCheckbox1"
                              value="">
                              <td>${ pastReport.week } 주차</td>
                              <td>${ pastReport.mentorId }</td>
                              <td>${ pastReport.mentor }</td>
                              <td>${ pastReport.depName }</td>
                              <td>${ pastReport.attendedMentee }</td>
                              <td>${ pastReport.year }</td>
                              <td><a href="${R}admin/excelView/${pastReport.id}"><button
                                       type="submit" class="btn btn-primary btn-sm">▼</button></a>
                                 <a href="readTeamImage?pastReportId=${ pastReport.id }" target="_blank" BORDER="0">
                                    <button type="button" class="btn btn-primary btn-sm">img</button></a></td>                                    
                     </tr>
                  </c:forEach>
               </tbody>
            </table>

         <div style="margin: 0 auto" ; align="center" ; padding="5px";>
                  <my:pagination pageSize="${ pagination.sz }"
                     recordCount="${ pagination.recordCount }" />
               </div>

            <div class="pull-right">
               <a href="${R}admin/excelView"><button type="submit"
                     class="btn btn-success">선택 항목 다운로드</button></a>
            </div>
         </div>
   </div>
   
   

</body>
</html>