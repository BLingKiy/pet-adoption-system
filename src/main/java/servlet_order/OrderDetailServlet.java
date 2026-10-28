package servlet_order;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.OrderDetail;
import bean.User;
import dao.OrderDetailDao;
import service.OrderService;

@WebServlet("/OrderDetail")
public class OrderDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 权限检查
        if (!util.AuthUtil.requireLogin(request, response)) {
            return;
        }

        // 智能跳转到对应的详情页
        String orderId = request.getParameter("orderId");
        if (orderId != null) {
            String role = util.AuthUtil.getCurrentUserRole(request);
            // admin和user都跳转到管理详情页
            if ("admin".equals(role) || "user".equals(role)) {
                try {
                    OrderService orderService = new OrderService();
                    orderService.queryByOrderId(request);
                    OrderDetailDao orderDetailDao = new OrderDetailDao();
                    List<OrderDetail> detailList = orderDetailDao.queryByOrderId(request, orderId);
                    request.setAttribute("detailList", detailList);
                    request.getRequestDispatcher("order/orderManageDetail.jsp").forward(request, response);
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("OrderManage");
                    return;
                }
            } else {
                // guest跳转到普通详情页
                try {
                    OrderService orderService = new OrderService();
                    orderService.queryByOrderId(request);
                    OrderDetailDao orderDetailDao = new OrderDetailDao();
                    List<OrderDetail> detailList = orderDetailDao.queryByOrderId(request, orderId);
                    request.setAttribute("detailList", detailList);
                    request.getRequestDispatcher("order/orderDetail.jsp").forward(request, response);
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("OrderList");
                    return;
                }
            }
        }

        // 如果没有orderId参数，根据角色跳转到订单列表
        String role = util.AuthUtil.getCurrentUserRole(request);
        if ("admin".equals(role)) {
            response.sendRedirect("OrderManage");
        } else {
            response.sendRedirect("OrderList");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}