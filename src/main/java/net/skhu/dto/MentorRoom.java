package net.skhu.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
@Entity
@Table(name = "mentorroom")
public class MentorRoom {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	@JsonIgnore
	@OneToOne
	@JoinColumn(name = "stdId")
	Student student;

	String accountNum;
	String bankName;
	String teamName;
	String subject;
	String purpose;
	String contents;
	String method;
	String time;
	String grade;
	int year;
	int semester;
	String file;
	int reportOk;





}