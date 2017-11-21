package net.skhu.controller;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.dto.QuestionComment;
import net.skhu.model.Pagination;
import net.skhu.model.QuestionCommentModel;
import net.skhu.model.QuestionModel;
import net.skhu.repository.QuestionCommentRepository;
import net.skhu.repository.StudentRepository;
import net.skhu.service.QuestionService;
import net.skhu.service.UserService;

@Controller
@RequestMapping("user")
public class QuestionController {

	@Autowired QuestionService questionService;
	@Autowired StudentRepository studentRepository;
	@Autowired QuestionCommentRepository questionCommentRepository;

    @RequestMapping("questionList")
    public String list(Pagination pagination, Model model) {
        model.addAttribute("list", questionService.findAll(pagination));
        model.addAttribute("orderBy", questionService.getOrderByOptions());
        model.addAttribute("searchBy", questionService.getSearchByOptions());

        return "user/questionList";
    }

    @RequestMapping(value="questionView", method=RequestMethod.GET)
    public String view(@RequestParam("id") int id, Model model, Pagination pagination) {

        model.addAttribute("question", questionService.findOne(id));
        model.addAttribute("comments", questionCommentRepository.findAll());
        model.addAttribute("questionCommentModel", new QuestionCommentModel());
        model.addAttribute("user", UserService.getCurrentUser());

        return "user/questionView";
    }

    @RequestMapping(value="questionView", method=RequestMethod.POST)
    public String view(@RequestParam("id") int id, Model model, @Valid QuestionCommentModel a, BindingResult bindingResult, Pagination pagination){

    	if(bindingResult.hasErrors()) {
    		return "user/questionView";
    	}
    	QuestionComment c = new QuestionComment();
    	c.setContent(a.getContent());
    	// c.setQuestion(questionService.findOne(id));
    	questionCommentRepository.save(c);

    	return "redirect:questionView?id=" + id + "&" + pagination.getQueryString();
    }

    // 작성자, 관리자만 수정 삭제 가능하게 해야함
    @RequestMapping(value="questionEdit", method=RequestMethod.GET)
    public String edit(@RequestParam("id") int id, Pagination pagination, Model model) {
    	model.addAttribute("user", UserService.getCurrentUser());
        model.addAttribute("questionModel", questionService.findOne(id));
        return "user/questionEdit";
    }

    @Transactional
    @RequestMapping(value="questionEdit", method=RequestMethod.POST)
    public String edit(Pagination pagination, Model model, @Valid QuestionModel a, BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            return "user/questionEdit";
        }
        questionService.update(a, UserService.getCurrentUser().getId());
        return "redirect:questionView?id=" + a.getId() + "&" + pagination.getQueryString();
    }

    @RequestMapping(value="questionCreate", method=RequestMethod.GET)
    public String create(Pagination pagination, Model model) {
    	model.addAttribute("user", UserService.getCurrentUser());
        model.addAttribute("questionModel", new QuestionModel());
        return "user/questionEdit";
    }

    @Transactional
    @RequestMapping(value="questionCreate", method=RequestMethod.POST)
    public String create(@Valid QuestionModel a, BindingResult bindingResult, Pagination pagination, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/questionEdit";
        }
        int id = questionService.insertQuestion(a, UserService.getCurrentUser().getId());
        return "redirect:questionView?id=" + id + "&" + pagination.getQueryString();
    }

    @RequestMapping(value="questionDelete", method=RequestMethod.GET)
    public String delete(@RequestParam("id") int id, Pagination pagination, Model model){
    	questionService.delete(id);
    	return "redirect:questionList?"+pagination.getQueryString();
    }

}
