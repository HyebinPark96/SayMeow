// ����� ��ۿ����� DB���� �޼ҵ�
package saymeow;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class ReviewMgr {
	// ������ Ʃ�� ���� ���� �ʰ� �����ϴ� �Ͱ� ���� ����
	private DBConnectionMgr pool; // pool ��ü ����
	
	/*���� - ���Ͼ��ε�*/
	// 1. ���ε� ���� ���� ��ġ(�� ���ϹǷ� ���)
	public static final String SAVEFOLDER = "C:/Jsp/jspproject/src/main/webapp/saymeow/storage/"; // ����� �빮�ڷ� ǥ���ϴ� ���� �Ϲ���

	// 2. ���ε� ���ϸ� ���ڵ�
	public static final String ENCODING = "EUC-KR";

	// 3. ���ε� ���� ũ�� ����
	public static final int MAXSIZE = 1024 * 1024 * 10; // 10mb
	
	// ������
	public ReviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// ���� �ۼ� INSERT
	public boolean insertReview(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			// ���Ͼ��ε� ���� �ڵ�
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()) { // ������ ���ٸ�
				// mkdirs() : ���������� ��� ���� ���� (���� �̸� �ȸ���� ���ǰ� ��Ʈ��)
				// mkdir() : ���������� ������ ���� �Ұ���
				dir.mkdirs(); 
			}
			// �� �ڵ� ���ĺ��� multi�� request ���Ƿ� request = null �Ǿ� multi ���
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
					ENCODING, new DefaultFileRenamePolicy());
			
			// �����̳� ���� �ۼ����� �ʾҴٸ� 
			if(multi.getParameter("subject").trim().equals("") || 
					multi.getParameter("content").trim().equals("")) {
				return flag; // false ��ȯ
			}
			
			
			// ���Ͼ��ε� ���ߴٸ� filename = null, filesize = 0�� DB������
			String filename = null;
			int filesize = 0;
			
			// ReviewForm.jsp ���Ͼ��ε�� ������ name = filename
			if(multi.getFilesystemName("filename")!=null) {
				// ���Ͼ��ε� �ߴٸ�
				filename = multi.getFilesystemName("filename");
				// (long -> int)ĳ�����Ͽ� ����ũ�� ��������
				filesize = (int)multi.getFile("filename").length();
			}
			
			con = pool.getConnection();
			sql = "INSERT INTO review(onum,id,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES(?,?,?,now(),?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(multi.getParameter("onum"))); // multi�� object�� ���ϵǹǷ� ����ȯ�ؼ� �޾��ֱ�
			pstmt.setString(2, multi.getParameter("id"));
			pstmt.setInt(3, Integer.parseInt(multi.getParameter("pnum"))); 
			pstmt.setString(4, multi.getParameter("subject"));
			pstmt.setString(5, multi.getParameter("content"));
			pstmt.setInt(6, Integer.parseInt(multi.getParameter("score")));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			
			// �������� �����̸� 1(������� �� ����) ����, �������̸� 0 ����
			if(pstmt.executeUpdate()==1) 
				flag = true; 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	// ��ǰ�� ��ü ���� �������� SELECT (���� �÷� �� �ҷ��ͼ� ��->ä� �̹��� ����)
	public Vector<ReviewBean> getAllReviews(int pnum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM tblReview "
				+ "WHERE pnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pnum); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewBean rBean = new ReviewBean(); // ���� ��ü ����
				
				rBean.setRnum(rs.getInt(1));
				rBean.setOnum(rs.getInt(2));
				rBean.setId(rs.getString(3));
				rBean.setPnum(rs.getInt(4));
				rBean.setDate(rs.getString(5)); // (sql)Date���� -> (java)String����
				rBean.setSubject(rs.getString(6));
				rBean.setContent(rs.getString(7));
				rBean.setScore(rs.getInt(8));
				rBean.setPhoto(rs.getString(9));
				
				vlist.addElement(rBean); // ��������� ���Ϳ� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	// ������ ��� �ۼ�
	public void insertRComment(RCommentBean rBean) { // jsp ������ bean.setXXX 
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO tblRComment(rnum, id, pnum, rcDate, comment) "
				+ "VALUES(?,?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rBean.getRnum());
			pstmt.setString(2, rBean.getId());
			pstmt.setInt(3, rBean.getPnum());
			pstmt.setString(4, rBean.getRcDate());
			pstmt.setString(5, rBean.getComment());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	// Ư�� ������ ������ �ۼ� ��� �ҷ����� -> ��� �޸� ����� �ݺ������� �� �� �ְԲ�
	public RCommentBean getRComment(int rnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		RCommentBean rcBean = new RCommentBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM tblRComment "
				+ "WHERE rnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rcBean.setRcNum(rs.getInt(1));
				rcBean.setRnum(rs.getInt(2));
				rcBean.setId(rs.getString(3));
				rcBean.setPnum(rs.getInt(4));
				rcBean.setRcDate(rs.getString(5)); // (sql)Date���� -> (java)String����
				rcBean.setComment(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rcBean;
	}
	
	
	// ���� ��� (1�� - 2��, 2�� - 5��, ...)
	
	
	
	
}
