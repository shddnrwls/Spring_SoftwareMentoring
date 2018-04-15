package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.Department;

public interface DepartmentRepository extends JpaRepository<Department, Integer> {

}