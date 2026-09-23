package model;

import java.io.Serializable;

public class UserModel implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String userId;
	private String userPass;
	
	//コンストラクタ
	public UserModel() {}
	public UserModel(String userId, String userPass) {
		this.userId = userId;
		this.userPass = userPass;
	}
	
	//ゲッター セッター
	public String getUserId() { return userId; }
	public void setUserId(String userId) { this.userId = userId; }
	public String getUserPass() { return userPass; }
	public void setUserPass(String userPass) { this.userPass = userPass; }
	
}
