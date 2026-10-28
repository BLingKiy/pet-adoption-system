package bean;

public class User {

	private String userId;				//用户ID
	private String username;			//用户名
	private String password;			//密码
	private String realName;			//真实姓名
	private String role;				//角色级别：guest、user、admin
	private String timeRenew;			//更新时间
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getTimeRenew() {
		return timeRenew;
	}
	public void setTimeRenew(String timeRenew) {
		this.timeRenew = timeRenew;
	}
}
