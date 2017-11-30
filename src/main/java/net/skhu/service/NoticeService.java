package net.skhu.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.skhu.dto.Notice;
import net.skhu.model.NoticeModel;
import net.skhu.model.Option;
import net.skhu.model.Pagination;
import net.skhu.repository.NoticeRepository;

@Service
public class NoticeService {

	@Autowired NoticeRepository noticeRepository;

	public Notice findOne(int id){
		Notice notice = noticeRepository.findOne(id);
		notice.setHit(notice.getHit() + 1);
		noticeRepository.save(notice);
		return notice;
	}

	public List<Notice> findAll(Pagination pagination){
		return noticeRepository.findAll(pagination);
	}

	public void update(NoticeModel a){
		System.out.println("들어오냐2");
		noticeRepository.update(a.getId(), a.getTitle(), a.getContent());
	}

	public int insertNotice(NoticeModel a){
		Notice last = noticeRepository.findTopByOrderByNoDesc();
        int no = (last == null) ? 1 : last.getNo() + 1;
        Notice notice = new Notice();

        notice.setNo(no);						// no 최대값 + 1 전달
        notice.setTitle(a.getTitle());
        notice.setContent(a.getContent());
        notice.setDate(new Date());

        noticeRepository.save(notice);

        return notice.getId();
	}

	public void delete(int id){
		noticeRepository.delete(id);
	}

	public Option[] getOrderByOptions(){
		return noticeRepository.orderBy;
	}

	public Option[] getSearchByOptions(){
		return noticeRepository.searchBy;
	}

}
