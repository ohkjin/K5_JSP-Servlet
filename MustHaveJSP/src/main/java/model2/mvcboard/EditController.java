package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/edit.do")
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
)
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int idx = 0;
		String sidx = req.getParameter("idx");
		if(sidx!=null) idx = Integer.parseInt(sidx);
		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDTO dto = dao.selectView(idx);
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/14MVCBoard/Edit.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//1. File Upload ============
		// Check physical Upload Directory
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		//File Upload
		String originalFileName = "";
		try {
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		}catch(Exception e) {
			JSFunction.alertBack(resp,"File Upload Error");
		}
	
		//2. Other  =================
		// Get Edited from Parameter
		int idx = 0;
		String sidx = req.getParameter("idx");
		if(sidx!=null) idx = Integer.parseInt(sidx);
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		
//		String name = req.getParameter("name");
//		String title = req.getParameter("title");
//		String content = req.getParameter("content");
//		
		// Get pwd from Session
		HttpSession session = req.getSession();
		String pass = (String)session.getAttribute("pass");
		
		// Save to DTO
		MVCBoardDTO dto = new MVCBoardDTO();
		dto.setIdx(idx);
		dto.setName(req.getParameter("name"));
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		dto.setPass(pass);
		
		// Set OriginalFileName and SavedFileName
		if(originalFileName!="") {
			//change if attached file exists
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
			dto.setOfile(originalFileName);
			dto.setSfile(savedFileName);
			
			//Delete Original
			FileUtil.deleteFile(req, "/Uploads", prevSfile);
		}
		else {
			//Remain if no attached file
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		//Update edited content on DB by DAO
		MVCBoardDAO dao = new MVCBoardDAO();
		int result = dao.updatePost(dto);
		dao.close();
	
		if(result==1) {
			session.removeAttribute("pass");
			resp.sendRedirect("../mvcboard/view.do?idx="+sidx);
		}else {
			JSFunction.alertLocation(resp, "Wrong Password", "../mvcboard/view.do?idx="+sidx);
		}
	}
}
