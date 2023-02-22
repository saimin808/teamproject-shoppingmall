package com.onore.project.mapper;

import java.util.List;

import com.onore.project.dto.NoticeDTO;

public interface NoticeMapper {
	
	Integer insertNotice(NoticeDTO notice);
	List<NoticeDTO> getAllNotice();
	NoticeDTO getNotice(Integer notice_num);
	Integer updateNotice(NoticeDTO notice);
	
}
