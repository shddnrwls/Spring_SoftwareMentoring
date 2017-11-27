package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.QuestionComment;

public interface QuestionCommentRepository extends JpaRepository<QuestionComment, Integer> {

	List<QuestionComment> findByQuestionId(int id);

}
