package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.Report;

public interface ReportRepository extends JpaRepository<Report, Integer> {

	List<Report> findByWeek(String week);

	List<Report> findByMentorRoomId(int id);

}