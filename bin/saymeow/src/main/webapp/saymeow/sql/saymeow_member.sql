DROP TABLE IF EXISTS member;

CREATE TABLE Member (
 id varchar(50) PRIMARY KEY,
 pwd varchar(50) NOT null,
 name varchar(50) NOT null,
 birthday varchar(6) NOT null,
 phone CHAR(11) NOT NULL,
 email varchar(30) NOT null,
 address varchar(200) NOT null, /*주소지 : 시군구와 번지수까지 포함하면 크기가 커질 수 있으므로 비교적 크게 설정*/
 grade tinyint DEFAULT 0, /*회원saymeow등급 : 0(회원가입시 디폴트),1, 2, ... */ 
 mode tinyint DEFAULT 0, /*회원 : 0, 관리자 : 1 이지만, 관리자는 수동으로 추가할 예정이므로 회원가입 시 디폴트를 0으로 한다.*/
 /*아래부터 펫 관련 컬럼*/
 petName VARCHAR(30) NOT NULL, /*고양이 이름*/
 petAge DATE NOT NULL, /*고양이 나이*/
 petGender TINYINT NOT NULL DEFAULT 1, /*고양이 성별 : 0 - 남아, 1 - 여아*/
 petBreed VARCHAR(50) NOT NULL /*고양이 품종*/
);