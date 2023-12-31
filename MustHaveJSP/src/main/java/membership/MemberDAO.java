package membership;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.JDBConnect;
import jakarta.servlet.ServletContext;




public class MemberDAO extends JDBConnect {
	
//	public static void main(String[] args) {
//		MemberDAO md = new MemberDAO("com.mysql.cj.jdbc.Driver",
//				"jdbc:mysql://localhost/musthave", //localhost자리에 IP주소를 사용하여 가능
//				"scott","tiger");//root 는 remote에서는 접근이 일단 불가
//		MemberDTO member = md.getMemberDTO("musthave", "1234");
//		if(member!=null) System.out.println(member);
//		else System.out.println("Data Null");
//	}
	public MemberDAO(String drv,String url, String id,String pw) {
		super(drv,url,id,pw);
	}
	
	public MemberDAO(ServletContext application) {
		super(application);
	}

	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = null; //초기값 설정하지 않을시 불러와지는 값이 없으면 ERROR발생
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1, uid);
			ps.setString(2, upass);
			rs = ps.executeQuery();

			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
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
