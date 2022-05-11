// 관리자기능: 회원관리
package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AdminMemberMgr {

		private DBConnectionMgr pool;
		public static final String SAVEDIRECTORY = 
				"C:/Jsp/myapp/src/main/webapp/saymeow/image/"; // 경로수정할것
		public static final String ENCODING = "EUC-KR";
		public static final int MAXPOSTSIZE = 10*1024*1024;//10mb

		public AdminMemberMgr() {
			pool = DBConnectionMgr.getInstance();
		}

	
	// 1. 전체 회원 리스트업
	public Vector<MemberBean> getAllM() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString(1));				
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setBirthday(rs.getString(4));
				bean.setPhone(rs.getString(5));
				bean.setEmail(rs.getString(6));
				bean.setAddress(rs.getString(7));
				bean.setGrade(rs.getInt(8));
				bean.setMode(rs.getInt(9));
				bean.setPetName(rs.getString(10));
				bean.setPetAge(rs.getString(11));
				bean.setPetGender(rs.getString(12));
				bean.setPetBreed(rs.getString(13));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println("[AdminMemberMgr] getAllM 실행");
		return vlist;
	}
	
	// 2. 회원 검색 (id값으로 검색)
	
	public Vector<MemberBean> searchM(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM member "
				+ "WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString(1));				
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setBirthday(rs.getString(4));
				bean.setPhone(rs.getString(5));
				bean.setEmail(rs.getString(6));
				bean.setAddress(rs.getString(7));
				bean.setGrade(rs.getInt(8));
				bean.setMode(rs.getInt(9));
				bean.setPetName(rs.getString(10));
				bean.setPetAge(rs.getString(11));
				bean.setPetGender(rs.getString(12));
				bean.setPetBreed(rs.getString(13));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println("[AdminMemberMgr] searchM 실행");
		return vlist;
	}
	
}


