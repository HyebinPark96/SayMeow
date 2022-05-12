package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class OrderMgr {
	private DBConnectionMgr pool;
	
	public OrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//insert
	// 접수중(1) , 접수완료(2) , 배송 준비중(3), 배송중(4), 배송완료(5), 주문취소(6)
	public void insertOrder(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert petorder(pnum, qty, pname, id, regdate, oaddress, state) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order.getPnum());
			pstmt.setInt(2, order.getQty());
			pstmt.setString(3, order.getPname());
			pstmt.setString(4, order.getId());
			pstmt.setString(5, UtilMgr.getDay());
			pstmt.setString(6, order.getOaddress());
			pstmt.setString(7, "1");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//list
	public Vector<OrderBean> getOrderList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from petorder where id=? order by onum desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setOnum(rs.getInt("onum"));
				order.setPnum(rs.getInt("pnum"));
				order.setQty(rs.getInt("qty"));
				order.setPname(rs.getString("pname"));
				order.setId(rs.getString("id"));
				order.setRegdate(rs.getString("regdate"));
				order.setOaddress(rs.getString("oaddress"));
				order.setState(rs.getString("state"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//cancle
	public void cancleOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			//여기서 for문 돌리기
			sql = "update petorder set state=? where onum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "6");
			pstmt.setInt(2, onum);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	/*admin*/
	//detail
	public OrderBean getOrderDetail(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		OrderBean order = new OrderBean();
		try {
			con = pool.getConnection();
			sql = "select * from petorder where onum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order.setOnum(rs.getInt("onum"));
				order.setPnum(rs.getInt("pnum"));
				order.setQty(rs.getInt("qty"));
				order.setPname(rs.getString("pname"));
				order.setId(rs.getString("id"));
				order.setRegdate(rs.getString("regdate"));
				order.setOaddress(rs.getString("oaddress"));
				order.setState(rs.getString("state"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return order;
	}
	
	//all list
	public Vector<OrderBean> getOrderAllList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from petorder order by onum desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setOnum(rs.getInt("onum"));
				order.setPnum(rs.getInt("pnum"));
				order.setQty(rs.getInt("qty"));
				order.setPname(rs.getString("pname"));
				order.setId(rs.getString("id"));
				order.setRegdate(rs.getString("regdate"));
				order.setOaddress(rs.getString("oaddress"));
				order.setState(rs.getString("state"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//update
	public boolean updateOrder(int onum, String state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update petOrder set state = ? where onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setInt(2, onum);
			if(pstmt.executeUpdate()==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//delete
	public boolean deleteOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from petorder where onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			if(pstmt.executeUpdate()==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//review
	public boolean reviewOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from petorder where onum=? and state=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			pstmt.setString(2, "5");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
}
