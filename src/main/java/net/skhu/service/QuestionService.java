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
import net.skhu.repository.StudentRepository;
import net.skhu.repository.UserRepository;

@Service
public class QuestionService {

	@Autowired QuestionRepository questionRepository;
	@Autowired UserRepository userRepository;
	@Autowired StudentRepository studentRepository;


	public Question findOne(int id){
		Question question = questionRepository.findOne(id);
//		question.setHit(question.getHit() + 1);
//		questionRepository.save(question);
		return question;
	}

	public List<Question> findAll(Pagination pagination){
		return questionRepository.findAll(pagination);
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

        Student student = studentRepository.findOneByUserId(userId);

        question.setNo(no);						// no 최대값 + 1 전달
		question.setStudent(student);
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
