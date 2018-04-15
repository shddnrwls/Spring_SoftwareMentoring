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
@Table(name = "teamming")
public class Team {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	@JsonIgnore
	@OneToOne
	@JoinColumn(name = "stdId")
	Student student;

	int mentorRoomId;
	int athority;

}