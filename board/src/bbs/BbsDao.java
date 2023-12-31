package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sun.org.apache.bcel.internal.generic.RET;

public class BbsDao {
	private Connection connection;
	private ResultSet rs;
	
	public BbsDao() {
		
		try {
			String Db_Driver = "org.mariadb.jdbc.Driver";
			String Db_Url = "jdbc:mariadb://localhost:3306/test";
			String Db_User = "root";
			String Db_Password = "1234";
			Class.forName(Db_Driver);
			connection = DriverManager.getConnection(Db_Url, Db_User, Db_Password);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public String getDate() {
		String sql = "select now()";
		try {
			PreparedStatement pstmt = connection.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		
		}return "";
	}
		
	public int getNext() {
		String sql = "select bbsID from board order by bbsID desc";
		try {
			PreparedStatement pstmt = connection.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	
	}
		
	
	public int write(String bbsTitle,String userID,String bbsContent) {
		String sql = "insert into board values(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1,getNext());
			pstmt.setString(2,bbsTitle);
			pstmt.setString(3,userID);
			pstmt.setString(4,getDate());
			pstmt.setString(5,bbsContent);
			pstmt.setInt(6,1);
			return pstmt.executeUpdate();
	
		}catch(Exception e) {
			e.printStackTrace();
		
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
			String sql = "select * from board where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				PreparedStatement pstmt = connection.prepareStatement(sql);
				pstmt.setInt(1, getNext()-(pageNumber-1)*10);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
	return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String sql = "select * from board where bbsID<? and bbsAvailable = 1";
		try {
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
	}catch(Exception e) {
		e.printStackTrace();
	} return false;
}
	
	public Bbs getBbs(int BbsID) {
		String sql= "select * from board where BbsID=?";
		try {
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, BbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}return null;
	}
	
	public int update(int bbsID,String bbsTitle,String bbsContent) {
		String sql = "update board set bbsTitle = ?,bbsContent = ? where bbsID = ?";
		try {
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setString(1,bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
				return pstmt.executeUpdate();
	
	}catch(Exception e) {
		e.printStackTrace();
	}return -1;
	
	
}
	public int delete(int bbsID) {
		String sql = "update board set bbsAvailable = 0 where bbsID = ?";
		try {
			PreparedStatement pstmt = connection.prepareStatement(sql);
		
			pstmt.setInt(1, bbsID);
				return pstmt.executeUpdate();
	
	}catch(Exception e) {
		e.printStackTrace();
	}return -1;
	
	}
	
	
}