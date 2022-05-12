package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AdminOrderMgr {
	private DBConnectionMgr pool;
	
	public AdminOrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 전체 레코드 수 카운트
	public int getCountRecord(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int recordCnt = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("") || keyWord==null) { // 검색일 때
				sql = "SELECT count(*) "
					+ "FROM petorder ";
				pstmt = con.prepareStatement(sql);
			} else { // 검색 아닐 때
				sql = "SELECT count(*) "
					+ "FROM petorder "
					+ "WHERE " + keyField + " LIKE ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // %안붙이는 오류 주의
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				recordCnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return recordCnt; // 개수 반환
	}
	
	
	
	// 전체 주문목록 가져오기
	public Vector<OrderBean> getOrderList(String keyField, String keyWord, int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // 검색안했다면
				sql = "SELECT * "
					+ "FROM petorder "
					+ "ORDER BY onum DESC "
					+ "LIMIT ?, ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else { // 검색했다면
				sql = "SELECT * "
					+ "FROM petorder "
					+ "WHERE " + keyField + " LIKE ? "
					+ "ORDER BY onum DESC " 
					+ "LIMIT ?, ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord +"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean bean = new OrderBean();
				
				bean.setOnum(rs.getInt(1));
				bean.setPnum(rs.getInt(2));
				bean.setQty(rs.getInt(3));
				bean.setPname(rs.getString(4));
				bean.setOid(rs.getString(5));
				bean.setRegdate(rs.getString(6));
				bean.setOaddress(rs.getString(7));
				bean.setState(rs.getString(8));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 주문내역 일부 삭제
	public void deleteOrder(String onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
				con = pool.getConnection();
				sql = "DELETE FROM petorder "
					+ "WHERE onum = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(onum));
				pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	// (테스트용 메소드) Post 1000 : (한 페이지당 10개의 게시글)1000개의 게시물 입력 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT petorder(pnum,qty,pname,oid,regdate,oaddress,state) "
				+ "VALUES (1, 22, '카샤카샤', 1, now(),'부산', '배송완료');";
			pstmt = con.prepareStatement(sql);
			// 1000번 반복
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate(); // 실행
			}
			System.out.println("Post1000 Success"); 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	public static void main(String[] args) {
		AdminOrderMgr aoMgr = new AdminOrderMgr(); 
		aoMgr.post1000(); // 테스트용 1000개 레코드 입력 메소드 호출
	}
	
	
	
	
}
