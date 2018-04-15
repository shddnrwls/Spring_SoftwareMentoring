package net.skhu.model;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class QuestionModel {
	int id;

	@NotEmpty(message="제목을 입력하세요")
	String title;

	@Size(min=5, message="문의 사항을 입력하세요")
	String content;
}
