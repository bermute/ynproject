package kr.co.gudi.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	int memberDo(Map<String, Object> params);

	int loginDo(Map<String, Object> params);

}
