package fileupload;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class MyFileDAO extends JDBConnect {
	
	public int insertFile(MyFileDTO dto) {
		int result = 0;

		String query = "INSERT INTO myfile(title,cate,ofile,sfile) Values ("
				+ "?,?,?,?)";
		PreparedStatement ps = null;
		
		try {
			ps = getCon().prepareStatement(query);
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getCate());
			ps.setString(3, dto.getOfile());
			ps.setString(4, dto.getSfile());
			
			result = ps.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("Insert 중 예외 발생 ("+e.getMessage()+")");
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
	
	public List<MyFileDTO> myFileList() {
		List<MyFileDTO> filelist = new Vector<>();
		
		Statement st = null;
		ResultSet rs = null;
		MyFileDTO dto = null;
		
		String query = "SELECT * FROM myfile ORDER BY idx DESC ";
		
		try {
			st = getCon().createStatement();
			rs = st.executeQuery(query);
			while(rs.next()) { //목록안 파일 수만큼 반복
				dto = new MyFileDTO();
				dto.setIdx(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setCate(rs.getString(3));
				dto.setOfile(rs.getString(4));
				dto.setSfile(rs.getString(5));
				dto.setPostdate(rs.getDate(6));
				
				filelist.add(dto);
			}
		
		}catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return filelist;
	}
	
}
