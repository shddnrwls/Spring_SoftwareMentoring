package net.skhu.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import net.skhu.dto.Adminoption;
import net.skhu.dto.Department;
import net.skhu.dto.Employee;
import net.skhu.dto.ImageFile;
import net.skhu.dto.LicenseFile;
import net.skhu.dto.Manage_main;
import net.skhu.dto.MentorApply;
import net.skhu.dto.MentorRoom;
import net.skhu.dto.PastReport;
import net.skhu.dto.Professor;
import net.skhu.dto.Report;
import net.skhu.dto.Student;
import net.skhu.dto.SurveyURL;
import net.skhu.dto.Team;
import net.skhu.dto.User;
import net.skhu.repository.AdminoptionRepository;
import net.skhu.repository.DepartmentRepository;
import net.skhu.repository.EmployeeRepository;
import net.skhu.repository.ImageFileRepository;
import net.skhu.repository.LicenseFileRepository;
import net.skhu.repository.Manage_mainRepository;
import net.skhu.repository.MentorApplyRepository;
import net.skhu.repository.MentorRoomRepository;
import net.skhu.repository.PastReportRepository;
import net.skhu.repository.ProfessorRepository;
import net.skhu.repository.ReportImageFileRepository;
import net.skhu.repository.ReportRepository;
import net.skhu.repository.StudentRepository;
import net.skhu.repository.SurveyURLRepository;
import net.skhu.repository.TeamRepository;
import net.skhu.repository.UserRepository;
import net.skhu.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	StudentRepository studentRepository;
	@Autowired
	MentorApplyRepository mentorApplyRepository;
	@Autowired
	UserRepository userRepository;
	@Autowired
	UserService userService;
	@Autowired
	Manage_mainRepository manage_mainRepository;
	@Autowired
	TeamRepository teamRepository;
	@Autowired
	MentorRoomRepository mentorRoomRepository;
	@Autowired
	ImageFileRepository imageFileRepository;
	@Autowired
	LicenseFileRepository licenseFileRepository;
	@Autowired
	DepartmentRepository departmentRepository;
	@Autowired
	ProfessorRepository professorRepository;
	@Autowired
	EmployeeRepository employeeRepository;
	@Autowired
	ReportRepository reportRepository;
	@Autowired
	AdminoptionRepository adminOptionRepository;
	@Autowired
	PastReportRepository pastReportRepository;
	@Autowired
	SurveyURLRepository surveyURLRepository;
	@Autowired
	ReportImageFileRepository reportImageFileRepository;

	@RequestMapping("index")
	public String index(Model model) {

		Principal principal = SecurityContextHolder.getContext().getAuthentication();
		String userId = principal.getName();
		User user = userRepository.findOneByUserId(userId);

		model.addAttribute("user", user);
		model.addAttribute("principal", principal);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		if (user.getPassword().equals("1234")) {
			if (user.getJob().equals("1")) {
				Student student = studentRepository.findByUserUserId(userId);
				List<Department> departments = departmentRepository.findAll();
				model.addAttribute("student", student);
				model.addAttribute("departments", departments);

				return "user/myPageStudent";
			} else if (user.getJob().equals("2")) {
				Professor professor = professorRepository.findByUserUserId(userId);
				model.addAttribute("professor", professor);

				return "user/myPageProfessor";
			} else {
				Employee employee = employeeRepository.findByUserUserId(userId);
				model.addAttribute("employee", employee);

				return "user/myPageEmployee";
			}
		} else {
			Manage_main manage_main = manage_mainRepository.findOne(1);
			manage_main.setContents1(brToEnter(manage_main.getContents1()));
			manage_main.setContents2(brToEnter(manage_main.getContents2()));
			manage_main.setContents3(brToEnter(manage_main.getContents3()));
			manage_main.setContents4(brToEnter(manage_main.getContents4()));
			model.addAttribute("manage_main", manage_main);

			return "user/index";
		}
	}

	public String enterToBr(String enter) {
		String temp = enter;
		temp = temp.replace("\r\n", "<br/>");
		return temp;
	}

	public String brToEnter(String enter) {
		String temp = enter;
		temp = temp.replace("<br/>", "\r\n");
		return temp;
	}

	@RequestMapping(value = "index", method = RequestMethod.POST)
	public String index(Model model, Manage_main manage_main) {
		manage_main.setId(1);
		manage_main.setContents1(enterToBr(manage_main.getContents1()));
		manage_main.setContents2(enterToBr(manage_main.getContents2()));
		manage_main.setContents3(enterToBr(manage_main.getContents3()));
		manage_main.setContents4(enterToBr(manage_main.getContents4()));
		manage_mainRepository.save(manage_main);

		return "redirect:index";
	}

	@RequestMapping(value = "mentorApply", method = RequestMethod.GET)
	public String mentorApply(Model model) {

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		if (optionList.getMentorActive() == null)
			return "redirect:/user/index";
		else {
			Principal principal = SecurityContextHolder.getContext().getAuthentication();
			Student student = studentRepository.findByUserUserId(principal.getName());

			MentorApply mentorApply = new MentorApply();
			mentorApply.setStudent(student);

			model.addAttribute("student", student);
			model.addAttribute("mentorApply", mentorApply);
			model.addAttribute("principal", principal);

			return "user/mentorApply";
		}
	}

	@RequestMapping(value = "mentorApply", method = RequestMethod.POST)
	public String mentorApply(Model model, MentorApply mentorApply, Principal principal,
			@RequestParam("fileUpload") MultipartFile[] uploadFiles) throws IOException {

		LicenseFile oldLicenseFile = licenseFileRepository.findByMentorApplyId(mentorApply.getId());

		if (oldLicenseFile != null)
			licenseFileRepository.delete(oldLicenseFile);

		Student student = new Student();
		student = studentRepository.findByUserUserId(principal.getName());

		mentorApply.setStudent(student);
		mentorApply.setYear(2017);
		mentorApply.setSemester(2);
		mentorApplyRepository.save(mentorApply);

		for (MultipartFile uploadFile : uploadFiles) {
			if (uploadFile.getSize() <= 0)
				continue;
			String fileName = Paths.get(uploadFile.getOriginalFilename()).getFileName().toString();
			LicenseFile licenseFile = new LicenseFile();
			licenseFile.setFileName(fileName);
			licenseFile.setFileSize((int) uploadFile.getSize());
			licenseFile.setFileTime(new Date());
			licenseFile.setData(uploadFile.getBytes());
			licenseFile.setMentorApply(mentorApply);
			licenseFileRepository.save(licenseFile);

		}
		return "redirect:index";
	}

	@RequestMapping("menteeSelect")
	public String mentorRoom(Model model) {

		List<MentorRoom> mentorList = mentorRoomRepository.findAll();
		Adminoption optionList = adminOptionRepository.findOne(1);

		model.addAttribute("mentorList", mentorList);
		model.addAttribute("optionList", optionList);

		if(optionList.getMenteeActive() == null) return "redirect:/user/index";
		else return "user/menteeSelect";
	}

	// @RequestMapping(value = "menteeSelectRoom/{id}", method =
	// RequestMethod.GET)
	// public String mentorRoom(Model model, @PathVariable int id) {
	//
	// MentorRoom mentorRoom = mentorRoomRepository.findOne(id);
	// List<Team> teamList = teamRepository.findBymentorRoomId(id);
	// Adminoption optionList = adminOptionRepository.findOne(1);
	//
	// model.addAttribute("mentorRoom", mentorRoom);
	// model.addAttribute("teamList", teamList);
	// model.addAttribute("optionList", optionList);
	// return "user/menteeSelectRoom";
	// }

	@RequestMapping(value = "menteeSelectRoom", method = RequestMethod.GET)
	public String mentorRoom(Model model, @RequestParam("id") int id) {

		MentorRoom mentorRoom = mentorRoomRepository.findOne(id);
		List<Team> teamList = teamRepository.findBymentorRoomId(id);
		Adminoption optionList = adminOptionRepository.findOne(1);

		model.addAttribute("mentorRoom", mentorRoom);
		model.addAttribute("teamList", teamList);
		model.addAttribute("optionList", optionList);
		return "user/menteeSelectRoom";
	}

	@RequestMapping(value = "selectTeam/{id}", method = RequestMethod.GET)
	public String delete(Model model, @PathVariable int id) {

		Principal principal = SecurityContextHolder.getContext().getAuthentication();
		Student student = studentRepository.findByUserUserId(principal.getName());
		List<Team> teamList = teamRepository.findBymentorRoomId(id);
		Adminoption adminoption = adminOptionRepository.findOne(1);

		if (teamList.size() == adminoption.getMenteeMaxNum())
			return "redirect:/user/myMentorRoom";
		else {
			Team team = new Team();
			team.setStudent(student);
			team.setMentorRoomId(id);

			model.addAttribute("team", team);
			teamRepository.save(team);

			return "redirect:/user/myMentorRoom";
		}
	}

	@RequestMapping(value = "myMentorRoom", method = RequestMethod.GET)
	public String single(Model model) {

		Principal principal = SecurityContextHolder.getContext().getAuthentication();
		Student student = studentRepository.findByUserUserId(principal.getName());

		Team team = teamRepository.findByStudent(student);
		model.addAttribute("team", team);

		List<Team> teamList = teamRepository.findBymentorRoomId(team.getMentorRoomId());
		model.addAttribute("teamList", teamList);

		MentorRoom mentorRoom = mentorRoomRepository.findOne(team.getMentorRoomId());
		model.addAttribute("mentorRoom", mentorRoom);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/myMentorRoom";
	}

	@RequestMapping(value = "myPage", method = RequestMethod.GET)
	public String myPage(Model model) {

		Principal principal = SecurityContextHolder.getContext().getAuthentication();
		String userId = principal.getName();
		User user = userRepository.findOneByUserId(userId);

		model.addAttribute("user", user);
		model.addAttribute("principal", principal);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		if (user.getJob().equals("1")) {

			Student student = studentRepository.findByUserUserId(userId);
			List<Department> departments = departmentRepository.findAll();
			model.addAttribute("departments", departments);
			model.addAttribute("student", student);
			return "user/myPageStudent";

		} else if (user.getJob().equals("2")) {

			Professor professor = professorRepository.findByUserUserId(userId);
			model.addAttribute("professor", professor);
			return "user/myPageProfessor";

		} else {

			Employee employee = employeeRepository.findByUserUserId(userId);
			model.addAttribute("employee", employee);
			return "user/myPageEmployee";

		}

	}

	@RequestMapping(value = "myPageStudent", method = RequestMethod.POST)
	public String myPage(Model model, Student student, User user,
			@RequestParam(value = "newPassword", defaultValue = "0") String newPassword,
			@RequestParam("fileUpload") MultipartFile[] uploadFiles) throws IOException {

		ImageFile oldImageFile = imageFileRepository.findByUserId(user.getId());

		for (MultipartFile uploadFile : uploadFiles) {
			if (uploadFile.getSize() <= 0)
				continue;
			String fileName = Paths.get(uploadFile.getOriginalFilename()).getFileName().toString();
			ImageFile imageFile = new ImageFile();
			imageFile.setFileName(fileName);
			imageFile.setFileSize((int) uploadFile.getSize());
			imageFile.setFileTime(new Date());
			imageFile.setData(uploadFile.getBytes());
			imageFile.setUser(user);
			if (oldImageFile != null)
				imageFileRepository.delete(oldImageFile);
			imageFileRepository.save(imageFile);

		}

		if (!newPassword.equals("0"))
			user.setPassword(newPassword);
		System.out.println(user);
		userRepository.save(user);
		// studentRepository.save(professor);

		return "redirect:myPage";
	}

	@RequestMapping(value = "myPageProfessor", method = RequestMethod.POST)
	public String myPage(Model model, Professor professor, User user,
			@RequestParam(value = "newPassword", defaultValue = "0") String newPassword,
			@RequestParam("fileUpload") MultipartFile[] uploadFiles) throws IOException {

		ImageFile oldImageFile = imageFileRepository.findByUserId(user.getId());

		for (MultipartFile uploadFile : uploadFiles) {
			if (uploadFile.getSize() <= 0)
				continue;
			String fileName = Paths.get(uploadFile.getOriginalFilename()).getFileName().toString();
			ImageFile imageFile = new ImageFile();
			imageFile.setFileName(fileName);
			imageFile.setFileSize((int) uploadFile.getSize());
			imageFile.setFileTime(new Date());
			imageFile.setData(uploadFile.getBytes());
			imageFile.setUser(user);
			if (oldImageFile != null)
				imageFileRepository.delete(oldImageFile);
			imageFileRepository.save(imageFile);

		}

		if (!newPassword.equals("0"))
			user.setPassword(newPassword);
		System.out.println(user);
		userRepository.save(user);
		// professorRepository.save(professor);

		return "redirect:myPage";
	}

	@RequestMapping(value = "myPageEmployee", method = RequestMethod.POST)
	public String myPage(Model model, Employee employee, User user,
			@RequestParam(value = "newPassword", defaultValue = "0") String newPassword,
			@RequestParam("fileUpload") MultipartFile[] uploadFiles) throws IOException {

		ImageFile oldImageFile = imageFileRepository.findByUserId(user.getId());

		for (MultipartFile uploadFile : uploadFiles) {
			if (uploadFile.getSize() <= 0)
				continue;
			String fileName = Paths.get(uploadFile.getOriginalFilename()).getFileName().toString();
			ImageFile imageFile = new ImageFile();
			imageFile.setFileName(fileName);
			imageFile.setFileSize((int) uploadFile.getSize());
			imageFile.setFileTime(new Date());
			imageFile.setData(uploadFile.getBytes());
			imageFile.setUser(user);
			if (oldImageFile != null)
				imageFileRepository.delete(oldImageFile);
			imageFileRepository.save(imageFile);

		}

		if (!newPassword.equals("0"))
			user.setPassword(newPassword);
		userRepository.save(user);
		// employeeRepository.save(employee);

		return "redirect:myPage";
	}

	@RequestMapping("surveyApply")
	public String surveyApply(Model model) {
		Principal principal = SecurityContextHolder.getContext().getAuthentication();
		String userId = principal.getName();
		User user = userRepository.findOneByUserId(userId);
		SurveyURL surveyURL = surveyURLRepository.findOne(1);

		if (user.getAuthority().equals("1")) {
			model.addAttribute("URL", surveyURL.getMenteeURL());
		} else
			model.addAttribute("URL", surveyURL.getMentorURL());

		return "user/surveyApply";
	}

	@RequestMapping("image")
	public void image(@RequestParam(value = "userId") int userId, HttpServletResponse response) throws IOException {
		ImageFile imageFile = imageFileRepository.findByUserId(userId);
		if (imageFile == null)
			return;
		String fileName = URLEncoder.encode(imageFile.getFileName(), "UTF-8");
		response.setContentType(imageFile.getMimeType());
		response.setHeader("Content-Disposition", "filename=" + fileName + ";");
		try (BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())) {
			output.write(imageFile.getData());
		}
	}

	@RequestMapping("imageMentorApply")
	public void imageMentorApply(@RequestParam(value = "mentorApplyId") int mentorApplyId, HttpServletResponse response)
			throws IOException {

		LicenseFile licenseFile = licenseFileRepository.findByMentorApplyId(mentorApplyId);

		System.out.println(licenseFile);

		if (licenseFile == null)
			return;
		String fileName = URLEncoder.encode(licenseFile.getFileName(), "UTF-8");
		response.setContentType(licenseFile.getMimeType());
		response.setHeader("Content-Disposition", "filename=" + fileName + ";");
		try (BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())) {
			output.write(licenseFile.getData());
		}
	}

	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String report(Model model) {

		Report report = new Report();
		model.addAttribute("report", report);

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/report";
	}

	@RequestMapping(value = "report", method = RequestMethod.POST)
	public String report(Model model, Report report, @RequestParam("fileUpload") MultipartFile[] uploadFiles)
			throws IOException {

		Principal principal = SecurityContextHolder.getContext().getAuthentication();
		Student student = studentRepository.findByUserUserId(principal.getName());
		MentorRoom mentorRoom = mentorRoomRepository.findByStudentId(student.getId());

		/*
		 * 여기부턴 중복검사 만약 같은 주차의 report가 있다면
		 *
		 * List<Report> listReport =
		 * reportRepository.findByWeek(report.getWeek()); if (listReport !=
		 * null) for (Report data : listReport) // 그 중 mentorRoomId가 같은 것이 있다면
		 * if (data.getMentorRoom().getId() == mentorRoom.getId()) return
		 * "user/already"; // 여기까지
		 */

		PastReport pastReport = new PastReport();

		report.setMentorRoom(mentorRoom);
		report.setYear(2017);
		report.setSemester(2);

		List<Team> teamList = teamRepository.findBymentorRoomIdAndAthority(mentorRoom.getId(), 0);
		String mentees = new String();

		for (int i = 0; i < teamList.size(); i++) {
			mentees += teamList.get(i).getStudent().getUser().getName() + " ";
		}

		pastReport.setAttendedMentee(report.getAttendedMentee());
		pastReport.setContents(report.getContents());
		pastReport.setDepName(mentorRoom.getStudent().getDepartment().getDepName());
		pastReport.setFile(report.getFile());
		pastReport.setMentees(mentees);
		pastReport.setMentor(student.getUser().getName());
		pastReport.setMentorId(principal.getName());
		pastReport.setPlace(report.getPlace());
		pastReport.setWeek(report.getWeek());
		pastReport.setYear(report.getYear() + "-" + report.getSemester());

		reportRepository.save(report);
		pastReportRepository.save(pastReport);

		/*
		 * ReportImageFile oldReportImageFile =
		 * reportImageFileRepository.findByReportId(report.getId()); for
		 * (MultipartFile uploadFile : uploadFiles) { if (uploadFile.getSize()
		 * <= 0) continue; String fileName =
		 * Paths.get(uploadFile.getOriginalFilename()).getFileName().toString();
		 * ReportImageFile reportImageFile = new ReportImageFile();
		 * reportImageFile.setFileName(fileName);
		 * reportImageFile.setFileSize((int) uploadFile.getSize());
		 * reportImageFile.setFileTime(new Date());
		 * reportImageFile.setData(uploadFile.getBytes());
		 * reportImageFile.setReport(report); if (oldReportImageFile != null)
		 * reportImageFileRepository.delete(oldReportImageFile);
		 * reportImageFileRepository.save(reportImageFile); }
		 */

		return "redirect:index";
	}

	/*
	 * ReportImageFile oldReportImageFile =
	 * reportImageFileRepository.findByReportId(report.getId());
	 *
	 * for (MultipartFile uploadFile : uploadFiles) { if (uploadFile.getSize()
	 * <= 0) continue; String fileName =
	 * Paths.get(uploadFile.getOriginalFilename()).getFileName().toString();
	 * ReportImageFile reportImageFile = new ReportImageFile();
	 * reportImageFile.setFileName(fileName); reportImageFile.setFileSize((int)
	 * uploadFile.getSize()); reportImageFile.setFileTime(new Date());
	 * reportImageFile.setData(uploadFile.getBytes());
	 * reportImageFile.setReport(report); if (oldReportImageFile != null)
	 * reportImageFileRepository.delete(oldReportImageFile);
	 * reportImageFileRepository.save(reportImageFile);
	 *
	 * }
	 */

	/*
	 * @RequestParam("fileUpload") MultipartFile[] uploadFiles) throws
	 * IOException {
	 */

}
