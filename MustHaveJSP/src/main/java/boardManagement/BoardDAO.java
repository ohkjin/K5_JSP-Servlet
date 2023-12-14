package boardManagement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.JDBConnect;




public class BoardDAO extends JDBConnect {
	
//	public static void main(String[] args) {
//		MemberDAO md = new MemberDAO("com.mysql.cj.jdbc.Driver",
//				"jdbc:mysql://localhost/musthave", //localhost자리에 IP주소를 사용하여 가능
//				"scott","tiger");//root 는 remote에서는 접근이 일단 불가
//		MemberDTO member = md.getMemberDTO("musthave", "1234");
//		if(member!=null) System.out.println(member);
//		else System.out.println("Data Null");
//	}
	public BoardDAO(String drv,String url, String id,String pw) {
		super(drv,url,id,pw);
	}
	public int insertBoardDTO(String utitle, String ucontent, String uid) {
		BoardDTO dto = new BoardDTO();
		String query = "INSERT INTO board(title,content,id)"
				+"SELECT ?,?,?";
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1, utitle);
			ps.setString(2, ucontent);
			ps.setString(3, uid);
			ps.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(ps!=null) ps.close();
				if(rs!=null) rs.close(); //실패시 rs값이 null이기에 닫을때 에러
										 //예외 발생시 못닫을수 있기에 trycatch로 감싸는것이 좋다
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return 1;
	}
	public BoardDTO getBoardDTO(String utitle, String ucontent, String uid) {
		BoardDTO dto = new BoardDTO();
		String query = "SELECT * FROM member WHERE title=? AND content=? AND id=?";
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1, utitle);
			ps.setString(2, ucontent);
			ps.setString(3, uid);
			rs = ps.executeQuery();
		
			if(rs.next()) {
				BoardDTO m = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostdate(rs.getString(5));
				dto.setVisitcount(rs.getInt(6));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null) ps.close();
				if(rs!=null) rs.close(); //실패시 rs값이 null이기에 닫을때 에러
										 //예외 발생시 못닫을수 있기에 trycatch로 감싸는것이 좋다
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
}