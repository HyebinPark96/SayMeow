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
			sql = "INSERT INTO review(onum,rid,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES(?,?,?,now(),?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(multi.getParameter("onum"))); // multi는 object로 리턴되므로 형변환해서 받아주기
			pstmt.setString(2, multi.getParameter("rid"));
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
	
	
	
	// 관리자 댓글 작성
	public void insertRComment(RCommentBean rBean) { // jsp 측에서 bean.setXXX 
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
	
	// Board Max Num : rnum의 최대값
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
				maxNum = rs.getInt(1); // 불러온 max num값을 넣음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	// Board Total Count : (페이징 처리위해) 총 리뷰 수 // 검색하든 안하든 동일하게 적용되는 메소드 
	// keyField : id, subject, content 들어올 수 있음
	public int getTotalCount(String keyField, String keyWord) { 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("") || keyWord==null) {
				// 검색이 아닐 때
				sql = "SELECT COUNT(*) "
					+ "FROM review ";
				pstmt = con.prepareStatement(sql);
			} else {
				// 검색일 때 keyField : name, subject, content 들어올 수 있음
				sql = "SELECT COUNT(*) "
					+ "FROM review "
					+ "WHERE " + keyField + " like ? "; // like '%test%'
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' 자동으로 붙여줌	
			}  
			
			rs = pstmt.executeQuery(); // 실행
			
			if(rs.next())
				totalCount = rs.getInt(1); // 결과의 첫번째 값 들고옴
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount; // 전체 게시글 수 반환
	}
	
	// Board List (SELECT) : 검색기능 // 검색하든 안하든 동일하게 적용되는 메소드 
	public Vector<ReviewBean> getBoardList(String keyField, String keyWord, int start, int cnt) { /*뒤 두개는 limit - SQL문*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		// 10개단위로 Vector로 들고오기, 10으로안나뉘는 레코드갯수는 마지막에 나머지 2,3,... 이렇게 들고올 수도 있음
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // 검색이 아닐 때
				sql = "SELECT * "
					+ "FROM review "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? "; /*LIMIT : 첫번째 물음표 이후 레코드부터 가져오되, 두번째물음표 갯수만큼 가져오기*/ 
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else { // 검색일 때 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE " + keyField + " LIKE ? " // 띄워쓰기 중요!!
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? " ;
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%"); // 자동으로 따옴표 생성 like %'aaa'%
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			
			rs = pstmt.executeQuery(); // 실행
			
			while(rs.next()) {
				ReviewBean bean = new ReviewBean(); // 객체 생성
				
				// 페이징처리에 필요한 것만 가져오기
				bean.setRnum(rs.getInt("rnum")); // 리뷰순번
				// bean.setOnum(rs.getInt("onum")); // 주문번호는 필요없을 듯
				bean.setRid(rs.getString("rid")); // 리뷰 작성자 id 
				bean.setPnum(rs.getInt("pnum")); // 상품번호 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getInt("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // 벡터에 빈즈단위로 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// Board Read : 한 개의 리뷰 읽기, 10개 컬럼 빈즈에 모두 저장
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
		return bean; // 한개 게시글 빈즈 리턴
	}
	
	// Board Delete : 파일있든 없든 리뷰 삭제
	public void deleteBoard(int rnum, String filename/*DB 안가면서 게시물 삭제 가능*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(filename!=null&&!filename.equals("")) { // 업로드 파일 있는 리뷰라면
				File f = new File(SAVEFOLDER+filename);
				if(f.exists()) { // storage 폴더에 파일이 존재한다면
					f.delete(); // 삭제
				}
			}
			con = pool.getConnection();
			sql = "DELETE FROM review "
				+ "WHERE rnum = ? "; // 게시글 순번으로 조회하여 삭제
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.executeUpdate(); // 실행
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// Board Update : 리뷰 수정 (업로드 파일까지 수정기능 추가)
	public void updateBoard(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			// 리뷰 작성 시 rnum 보내는 것 받아와서 int형 변환
			int rnum = Integer.parseInt(multi.getParameter("rnum")); 
			
			// 새로운 파일 속성들
			String rid = multi.getParameter("rid");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String filename = multi.getFilesystemName("filename"); // !!새로운 파일명!!
			
			// 파일 수정 시 조건문
			if(filename!=null&&!filename.equals("")) { // 새 파일명 있음 -> 새 파일로 수정하는 경우
				ReviewBean bean = getBoard(rnum); // 기존 저장되어있던 빈즈로 리뷰 한 개의 정보 가져오기
				String tempFile = bean.getFilename(); // !!기존 파일명!!
				if(tempFile!=null&&tempFile.equals("")) { // 기존 파일 있다면
					File f = new File(SAVEFOLDER+tempFile);
					if(f.exists()) {
						f.delete(); // storage폴더의 기존 파일 삭제
					}
				}
				
				// 새로운 업로드 파일의 크기
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
				
			} else { // 기존 업로드된 파일 없다면 파일 조건 제외
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
	
	// (테스트용 메소드) Post 1000 : (한 페이지당 10개의 게시글)1000개의 게시물 입력 
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
				pstmt.executeUpdate(); // 실행
			}
			System.out.println("Post1000 Success"); 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 메인메소드
	public static void main(String[] args) {
		ReviewMgr rMgr = new ReviewMgr(); 
		rMgr.post1000(); // 테스트용 1000개 레코드 입력 메소드 호출
	}
	
}
