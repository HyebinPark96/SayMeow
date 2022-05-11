package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ProductMgr {

	private DBConnectionMgr pool;
	public static final String SAVEDIRECTORY = "C:/Jsp/myapp/src/main/webapp/shop/data/";
	public static final String ENCODING = "EUC-KR";
	public static final int MAXPOSTSIZE = 10 * 1024 * 1024;// 10mb

	public ProductMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// ��ǰ ��ü ����Ʈ�� Product List
	/*
	 * public Vector<ProductBean> getProductList() { Connection con = null;
	 * PreparedStatement pstmt = null; ResultSet rs = null; String sql = null;
	 * Vector<ProductBean> vlist = new Vector<ProductBean>(); try { con =
	 * pool.getConnection(); sql = "select pnum, pname, price1, image from product "
	 * + "order by pnum desc"; pstmt = con.prepareStatement(sql); rs =
	 * pstmt.executeQuery(); while(rs.next()) { ProductBean bean = new
	 * ProductBean(); bean.setPnum(rs.getInt(1)); bean.setPname(rs.getString(2));
	 * bean.setPrice1(rs.getInt(3)); bean.setImage(rs.getString(4));
	 * vlist.addElement(bean); }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); } finally {
	 * pool.freeConnection(con, pstmt, rs); } return vlist; }
	 */

	// ī�װ��� ��ǰ����Ʈ��
	public Vector<ProductBean> getP(String mClass, String sClass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			if (sClass != null) { // �ߺз� ����
				sql = "SELECT pnum, pname, price1, image " + "FROM product " + "WHERE (sclass = ? AND pstat = 1) "
						+ "ORDER BY pnum DESC";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sClass);
			} else if (sClass == null) {
				sql = "SELECT pnum, pname, price1, image " + "FROM product " + "WHERE ( mclass = ? AND pstat = 1) "
						+ "ORDER BY pnum DESC";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mClass);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setPrice1(rs.getInt(3));
				bean.setImage(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println("[Mgr.getP] mClass:" + mClass + " /sClass:" + sClass);
		return vlist;
	}

	// ī�װ� �� ���ĺ� ��ǰ����Ʈ��
	public Vector<ProductBean> getP2(String mClass, String sClass, String sort) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = null;
		String sql2 = null;
		String sql3 = null;

		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql1 = "SELECT pnum, pname, price1, image " + "FROM product ";
			if (sort == null || sort.equals("0") || sort.equals("null")) { // �ֽż�
				if (sClass == null || sClass.equals("null")) { // �ߺз�X
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY pnum DESC";
					pstmt = con.prepareStatement(sql1 + sql2 + sql3);
					pstmt.setString(1, mClass);
				} else { // �ߺз�O
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY pnum DESC";
					pstmt = con.prepareStatement(sql1 + sql2 + sql3);
					pstmt.setString(1, sClass);
				}
			} else if (sort.equals("1")) { // ���� ���ݼ�
				if (sClass == null || sClass.equals("null")) { // �ߺз�X
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 DESC";
					pstmt = con.prepareStatement(sql1 + sql2 + sql3);
					pstmt.setString(1, mClass);
				} else { // �ߺз�O
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 DESC";
					pstmt = con.prepareStatement(sql1 + sql2 + sql3);
					pstmt.setString(1, sClass);
				}
			} else if (sort.equals("2")) // ���� ���ݼ�
				if (sClass == null || sClass.equals("null")) { // �ߺз�X
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 ASC";
					pstmt = con.prepareStatement(sql1 + sql2 + sql3);
					pstmt.setString(1, mClass);
				} else { // �ߺз�O
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 ASC";
					pstmt = con.prepareStatement(sql1 + sql2 + sql3);
					pstmt.setString(1, sClass);
				}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setPrice1(rs.getInt(3));
				bean.setImage(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println("[Mgr.getP] mClass:" + mClass + " /sClass:" + sClass + " /sort:" + sort);
		return vlist;
	}

}
