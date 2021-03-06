package poly.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.ProjectsDTO;
import poly.service.IJoinService;
import poly.service.IMypageService;
import poly.util.CmmUtil;

@Controller("MypageController")
public class MypageController {

	@Resource(name = "JoinService")
	private IJoinService JoinService;
	@Resource(name = "MypageService")
	private IMypageService MypageService;
	
	private Logger log = Logger.getLogger(getClass());
	
	
	// ================================= 마이페이지
	@RequestMapping(value = "mypage")
	public String mypage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		log.info("마이페이지 화면 출력");
		if (session.getAttribute("id") == null) {
			String url = "/user/login.do";
			String msg = "로그인이 필요합니다.";
			request.setAttribute("url", url);
			request.setAttribute("msg", msg);
			return "/redirect";
		}
		ArrayList<String> rList = (ArrayList)session.getAttribute("UserAllerList");
		Collections.sort(rList);
		
		HashMap<String, String> hm = new HashMap<>();
		
		hm.put("갑각류", rList.contains("갑각류")?"checked":"");
		hm.put("달걀", rList.contains("달걀")?"checked":"");
		hm.put("땅콩", rList.contains("땅콩")?"checked":"");
		hm.put("밀", rList.contains("밀")?"checked":"");
		hm.put("생선", rList.contains("생선")?"checked":"");
		hm.put("우유", rList.contains("우유")?"checked":"");
		hm.put("조개", rList.contains("조개")?"checked":"");
		hm.put("콩", rList.contains("콩")?"checked":"");
		
		model.addAttribute("hm",hm);

		for(String key : hm.keySet()) {
			log.info(key+" 알러지 여부 : "+hm.get(key));
		}
		
		
		return "/mypage/mypage";
	}
	
	@RequestMapping(value = "mypage/logout")
	public String logout(HttpSession session) {
		log.info("로그아웃 시작");
		session.invalidate();
		
		String result = "/alert/logOutAlert";
		
		return result;
	}

	// ================================= 마이페이지 개인정보 수정 로직 
	@RequestMapping(value="/user/userUpdate.do")
	public String userUpdate(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		
		int res = 0;
		//마이페이지 수정 결과에 대한 메시지를 전달할 변수
	    String msg= "";
		
		//마이페이지 입력화면 에서 받는 정보를 저장할 변수
	    ProjectsDTO uDTO = null;
	    try { 
		//효율적인 문자열 붙이기를 위한 스트링빌더 사용
		StringBuilder allergySB= new StringBuilder();
		for(int i =0;i<8;i++) {
			String str= CmmUtil.nvl(request.getParameter( ("allergy"+(i+1))  ) );
			
			if(!str.equals("") && !str.equals("undifined")) {
				log.info("str : "+str);
				allergySB.append(str);
				if(i!=7)
				allergySB.append(",");
				}
			}
	    
		String allergy = allergySB.toString();
	    
		log.info("마이페이지에서 받아온 수정할 allergy : "+allergy);
		
		//마이페이지에서 받는 정보를 저장할 변수를 메모리에 올리기
		uDTO = new ProjectsDTO();
		uDTO.setUser_allergy(allergy);
		uDTO.setUser_id(CmmUtil.nvl((String)session.getAttribute("id")));
		
		res = MypageService.updateAller(uDTO);

		
		if (res==1) {
            msg = "알레르기 정보 변경에 성공하였습니다.";
            //변경된 알러지 정보 jsp에 전달
            model.addAttribute("allergy", allergy);
            log.info("msg : " + msg );
         }else {
            msg = "알레르기 정보 변경에 실패하였습니다.\n 관리자에게 문의해주세요.";
         }
	
		
	    }catch(Exception e) {
         //저장이 실패되면 사용자에게 보여줄 메시지
         msg = "Fail :" + e.toString();
         res=0;
         log.info(e.toString());
         e.printStackTrace();
         
      }finally {
         log.info(this.getClass().getName() + "마이페이지 개인정보 수정 로직 종료");
         //마이페이지 수정 결과 jsp로 전달
         model.addAttribute("msg", msg);
         model.addAttribute("res", Integer.toString(res));
         
         uDTO = null;
      }
        
		return "/alert/userUpMsg";
	}
		
	
	}


