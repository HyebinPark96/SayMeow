DROP TABLE IF EXISTS member;

CREATE TABLE Member (
 id varchar(50) PRIMARY KEY,
 pwd varchar(50) NOT null,
 name varchar(50) NOT null,
 birthday varchar(6) NOT null,
 phone CHAR(11) NOT NULL,
 email varchar(30) NOT null,
 address varchar(200) NOT null, /*�ּ��� : �ñ����� ���������� �����ϸ� ũ�Ⱑ Ŀ�� �� �����Ƿ� ���� ũ�� ����*/
 grade tinyint DEFAULT 0, /*ȸ��saymeow��� : 0(ȸ�����Խ� ����Ʈ),1, 2, ... */ 
 mode tinyint DEFAULT 0, /*ȸ�� : 0, ������ : 1 ������, �����ڴ� �������� �߰��� �����̹Ƿ� ȸ������ �� ����Ʈ�� 0���� �Ѵ�.*/
 /*�Ʒ����� �� ���� �÷�*/
 petName VARCHAR(30) NOT NULL, /*����� �̸�*/
 petAge DATE NOT NULL, /*����� ����*/
 petGender TINYINT NOT NULL DEFAULT 1, /*����� ���� : 0 - ����, 1 - ����*/
 petBreed VARCHAR(50) NOT NULL /*����� ǰ��*/
);