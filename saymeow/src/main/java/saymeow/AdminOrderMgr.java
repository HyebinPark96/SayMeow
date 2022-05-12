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
	
	// ��ü ���ڵ� �� ī��Ʈ
	public int getCountRecord(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int recordCnt = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("") || keyWord==null) { // �˻��� ��
				sql = "SELECT count(*) "
					+ "FROM petorder ";
				pstmt = con.prepareStatement(sql);
			} else { // �˻� �ƴ� ��
				sql = "SELECT count(*) "
					+ "FROM petorder "
					+ "WHERE " + keyField + " LIKE ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // %�Ⱥ��̴� ���� ����
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				recordCnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return recordCnt; // ���� ��ȯ
	}
	
	
	
	/*
	 * // ��ü �ֹ���� �������� public Vector<OrderBean> getOrderList(String keyField, String
	 * keyWord, int start, int cnt){ Connection con = null; PreparedStatement pstmt
	 * = null; ResultSet rs = null; String sql = null; Vector<OrderBean> vlist = new
	 * Vector<OrderBean>(); try { con = pool.getConnection();
	 * if(keyWord==null||keyWord.trim().equals("")) { // �˻����ߴٸ� sql = "SELECT * " +
	 * "FROM petorder " + "ORDER BY onum DESC " + "LIMIT ?, ? "; pstmt =
	 * con.prepareStatement(sql); pstmt.setInt(1, start); pstmt.setInt(2, cnt); }
	 * else { // �˻��ߴٸ� sql = "SELECT * " + "FROM petorder " + "WHERE " + keyField +
	 * " LIKE ? " + "ORDER BY onum DESC " + "LIMIT ?, ? "; pstmt =
	 * con.prepareStatement(sql); pstmt.setString(1, "%" + keyWord +"%");
	 * pstmt.setInt(2, start); pstmt.setInt(3, cnt); } rs = pstmt.executeQuery();
	 * while(rs.next()) { OrderBean bean = new OrderBean();
	 * 
	 * bean.setOnum(rs.getInt(1)); bean.setPnum(rs.getInt(2));
	 * bean.setQty(rs.getInt(3)); bean.setPname(rs.getString(4));
	 * bean.setOid(rs.getString(5)); bean.setRegdate(rs.getString(6));
	 * bean.setOaddress(rs.getString(7)); bean.setState(rs.getString(8));
	 * 
	 * vlist.addElement(bean); } } catch (Exception e) { e.printStackTrace(); }
	 * finally { pool.freeConnection(con, pstmt, rs); } return vlist; }
	 */
	
	// �Ⱓ�� �ֹ���� ��������
	public Vector<OrderBean> getOrderList(String keyField, String keyWord, int start, int cnt, String interval){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // Ű���� �˻�X 
				System.out.println("Ű���� �˻��� ���ߴ�.");
				if(!interval.trim().equals("")) { // Ű���� �˻�X + �Ⱓ�� �˻�O
					System.out.println("���͹��� �Ѿ�´�.");
					if(interval.trim().equals("1")) { // 1����
						System.out.println("interval 1�� ��� : " + interval);
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("3")) { // 3����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("6")) { // 6����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("12")) { // 1��
						System.out.println("interval : " + interval);
						System.out.println("start : " + start);
						System.out.println("cnt : " + cnt);
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("all")) { // ��ü�Ⱓ��ȸ
						sql = "SELECT * "
							+ "FROM petorder "
							+ "ORDER BY onum DESC " 
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, cnt);
					}
				}
			} else if(keyWord!=null){ // Ű���� �˻�O
				System.out.println("�˻����ߴ�.");
				if(interval.trim().equals("")) { // Ű���� �˻�O + �Ⱓ�� �˻�O
					if(interval.trim().equals("1")) { // 1����
						sql = "SELECT * "
								+ "FROM petorder "
								+ "WHERE " + keyField + " LIKE ? AND "
								+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
								+ "ORDER BY onum DESC "
								+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("3")) { // 3����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? AND "
							+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("6")) { // 6����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? AND "
							+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("12")) { // 1��
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? AND "
							+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("all")) { // ��ü�Ⱓ 
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
				} else { // Ű���� �˻�O + �Ⱓ�� �˻�X
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
			}
			System.out.println("if���� �� ����������");
			rs = pstmt.executeQuery(); // ����
			
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
			System.out.println("���Ϳ� �� �־�����");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println(vlist.size());
		return vlist;
	}
	
	// �ֹ����� �Ϻ� ����
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
	
	
	// (�׽�Ʈ�� �޼ҵ�) Post 1000 : (�� �������� 10���� �Խñ�)1000���� �Խù� �Է� 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT petorder(pnum,qty,pname,oid,regdate,oaddress,state) "
				+ "VALUES (1, 22, 'ī��ī��', 1, now(),'�λ�', '��ۿϷ�');";
			pstmt = con.prepareStatement(sql);
			// 1000�� �ݺ�
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate(); // ����
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
		aoMgr.post1000(); // �׽�Ʈ�� 1000�� ���ڵ� �Է� �޼ҵ� ȣ��
	}
	
	
	
	
}
