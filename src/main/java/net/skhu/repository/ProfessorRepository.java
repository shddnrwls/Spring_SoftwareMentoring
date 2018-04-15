package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.Professor;

public interface ProfessorRepository extends JpaRepository<Professor, Integer> {

	Professor findByUserUserId(String name);

}
