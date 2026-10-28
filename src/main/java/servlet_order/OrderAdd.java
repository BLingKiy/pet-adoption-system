package servlet_order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.CartService;
import service.OrderService;

@WebServlet("/OrderAdd")
public class OrderAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 权限检查
        if (!util.AuthUtil.requireLogin(request, response)) {
            return;
        }

        String msg = "";
        String url = "order/orderAdd.jsp";
        boolean isRedirect = false;

        try {
            if (request.getParameter("buttonSubmit") != null) {
                OrderService orderService = new OrderService();
                if (orderService.add(request)) {
                    url = "OrderDetail?orderId=" + request.getAttribute("orderId");
                    response.sendRedirect(url);
                    isRedirect = true;
                    return;
                }
            }

            CartService cartService = new CartService();
            cartService.queryByUserId(request);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (!isRedirect) {
                if (request.getAttribute("msg") != null) {
                    msg += request.getAttribute("msg").toString();
                }
                request.setAttribute("msg", msg);

                request.getRequestDispatcher(url).forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}