package kr.co.gudi.dto;


public class BoardDTO {
	private String codeType;
	private int num;
	private String name;	
	private String title;
	private String content;
	private String regdate;
	private int bHit;
	public String getCodeType() {
		return codeType;
	}
	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [codeType=" + codeType + ", num=" + num + ", name=" + name + ", title=" + title
				+ ", content=" + content + ", regdate=" + regdate + ", bHit=" + bHit + "]";
	}
}
