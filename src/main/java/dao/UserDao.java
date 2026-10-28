package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import bean.User;

public class UserDao {	
	
	Db db = new Db();													//新建实例（该实例实现了数据的增删改查）
	String sql = "";
	ResultSet rs = null;
	
	/**------------------------------ 根据用户名和密码查询用户。登录验证用 */
	public User queryByUsernameAndPassword (HttpServletRequest request, String username, String password) {
		
		User user = null;
		String msg = "";
		
		try {
			sql = "select userId, role from tb_user where userName = ? and password = ?";
			rs = db.select(sql, username, password);
			
			if (rs == null) {			
				msg += "数据库操作发生错误！";
				return user;
			}
			
			if (rs.next() == false) {
				db.close();
				//msg += "用户名或密码错误！";
				return user;
			}
					
			String userId	= rs.getString("userId");		//读取字段
			String role 	= rs.getString("role");	
			db.close();										//用完及时关闭与数据库连接
	
			user = new User();								//创建user对象
			
			user.setUserId(userId);							//给属性赋值
			user.setUsername(username);
			user.setRole(role);	
			return user;
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return user;
	}
	
	
	/**------------------------------ 获取记录总数 */
	public int queryCount (HttpServletRequest request, String search) {

		int count = 0;
		String msg = "";
		
		try {
			String sqlWhere = "";
			
			if (search.equals("") == false) {							//如果有搜索内容
				//sqlWhere = " where username like '%陈%'";				//增加模糊查询
				sqlWhere = " where concat_ws(',', username, realName) like ?";	//多字段模糊查询
			}
			
			if (search.equals("")) {
				sql = "select count(*) from tb_user"; 					//查询到记录总数
				rs = db.select(sql); 									//执行查询，得到结果集
			} else {
				sql = "select count(*) from tb_user " + sqlWhere; 		//模糊查询
				rs = db.select(sql, "%" + search + "%"); 
			}
			
			if (rs == null) {			
				msg += "数据库操作发生错误！";
				return count;
			}
			
			if (rs.next() == false) {
				db.close();
				return count;
			}			
			count = rs.getInt(1);
			db.close();

			return count;									//满足条件的记录数可能为0
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();							//输出异常信息到控制台
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return count;
	}	

	/**------------------------------ 获取满足查询条件的要显示的页中的记录列表 */
	public List<User> queryAll (HttpServletRequest request, String search, int indexStart, int pageSize) {
		
		List<User> userList = new ArrayList<User>();
		String msg = "";
		
		try {
			String userId, username, realName, role, timeRenew;
						
			String sqlWhere = "";
			
			if (search.equals("") == false) {							//如果有搜索内容
				sqlWhere = " where concat_ws(',', username, realName) like ?";	//多字段模糊查询
			}
			
			if (search.equals("")) {
				sql = "select * from tb_user order by username" 
						+ " limit " + indexStart + "," + pageSize; 	//只获取该页的记录
				rs = db.select(sql);
			} else {
				sql = "select * from tb_user " + sqlWhere + " order by username" 
						+ " limit " + indexStart + "," + pageSize;
				rs = db.select(sql, "%" + search + "%"); 				//模糊查询
			}
			
			if (rs == null) {			
				msg += "数据库操作发生错误！";
				return userList;
			}

			User user = null;
			
			while (rs.next()) {
				userId 		= rs.getString("userId");
				username 	= rs.getString("username");	
				realName 	= rs.getString("realName");	
				role 		= rs.getString("role");	
				timeRenew	= rs.getString("timeRenew");	//在连接MySQL 8时指定了时区地点，则获取到的时间不需格式化
	
				user = new User();
		
				user.setUserId(userId);
				user.setUsername(username);
				user.setRealName(realName);
				user.setRole(role);
				user.setTimeRenew(timeRenew);	

				userList.add(user);							//添加到对象列表
			}
			db.close();
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return userList;
	}	

	/**------------------------------ 根据ID查询记录 */
	public User queryByUserId (HttpServletRequest request, String userId) {
		
		User user = null;
		String msg = "";
		
		try {
			String username, realName, role, timeRenew;
			
			sql = "select * from tb_user where userId = ?";
			rs = db.select(sql, userId);
			
			if (rs == null) {			
				msg += "数据库操作发生错误！";
				return user;
			}
			
			if (rs.next() == false) {
				db.close();
				//msg += "userId号对应的记录已不存在，请刷新页面后重试！";
				return user;
			}
					
			username 	= rs.getString("username");	
			realName 	= rs.getString("realName");	
			role 		= rs.getString("role");	
			timeRenew	= rs.getString("timeRenew");	//在连接MySQL 8时指定了时区地点，则获取到的时间不需格式化
			db.close();
	
			user = new User();							//创建对象
			
			user.setUserId(userId);
			user.setUsername(username);
			user.setRealName(realName);
			user.setRole(role);
			user.setTimeRenew(timeRenew);	
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return user;
	}
	
	/**------------------------------ 是否存在用户名的记录 */
	public boolean existByUsername (HttpServletRequest request, String username) {

		String msg = "";
		
		try {
			sql = "select * from tb_user where username = ?";
			rs = db.select(sql, username);
			
			if (rs == null) {			
				msg += "数据库操作发生错误！";
				return false;
			}
			
			if (rs.next() == false) {
				db.close();
				return false;
			}
			db.close();

			//msg += "已存在相同的用户编码！";
			return true;
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return false;
	}	

	/**------------------------------ 是否存在用户名相同而与ID不同的记录 */
	public boolean existByUserameExptId (HttpServletRequest request, String username, String userId) {

		String msg = "";
		
		try {
			sql = "select * from tb_user where username = ? and userId != ?";
			rs = db.select(sql, username, userId);
			
			if (rs == null) {			
				msg += "数据库操作发生错误！";
				return false;
			}
			
			if (rs.next() == false) {
				db.close();
				return false;
			}
			db.close();			
			
			//msg += "已存在相同的用户名！";
			return true;
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return false;
	}

	/**------------------------------ 新添记录 */
	public String addUser (HttpServletRequest request, User user) {		
		
		String userId = "0";
		String msg = "";
		
		try {
			String username, password, realName, role;
			
			username	= user.getUsername();
			password 	= user.getPassword();
			realName 	= user.getRealName();
			role 		= user.getRole();	
						
			sql = "insert tb_user (username, password, realName, role)"
					+ " values (?, ?, ?, ?)";
			userId = db.insert(sql, username, password, realName, role);
			
			if (userId.equals("0")) {
				//msg += "用户新添失败！";
				return userId;
			}
	
			//msg = "用户新添成功！";		
			return userId;
		
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return userId;
	}
	
	/**------------------------------ 修改记录 */
	public boolean editUser (HttpServletRequest request, User user) {		
		
		String msg = "";
		
		try {
			String userId, password, realName, role;
			
			userId 		= user.getUserId();
			password	= user.getPassword();
			realName 	= user.getRealName();
			role 		= user.getRole();

			int count = 0;
			
			if (password.isEmpty()) {									//输入的密码为空时，密码不更改
				sql = "update tb_user set realName = ?, role = ?, timeRenew = (now()) where userId = ?";
				count = db.update(sql, realName, role, userId);
			} else {
				sql = "update tb_user set password = ?, realName = ?, role = ?, timeRenew = (now()) where userId = ?";
				count = db.update(sql, password, realName, role, userId);
			}
			
			if (count == 0) {
				//msg = "用户信息修改失败！";
				return false;
			}	
		
			//msg = "用户信息修改成功！";		
			return true;
		
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return false;
	}		

	/**------------------------------ 删除ID对应的记录 */
	public boolean deleteByUserId (HttpServletRequest request, String userId) {

		String msg = "";
		
		try {	
			sql = "delete from tb_user where userId = ?";
			int count = db.delete(sql, userId);
			
			if (count == 0) {
				//msg += "用户删除失败！";
				return false;
			}	
			
			//msg = "用户删除成功！";
			return true;
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return false;
	}
	
	/**------------------------------ 删除ID列表中的记录 */
	public boolean deleteByUserIdLot (HttpServletRequest request, String userIdLot) {

		String msg = "";
		
		try {
			sql = "delete from tb_user where userId in (" + userIdLot + ")";		//批量删除记录
			int count = db.delete(sql);
			
			if (count == 0) {
				//msg += "用户批量删除失败！";
				return false;
			}
			
			//msg = "用户批量删除成功！";
			return true;
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
		}		

		return false;
	}
}
