package net.skhu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import net.skhu.dto.Manage_main;
import net.skhu.repository.Manage_mainRepository;

@Controller
public class GuestController {

	@Autowired
	Manage_mainRepository manage_mainRepository;

	@RequestMapping({ "/", "guest/index" })
	public String index(Model model) {
		Manage_main manage_main = manage_mainRepository.findOne(1);

		manage_main.setContents1(brToEnter(manage_main.getContents1()));
		manage_main.setContents2(brToEnter(manage_main.getContents2()));
		manage_main.setContents3(brToEnter(manage_main.getContents3()));
		manage_main.setContents4(brToEnter(manage_main.getContents4()));

		model.addAttribute("manage_main", manage_main);

		return "guest/index";
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

	@RequestMapping("guest/login")
	public String login() {
		return "guest/login";
	}
}
