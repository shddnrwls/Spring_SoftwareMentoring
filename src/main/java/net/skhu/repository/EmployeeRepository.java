package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {

	Employee findByUserUserId(String userId);

}
