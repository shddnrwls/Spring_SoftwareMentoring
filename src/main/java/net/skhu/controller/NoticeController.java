package net.skhu.controller;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.dto.Adminoption;
import net.skhu.model.NoticeModel;
import net.skhu.model.Pagination;
import net.skhu.repository.AdminoptionRepository;
import net.skhu.service.NoticeService;

@Controller
@RequestMapping("user")
public class NoticeController {

	@Autowired
	NoticeService noticeService;
	@Autowired
	AdminoptionRepository adminOptionRepository;

	@RequestMapping("noticeList")
	public String list(Pagination pagination, Model model) {
		model.addAttribute("list", noticeService.findAll(pagination));
		model.addAttribute("orderBy", noticeService.getOrderByOptions());
		model.addAttribute("searchBy", noticeService.getSearchByOptions());

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/noticeList";
	}

	@RequestMapping("noticeView")
	public String view(@RequestParam("id") int id, Pagination pagination, Model model) {

		model.addAttribute("notice", noticeService.findOne(id));

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/noticeView";
	}

	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "noticeEdit", method = RequestMethod.GET)
	public String edit(@RequestParam("id") int id, Pagination pagination, Model model) {
		model.addAttribute("noticeModel", noticeService.findOne(id));

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "admin/noticeEdit";
	}

	@Secured("ROLE_ADMIN")
	@Transactional
	@RequestMapping(value = "noticeEdit", method = RequestMethod.POST)
	public String edit(@Valid NoticeModel a, BindingResult bindingResult, Pagination pagination, Model model) {
		if (bindingResult.hasErrors()) {
			return "admin/noticeEdit";
		}
		noticeService.update(a);
		return "redirect:noticeList?" + pagination.getQueryString();
	}

	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "noticeCreate", method = RequestMethod.GET)
	public String create(Pagination pagination, Model model) {
		model.addAttribute("noticeModel", new NoticeModel());

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "admin/noticeEdit";
	}

	@Secured("ROLE_ADMIN")
	@Transactional
	@RequestMapping(value = "noticeCreate", method = RequestMethod.POST)
	public String create(@Valid NoticeModel a, BindingResult bindingResult, Pagination pagination, Model model) {
		if (bindingResult.hasErrors()) {
			return "admin/noticeEdit";
		}
		// int id = noticeService.insertNotice(a);
		return "redirect:noticeList?" + pagination.getQueryString();
	}

	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "noticeDelete", method = RequestMethod.GET)
	public String delete(@RequestParam("id") int id, Pagination pagination, Model model) {
		noticeService.delete(id);
		return "redirect:noticeList?" + pagination.getQueryString();
	}

}
