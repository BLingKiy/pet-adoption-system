package service;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import bean.User;
import dao.UserDao;
import util.Md5;

public class UserService {
	
	UserDao userDao = new UserDao();						//创建对象
	
	public boolean queryAll (HttpServletRequest request) {
		
		List<User> userList = null; 						//记录列表
		String search = ""; 								//搜索的内容
		int indexStart = 0;	 								//查询的起始位置	
		int pageShow = 1; 									//当前页码					
		String page = ""; 									//页码链接组	
		String msg = "";
		
		try {	
			if (request.getParameter("buttonDelete") != null) { 				//如果单击了删除按钮
				String[] userIdArray = request.getParameterValues("userId"); 	//ID列表				
				
				if (userIdArray != null) {
					deleteByUserIdLot(request, userIdArray);					//****删除所选。在本类中定义的方法
				}
			}	
	
			String buttonSearch	= request.getParameter("buttonSearch");	//搜索按钮
			String buttonPage  	= request.getParameter("buttonPage"); 	//页码提交按钮
			String pageInput  	= "1";									//输入的页码
			
			if (buttonSearch != null && request.getParameter("search") != null) { 		//如果按下了搜索按钮
				search = request.getParameter("search").trim(); 						//搜索内容
			} else if (buttonPage != null && request.getParameter("search") != null) { 	//如果按下了页码提交按钮
				search 	  = request.getParameter("search").trim(); 						//搜索内容
				pageInput = request.getParameter("pageShow"); 							//页码输入框中的值
			} else { 													//点击了页码链接，或者刚打开此页
				if (request.getParameter("searchUrl") != null) { 
					search = request.getParameter("searchUrl"); 		//不需要进行解码操作，系统会自动解码
				}
				
				if (request.getParameter("pageUrl") != null) {			//地址栏中的页码
					pageInput = request.getParameter("pageUrl");
				}
			}
			
			int countRow = userDao.queryCount(request, search);		//****获得记录总数
					
			int pageSize  = 6;  										//每页6条记录
			int pageCount = 0; 											//预设总页数为0
		
			if (countRow % pageSize == 0) {								//如果余数为0，即能整除
				pageCount = countRow / pageSize; 						//总页数
			} else {
				pageCount = countRow / pageSize + 1;					//不能整除则加1页。如果除数为小数，将自动去除小数部分得到整数			
			}
			
			try { 									 
				pageShow = Integer.parseInt(pageInput);					//如果是数字，返回字符串对应的整数   
			} catch (Exception e) {
				//showPage = 1; 										//如果抛出异常，则取预设值
			}				
		
			if (pageShow < 1) {											//如果当前页码小于1
				pageShow = 1;
			} else if (pageShow > pageCount && pageCount >= 1) { 		//如果当前页码大于总页数，且总页数>=1
				pageShow = pageCount;
			}
			
			String searchUrl = "";
			
			if (search.equals("") == false) {
				searchUrl = URLEncoder.encode(search, "UTF-8");			//进行URL编码，以便在地址栏传递				
			}
			
			if (pageShow <= 1) {
				page += "<span style='color:gray;'>首页&ensp;";
				page += "上一页&ensp;</span>";
			} else { 
				page += "<a href='?pageUrl=1&searchUrl=" + searchUrl + "'>首页</a>&ensp;";
				page += "<a href='?pageUrl=" + (pageShow - 1) + "&searchUrl=" + searchUrl + "'>上一页</a>&ensp;";
			}
	
			if (pageShow >= pageCount) {
				page += "<span style='color:gray;'>下一页&ensp;";
				page += "末页</span>";
			} else { 
				page += "<a href='?pageUrl=" + (pageShow + 1) + "&searchUrl=" + searchUrl + "'>下一页</a>&ensp;";
				page += "<a href='?pageUrl=" + pageCount + "&searchUrl=" + searchUrl + "'>尾页</a>";
			}
			
			page += "&emsp;&emsp;";
			page += "页码：" + pageShow + "/" + pageCount + "&emsp;";
			page += "记录数：" + countRow + "&emsp;&emsp;";	
			
			page += "输入页码:";
			page += "	<input type='text' name='pageShow' value='" + pageShow + "' style='width:40px; text-align:center;'>";
			page += "	<input type='submit' name='buttonPage' value='提交'>&emsp;";

			if (pageShow > 0) {
				indexStart = (pageShow - 1) * pageSize;  						//查询的起始位置
			}
			
			userList = userDao.queryAll(request, search, indexStart, pageSize);	//****获取当前页的记录列表
			
			if (userList == null || userList.size() == 0) {
				msg += "（查无记录）";
				return false;
			}

			return true;
		
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
			
			if (request.getSession().getAttribute("msg") != null) {				//如果session中有消息。在详情页删除记录后保存的消息
				msg += request.getSession().getAttribute("msg").toString();		//读取session中的消息
				request.getSession().removeAttribute("msg");					//从session中移除此键值			
				request.setAttribute("msg", msg);								//将消息赋值给request
			}

			request.setAttribute("search", search);
			request.setAttribute("indexStart", indexStart);  					//查询的起始位置
			request.setAttribute("page", page);
			request.setAttribute("userList", userList);
		}
		
		return false;			
	}

	public boolean queryByUserId (HttpServletRequest request) {		
		
		User user = null;
		String msg = "";
		
		try {	
			String userId = request.getParameter("userId"); 		//获取地址栏参数id的值
			
			try { 									 
				Integer.parseInt(userId);							//尝试转换为整数，即判断其是否为整数
			} catch (Exception e) {
				msg += "参数userId错误！";
				return false;
			}	
			
			User myUser = (User) request.getSession().getAttribute("myUser");
			
			if (myUser == null) {									//如果此session属性不存在
				msg = "您的登录已失效！请重新登录。";
				return false;
			}	
			
			String myUserId = myUser.getUserId();
			String myRole   = myUser.getRole();
			
			if (userId.equals(myUserId) == false && myRole.equals("admin") == false) {		
				msg = "您只能查看或修改自己的信息！";
				return false;
			}
			
			user = userDao.queryByUserId(request, userId);			//****
			
			if (user == null) {
				msg += "（查无此用户记录）";
				return false;
			}

			return true;
		
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
			
			if (request.getSession().getAttribute("msg") != null) {				//如果session中有消息。新添或修改记录后保存的消息
				msg += request.getSession().getAttribute("msg").toString();		//读取session中的消息
				request.getSession().removeAttribute("msg");					//从session中移除此键值			
				request.setAttribute("msg", msg);								//将消息赋值给request
			}
			
			request.setAttribute("user", user);
		}
		
		return false;
	}	
	
	public String addUser (HttpServletRequest request) {		

		String userId = "0";
		String msg = "";
		
		try {
			String username, password, password2, realName, role;
						
			username  	= request.getParameter("username"); 		//获取输入的值
			password  	= request.getParameter("password");
			password2  	= request.getParameter("password2");
			realName  	= request.getParameter("realName");
			role  		= request.getParameter("role");
			
			if (username == null || password == null || password2 == null || realName == null) {
				msg = "输入不正确！";									//值为null的原因：输入框名称不对，或者在地址栏直接输入本页网址
				return userId;
			}
			username = username.trim();
			realName = realName.trim();
			
			if (username.length() < 1 || username.length() > 45) {
				msg = "用户名为1~45个字符！";
				return userId;
			}
	
			if (password.length() < 1 || password.length() > 45) {
				msg = "密码为1~45个字符！";
				return userId;
			}
			if (password2.length() < 1 || password2.length() > 45) {
				msg = "“密码确认”为1~45个字符！";
				return userId;
			}
			if (password.equals(password2) == false) {
				msg = "请确认2个密码保持一致！";
				return userId;
			}
			
			if (realName.length() > 45) {
				msg = "真实姓名最多为45个字符！";
				return userId;
			}
			
			if (role == null) {
				msg += "请选择角色级别。";
				return userId;
			}
			role = role.trim();	
			
			if (!(role.equals("guest") || role.equals("user") || role.equals("admin"))) {
				msg += "角色级别输入有误！";
				return userId;
			}
			
			if (userDao.existByUsername(request, username)) {	//****			
				msg += "所输入的用户名已经存在，请修改后再提交！";
				return userId;
			}			

			String salt = "login_fdsfj45349fd";					//加点料（盐）。此料应与登录验证LoginCheck.java中加的料相同
			password = Md5.getMd5(username + password + salt);	//对用户名+密码+料进行MD5加密

			User user = new User();
			
			//user.setUserId(userId);
			user.setUsername(username);
			user.setPassword(password);
			user.setRealName(realName);
			user.setRole(role);
			
			userId = userDao.addUser(request, user);			//****新添记录
			
			if (userId.equals("0")) {
				msg += "新添记录失败！请重试。";
				return userId;
			}

			msg += "新添记录成功。";
			request.getSession().setAttribute("msg", msg);		//通过session传递消息。消息将显示在详情页中
			return userId;										//返回新添记录的ID
		
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
	
	public boolean editUser (HttpServletRequest request) {	
		
		String userId = "0";
		String msg = "";
		
		try {			
			userId = request.getParameter("userId"); 				//获取地址栏参数id的值
			
			try { 									 
				Integer.parseInt(userId);				
			} catch (Exception e) {
				msg += "参数userId错误！";
				return false;
			}

			String password, password2, realName, role;
			
			password  	= request.getParameter("password");			//获取输入的值
			password2  	= request.getParameter("password2");
			realName  	= request.getParameter("realName");
			role  		= request.getParameter("role");

			if (password == null || password2 == null || realName == null) {
				msg = "输入不正确！";									//值为null的原因：输入框名称不对，或者在地址栏直接输入本页网址
				return false;
			}
			realName = realName.trim();
			
			if (password.isEmpty() == false || password2.isEmpty() == false) {	
				if (password.length() < 1 || password.length() > 45) {
					msg = "密码为1~45个字符！";
					return false;
				}
				if (password2.length() < 1 || password2.length() > 45) {
					msg = "“密码确认”为1~45个字符！";
					return false;
				}
				if (password.equals(password2) == false) {
					msg = "请确认2个密码保持一致！";
					return false;
				}
			}
			
			if (realName.length() > 45) {
				msg = "真实姓名最多为45个字符！";
				return false;
			}
			
			if (role == null) {
				msg += "请选择角色级别。";
				return false;
			}
			role = role.trim();	
			
			if (!(role.equals("guest") || role.equals("user") || role.equals("admin"))) {
				msg += "角色级别输入有误！";
				return false;
			}

			User myUser = (User) request.getSession().getAttribute("myUser");
			
			if (myUser == null) {									//如果此session属性不存在
				msg = "您的登录已失效！请重新登录。";
				return false;
			}	
			
			String myUserId = myUser.getUserId();
			String myRole   = myUser.getRole();
			
			if (userId.equals(myUserId) == false && myRole.equals("admin") == false) {		
				msg = "您只能修改自己的信息！";
				return false;
			}

			if (userId.equals(myUserId) && role.equals(myRole) == false) {
				msg = "您不能更改自己的角色级别。";
				return false;		
			}
			
			User user = userDao.queryByUserId(request, userId);	//****
			
			if (user == null) {
				msg += "userId号对应的记录已不存在，请刷新页面后重试！";
				return false;
			}
			
			if (password.isEmpty() == false) {						//输入的密码不为空
				String username = user.getUsername();
	
				String salt = "login_fdsfj45349fd";					//加点料（盐）。此料应与登录验证LoginCheck.java中加的料相同
				password = Md5.getMd5(username + password + salt);	//对用户名+密码+料进行MD5加密
			}
			
			//user.setUserId(userId);
			//user.setUsername(username);
			user.setPassword(password);
			user.setRealName(realName);
			user.setRole(role);

			boolean result = userDao.editUser(request, user);		//****更新记录
			
			if (result == false) {
				msg += "用户信息修改失败！请重试。";
				return false;
			}	
			
			msg += "用户信息修改成功。";
			request.getSession().setAttribute("msg", msg);			//通过session传递消息。消息将显示在详情页中
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
	
	public boolean deleteByUserId (HttpServletRequest request) {

		String msg = "";
		
		try {	
			String userId = request.getParameter("userId"); 			//取得地址栏参数id
			
			try { 									 
				Integer.parseInt(userId);		
			} catch (Exception e) {
				msg += "参数userId错误！";
				return false;
			}

			if (userDao.queryByUserId(request, userId) == null) {		//****			
				msg += "userId号对应的记录已不存在，请刷新页面后重试！";
				return false;
			}			

			User myUser = (User) request.getSession().getAttribute("myUser");
			
			if (myUser == null) {										//如果此session属性不存在
				msg = "您的登录已失效！请重新登录。";
				return false;
			}	
			
			String myUserId = myUser.getUserId();
			
			if (userId.equals(myUserId)) {
				msg = "您不能删除自己。";
				return false;
			}
			
			boolean result = userDao.deleteByUserId(request, userId);	//****删除这条记录
			
			if (result == false) {
				msg += "删除记录失败！请重试。";
				return false;
			}

			msg += "删除记录成功。";
			return true;
		
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);
			
			request.getSession().setAttribute("msg", msg);				//通过session传递消息。消息将显示在列表页中
		}
		
		return false;
	}
	
	public boolean deleteByUserIdLot (HttpServletRequest request, String[] userIdArray) {	//被本类中的queryAll()方法调用
		
		String msg = "";
		
		try {
			User myUser = (User) request.getSession().getAttribute("myUser");
			
			if (myUser == null) {										//如果此session属性不存在
				msg = "您的登录已失效！请重新登录。";
				return false;
			}	
			
			String myUserId = myUser.getUserId();			
			String userIdLot = "";
			
			for (int i = 0; i < userIdArray.length; i++) {
				try { 									 
					Integer.parseInt(userIdArray[i]);	   
				} catch (Exception e) {
					continue;											//如果转换失败，即不是整数，则略过此项
				}
				
				if (userIdArray[i].equals(myUserId)) {
					//msg = "您不能删除自己。";
					continue;
				}
				
				userIdLot += "," + userIdArray[i];	
			}
			
			if (userIdLot.isEmpty()) {
				return false;
			}
			userIdLot = userIdLot.substring(1);								//去除最前面的逗号
			
			boolean result = userDao.deleteByUserIdLot(request, userIdLot);	//****删除这些记录

			if (result == false) {
				msg += "删除记录失败！请重试。";
				return false;
			}

			msg += "删除记录成功。";
			return false;
		
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
