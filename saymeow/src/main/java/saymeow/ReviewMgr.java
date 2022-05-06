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
			sql = "INSERT INTO review(onum,rid,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES(?,?,?,now(),?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(multi.getParameter("onum"))); // multi�� object�� ���ϵǹǷ� ����ȯ�ؼ� �޾��ֱ�
			pstmt.setString(2, multi.getParameter("rid"));
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
	
	
	
	// ������ ��� �ۼ�
	public void insertRComment(RCommentBean rBean) { // jsp ������ bean.setXXX 
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO rComment(rcNum, cid, pnum, rcDate, comment) "
				+ "VALUES(?,?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rBean.getRnum());
			pstmt.setString(2, rBean.getCid());
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
	
	
	//////////////////////////////////////////////////// reviewBoard.jsp
	
	// Board Max Num : rnum�� �ִ밪
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT MAX(rnum) "
				+ "FROM review ";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) 
				maxNum = rs.getInt(1); // �ҷ��� max num���� ����
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	// Board Total Count : (����¡ ó������) �� ���� �� // �˻��ϵ� ���ϵ� �����ϰ� ����Ǵ� �޼ҵ� 
	// keyField : id, subject, content ���� �� ����
	public int getTotalCount(String keyField, String keyWord) { 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("") || keyWord==null) {
				// �˻��� �ƴ� ��
				sql = "SELECT COUNT(*) "
					+ "FROM review ";
				pstmt = con.prepareStatement(sql);
			} else {
				// �˻��� �� keyField : name, subject, content ���� �� ����
				sql = "SELECT COUNT(*) "
					+ "FROM review "
					+ "WHERE " + keyField + " like ? "; // like '%test%'
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' �ڵ����� �ٿ���	
			}  
			
			rs = pstmt.executeQuery(); // ����
			
			if(rs.next())
				totalCount = rs.getInt(1); // ����� ù��° �� ����
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount; // ��ü �Խñ� �� ��ȯ
	}
	
	// Board List (SELECT) : �˻���� // �˻��ϵ� ���ϵ� �����ϰ� ����Ǵ� �޼ҵ� 
	public Vector<ReviewBean> getBoardList(String keyField, String keyWord, int start, int cnt) { /*�� �ΰ��� limit - SQL��*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		// 10�������� Vector�� ������, 10���ξȳ����� ���ڵ尹���� �������� ������ 2,3,... �̷��� ���� ���� ����
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // �˻��� �ƴ� ��
				sql = "SELECT * "
					+ "FROM review "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? "; /*LIMIT : ù��° ����ǥ ���� ���ڵ���� ��������, �ι�°����ǥ ������ŭ ��������*/ 
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else { // �˻��� �� 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE " + keyField + " LIKE ? " // ������� �߿�!!
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? " ;
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%"); // �ڵ����� ����ǥ ���� like %'aaa'%
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			
			rs = pstmt.executeQuery(); // ����
			
			while(rs.next()) {
				ReviewBean bean = new ReviewBean(); // ��ü ����
				
				// ����¡ó���� �ʿ��� �͸� ��������
				bean.setRnum(rs.getInt("rnum")); // �������
				// bean.setOnum(rs.getInt("onum")); // �ֹ���ȣ�� �ʿ���� ��
				bean.setRid(rs.getString("rid")); // ���� �ۼ��� id 
				bean.setPnum(rs.getInt("pnum")); // ��ǰ��ȣ 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getInt("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // ���Ϳ� ��������� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// Board Read : �� ���� ���� �б�, 10�� �÷� ��� ��� ����
	public ReviewBean getBoard(int rnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReviewBean bean = new ReviewBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM review "
				+ "WHERE rnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setRnum(rs.getInt("rnum"));
				bean.setOnum(rs.getInt("onum"));
				bean.setRid(rs.getString("rid"));
				bean.setPnum(rs.getInt("pnum"));
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getInt("score"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean; // �Ѱ� �Խñ� ���� ����
	}
	
	// Board Delete : �����ֵ� ���� ���� ����
	public void deleteBoard(int rnum, String filename/*DB �Ȱ��鼭 �Խù� ���� ����*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(filename!=null&&!filename.equals("")) { // ���ε� ���� �ִ� ������
				File f = new File(SAVEFOLDER+filename);
				if(f.exists()) { // storage ������ ������ �����Ѵٸ�
					f.delete(); // ����
				}
			}
			con = pool.getConnection();
			sql = "DELETE FROM review "
				+ "WHERE rnum = ? "; // �Խñ� �������� ��ȸ�Ͽ� ����
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.executeUpdate(); // ����
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// Board Update : ���� ���� (���ε� ���ϱ��� ������� �߰�)
	public void updateBoard(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			// ���� �ۼ� �� rnum ������ �� �޾ƿͼ� int�� ��ȯ
			int rnum = Integer.parseInt(multi.getParameter("rnum")); 
			
			// ���ο� ���� �Ӽ���
			String rid = multi.getParameter("rid");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String filename = multi.getFilesystemName("filename"); // !!���ο� ���ϸ�!!
			
			// ���� ���� �� ���ǹ�
			if(filename!=null&&!filename.equals("")) { // �� ���ϸ� ���� -> �� ���Ϸ� �����ϴ� ���
				ReviewBean bean = getBoard(rnum); // ���� ����Ǿ��ִ� ����� ���� �� ���� ���� ��������
				String tempFile = bean.getFilename(); // !!���� ���ϸ�!!
				if(tempFile!=null&&tempFile.equals("")) { // ���� ���� �ִٸ�
					File f = new File(SAVEFOLDER+tempFile);
					if(f.exists()) {
						f.delete(); // storage������ ���� ���� ����
					}
				}
				
				// ���ο� ���ε� ������ ũ��
				int filesize = (int)multi.getFile("filename").length();
				sql = "UPDATE review "
					+ "SET rid=?, subject=?, content=?, filename=?, filesize=? "
					+ "WHERE rnum = ? ";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, rid);
				pstmt.setString(2, subject);
				pstmt.setString(3, content);
				pstmt.setString(4, filename);
				pstmt.setInt(5, filesize);
				pstmt.setInt(6, rnum);
				
			} else { // ���� ���ε�� ���� ���ٸ� ���� ���� ����
				sql = "UPDATE review "
					+ "SET rid=?, subject=?, content=? "
					+ "WHERE num = ? ";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, rid);
					pstmt.setString(2, subject);
					pstmt.setString(3, content);
					pstmt.setInt(4, rnum);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// (�׽�Ʈ�� �޼ҵ�) Post 1000 : (�� �������� 10���� �Խñ�)1000���� �Խù� �Է� 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT review(onum,rid,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES (1, 'aaa', 1, now(),'Hello','World!', 3, null, 0);";
			pstmt = con.prepareStatement(sql);
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
	
	// ���θ޼ҵ�
	public static void main(String[] args) {
		ReviewMgr rMgr = new ReviewMgr(); 
		rMgr.post1000(); // �׽�Ʈ�� 1000�� ���ڵ� �Է� �޼ҵ� ȣ��
	}
	
}
