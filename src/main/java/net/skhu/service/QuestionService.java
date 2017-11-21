package net.skhu.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.skhu.dto.Question;
import net.skhu.dto.Student;
import net.skhu.model.Option;
import net.skhu.model.Pagination;
import net.skhu.model.QuestionModel;
import net.skhu.repository.QuestionRepository;

@Service
public class QuestionService {

	@Autowired QuestionRepository questionRepository;

	public Question findOne(int id){
		return questionRepository.findOne(id);
	}

	public List<Question> findAll(Pagination pagination){
		return questionRepository.findAll();
	}

	public void update(QuestionModel a, int userId){
		//questionRepository.update(a.getId(), userId, a.getTitle(), a.getContent());
		Question q = questionRepository.findOne(a.getId());

		if(UserService.getCurrentUser().getId() == q.getStudent().getId()){
			q.setContent(a.getContent());
			q.setTitle(a.getTitle());
			questionRepository.save(q);
		}
	}

	public int insertQuestion(QuestionModel a, int userId){
		Question last = questionRepository.findTopByOrderByNoDesc();
        int no = (last == null) ? 1 : last.getNo() + 1;
        Question question = new Question();

        question.setNo(no);						// no 최대값 + 1 전달
        question.setStudent(new Student());
        question.getStudent().setId(userId);
        question.setTitle(a.getTitle());
        question.setContent(a.getContent());
        question.setDate(new Date());

        questionRepository.save(question);

        return question.getId();
	}

	public void delete(int id){
		questionRepository.delete(id);
	}

	public Option[] getOrderByOptions(){
		return questionRepository.orderBy;
	}

	public Option[] getSearchByOptions(){
		return questionRepository.searchBy;
	}

}
