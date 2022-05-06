// 리뷰와 댓글에관한 DB연동 메소드
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
	// 수영장 튜브 공기 빼지 않고 재사용하는 것과 같은 원리
	private DBConnectionMgr pool; // pool 객체 생성
	
	/*리뷰 - 파일업로드*/
	// 1. 업로드 파일 저장 위치(안 변하므로 상수)
	public static final String SAVEFOLDER = "C:/Jsp/jspproject/src/main/webapp/saymeow/storage/"; // 상수는 대문자로 표기하는 것이 일반적

	// 2. 업로드 파일명 인코딩
	public static final String ENCODING = "EUC-KR";

	// 3. 업로드 파일 크기 제한
	public static final int MAXSIZE = 1024 * 1024 * 10; // 10mb
	
	// 생성자
	public ReviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 리뷰 작성 INSERT
	public boolean insertReview(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			// 파일업로드 관련 코드
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()) { // 폴더가 없다면
				// mkdirs() : 상위폴더가 없어도 생성 가능 (폴더 미리 안만드면 조건과 셋트임)
				// mkdir() : 상위폴더가 없으면 생성 불가능
				dir.mkdirs(); 
			}
			// 위 코드 이후부터 multi에 request 들어가므로 request = null 되어 multi 사용
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
					ENCODING, new DefaultFileRenamePolicy());
			
			// 제목이나 내용 작성하지 않았다면 
			if(multi.getParameter("subject").trim().equals("") || 
					multi.getParameter("content").trim().equals("")) {
				return flag; // false 반환
			}
			
			
			// 파일업로드 안했다면 filename = null, filesize = 0이 DB에저장
			String filename = null;
			int filesize = 0;
			
			// ReviewForm.jsp 파일업로드된 파일의 name = filename
			if(multi.getFilesystemName("filename")!=null) {
				// 파일업로드 했다면
				filename = multi.getFilesystemName("filename");
				// (long -> int)캐스팅하여 파일크기 가져오기
				filesize = (int)multi.getFile("filename").length();
			}
			
			con = pool.getConnection();
			sql = "INSERT INTO review(onum,id,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES(?,?,?,now(),?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(multi.getParameter("onum"))); // multi는 object로 리턴되므로 형변환해서 받아주기
			pstmt.setString(2, multi.getParameter("id"));
			pstmt.setInt(3, Integer.parseInt(multi.getParameter("pnum"))); 
			pstmt.setString(4, multi.getParameter("subject"));
			pstmt.setString(5, multi.getParameter("content"));
			pstmt.setInt(6, Integer.parseInt(multi.getParameter("score")));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			
			// 정상적인 저장이면 1(영향받은 행 갯수) 리턴, 비정상이면 0 리턴
			if(pstmt.executeUpdate()==1) 
				flag = true; 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	// 상품별 전체 리뷰 가져오기 SELECT (별점 컬럼 값 불러와서 빈별->채운별 이미지 변경)
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
				ReviewBean rBean = new ReviewBean(); // 빈즈 객체 생성
				
				rBean.setRnum(rs.getInt(1));
				rBean.setOnum(rs.getInt(2));
				rBean.setId(rs.getString(3));
				rBean.setPnum(rs.getInt(4));
				rBean.setDate(rs.getString(5)); // (sql)Date형식 -> (java)String형식
				rBean.setSubject(rs.getString(6));
				rBean.setContent(rs.getString(7));
				rBean.setScore(rs.getInt(8));
				rBean.setPhoto(rs.getString(9));
				
				vlist.addElement(rBean); // 빈즈단위로 벡터에 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	// 관리자 댓글 작성
	public void insertRComment(RCommentBean rBean) { // jsp 측에서 bean.setXXX 
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
	
	
	// 특정 리뷰의 관리자 작성 댓글 불러오기 -> 댓글 달린 리뷰는 반복문으로 볼 수 있게끔
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
				rcBean.setRcDate(rs.getString(5)); // (sql)Date형식 -> (java)String형식
				rcBean.setComment(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rcBean;
	}
	
	
	// 별점 통계 (1점 - 2개, 2점 - 5개, ...)
	
	
	
	
}
