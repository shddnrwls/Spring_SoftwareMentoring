package net.skhu.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.FieldPosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import net.skhu.dto.Adminoption;
import net.skhu.dto.LicenseFile;
import net.skhu.dto.MentorApply;
import net.skhu.dto.MentorRoom;
import net.skhu.dto.PastReport;
import net.skhu.dto.Report;
import net.skhu.dto.SurveyURL;
import net.skhu.dto.Team;
import net.skhu.dto.TeamImageFile;
import net.skhu.dto.User;
import net.skhu.model.Pagination;
import net.skhu.repository.AdminoptionRepository;
import net.skhu.repository.EmployeeRepository;
import net.skhu.repository.LicenseFileRepository;
import net.skhu.repository.MentorApplyRepository;
import net.skhu.repository.MentorRoomRepository;
import net.skhu.repository.PastReportRepository;
import net.skhu.repository.ProfessorRepository;
import net.skhu.repository.ReportImageFileRepository;
import net.skhu.repository.ReportRepository;
import net.skhu.repository.StudentRepository;
import net.skhu.repository.SurveyURLRepository;
import net.skhu.repository.TeamImageFileRepository;
import net.skhu.repository.TeamRepository;
import net.skhu.repository.UserRepository;
import net.skhu.service.TaskService;
import net.skhu.util.WriteReportToExcelFile;

@Controller
@RequestMapping("admin")
public class AdminController {

	@Autowired
	StudentRepository studentRepository;
	@Autowired
	ProfessorRepository professorRepository;
	@Autowired
	EmployeeRepository employeeRepository;
	@Autowired
	AdminoptionRepository adminOptionRepository;
	@Autowired
	MentorRoomRepository mentorRoomRepository;
	@Autowired
	MentorApplyRepository mentorApplyRepository;
	@Autowired
	UserRepository userRepository;
	@Autowired
	TaskService taskService;
	@Autowired
	TeamRepository teamRepository;
	@Autowired
	ReportRepository reportRepository;
	@Autowired
	PastReportRepository pastReportRepository;
	@Autowired
	LicenseFileRepository licenseFileRepository;
	@Autowired
	SurveyURLRepository surveyURLRepository;
	@Autowired
	ReportImageFileRepository reportImageFileRepository;
	@Autowired
	TeamImageFileRepository teamImageFileRepository;

	@RequestMapping("index")
	public String list(Model model, Pagination pagination) {
		// List<Student> stdList = studentRepository.findAll();
		// List<Professor> profList = professorRepository.findAll();
		// List<Employee> empList = employeeRepository.findAll();
		// model.addAttribute("stdList", stdList);
		// model.addAttribute("profList", profList);
		// model.addAttribute("empList", empList);

		List<MentorApply> mentorList = mentorApplyRepository.findAll();
		Adminoption optionList = adminOptionRepository.findOne(1);
		List<User> userList = userRepository.findAll(pagination);
		List<Report> reportList = reportRepository.findAll();

		model.addAttribute("userList", userList);
		model.addAttribute("mentorList", mentorList);
		model.addAttribute("optionList", optionList);
		model.addAttribute("orderBy", UserRepository.orderBy);
		model.addAttribute("searchBy", UserRepository.searchBy);
		model.addAttribute("reportList", reportList);
		model.addAttribute("surveyURL", surveyURLRepository.findOne(1));

		// 다시 int형으로 되어있던것을 text형태로 만들어주는 코드.
		if (pagination.getSb() == 3)
			switch (pagination.getSt()) {
			case "1":
				pagination.setSt("학생");
				break;
			case "2":
				pagination.setSt("교수");
				break;
			case "3":
				pagination.setSt("직원");
				break;
			default:
				pagination.setSt("");
			}

		// 다시 int형으로 되어있던것을 text형태로 만들어주는 코드.
		if (pagination.getSb() == 4)
			switch (pagination.getSt()) {
			case "1":
				pagination.setSt("멘토");
				break;
			case "2":
				pagination.setSt("멘티");
				break;
			case "3":
				pagination.setSt("관리자");
				break;
			default:
				pagination.setSt("");
			}

		return "admin/index";
	}

	@RequestMapping("deleteUser")
	public String delete(Model model, @RequestParam("deleteUserIds") String[] deleteUserIds, Pagination pagination) {

		for (String userId : deleteUserIds)
			userRepository.delete(Integer.parseInt(userId));

		return "redirect:index?" + pagination.getQueryString();
	}

	@RequestMapping(value = "index", method = RequestMethod.POST)
	public String userList(Model model, @RequestParam(value = "onoffswitch1", required = false) String onoffswitch1,
			@RequestParam(value = "onoffswitch2", required = false) String onoffswitch2,
			@RequestParam(value = "onoffswitch3", required = false) String onoffswitch3,
			@RequestParam(value = "menteeMaxNum") int menteeMaxNum) {

		Adminoption adminOption = new Adminoption();

		adminOption.setAdminOptionId(1);
		adminOption.setMentorActive(onoffswitch1);
		adminOption.setMenteeActive(onoffswitch2);
		adminOption.setSurveyActive(onoffswitch3);
		adminOption.setMenteeMaxNum(menteeMaxNum);

		adminOptionRepository.save(adminOption);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "redirect:index";
	}

	@RequestMapping("allMentorRoom")
	public String mentorRoom(Model model) {
		List<MentorRoom> mentorList = mentorRoomRepository.findAll();
		model.addAttribute("mentorList", mentorList);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "admin/allMentorRoom";
	}

	@RequestMapping(value = "mentorApply", method = RequestMethod.GET)
	public String mentorApply(Model model, @RequestParam("id") int id) {

		MentorApply mentorApply = mentorApplyRepository.findOne(id);
		model.addAttribute("mentorApply", mentorApply);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "admin/mentorApply";
	}

	/*
	 * @RequestMapping("readReportImage") public void
	 * readReportImage(@RequestParam(value = "reportId") int reportId,
	 * HttpServletResponse response) throws IOException {
	 *
	 * ReportImageFile reportImageFile =
	 * reportImageFileRepository.findByReportId(reportId);
	 *
	 * System.out.println(reportImageFile); if (reportImageFile == null) return;
	 * String fileName = URLEncoder.encode(reportImageFile.getFileName(),
	 * "UTF-8"); response.setContentType(reportImageFile.getMimeType());
	 * response.setHeader("Content-Disposition", "filename=" + fileName + ";");
	 * try (BufferedOutputStream output = new
	 * BufferedOutputStream(response.getOutputStream())) {
	 * output.write(reportImageFile.getData()); } }
	 */

	@RequestMapping(value = "adminMentorRoom", method = RequestMethod.GET)
	public String mentorRoom(Model model, @RequestParam("id") int id) {

		MentorRoom mentorRoom = mentorRoomRepository.findOne(id);
		List<Team> teamList = teamRepository.findBymentorRoomId(id);
		model.addAttribute("teamList", teamList);
		model.addAttribute("mentorRoom", mentorRoom);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "admin/adminMentorRoom";
	}

	@RequestMapping(value = "success", method = RequestMethod.GET)
	public String success(Model model, @RequestParam("id") int id) {

		MentorApply mentorApply = mentorApplyRepository.findOne(id);

		User user = mentorApplyRepository.findOne(id).getStudent().getUser();

		if ("1".equals(user.getAuthority())) {
			user.setAuthority("2");
		}

		userRepository.save(user);

		MentorRoom mentorRoom = new MentorRoom();
		Team team = new Team();

		mentorRoom.setBankName(mentorApply.getBankName());
		mentorRoom.setAccountNum(mentorApply.getAccountNum());
		mentorRoom.setContents(mentorApply.getContents());
		mentorRoom.setGrade(mentorApply.getGrade());
		mentorRoom.setMethod(mentorApply.getMethod());
		mentorRoom.setPurpose(mentorApply.getPurpose());
		mentorRoom.setStudent(mentorApply.getStudent());
		mentorRoom.setSemester(mentorApply.getSemester());
		mentorRoom.setYear(mentorApply.getYear());
		mentorRoom.setTeamName(mentorApply.getTeamName());
		mentorRoom.setTime(mentorApply.getTime());
		mentorRoom.setSubject(mentorApply.getSubject());
		team.setStudent(mentorApply.getStudent());

		model.addAttribute("mentorApply", mentorApply);
		model.addAttribute("mentorRoom", mentorRoom);
		mentorRoomRepository.save(mentorRoom);
		mentorApplyRepository.delete(mentorApply);

		team.setMentorRoomId(mentorRoom.getId());
		team.setAthority(2);
		model.addAttribute("team", team);
		teamRepository.save(team);

		return "redirect:index";
	}

	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(Model model, @RequestParam("id") int id) {

		MentorApply mentorApply = mentorApplyRepository.findOne(id);
		model.addAttribute("mentorApply", mentorApply);
		mentorApplyRepository.delete(mentorApply);

		return "redirect:index";
	}

	@RequestMapping(value = "mentorRoomDelete", method = RequestMethod.GET)
	public String metorroomdelete(Model model, @RequestParam("id") int id) {

		MentorRoom mentorRoom = mentorRoomRepository.findOne(id);
		model.addAttribute("mentorApply", mentorRoom);
		mentorRoomRepository.delete(mentorRoom);

		return "redirect:/admin/allMentorRoom";
	}

	@RequestMapping(value = "teamDelete", method = RequestMethod.GET)
	public String deleteTeam(Model model, @RequestParam("id") int id) {

		Team team = teamRepository.findOne(id);
		model.addAttribute("team", team);
		teamRepository.delete(team);

		return "redirect:/admin/adminMentorRoom?id=" + team.getMentorRoomId();
	}

	@RequestMapping("changeAuthority")
	public String changeAuthority(Model model, @RequestParam("userId") int userId,
			@RequestParam("authority") String authority, @RequestParam("pg") String pg, @RequestParam("ob") String ob,
			@RequestParam("sb") String sb, @RequestParam("st") String st) {

		User user = userRepository.findOne(userId);
		user.setAuthority(authority);
		userRepository.save(user);

		return "redirect:index?pg=" + pg + "&ob=" + ob + "&sb=" + sb + "&st=" + st;
	}

	/* excel view 로 뽑기 */
	// 학생 업로드
	@RequestMapping(value = "excelUpload", method = RequestMethod.POST)
	public String excelUpload(Model model, MultipartHttpServletRequest request) throws Exception {

		MultipartFile excelFile = request.getFile("excelFile");
		System.out.println("엑셀 파일 업로드 컨트롤러");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}
		File destFile = new File(System.getProperty("user.dir") + excelFile.getOriginalFilename());

		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}

		taskService.excelUpload(destFile);
		destFile.delete();

		return "redirect:/admin/index";

	}

	/* excel view 로 뽑기 */
	// 교수 업로드
	@RequestMapping(value = "excelUploadPro", method = RequestMethod.POST)
	public String excelUploadPro(Model model, MultipartHttpServletRequest request) throws Exception {

		MultipartFile excelFile = request.getFile("excelFile");
		System.out.println("엑셀 파일 업로드 컨트롤러");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}
		File destFile = new File(System.getProperty("user.dir") + excelFile.getOriginalFilename());

		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}

		taskService.excelUploadPro(destFile);
		destFile.delete();

		return "redirect:/admin/index";

	}

	/* excel view 로 뽑기 */
	// 직원 업로드
	@RequestMapping(value = "excelUploadEmp", method = RequestMethod.POST)
	public String excelUploadEmp(Model model, MultipartHttpServletRequest request) throws Exception {

		MultipartFile excelFile = request.getFile("excelFile");
		System.out.println("엑셀 파일 업로드 컨트롤러");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}
		File destFile = new File(System.getProperty("user.dir") + excelFile.getOriginalFilename());

		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}

		taskService.excelUploadEmp(destFile);
		destFile.delete();

		return "redirect:/admin/index";

	}

	@RequestMapping("adminReport")
	public String report(Model model, Pagination pagination) {
		// List<Report> reportList = reportRepository.findAll(pagination);
		List<PastReport> pastReportList = pastReportRepository.findAll(pagination);

		model.addAttribute("orderBy", PastReportRepository.orderBy);
		model.addAttribute("searchBy", PastReportRepository.searchBy);
		// model.addAttribute("reportList", reportList);
		model.addAttribute("pastReportList", pastReportList);

		return "admin/adminReport";
	}

	@RequestMapping("excelView/{id}")
	public String excelView(Model model, @PathVariable int id, HttpServletResponse response) throws Exception {

		PastReport pastReport = pastReportRepository.findOne(id);
		List<PastReport> reportList = new ArrayList<>();

		reportList.add(pastReport);

		WriteReportToExcelFile.writeReportToFile(
				getNowYMD() + "_" + pastReport.getMentorId() + "_" + pastReport.getWeek() + "주차_report.xlsx",
				reportList, response);

		return "redirect:/admin/index";
	}

	@RequestMapping("excelView")
	public String excelView(Model model, @RequestParam("downloadReportIds") String[] downloadReportIds,
			HttpServletResponse response) throws Exception {
		System.out.println("농욱진");

		List<PastReport> reportList = new ArrayList<>();

		for (String reportId : downloadReportIds)
			reportList.add(pastReportRepository.findOne(Integer.parseInt(reportId)));

		System.out.println("여기는?");
		WriteReportToExcelFile.writeCheckReportToFile("all_report.xlsx", reportList, response);

		return "redirect:/admin/index";
	}

	@RequestMapping("license")
	public void license(@RequestParam(value = "mentorApplyId") int mentorApplyId, HttpServletResponse response)
			throws IOException {
		System.out.println(mentorApplyId);
		LicenseFile licenseFile = licenseFileRepository.findByMentorApplyId(mentorApplyId);
		if (licenseFile == null)
			return;
		String fileName = URLEncoder.encode(licenseFile.getFileName(), "UTF-8");
		response.setContentType(licenseFile.getMimeType());
		response.setHeader("Content-Disposition", "filename=" + fileName + ";");
		try (BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())) {
			output.write(licenseFile.getData());
		}
	}

	@RequestMapping(value = "editSurveyURL", method = RequestMethod.POST)
	public String editQuestionURL(Model model, SurveyURL surveyURL) {
		surveyURL.setId(1);
		surveyURLRepository.save(surveyURL);
		return "redirect:/admin/index";
	}

	private String getNowYMD() {
		StringBuffer dateResult = new StringBuffer();

		Date date = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		simpleDate.format(date, dateResult, new FieldPosition(1));
		return dateResult.toString();
	}

	@RequestMapping("readTeamImage")
	public void readTeamImage(@RequestParam(value = "pastReportId") int pastReportId, HttpServletResponse response)
			throws IOException {

		TeamImageFile teamImageFile = teamImageFileRepository.findByPastReportId(pastReportId);
		if (teamImageFile == null)
			return;

		String fileName = URLEncoder.encode(teamImageFile.getFileName(), "UTF-8");
		response.setContentType(teamImageFile.getMimeType());
		response.setHeader("Content-Disposition", "filename=" + fileName + ";");
		try (BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())) {
			output.write(teamImageFile.getData());
		}
	}

}
