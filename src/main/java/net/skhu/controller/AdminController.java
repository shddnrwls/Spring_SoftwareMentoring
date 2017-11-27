package net.skhu.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
import net.skhu.dto.MentorApply;
import net.skhu.dto.MentorRoom;
import net.skhu.dto.Report;
import net.skhu.dto.Team;
import net.skhu.dto.User;
import net.skhu.model.Pagination;
import net.skhu.repository.AdminoptionRepository;
import net.skhu.repository.EmployeeRepository;
import net.skhu.repository.MentorApplyRepository;
import net.skhu.repository.MentorRoomRepository;
import net.skhu.repository.ProfessorRepository;
import net.skhu.repository.ReportRepository;
import net.skhu.repository.StudentRepository;
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

	@RequestMapping("index")
	public String list(Model model, Pagination pagination) {
		// List<Student> stdList = studentRepository.findAll();
		// List<Professor> profList = professorRepository.findAll();
		// List<Employee> empList = employeeRepository.findAll();
		List<MentorApply> mentorList = mentorApplyRepository.findAll();
		Adminoption optionList = adminOptionRepository.findOne(1);
		List<User> userList = userRepository.findAll(pagination);
		List<Report> reportList = reportRepository.findAll();

		// model.addAttribute("stdList", stdList);
		// model.addAttribute("profList", profList);
		// model.addAttribute("empList", empList);
		model.addAttribute("userList", userList);
		model.addAttribute("mentorList", mentorList);
		model.addAttribute("optionList", optionList);
		model.addAttribute("orderBy", UserRepository.orderBy);
		model.addAttribute("searchBy", UserRepository.searchBy);
		model.addAttribute("reportList", reportList);

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

		String url = "redirect:/admin/index?" + pagination.getQueryString();

		return url;
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

		return "redirect:/admin/index";
	}

	@RequestMapping("allMentorRoom")
	public String mentorRoom(Model model) {
		List<MentorRoom> mentorList = mentorRoomRepository.findAll();
		model.addAttribute("mentorList", mentorList);

		return "admin/allMentorRoom";
	}

	@RequestMapping(value = "mentorApply/{id}", method = RequestMethod.GET)
	public String mentorApply(Model model, @PathVariable int id) {

		MentorApply mentorApply = mentorApplyRepository.findOne(id);

		model.addAttribute("mentorApply", mentorApply);

		return "admin/mentorApply";
	}

	@RequestMapping(value = "adminMentorRoom/{id}", method = RequestMethod.GET)
	public String mentorRoom(Model model, @PathVariable int id) {

		MentorRoom mentorRoom = mentorRoomRepository.findOne(id);
		List<Team> teamList = teamRepository.findBymentorRoomId(id);
		model.addAttribute("teamList", teamList);
		model.addAttribute("mentorRoom", mentorRoom);

		return "admin/adminMentorRoom";
	}

	@RequestMapping(value = "success/{id}", method = RequestMethod.GET)
	public String success(Model model, @PathVariable int id) {

		MentorApply mentorApply = mentorApplyRepository.findOne(id);
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
		return "redirect:/admin/index";
	}

	@RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
	public String delete(Model model, @PathVariable int id) {
		MentorApply mentorApply = mentorApplyRepository.findOne(id);
		model.addAttribute("mentorApply", mentorApply);
		mentorApplyRepository.delete(mentorApply);
		return "redirect:/admin/index";
	}

	@RequestMapping(value = "mentorroomdelete/{id}", method = RequestMethod.GET)
	public String metorroomdelete(Model model, @PathVariable int id) {
		MentorRoom mentorRoom = mentorRoomRepository.findOne(id);

		model.addAttribute("mentorApply", mentorRoom);
		mentorRoomRepository.delete(mentorRoom);
		return "redirect:/admin/mentorRoom";
	}

	@RequestMapping(value = "teamdelete/{id}", method = RequestMethod.GET)
	public String deleteTeam(Model model, @PathVariable int id) {
		Team team = teamRepository.findOne(id);
		model.addAttribute("team", team);
		teamRepository.delete(team);
		return "redirect:/admin/allMentorRoom";
	}

	@RequestMapping("changeAuthority")
	public String changeAuthority(Model model, @RequestParam("userId") int userId,
			@RequestParam("authority") String authority, @RequestParam("pg") String pg, @RequestParam("ob") String ob,
			@RequestParam("sb") String sb, @RequestParam("st") String st) {
		User user = userRepository.findOne(userId);
		user.setAuthority(authority);
		userRepository.save(user);
		return "redirect:/admin/index?pg=" + pg + "&ob=" + ob + "&sb=" + sb + "&st=" + st;
	}

	/* excel view 로 뽑기 */
	@RequestMapping(value = "excelUpload", method = RequestMethod.POST)
	public String excelUpload(Model model, MultipartHttpServletRequest request) throws Exception {
		MultipartFile excelFile = request.getFile("excelFile");
		System.out.println("엑셀 파일 업로드 컨트롤러");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}
		File destFile = new File("D:\\" + excelFile.getOriginalFilename());

		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}

		List<User> users;

		users = taskService.excelUpload(destFile);

		for (User user : users) {
			userRepository.save(user);
		}

		// FileUtils.delete(destFile.getAbsolutePath());
		return "redirect:/admin/index";

	}

	@RequestMapping("excelView/{id}")
	public String excelView(Model model, @PathVariable int id) throws Exception {
		System.out.println("농욱진");

		Report report = reportRepository.findOne(id);
		List<Report> reportList = new ArrayList<>();

		reportList.add(report);

		WriteReportToExcelFile.writeReportToFile(
				report.getMentorRoom().getStudent().getUser().getUserId() + "_" + report.getWeek() + "_report.xlsx",
				reportList);

		return "redirect:/admin/index";
	}

	@RequestMapping("excelView")
	public String excelView(Model model) throws Exception {
		System.out.println("농욱진");

		List<Report> reportList = reportRepository.findAll();

		WriteReportToExcelFile.writeAllReportToFile("all_report.xlsx", reportList);

		return "redirect:/admin/index";
	}

}
