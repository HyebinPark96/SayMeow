package saymeow;

public class MailSend {
	// mgr로 DB조회했을 때 존재하는 id와 email을 입력받았다면 메일 보내는 메소드
	public boolean sendEmail(String id, String email) {
		boolean flag = false; // 디폴트
		MemberMgr mgr = new MemberMgr();
		String pwd = mgr.getPwd(id, email);
		if(pwd!=null) {
			String subject = "[SayMeow] 아이디, 비밀번호 안내입니다.";
			String content = "id : " + id + " / pwd : " + pwd;
			GmailSend.send(subject, content, email);
			flag = true; // 정상적으로 전송되었다면 true 반환
		}
		
		return flag;
	}

}
