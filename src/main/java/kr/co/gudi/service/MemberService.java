package kr.co.gudi.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.mapper.MemberMapper;

@Service
public class MemberService {

	@Autowired MemberMapper member_mer;
	public int memberDo(Map<String, Object> params) {
		return member_mer.memberDo(params);
	}
	public int loginDo(Map<String, Object> params) {
		return member_mer.loginDo(params);
	}

}
