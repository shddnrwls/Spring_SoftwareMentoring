package net.skhu.util;

import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import net.skhu.dto.Report;

public class WriteReportToExcelFile {

	public static void writeReportToFile(String fileName, List<Report> reportList) throws Exception{
		Workbook workbook = null;

		if(fileName.endsWith("xlsx")){
			workbook = new XSSFWorkbook();
		}else if(fileName.endsWith("xls")){
			workbook = new HSSFWorkbook();
		}else{
			throw new Exception("invalid file name, should be xls or xlsx");
		}

		Sheet sheet = workbook.createSheet("report");

		int rowIndex = 0;
		int excelname=0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수

		Report report = reportList.get(0);
		Row row = sheet.createRow(rowIndex++);

		Cell cell0 = row.createCell(0);
		cell0.setCellValue("ID");
		Cell cell1 = row.createCell(1);
		cell1.setCellValue("주차");
		Cell cell2 = row.createCell(2);
		cell2.setCellValue("장소");
		Cell cell3 = row.createCell(3);
		cell3.setCellValue("내용");
		Cell cell4 = row.createCell(4);
		cell4.setCellValue("년도");
		Cell cell5 = row.createCell(5);
		cell5.setCellValue("학기");


		row = sheet.createRow(rowIndex++);

		cell0 = row.createCell(0);
		cell0.setCellValue(report.getId());
		cell1 = row.createCell(1);
		cell1.setCellValue(report.getWeek());
		cell2 = row.createCell(2);
		cell2.setCellValue(report.getPlace());
		cell3 = row.createCell(3);
		cell3.setCellValue(report.getContents());
		cell4 = row.createCell(4);
		cell4.setCellValue(report.getYear());
		cell5 = row.createCell(5);
		cell5.setCellValue(report.getSemester());

		System.out.println("어디가 오류일까나~~~~1");

		//lets write the excel data to file now
		FileOutputStream fos = new FileOutputStream(System.getProperty("user.home")+"/"+fileName);
		workbook.write(fos);
		fos.close();

		System.out.println("어디가 오류일까나~~~~2");

		System.out.println(fileName + " written successfully");
	}


	public static void writeAllReportToFile(String fileName, List<Report> reportList) throws Exception{
		Workbook workbook = null;

		if(fileName.endsWith("xlsx")){
			workbook = new XSSFWorkbook();
		}else if(fileName.endsWith("xls")){
			workbook = new HSSFWorkbook();
		}else{
			throw new Exception("invalid file name, should be xls or xlsx");
		}

		Sheet sheet = workbook.createSheet("report");

		Iterator<Report> iterator = reportList.iterator();

		int rowIndex = 0;
		int excelname = 0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수

		do{
			Report report = iterator.next();
			Row row = sheet.createRow(rowIndex++);


			if(excelname==0){ // 처음에 고정값
				Cell cell0 = row.createCell(0);
				cell0.setCellValue("ID");
				Cell cell1 = row.createCell(1);
				cell1.setCellValue("주차");
				Cell cell2 = row.createCell(2);
				cell2.setCellValue("장소");
				Cell cell3 = row.createCell(3);
				cell3.setCellValue("내용");
				Cell cell4 = row.createCell(4);
				cell4.setCellValue("년도");
				Cell cell5 = row.createCell(5);
				cell5.setCellValue("학기");

				row = sheet.createRow(rowIndex++);

				cell0 = row.createCell(0);
				cell0.setCellValue(report.getId());
				cell1 = row.createCell(1);
				cell1.setCellValue(report.getWeek());
				cell2 = row.createCell(2);
				cell2.setCellValue(report.getPlace());
				cell3 = row.createCell(3);
				cell3.setCellValue(report.getContents());
				cell4 = row.createCell(4);
				cell4.setCellValue(report.getYear());
				cell5 = row.createCell(5);
				cell5.setCellValue(report.getSemester());

				excelname++;

			} else {  // 다음부터는 순차적으로 값이 들어감
				Cell cell0 = row.createCell(0);
				cell0.setCellValue(report.getId());
				Cell cell1 = row.createCell(1);
				cell1.setCellValue(report.getWeek());
				Cell cell2 = row.createCell(2);
				cell2.setCellValue(report.getPlace());
				Cell cell3 = row.createCell(3);
				cell3.setCellValue(report.getContents());
				Cell cell4 = row.createCell(4);
				cell4.setCellValue(report.getYear());
				Cell cell5 = row.createCell(5);
				cell5.setCellValue(report.getSemester());
			}

		}while(iterator.hasNext());


		System.out.println("어디가 오류일까나~~~~1");

		//lets write the excel data to file now
		FileOutputStream fos = new FileOutputStream(System.getProperty("user.home")+"/"+fileName);
		workbook.write(fos);
		fos.close();

		System.out.println("어디가 오류일까나~~~~2");

		System.out.println(fileName + " written successfully");
	}


}