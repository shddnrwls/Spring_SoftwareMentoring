package net.skhu.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pastreport")
public class PastReport {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   int id;

   String mentorId;
   String depName;
   String mentor;
   String mentees;
   String place;
   String contents;
   String file;
   String year;
   int week;
   String attendedMentee;

}