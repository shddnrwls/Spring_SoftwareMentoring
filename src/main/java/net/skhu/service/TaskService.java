package net.skhu.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.skhu.dto.User;
import net.skhu.repository.UserRepository;
import net.skhu.util.ExcelRead;
import net.skhu.util.ExcelReadOption;

@Service
public class TaskService {
	@Autowired
	UserRepository userRepository;

	public List<User> excelUpload(java.io.File destFile) throws Exception {
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
			user.setAuthority(content.get("F"));

			user.setJob(content.get("G"));

			// java.text.SimpleDateFormat transFormat = new
			// java.text.SimpleDateFormat("yyyy-MM-dd");
			// java.util.Date parsed = transFormat.parse(content.get("L"));
			// java.sql.Date sql = new java.sql.Date(parsed.getTime());
			// user.setU_birth(sql);
			users.add(user);
		}

		return users;
	}
	// public int validateRegister(User user){
	// int count = 0;
	// Integer i = user.getPhoneNumber();
	// if(i==null){
	// user.setVal_cNumber("border-color: rgba(29, 171, 244, 0.45);border-width:
	// initial;");
	// count=1;
	// }
	// String s=user.getU_name();
	// if(StringUtils.isBlank(s)){
	// user.setVal_name("border-color: rgba(29, 171, 244, 0.45);border-width:
	// initial;");
	// count=1;
	// }
	// s=user.getU_phone();
	// if(StringUtils.isBlank(s)){
	// user.setVal_phone("border-color: rgba(29, 171, 244, 0.45);border-width:
	// initial;");
	// count=1;
	// }
	// s=user.getU_birth2();
	// if(StringUtils.isBlank(s) ||
	// !s.matches("(19|20)[0-9]{2}-((0[1-9])|(1[012]))-[0-3][0-9]")){
	// user.setVal_birth("border-color: rgba(29, 171, 244, 0.45);border-width:
	// initial;");
	// count=1;
	// }
	// return count;
	// }
}