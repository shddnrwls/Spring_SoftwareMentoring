package net.skhu.controller;

import java.util.Date;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.dto.Adminoption;
import net.skhu.dto.Question;
import net.skhu.dto.QuestionComment;
import net.skhu.model.Pagination;
import net.skhu.model.QuestionModel;
import net.skhu.repository.AdminoptionRepository;
import net.skhu.repository.QuestionCommentRepository;
import net.skhu.repository.QuestionRepository;
import net.skhu.repository.StudentRepository;
import net.skhu.service.QuestionService;
import net.skhu.service.UserService;

@Controller
@RequestMapping("user")
public class QuestionController {

	@Autowired
	QuestionService questionService;
	@Autowired
	StudentRepository studentRepository;
	@Autowired
	QuestionCommentRepository questionCommentRepository;
	@Autowired
	QuestionRepository questionRepository;
	@Autowired
	AdminoptionRepository adminOptionRepository;

	@RequestMapping("questionList")
	public String list(Pagination pagination, Model model) {
		model.addAttribute("list", questionService.findAll(pagination));
		model.addAttribute("orderBy", questionService.getOrderByOptions());
		model.addAttribute("searchBy", questionService.getSearchByOptions());

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/questionList";
	}

	@RequestMapping(value = "questionView", method = RequestMethod.GET)
	public String view(@RequestParam("id") int id, Model model, Pagination pagination) {

		model.addAttribute("question", questionService.findOne(id));
		model.addAttribute("questioncommentList", questionCommentRepository.findByQuestionId(id));

		// 댓글 작성
		model.addAttribute("questioncomment", new QuestionComment());
		model.addAttribute("user", UserService.getCurrentUser());

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/questionView";
	}

	@RequestMapping(value = "questionView", method = RequestMethod.POST)
	public String view(@RequestParam("id") int id, Model model, QuestionComment questionComment,
			BindingResult bindingResult, Pagination pagination) {

		if (bindingResult.hasErrors()) {
			return "user/questionView";
		}

		QuestionComment newComment = new QuestionComment();
		String temp = questionComment.getContent();
		temp = temp.replace("\r\n", "<br/>");
		newComment.setContent(temp);
		newComment.setQuestion(questionRepository.findOne(id));
		newComment.setDate(new Date());

		questionCommentRepository.save(newComment);

		return "redirect:questionView?id=" + id + "&" + pagination.getQueryString();
	}

	// 작성자, 관리자만 수정 삭제 가능하게 해야함
	@RequestMapping(value = "questionEdit", method = RequestMethod.GET)
	public String edit(@RequestParam("id") int id, Pagination pagination, Model model) {
		model.addAttribute("user", UserService.getCurrentUser());
		model.addAttribute("questionModel", questionService.findOne(id));

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/questionEdit";
	}

	@Transactional
	@RequestMapping(value = "questionEdit", method = RequestMethod.POST)
	public String edit(Pagination pagination, Model model, @Valid QuestionModel a, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "user/questionEdit";
		}
		questionService.update(a, UserService.getCurrentUser().getId());
		return "redirect:questionList?" + pagination.getQueryString();
	}

	@RequestMapping(value = "questionCreate", method = RequestMethod.GET)
	public String create(Pagination pagination, Model model) {
		model.addAttribute("user", UserService.getCurrentUser());
		model.addAttribute("questionModel", new QuestionModel());

		Adminoption optionList = adminOptionRepository.findOne(1);
		model.addAttribute("optionList", optionList);

		return "user/questionEdit";
	}

	@Transactional
	@RequestMapping(value = "questionCreate", method = RequestMethod.POST)
	public String create(@Valid QuestionModel a, BindingResult bindingResult, Pagination pagination, Model model) {
		if (bindingResult.hasErrors()) {
			return "user/questionEdit";
		}
		int id = questionService.insertQuestion(a, UserService.getCurrentUser().getId());
		return "redirect:questionList?" + pagination.getQueryString();
	}

	@RequestMapping(value = "questionDelete", method = RequestMethod.GET)
	public String delete(@RequestParam("id") int id, Pagination pagination, Model model) {
		questionService.delete(id);
		return "redirect:questionList?" + pagination.getQueryString();
	}

	@RequestMapping(value="questionCommentDelete", method=RequestMethod.GET)
	public String delete(@RequestParam("id") int id, Pagination pagination, Question question){
		int questionId = questionCommentRepository.findOne(id).getQuestion().getId();
		questionCommentRepository.delete(questionCommentRepository.findOne(id));

		return "redirect:questionView?id="+ questionId + "&" + pagination.getQueryString();
	}

}
