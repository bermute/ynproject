package kr.co.gudi.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.gudi.service.MemberService;

@RestController
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MemberService member_ser;
	
	@RequestMapping(value="/")
	public ModelAndView member() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}
	
	@RequestMapping(value="/membership.go")
	public ModelAndView membership() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("membership");
		return mav;
	}
	
	@PostMapping(value="membership.do")
	public ModelAndView memberDo(@RequestParam Map<String, Object> params) {
		//logger.info("벨류값 확인: " + params);
		int row = member_ser.memberDo(params);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");	
		return mav;
		
	}
	
	@PostMapping(value="login.do")
	public ModelAndView loginDo(@RequestParam Map<String, Object> params , HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		int row = member_ser.loginDo(params);
		if (row >0) {
			mav.setViewName("list");
			session.setAttribute("loginId", params.get("id"));
			
		}else {
			mav.setViewName("redirect:/");
		}
		
		return mav;
	}
	
	
}
