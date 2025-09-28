package kr.co.gudi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.expr.Instanceof;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.gudi.dto.BoardDTO;
import kr.co.gudi.service.BoardService;


@RestController
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
//	@RequestParam(value="/")
//	public 
	
	@Autowired BoardService board_ser;
	
//	@PostMapping(value="/list.ajax")
//	public Map<String , Object> listDo() {
//		//List<BoardDTO> list = board_ser.searchAjax();
//		Map<String, Object> map = new HashMap<String, Object>();
//		System.out.println(list.toString());
//		map.put("list", list);
//		return map;
//	}
	@RequestMapping(value="/list.go")
	public ModelAndView listGo(@RequestParam(required = false) Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		int page = 1;
		int cnt = 10;
		System.out.println(map.toString());
		System.out.println(map.get("page"));
		System.out.println(map.get("cnt"));
		if (map != null && !map.isEmpty()) {
			page = (int) Integer.parseInt((String) map.get("page"));
			cnt = (int) Integer.parseInt((String) map.get("cnt"));
		}
		
		System.out.println("page: " + page + " cnt: "+ cnt);
		map.put("startPage", (page-1)*cnt +1 );
		map.put("endPage", page*cnt);
		List<BoardDTO> list = board_ser.searchAjax(map);
		int total = board_ser.totalPageCall(map);
		int totalPages = (int)Math.ceil((double) total / cnt) < 1 ? 1 : (int)Math.ceil((double) total / cnt) ;
		
		int prev = Math.max(page-1, 1);
		int next = Math.min(totalPages,page+1);
		int start = (int) (Math.floor((page- 1) / 5) * 5 + 1);
		int end = Math.min(totalPages, start + 5 - 1);
		int first = Math.max(1,start-1);
		int last = Math.min(totalPages,end+1);
		
		mav.addObject("list",list);
		mav.addObject("page", page);
		mav.addObject("cnt", cnt);
		mav.addObject("totalPages", totalPages);
		mav.addObject("first", first);
		mav.addObject("last", last);
		mav.addObject("prev",prev);
		mav.addObject("next",next);
		mav.addObject("start",start);
		mav.addObject("end",end);

		
		mav.setViewName("list");
		return mav;
	}
	
	@PostMapping(value="/search.ajax")
	public Map<String , Object> searchAjax(@RequestBody Map<String, Object> map ) {
		Map<String, Object> mav = new HashMap<String, Object>();
		int page = (int) map.get("page");
		int cnt = (int) map.get("cnt");
		map.put("startPage", (page-1)*cnt +1 );
		map.put("endPage", page*cnt);
		List<BoardDTO> list = board_ser.searchAjax(map);
		int total = board_ser.totalPageCall(map);
		mav.put("totalPages", ((int)Math.ceil((double) total / cnt) < 1 ? 1 : (int)Math.ceil((double) total / cnt) ));
		mav.put("list", list);
		return mav;
	}
	
	@RequestMapping(value="/write.go")
	public ModelAndView writeGo() {
		return new ModelAndView("write");	
	}
	
	
	@RequestMapping(value="/write.do")
	public ModelAndView writeDo(@RequestParam Map<String, Object> params) {
		int row = board_ser.writeDo(params);
        Object idx = params.get("idx");
		ModelAndView mav = new ModelAndView();
		if (row>0) {
			mav.setViewName("redirect:/detail.do?idx="+idx );
		}else {
			mav.setViewName("write");
		}
		return mav;
	}
	
	@RequestMapping(value="/detail.do")
	public ModelAndView detailDo(int idx) {
		
		
		BoardDTO info = board_ser.detailDo(idx,true);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("detail");
		mav.addObject("info",info);
		return mav;
	}
	

	
	
	@RequestMapping(value="/detailDel.do")
	public ModelAndView detailDel(int idx) {
		int row = board_ser.boardDel(idx);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:list.go");
		return mav;
	}
	
	@RequestMapping(value="/logout.do")
	public ModelAndView logout(HttpSession session) {
		session.removeAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	@RequestMapping(value="/update.go")
	public ModelAndView updateGo(int idx) {
		BoardDTO info = board_ser.detailDo(idx,true);
		ModelAndView mav = new ModelAndView();
		mav.addObject("info",info);
		mav.setViewName("update");
		return mav;
	}
	@RequestMapping(value="/update.do")
	public ModelAndView updateDo(@RequestParam Map<String, Object> params) {
		int row = board_ser.updateDo(params);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/detail.do?idx="+params.get("idx") );
		return mav;
	}
	
}



































