package net.skhu.dto;

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
@Table(name="department")
public class Department {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	String depName;
	String officeNum;
	String officePhoneNumber;

	@ManyToOne
	@JoinColumn(name = "empId")
	Employee employee;
}
