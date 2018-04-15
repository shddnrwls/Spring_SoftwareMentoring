package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.MentorRoom;

public interface MentorRoomRepository extends JpaRepository<MentorRoom, Integer> {

	MentorRoom findByStudentId(int id);

}