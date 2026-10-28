package servlet_order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.OrderService;

@WebServlet("/OrderCancel")
public class OrderCancel extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 权限检查
        if (!util.AuthUtil.requireLogin(request, response)) {
            return;
        }

        String msg = "";
        // 根据用户角色决定跳转地址：admin和user跳转到OrderManage，guest跳转到OrderList
        String role = util.AuthUtil.getCurrentUserRole(request);
        String url = ("admin".equals(role) || "user".equals(role)) ? "OrderManage" : "OrderList";

        try {
            OrderService orderService = new OrderService();
            orderService.cancel(request);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);

            response.sendRedirect(url);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}