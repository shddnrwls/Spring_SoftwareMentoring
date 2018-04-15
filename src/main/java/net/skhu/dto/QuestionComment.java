package net.skhu.dto;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="questioncomment")
public class QuestionComment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	String content;
	Date date;

	@ManyToOne
	@JoinColumn(name = "questionId")
	Question question;

	@ManyToOne
	@JoinColumn(name ="userId")
	User user;
}
