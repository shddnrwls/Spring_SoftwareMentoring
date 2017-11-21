package net.skhu.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="adminoption")
public class Adminoption {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int adminOptionId;

	String mentorActive;
	String menteeActive;
	String surveyActive;
	int menteeMaxNum;
}
