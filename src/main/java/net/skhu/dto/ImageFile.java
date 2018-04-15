package net.skhu.dto;

import java.util.Date;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="imageFile")
public class ImageFile {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	String fileName;
	int fileSize;
	Date fileTime;

	@Basic(fetch = FetchType.LAZY)
	@Lob
	byte[] data;

	@OneToOne
	@JoinColumn(name = "userId")
	User user;

	public String getMimeType() {
		int index = fileName.lastIndexOf('.');
		if (index > 0) {
			String extension = fileName.substring(index + 1).toLowerCase();
			switch (extension) {
			case "png":
			case "bmp":
			case "gif":
				return "image/" + extension;
			}
		}
		return "image/jpeg";
	}

}
