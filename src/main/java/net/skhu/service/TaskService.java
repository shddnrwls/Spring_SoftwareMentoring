package net.skhu.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.skhu.dto.Department;
import net.skhu.dto.Employee;
import net.skhu.dto.Professor;
import net.skhu.dto.Student;
import net.skhu.dto.User;
import net.skhu.repository.DepartmentRepository;
import net.skhu.repository.EmployeeRepository;
import net.skhu.repository.ProfessorRepository;
import net.skhu.repository.StudentRepository;
import net.skhu.repository.UserRepository;
import net.skhu.util.ExcelRead;
import net.skhu.util.ExcelReadOption;

@Service
public class TaskService {
	@Autowired
	UserRepository userRepository;
	@Autowired
	StudentRepository studentRepository;
	@Autowired
	DepartmentRepository departmentRepository;
	@Autowired
	ProfessorRepository professorRepository;
	@Autowired
	EmployeeRepository employeeRepository;

	public void excelUpload(java.io.File destFile) throws Exception {
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F");
		excelReadOption.setStartRow(2);

		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		List<User> users = new ArrayList<User>();
		for (Map<String, String> content : excelContent) {
			User user = new User();
			// System.out.println(content.toString());

			// 여기는 뭐하는 애임?

			user.setUserId(content.get("A"));
			user.setPassword(content.get("B"));
			user.setName(content.get("C"));
			user.setEmail(content.get("D"));
			user.setPhoneNumber(content.get("E"));

			String phoneNum = user.getPhoneNumber();
			String tempPswd = phoneNum.replaceAll("-", "");

			user.setPassword(tempPswd);
			user.setAuthority("1");
			user.setJob("1");
			userRepository.save(user);

			Student student = new Student();
			Department department = departmentRepository.findOne(1);

			student.setUser(user);
			student.setDepartment(department);
			student.setGrade(Integer.parseInt(content.get("F")));
			studentRepository.save(student);
		}
	}

	public void excelUploadPro(java.io.File destFile) throws Exception {
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G");
		excelReadOption.setStartRow(2);

		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		List<User> users = new ArrayList<User>();
		for (Map<String, String> content : excelContent) {
			User user = new User();
			// System.out.println(content.toString());

			// 여기는 뭐하는 애임?

			user.setUserId(content.get("A"));
			user.setPassword(content.get("B"));
			user.setName(content.get("C"));
			user.setEmail(content.get("D"));
			user.setPhoneNumber(content.get("E"));

			String phoneNum = user.getPhoneNumber();
			String tempPswd = phoneNum.replaceAll("-", "");

			user.setPassword(tempPswd);
			user.setAuthority("3");
			user.setJob("2");
			userRepository.save(user);

			Professor professor = new Professor();

			professor.setUser(user);
			professor.setLabNumber(content.get("F"));
			professor.setLabPhoneNumber(content.get("G"));

			professorRepository.save(professor);
		}
	}

	public void excelUploadEmp(java.io.File destFile) throws Exception {
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		excelReadOption.setOutputColumns("A", "B", "C", "D", "E");
		excelReadOption.setStartRow(2);

		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		List<User> users = new ArrayList<User>();
		for (Map<String, String> content : excelContent) {
			User user = new User();
			// System.out.println(content.toString());

			// 여기는 뭐하는 애임?

			user.setUserId(content.get("A"));
			user.setPassword(content.get("B"));
			user.setName(content.get("C"));
			user.setEmail(content.get("D"));
			user.setPhoneNumber(content.get("E"));

			String phoneNum = user.getPhoneNumber();
			String tempPswd = phoneNum.replaceAll("-", "");

			user.setPassword(tempPswd);
			user.setAuthority("3");
			user.setJob("3");
			userRepository.save(user);

			Employee employee = new Employee();
			employee.setUser(user);

			employeeRepository.save(employee);
		}
	}

}