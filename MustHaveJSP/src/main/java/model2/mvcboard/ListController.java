package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JSFunction;

@WebServlet("/mvcboard/list.do")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MVCBoardDAO dao = null;
		//뷰에 전달할 매개 별수 저장용 맵 생성
//		try {
		Map<String,Object> map = new HashMap<>();
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		if(searchWord!= null) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		dao = new MVCBoardDAO();
		int totalCnt = 0;
		if(dao!=null) {
			totalCnt = dao.selectCount(map);
		}
		
		/* 페이지 처리 start! */
	
		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		// 현재 페이지 확인
		int pageNum = 1; //default
		String pageTemp = req.getParameter("pageNum");
		if(pageTemp!=null&&!pageTemp.equals("")) pageNum = Integer.parseInt(pageTemp); //요청받은 페이지로 수정
		
		//목록에 출력할 게시물 범위 계산
		int start = (pageNum - 1)*pageSize +1;//게시물 첫번호
		int end = pageNum*pageSize;//게시물 막번호
		map.put("start", start);
		map.put("end", end);
		/* 페이지 처리 end */
		
		//게시물 목록받기
		List<MVCBoardDTO> boardLists = null;
		if(dao!=null) {
			boardLists=dao.selectListPage(map);
		}
		dao.close();
		
		//뷰에 전달할 매개변수 추가
		String pagingImg = BoardPage.pagingStr(totalCnt,pageSize,blockPage,pageNum,"../mvcboard/list.do");
		map.put("pagingImg", pagingImg);
		map.put("totalCnt", totalCnt);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		//전달할 데이터를 request 영역에 저장 후 List.jsp로 포워드
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
		
//	}catch(Exception e) {
//		e.printStackTrace();
//	}
	}
}
