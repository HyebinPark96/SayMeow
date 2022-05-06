package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ProductMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEDIRECTORY = 
			"C:/Jsp/myapp/src/main/webapp/shop/data/";
	public static final String ENCODING = "EUC-KR";
	public static final int MAXPOSTSIZE = 10*1024*1024;//10mb

	public ProductMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 상품 전체 리스트업 Product List
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
	
	// 카테고리별 상품리스트업
	public Vector<ProductBean> getP(String mClass, String sClass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			if(sClass!=null) { // 중분류 선택
				sql = "SELECT pnum, pname, price1, image "
					+ "FROM product "
					+ "WHERE (sclass = ? AND pstat = 1) "
					+ "ORDER BY pnum DESC";	
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sClass);	
			}else if(sClass==null) {
				sql = "SELECT pnum, pname, price1, image "
					+ "FROM product "
					+ "WHERE ( mclass = ? AND pstat = 1) "
					+ "ORDER BY pnum DESC";	
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mClass);	
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
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
		System.out.println("[Mgr.getP] mClass:"+mClass+" /sClass:"+sClass);
		return vlist;
	}

}
