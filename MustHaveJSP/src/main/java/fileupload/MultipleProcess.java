package fileupload;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/13FileUpload/MultipleProcess.do")
//파일 업로드 사용시 필수. 파일 사이즈 한계와 파일 여러개의 사이즈
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
)
public class MultipleProcess extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
            String saveDirectory = getServletContext().getRealPath("/Uploads");
            ArrayList<String> listFileName = FileUtil.multipleFile(req, saveDirectory);
            for(String originalFileName:listFileName) {
            	String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
            	insertMyFile(req, resp, originalFileName, savedFileName);
            	}
            resp.sendRedirect("FileList.jsp");
        	}
		catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "파일 업로드 오류 : "+ e.getMessage());
            req.getRequestDispatcher("MultiUploadMain.jsp").forward(req, resp);
        	}
    	}

    private void insertMyFile(HttpServletRequest req, HttpServletResponse resp, String oFileName, String sFileName) throws ServletException, IOException {
        String title = req.getParameter("title");
        String[] cateArray = req.getParameterValues("cate");
        StringBuffer cateBuf = new StringBuffer();

        if (cateArray == null) {
            cateBuf.append("선택한 항목 없음");
        } else {
            for (int i=0;i<cateArray.length;i++) {
            	if(i == 0) cateBuf.append(cateArray[0]);
            	else cateBuf.append(", "+ cateArray[i]);
            }
        }

        MyFileDTO dto = new MyFileDTO();
        dto.setTitle(title);
        dto.setCate(cateBuf.toString());
        dto.setOfile(oFileName);
        dto.setSfile(sFileName);

        MyFileDAO dao = new MyFileDAO();
        int iResult=0;
        iResult=dao.insertFile(dto);
        dao.close();
        if(iResult==0) {
        	req.setAttribute("errorMessage", "DB 업로드에 실패하였습니다");
        	req.getRequestDispatcher("MultiUploadMain.jsp").forward(req, resp);
        }
        else System.out.println("업로드에 성공하였습니다");
        
    }
}