package boardManagement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;




public class BoardDAO extends JDBConnect {
	
	public BoardDAO(String drv,String url, String id,String pw) {
		super(drv,url,id,pw);
	}
	
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	//검색 조건에 맞는 게시물의 갯수 반환
	public int selectCount(Map<String,Object> map) {
		int totalCnt =0; //게시물 수
		
		Statement st = null;
		ResultSet rs = null;
		
		String query = "SELECT COUNT(*) FROM board ";
		if(map.get("searchWord")!=null) {
			query+=" WHERE "+map.get("searchField") + " "
					+" LIKE '%" +map.get("searchWord") + "%'";
		}
		
		try {
			st = getCon().createStatement();
			rs = st.executeQuery(query);
			rs.next();
			totalCnt = rs.getInt(1);
		}catch(Exception e) {
			System.out.println("게시물 수 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCnt;
	}
	
	public List<BoardDTO> selectList(Map<String,Object> map) {
		List<BoardDTO> bbs = new Vector<>();
		
		Statement st = null;
		ResultSet rs = null;
		
		String query = "SELECT * FROM board ";
		
			if(map.get("searchWord")!=null) {
				query+=" WHERE "+map.get("searchField") + " "
						+" LIKE '%" +map.get("searchWord") + "%'";
			}
			
				query +=" ORDER BY num DESC ";
		
		try {
			st = getCon().createStatement();
			rs = st.executeQuery(query);
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setVisitcount(rs.getInt(6));
				
				bbs.add(dto);
			}
		
		}catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	public List<BoardDTO> selectListPage(Map<String,Object> map) {
		//게시물 목록을 담을 변수
		List<BoardDTO> bbs = new Vector<>();
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String query = "SELECT * FROM ( "
					 + "	SELECT Tb.*, ROWNUM rNum FROM ( "
					 + "		SELECT * FROM board ";
		
			if(map.get("searchWord")!=null) {
				query+=" WHERE "+map.get("searchField")
					  +" LIKE '%" +map.get("searchWord") + "%' ";
			}
			
				query +="		ORDER BY num DESC "
					  + "	) Tb "
					  + " ) "
					  + "WHERE rNum BETWEEN ? AND ?";
		
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1,map.get("start").toString());
			ps.setString(1,map.get("end").toString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setVisitcount(rs.getInt(6));
				
				bbs.add(dto);
			}
		
		}catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	//지정 게시물 조건에 맞는 내용 반환
		public BoardDTO selectView(int num) {
			BoardDTO dto = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			String query = "SELECT b.*,m.name "
					+ " FROM member m INNER JOIN board b "
					+ " ON m.id = b.id "
					+ " WHERE num=?";
			try {
				ps = getCon().prepareStatement(query);
				ps.setInt(1, num);
				rs = ps.executeQuery();
				while(rs.next()) {
					dto = new BoardDTO();
					dto.setNum(rs.getInt(1));
					dto.setTitle(rs.getString(2));
					dto.setContent(rs.getString(3));
					dto.setId(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setVisitcount(rs.getInt(6));
					dto.setName(rs.getString(7));
				}
			
			}catch(Exception e) {
				System.out.println("게시물 조회 중 예외 발생");
				e.printStackTrace();
			}
			return dto;
		}
		
	public void updateVisitCount(int num) {
		String query = "UPDATE board "
				+ " SET visitcount = visitcount+1 "
				+ " WHERE num=?";
		PreparedStatement ps = null;
		try {
			ps = getCon().prepareStatement(query);
			ps.setInt(1, num);
			ps.executeUpdate();
//			ps.executeQuery();
			
		}catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생 ("+e.getMessage()+")");
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null) ps.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	public int insertWrite(BoardDTO dto) {
		int result = 0;

		String query = "INSERT INTO board(title,content,id,visitcount) Values ("
				+ "?,?,?,0)";
		PreparedStatement ps = null;
		
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getContent());
			ps.setString(3, dto.getId());
			
			result = ps.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생 ("+e.getMessage()+")");
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(ps!=null) ps.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int updateEdit(BoardDTO dto) {
		String query = "UPDATE board "
				+ " SET title =?,content=? "
				+ " WHERE num=?";
		PreparedStatement ps = null;
		int result =0;
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getContent());
			ps.setInt(3, dto.getNum());
			
			result = ps.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생 ("+e.getMessage()+")");
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null) ps.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int deletePost(BoardDTO dto) {
		String query = "DELETE FROM board "
				+ " WHERE num=?";
		PreparedStatement ps = null;
		int result =0;
		try {
			ps = getCon().prepareStatement(query);
			ps.setInt(1, dto.getNum());
			
			result = ps.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생 ("+e.getMessage()+")");
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null) ps.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int insertBoardDTO(String utitle, String ucontent, String uid) {
		String query = "INSERT INTO board(title,content,id) Values (?,?,?)";
	
		PreparedStatement ps = null;
		
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
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return 1;
	}
	public BoardDTO getBoardDTO(String utitle, String ucontent, String uid) {
		String query = "SELECT * FROM member WHERE title=? AND content=? AND id=?";
		BoardDTO dto = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1, utitle);
			ps.setString(2, ucontent);
			ps.setString(3, uid);
			rs = ps.executeQuery();
		
			while(rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
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
