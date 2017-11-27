package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.ImageFile;

public interface ImageFileRepository extends JpaRepository<ImageFile, Integer> {

	ImageFile findByUserId(int id);

	void deleteByUserId(int id);

}