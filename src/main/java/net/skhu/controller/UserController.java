package net.skhu.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.skhu.dto.Manage_main;
import net.skhu.dto.MentorApply;
import net.skhu.dto.Student;
import net.skhu.repository.Manage_mainRepository;
import net.skhu.repository.MentorApplyRepository;
import net.skhu.repository.StudentRepository;
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

	@RequestMapping(value = "mentorApply", method = RequestMethod.GET)
	public String mentorApply(Model model) {
		Principal principal = SecurityContextHolder.getContext().getAuthentication();
		Student student = studentRepository.findByUserUserId(principal.getName());

		MentorApply mentorApply = new MentorApply();
		mentorApply.setStudent(student);

		model.addAttribute("student", student);
		model.addAttribute("mentorApply", mentorApply);
		model.addAttribute("principal", principal);

		return "user/mentorApply";
	}

	@RequestMapping(value = "mentorApply", method = RequestMethod.POST)
	public String mentorApply(Model model, MentorApply mentorApply, Principal principal) {

		// 메인 페이지 설명 부분 불러오기 위함
		Manage_main manage_main = manage_mainRepository.findOne(1);
		manage_main.setContents1(brToEnter(manage_main.getContents1()));
		manage_main.setContents2(brToEnter(manage_main.getContents2()));
		manage_main.setContents3(brToEnter(manage_main.getContents3()));
		manage_main.setContents4(brToEnter(manage_main.getContents4()));
		model.addAttribute("manage_main", manage_main);

		// 멘토 신청 부분
		Student student = new Student();
		student = studentRepository.findByUserUserId(principal.getName());

		mentorApply.setStudent(student);
		mentorApply.setYear(2017);
		mentorApply.setSemester(2);
		mentorApplyRepository.save(mentorApply);

		return "user/index";
	}

	@RequestMapping("index")
	public String index(Model model) {
		// 메인 페이지 설명 부분 불러오기 위함
		Manage_main manage_main = manage_mainRepository.findOne(1);
		manage_main.setContents1(brToEnter(manage_main.getContents1()));
		manage_main.setContents2(brToEnter(manage_main.getContents2()));
		manage_main.setContents3(brToEnter(manage_main.getContents3()));
		manage_main.setContents4(brToEnter(manage_main.getContents4()));
		model.addAttribute("manage_main", manage_main);

		return "user/index";
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
		manage_main.setContents1(enterToBr(manage_main.getContents1()));	// 콘텐츠 1의 개행문자를 <br>로 바꾸어 저장
		manage_main.setContents2(enterToBr(manage_main.getContents2()));	// 콘텐츠 2의 개행문자를 <br>로 바꾸어 저장
		manage_main.setContents3(enterToBr(manage_main.getContents3()));	// 콘텐츠 3의 개행문자를 <br>로 바꾸어 저장
		manage_main.setContents4(enterToBr(manage_main.getContents4()));	// 콘텐츠 4의 개행문자를 <br>로 바꾸어 저장

		manage_mainRepository.save(manage_main);

		return "user/index";
	}
}
