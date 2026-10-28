package servlet_user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.UserService;

@WebServlet("/UserDeleteDo")
public class UserDeleteDo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		//java.io.PrintWriter out = response.getWriter();
		String msg = "";
		String url = "UserList";

		// 权限检查 - 需要admin权限
		if (!util.AuthUtil.requireAdmin(request, response)) {
			return;
		}

		try {
			UserService userService = new UserService();
			userService.deleteByUserId(request);				//****删除此记录

		} catch (Exception e) {
			msg += "系统发生错误。";
			e.printStackTrace();
		} finally {
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			request.setAttribute("msg", msg);

			response.sendRedirect(url);							//重定向，地址栏URL能更新
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
