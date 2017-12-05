<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:url var="R" value="/" />

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
			<li><a href="${R}logout_processing" class="page-scroll"><button
						type="button" class="btn btn-outline-light btn-sm">로그아웃</button></a>
				<hr /></li>

			<li class="nav-item"><a class="nav-link js-scroll-trigger"
				href="${R}user/index">home</a></li>
			<li class="nav-item"><a class="nav-link js-scroll-trigger"
				href="${R}user/noticeList">공지사항</a></li>
			<c:if test="${ optionList.mentorActive == 'on' }">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/mentorApply">멘토 신청</a></li>
			</c:if>
			<c:if test="${ optionList.menteeActive == 'on' }">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/menteeSelect">멘티 신청</a></li>
			</c:if>
			<li class="nav-item"><a class="nav-link js-scroll-trigger"
				href="${R}user/myMentorRoom">멘토방</a></li>
			<li class="nav-item"><a class="nav-link js-scroll-trigger"
				href="${R}user/questionList">문의사항</a></li>
			<c:if test="${ optionList.surveyActive == 'on' }">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}user/surveyApply">설문조사</a></li>
			</c:if>
			<li class="nav-item"><a class="nav-link js-scroll-trigger"
				href="${R}user/myPage">My Page</a>
				<hr /></li>

			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}admin/index"><button type="button"
							class="btn btn-outline-light btn-sm">관리자 페이지</button></a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}admin/allMentorRoom"><button type="button"
							class="btn btn-outline-light btn-sm">관리자 멘토방</button></a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="${R}admin/adminReport"><button type="button"
							class="btn btn-outline-light btn-sm">보고서 관리</button></a></li>
			</sec:authorize>

		</ul>
	</div>
</nav>
<!-- 메뉴바 끝 -->