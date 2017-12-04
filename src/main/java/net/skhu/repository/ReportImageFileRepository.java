package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.ReportImageFile;

public interface ReportImageFileRepository extends JpaRepository<ReportImageFile, Integer>{
	/*ReportImageFile findByReportId(int reportId);*/
}