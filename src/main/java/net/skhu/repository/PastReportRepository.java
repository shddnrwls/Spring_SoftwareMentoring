package net.skhu.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.PastReport;
import net.skhu.model.Option;
import net.skhu.model.Pagination;

public interface PastReportRepository extends JpaRepository<PastReport, Integer> {

   Option[] searchBy = { new Option(0, "검색조건"), new Option(1, "날짜"), new Option(2, "학번"), new Option(3, "학과"),
         new Option(4, "연도") };

   Option[] orderBy = { new Option(0, "정렬순서"), new Option(1, "날짜"), new Option(2, "학번"), new Option(3, "학과"),
         new Option(4, "연도") };

   Sort[] sort = { new Sort(Sort.Direction.ASC, "id"), new Sort(Sort.Direction.DESC, "week"),
         new Sort(Sort.Direction.ASC, "mentorId"), new Sort(Sort.Direction.ASC, "depName"),
         new Sort(Sort.Direction.ASC, "year") };

   public default List<PastReport> findAll(Pagination pagination) {
      Pageable pageable = new PageRequest(pagination.getPg() - 1, pagination.getSz(), sort[pagination.getOb()]);

      Page<PastReport> page;

      String searchText = pagination.getSt();

      switch (pagination.getSb()) {
      case 1:
         page = this.findByWeek(Integer.parseInt(searchText), pageable);
         break;
      case 2:
         page = this.findByMentorIdContaining(searchText, pageable);
         break;
      case 3:
         page = this.findByDepNameContaining(searchText, pageable);
         break;
      case 4:
         page = this.findByYearContaining(searchText, pageable);
         break;

      default:
         page = this.findAll(pageable);
         break;
      }
      pagination.setRecordCount((int) page.getTotalElements());
      return page.getContent();
   }

   public Page<PastReport> findByDepNameContaining(String s, Pageable pageable);
   public Page<PastReport> findByMentorIdContaining(String s, Pageable pageable);
   public Page<PastReport> findByYearContaining(String s, Pageable pageable);
   public Page<PastReport> findByWeek(int s, Pageable pageable);
}