package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.Student;
import net.skhu.dto.Team;

public interface TeamRepository extends JpaRepository<Team, Integer> {
	List<Team> findBymentorRoomId(int id);
	List<Team> findBymentorRoomIdAndAthority(int id,int athority);

	Team findByStudent(Student student);

}