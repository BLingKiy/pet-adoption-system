package servlet_user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.UserService;

@WebServlet("/UserAddDo")
public class UserAddDo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		

		//由于新添用户的表单是以POST方式提交的，理应访问doPost()方法，
		//所以，如果以GET方式访问此Servlet，即访问doGet()方法，那么request中应无表单内容，
		//故此处需返回到Servlet类UserAdd，以便在表单输入新的用户信息。
		response.sendRedirect("UserAdd");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		java.io.PrintWriter out = response.getWriter();
		String msg = "";
		String url = "UserShow";

		// 权限检查 - 需要登录
		if (!util.AuthUtil.requireLogin(request, response)) {
			return;
		}

		try {
			UserService userService = new UserService();
			String userId = userService.addUser(request);	//****

			if (userId.equals("0")) {							//新添失败
				url = "";
				return;
			}

			//---------------------- 新添成功
			url = "UserShow?userId=" + userId;					//目标网址
			url = "@Redirect:" + url;							//增加@Redirect用于通过JS代码实现网页跳转（自创协议）

		} catch (Exception e) {
			msg += "系统发生错误。";
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);

			//----由于页面userAdd.jsp中是以Ajax方式提交表单，所以无论是输出错误消息，
			//----还是新添成功需跳转到详情页面，这里都是调用out()方法输出内容，
			//----再由Ajax根据接收到的内容决定下一步如何处理。

			if (url.equals("")) {							//如果新添失败
				out.print(msg);								//输出错误消息
			} else {										//如果新添成功
				out.print(url);								//网页将转向
			}
		}
	}
}
