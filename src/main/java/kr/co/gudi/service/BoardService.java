package kr.co.gudi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.dto.BoardDTO;
import kr.co.gudi.mapper.BoardMapper;

@Service
public class BoardService {

	@Autowired BoardMapper board_mer;
	
	public List<BoardDTO> searchAjax(Map<String, Object> map) {
		return board_mer.searchAjax(map);
	}

	public int writeDo(Map<String, Object> params) {
		return board_mer.writeDo(params);
	}

	public BoardDTO detailDo(int idx, boolean flag) {
		if (flag) {
			int row = board_mer.bhit(idx);
		}
		
		return board_mer.detailDo(idx);
	}

	public int boardDel(int idx) {
		return board_mer.boardDel(idx);
	}

	public int updateDo(Map<String, Object> params) {
		return board_mer.updateDo(params);
	}

	public int totalPageCall(Map<String, Object> map) {
		return board_mer.totalPageCall(map);
	}

}
