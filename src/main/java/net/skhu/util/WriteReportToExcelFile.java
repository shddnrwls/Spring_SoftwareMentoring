package net.skhu.util;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import net.skhu.dto.PastReport;

public class WriteReportToExcelFile {

	@SuppressWarnings("resource")
	public static void writeReportToFile(String fileName, List<PastReport> reportList, HttpServletResponse response)
			throws Exception {
		Workbook workbook = null;

		if (fileName.endsWith("xlsx")) {
			workbook = new XSSFWorkbook();
		} else if (fileName.endsWith("xls")) {
			workbook = new HSSFWorkbook();
		} else {
			throw new Exception("invalid file name, should be xls or xlsx");
		}

		Sheet sheet = workbook.createSheet("report");

		int rowIndex = 0;
		int excelname = 0; // 처음에는 ID 학번등 고정값을 넣기 위해 사용한 변수

		PastReport report = reportList.get(0);
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
		cell4.setCellValue("학기");
		Cell cell5 = row.createCell(5);
		cell5.setCellValue("참여멘티");
		Cell cell6 = row.createCell(6);
		cell6.setCellValue("멘토학번");

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
		cell5.setCellValue(report.getAttendedMentee());
		cell6 = row.createCell(6);
		cell6.setCellValue(report.getMentorId());

		System.out.println("어디가 오류일까나~~~~1");

		// lets write the excel data to file now

		FileOutputStream fos = new FileOutputStream(System.getProperty("user.home") + "/" + fileName);
		workbook.write(fos);
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
		try (BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())) {
			workbook.write(output);
		}

	}

	// 선택한 애들 다운로드
	@SuppressWarnings("resource")
	public static void writeCheckReportToFile(String fileName, List<PastReport> reportList,
			HttpServletResponse response) throws Exception {
		Workbook workbook = null;

		System.out.println("여기는?222");

		if (fileName.endsWith("xlsx")) {
			workbook = new XSSFWorkbook();
		} else if (fileName.endsWith("xls")) {
			workbook = new HSSFWorkbook();
		} else {
			throw new Exception("invalid file name, should be xls or xlsx");
		}

		for (PastReport temp : reportList) {
			Sheet sheet = workbook.createSheet(temp.getYear() + "_" + temp.getWeek() + "주차_" + temp.getMentorId());

			int rowIndex = 0;

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
			cell4.setCellValue("학기");
			Cell cell5 = row.createCell(5);
			cell5.setCellValue("참여멘티");
			Cell cell6 = row.createCell(6);
			cell6.setCellValue("멘토학번");

			row = sheet.createRow(rowIndex++);

			cell0 = row.createCell(0);
			cell0.setCellValue(temp.getId());
			cell1 = row.createCell(1);
			cell1.setCellValue(temp.getWeek());
			cell2 = row.createCell(2);
			cell2.setCellValue(temp.getPlace());
			cell3 = row.createCell(3);
			cell3.setCellValue(temp.getContents());
			cell4 = row.createCell(4);
			cell4.setCellValue(temp.getYear());
			cell5 = row.createCell(5);
			cell5.setCellValue(temp.getAttendedMentee());
			cell6 = row.createCell(6);
			cell6.setCellValue(temp.getMentorId());
		}

		System.out.println("어디가 오류일까나~~~~1");

		// lets write the excel data to file now
		FileOutputStream fos = new FileOutputStream(System.getProperty("user.home") + "/" + fileName);
		workbook.write(fos);
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
		try (BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())) {
			workbook.write(output);
		}
		// workbook.write()
		fos.close();

		System.out.println("어디가 오류일까나~~~~2");

		System.out.println(fileName + " written successfully");
	}

}