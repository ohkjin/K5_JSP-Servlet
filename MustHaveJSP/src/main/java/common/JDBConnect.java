package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletContext;

public class JDBConnect {
	private Connection con;
//	public Statement stmt;
//	public PreparedStatement psmt;
//	public ResultSet rs;
	
	public JDBConnect() {
		try {
			//HardCoding
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/musthave";
			String username ="scott";
			String password ="tiger";
			
			Class.forName(driver);
			con=DriverManager.getConnection(url,username,password);
			
			System.out.println("DB 연결 성공 (기본 생성자");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getCon() {
		return con;
	}

	public void setCon(Connection con) {
		this.con = con;
	}

	public JDBConnect(String driver,String url, String id, String pwd) {
		try {
			Class.forName(driver);
			con=DriverManager.getConnection(url,id,pwd);
			
			System.out.println("DB 연결 성공 (인수 생성자 1");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public JDBConnect(ServletContext application) {
		try {
			//HardCoding
			String driver = application.getInitParameter("MySQLDriver");
			String url = application.getInitParameter("MySQLURL");
			String id =application.getInitParameter("MySQLId");
			String pwd =application.getInitParameter("MySQLPwd");
			
			Class.forName(driver);
			con=DriverManager.getConnection(url,id,pwd);
			
			System.out.println("DB 연결 성공 (인수 생성자 2");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close() {
		try {
//			if(rs!=null) rs.close();
//			if(stmt!=null) stmt.close();
//			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
			
			System.out.println("JDBC 자원 해제");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}