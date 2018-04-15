package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.Student;

public interface StudentRepository extends JpaRepository<Student, Integer> {

	Student findByUserUserId(String userId);

	Student findOneByUserId(int userId);


}
