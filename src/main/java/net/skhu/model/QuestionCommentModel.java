package net.skhu.model;

import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class QuestionCommentModel {
	int id;

	@Size(min=1, message="댓글을 입력하세요")
	String content;

}
