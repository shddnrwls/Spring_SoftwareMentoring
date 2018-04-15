package net.skhu.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="surveyURL")
public class SurveyURL {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   int id;

   String menteeURL;
   String mentorURL;

}