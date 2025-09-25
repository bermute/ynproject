package kr.co.gudi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gudi.dto.BoardDTO;

@Mapper
public interface BoardMapper {

	List<BoardDTO> searchAjax(Map<String, Object> map);

	int writeDo(Map<String, Object> params);

	BoardDTO detailDo(int idx);

	int bhit(int idx);

	int boardDel(int idx);

	int updateDo(Map<String, Object> params);

	int totalPageCall(Map<String, Object> map);

	
}
