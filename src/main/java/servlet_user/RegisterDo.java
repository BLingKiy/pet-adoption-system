package servlet_user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.UserService;

@WebServlet("/RegisterDo")
public class RegisterDo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		

		//由于新添用户的表单是以POST方式提交的，理应访问doPost()方法，
		//所以，如果以GET方式访问此Servlet，即访问doGet()方法，那么request中应无表单内容，
		//故此处需返回到Servlet类UserAdd，以便在表单输入新的用户信息。
		response.sendRedirect("Register");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");		
		java.io.PrintWriter out = response.getWriter();
		String msg = "";
		String url = "login.jsp";
				
		try {			
			//注册不需要验证是否已登录			
			
			String role = request.getParameter("role");
			
			if (role == null || role.equals("guest") == false) {	//注册用户的用户角色强制设为为guest
				url = "";
				msg = "输入有误。请刷新页面后重新输入。";
				return;
			}

			UserService userService = new UserService();
			String userId = userService.addUser(request);		//****
			
			if (userId.equals("0")) {								//新添失败
				url = "";
				return;
			}
			
			if (request.getSession().getAttribute("msg") != null) {				//如果session中有消息。新添或修改记录后保存的消息
				msg += request.getSession().getAttribute("msg").toString();		//读取session中的消息
				request.getSession().removeAttribute("msg");					//从session中移除此键值			
				request.setAttribute("msg", msg);								//将消息赋值给request
			}
		
			//---------------------- 新添成功
			url = "@Redirect:" + url;								//增加@Redirect用于通过JS代码实现网页跳转（自创协议）
			
		} catch (Exception e) {
			msg += "系统发生错误。";	
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);

			//----由于页面register.jsp中是以Ajax方式提交表单，所以无论是输出错误消息，
			//----还是新添成功需跳转到详情页面，这里都是调用out()方法输出内容，
			//----再由Ajax根据接收到的内容决定下一步如何处理。
			
			if (url.equals("")) {							//如果新添失败
				out.print(msg);								//输出错误消息
			} else {										//如果新添成功
				out.print(url);								//网页将转向。
			}
		}
	}
}
