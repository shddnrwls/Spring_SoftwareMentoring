// 관리자 페이지 Tab 바뀌는 JS
$(function() {
	$('ul.nav-tabs a').click(function(e) {
		e.preventDefault()
		$(this).tab('show')
	});
});

$(function() {

	$("[data-url]").click(function() {
		var url = $(this).attr("data-url");
		location.href = url;
	})

	$("[data-confirm-delete]").click(function() {
		return confirm("선택하신 회원을 모두 삭제하시겠습니까?");
	})

})

function changeRadio(userId, authority, pastAuthority, pagination) {
	if (authority == pastAuthority)
		return;

	if (confirm("권한을 변경하시겠습니까?") == true) {
		location.href = "/mentoringNew/admin/changeAuthority?userId=" + userId
				+ "&authority=" + authority + "&" + pagination;
	} else {
		location.href = "index?" + pagination;
	}
	return;
}

// 검색 필터 반영하는 JS
$(document).ready(function(e) {
	$('.search-panel .dropdown-menu').find('a').click(function(e) {
		e.preventDefault();
		var param = $(this).attr("href").replace("#", "");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_param').val(param);
	});
});

// 보고서 탭 체크 박스 전체 선택 해제 JS
$("#allCheck").click(function() {
	if ($("#allCheck").prop("checked")) {
		$("input[type=checkbox]").prop("checked", true);
	} else {
		$("input[type=checkbox]").prop("checked", false);
	}
})

// 인혁: 멘토 항목 추가 삭제 JS
$(function() {
	$("#addTR_mento")
			.click(
					function() {
						var row = "<tr>";
						row += "<td><input type='text' class='form-control' id='formGroupExampleInput' placeholder='질문 내용'><div class='div_option'></div></td>";
						row += "<td style='vertical-align: top;'><select class='form-control' style='color:black; '><option value='1'>선택</option><option value='2'>객관식</option><option value='3'>주관식</option></select></td>'"
						row += "<td style='vertical-align: top; padding-top:1.7%;'><span> 항목 삭제 </span></td>";
						row += "</tr>";
						$("#table_mento").append(row);
					});
	$("#table_mento").on("click", "span", function() {
		$(this).closest("tr").remove();
	});
});

// 인혁: 멘티 항목 추가 삭제 JS
$(function() {
	$("#addTR_mentee")
			.click(
					function() {
						var row = "<tr>";
						row += "<td><input type='text' class='form-control' id='formGroupExampleInput' placeholder='질문 내용'></td>";
						row += "<td style='vertical-align: middle;'><select class='form-control' style='color:black; '><option value='1'>선택</option><option value='2'>객관식</option><option value='3'>주관식</option></select></td>'"
						row += "<td style='vertical-align: middle;'><span> 항목 삭제 </span></td>";
						row += "</tr>";
						$("#table_mentee").append(row);
					});
	$("#table_mentee").on("click", "span", function() {
		$(this).closest("tr").remove();
	});
});

// 인혁: (옵션수정) 처음 객관식 or 주관식을 선택했을 때
$(function() {
	$(".form-control")
			.change(
					function() {
						var selectNum = $(".form-control option:selected")
								.val();

						if (selectNum == 2) {
							var row = "<br><table id='table_option' style='width:40%; background-color:rgba(255, 255, 255, 0)'>";
							row += "</table>"
							row += "<button id='addTR_option' style='color:black; margin:2%; float:left;' type='button' class='btn btn-secondary'> 항목 추가 </button>";

							$(".div_option").append(row);

						} else if (selectNum == 3) {
							var row = "<br><div class='form-check' style='float:left;'>";
							row += "<label class='form-check-label'><input class='form-check-input' type='radio' name='exampleRadios' id='exampleRadios1' value='option1' checked>&nbsp단답형</label><br>"
							row += "<label class='form-check-label'><input class='form-check-input' type='radio' name='exampleRadios' id='exampleRadios1' value='option1'>&nbsp장문형</label></div>"
							$(".div_option").append(row);

						}

					});
});

// 인혁: 옵션을 계속해서 추가할 경우
$(document)
		.ready(
				function() {
					$(document)
							.on(
									"click",
									"#addTR_option",
									function(event) {
										// 동적으로 여러 태그가 생성된 경우라면 이런식으로 클릭된 객체를
										// this 키워드를 이용해서 잡아올 수 있다.
										var row = "<tr>";
										row += "<td><input class='form-check-input' type='radio' name='inlineRadioOptions' id='inlineRadio1' value='option1'></td>";
										row += "<td><input type='text' class='form-control' id='formGroupExampleInput' placeholder='옵션명' style='margin:2%;'></td>";
										row += "<td style='vertical-align: middle;'><span> &nbsp&nbsp 삭제 </span></td>";
										row += "</tr>";
										$("#table_option").append(row);
										$("#table_option").on(
												"click",
												"span",
												function() {
													$(this).closest("tr")
															.remove();
												});
									});
				});