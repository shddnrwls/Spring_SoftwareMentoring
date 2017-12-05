package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.TeamImageFile;

public interface TeamImageFileRepository extends JpaRepository<TeamImageFile, Integer> {

	TeamImageFile findByPastReportId(int pastReportId);

}