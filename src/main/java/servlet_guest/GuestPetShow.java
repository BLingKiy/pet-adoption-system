package servlet_guest;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.PetService;

@WebServlet("/GuestPetShow")
public class GuestPetShow extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String msg = "";
        String url = "guest/guestPetShow.jsp";
        boolean shouldForward = true;

        try {
            // 如果已登录且是admin或user，跳转到管理页面
            if (util.AuthUtil.isLoggedIn(request) && util.AuthUtil.isUserOrAdmin(request)) {
                String petId = request.getParameter("petId");
                if (petId != null && !petId.trim().equals("")) {
                    response.sendRedirect("PetShow?petId=" + petId);
                    shouldForward = false;
                    return;
                }
            }

            PetService petService = new PetService();
            petService.queryByPetId(request);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);

            if (shouldForward) {
                request.getRequestDispatcher(url).forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}