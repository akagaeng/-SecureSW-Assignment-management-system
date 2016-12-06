package Class;

import java.io.Serializable;

public class Assignment implements Serializable{

	int page;
	int submit_no;
    String student_name;
    int assignment_no;
    String title;
    String content;
    String grade;
	
    public Assignment() {
		
    }

	public Assignment(int page, int submit_no, String student_name, String title, String content,
			String grade) {
		super();
		this.page = page;
		this.submit_no = submit_no;
		this.student_name = student_name;
		this.title = title;
		this.content = content;
		this.grade = grade;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getSubmit_no() {
		return submit_no;
	}

	public void setSubmit_no(int submit_no) {
		this.submit_no = submit_no;
	}

	public String getStudent_name() {
		return student_name;
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
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

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	
    
    
}
