package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.LicenseFile;

public interface LicenseFileRepository extends JpaRepository<LicenseFile, Integer> {

	LicenseFile findByMentorApplyId(int mentorApplyId);

}