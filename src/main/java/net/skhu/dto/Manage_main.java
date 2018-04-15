package net.skhu.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name ="manage_main")
public class Manage_main {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   int id;

   String contents1;
   String contents2;
   String contents3;
   String contents4;

}