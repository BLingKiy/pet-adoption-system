package servlet_guest;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BreedService;
import service.PetService;

@WebServlet("/GuestPetList")
public class GuestPetList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String msg = "";
        String url = "guest/guestPetList.jsp";

        try {
            // 如果已登录且是admin或user，跳转到管理页面
            if (util.AuthUtil.isLoggedIn(request) && util.AuthUtil.isUserOrAdmin(request)) {
                response.sendRedirect("PetList");
                return;
            }

            PetService petService = new PetService();
            petService.queryAll(request);

            BreedService breedService = new BreedService();
            breedService.queryAllForPET(request);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);

            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}