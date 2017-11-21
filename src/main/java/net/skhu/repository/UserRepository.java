package net.skhu.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.dto.User;
import net.skhu.model.Option;
import net.skhu.model.Pagination;

public interface UserRepository extends JpaRepository<User, Integer> {
	// JPA query creation 기능에 의해 이 메소드가 자동으로 구현된다.
	User findOneByUserId(String userId);

	Option[] searchBy = { new Option(0, "검색조건"), new Option(1, "학번(교번)"), new Option(2, "이름"), new Option(3, "유형"),
			new Option(4, "권한") };

	Option[] orderBy = { new Option(0, "정렬순서"), new Option(1, "학번(교번)"), new Option(2, "이름"), new Option(3, "유형"),
			new Option(4, "권한") };

	Sort[] sort = { new Sort(Sort.Direction.ASC, "id"), new Sort(Sort.Direction.DESC, "userId"),
			new Sort(Sort.Direction.ASC, "name"), new Sort(Sort.Direction.ASC, "job"),
			new Sort(Sort.Direction.ASC, "Authority") };

	public default List<User> findAll(Pagination pagination) {
		Pageable pageable = new PageRequest(pagination.getPg() - 1, pagination.getSz(), sort[pagination.getOb()]);

		Page<User> page;

		// 학생/교수/직원 키워드로 검색했을때 db에서 int로 구분되어있으므로 변경해주는 코드.
		if (pagination.getSb() == 3)
			switch (pagination.getSt()) {
			case "학생":
				pagination.setSt("1");
				break;
			case "교수":
				pagination.setSt("2");
				break;
			case "직원":
				pagination.setSt("3");
				break;
			default:
				pagination.setSt("0");
			}

		// 멘토/멘티/관리자 키워드로 검색했을때 db에서 int로 구분되어있으므로 변경해주는 코드.
		if (pagination.getSb() == 4)
			switch (pagination.getSt()) {
			case "멘토":
				pagination.setSt("1");
				break;
			case "멘티":
				pagination.setSt("2");
				break;
			case "관리자":
				pagination.setSt("3");
				break;
			default:
				pagination.setSt("0");
			}

		String searchText = pagination.getSt();

		switch (pagination.getSb()) {
		case 1:
			page = this.findByUserIdContaining(searchText, pageable);
			break;
		case 2:
			page = this.findByNameContaining(searchText, pageable);
			break;
		case 3:
			page = this.findByJobContaining(searchText, pageable);
			break;
		case 4:
			page = this.findByAuthorityContaining(searchText, pageable);
			break;

		default:
			page = this.findAll(pageable);
			break;
		}
		pagination.setRecordCount((int) page.getTotalElements());
		return page.getContent();
	}

	public Page<User> findByUserIdContaining(String s, Pageable pageable);

	public Page<User> findByNameContaining(String s, Pageable pageable);

	public Page<User> findByJobContaining(String s, Pageable pageable);

	public Page<User> findByAuthorityContaining(String s, Pageable pageable);

}