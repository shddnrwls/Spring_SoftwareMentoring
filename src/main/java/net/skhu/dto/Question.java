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
@Table(name="question")
public class Question {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	int no;
	String title;
	String content;
	Date date;
	int hit;

	@ManyToOne
	@JoinColumn(name = "stdId")
	Student student;
}
