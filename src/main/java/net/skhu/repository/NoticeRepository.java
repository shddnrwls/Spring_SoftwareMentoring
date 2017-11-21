package net.skhu.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import net.skhu.dto.Notice;
import net.skhu.model.Option;
import net.skhu.model.Pagination;

public interface NoticeRepository extends JpaRepository<Notice, Integer> {

	Option[] searchBy = { new Option(0, "검색 없음"), new Option(1, "제목"), new Option(2, "본문") };
	Option[] orderBy = { new Option(0, "최근 글"), new Option(1, "오래된 글") };

	Sort[] sort = { new Sort(Sort.Direction.DESC, "id"), new Sort(Sort.Direction.ASC, "id") };

	public default List<Notice> findAll(Pagination pagination) {
		Pageable pageable = new PageRequest(pagination.getPg() - 1, pagination.getSz(), sort[pagination.getOb()]);

		Page<Notice> page;
		String searchText = pagination.getSt();
		switch (pagination.getSb()) {
		case 1:
			page = this.findByTitleContains(searchText, pageable);
			break;
		case 2:
			page = this.findByContentContains(searchText, pageable);
			break;
		default:
			page = this.findAll(pageable);
			break;
		}
		pagination.setRecordCount((int) page.getTotalElements());
		return page.getContent();
	}
	public Page<Notice> findByTitleContains(String title, Pageable pageable);
	public Page<Notice> findByContentContains(String content, Pageable pageable);
	public Notice findTopByOrderByNoDesc();

	/*
	 * 수정된 게시글을 저장하기 위한 메소드
	 * CURRENT_TIMESTAMP() 현재 날짜 시각을 리턴하는 JPQL 함수
	 * @Query에 정의된 JPQL 명령이 UPDATE이거나 DELETE라면 @Modifying 어노테이션도 반드시 붙어있어야 한다.
	 */
    @Modifying
    @Query("UPDATE Notice SET title=:title, content=:content, date=CURRENT_TIMESTAMP() WHERE id=:id")
    public void update(@Param("id") int id, @Param("title") String title, @Param("content") String content);

}
