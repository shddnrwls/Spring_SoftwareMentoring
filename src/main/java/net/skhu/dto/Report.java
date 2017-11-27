package net.skhu.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
@Entity
@Table(name="report")
public class Report {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	String place;
	String contents;
	String file;
	int year;
	int semester;
	String week;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "mentorRoomId")
	MentorRoom mentorRoom;

}