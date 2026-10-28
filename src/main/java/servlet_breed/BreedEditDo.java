package servlet_breed;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BreedService;

@WebServlet("/BreedEditDo")
public class BreedEditDo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.sendRedirect("BreedEdit?breedId=" + request.getParameter("breedId"));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		// 权限检查
		if (!util.AuthUtil.requireUserOrAdmin(request, response)) {
			return;
		}

		java.io.PrintWriter out = response.getWriter();
		String msg = "";
		String url = "";

		try {
			BreedService breedService = new BreedService();
			boolean result = breedService.editBreed(request);

			if (result == false) {
				if (request.getAttribute("msg") != null) {
					msg = request.getAttribute("msg").toString();
				} else {
					msg = "修改失败！";
				}
				out.print(msg);
				return;
			}

			String breedId = request.getParameter("breedId");
			url = "BreedShow?breedId=" + breedId;
			url = "@Redirect:" + url;
			out.print(url);

		} catch (Exception e) {
			msg += "系统发生错误。";
			e.printStackTrace();
			if (request.getAttribute("msg") != null) {
				msg += request.getAttribute("msg").toString();
			}
			out.print(msg);
		}
	}
}