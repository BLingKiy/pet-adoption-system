package service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Cart;
import bean.Order;
import bean.OrderDetail;
import dao.CartDao;
import dao.OrderDao;
import dao.OrderDetailDao;

public class OrderService {

    OrderDao orderDao = new OrderDao();
    OrderDetailDao orderDetailDao = new OrderDetailDao();
    CartDao cartDao = new CartDao();

    /**------------------------------ 查询用户订单列表 */
    public boolean queryByUserId(HttpServletRequest request) {

        List<Order> orderList = null;
        String msg = "";

        try {
            String userId = (String) request.getSession().getAttribute("userId");

            if (userId == null || userId.equals("")) {
                userId = request.getSession().getId();
            }

            orderList = orderDao.queryByUserId(request, userId);

            if (orderList == null || orderList.size() == 0) {
                msg += "（暂无订单）";
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

            if (request.getSession().getAttribute("msg") != null) {
                msg += request.getSession().getAttribute("msg").toString();
                request.getSession().removeAttribute("msg");
                request.setAttribute("msg", msg);
            }

            request.setAttribute("orderList", orderList);
        }

        return false;
    }

    /**------------------------------ 根据ID查询订单 */
    public boolean queryByOrderId(HttpServletRequest request) {

        Order order = null;
        String msg = "";

        try {
            String orderId = request.getParameter("orderId");

            try {
                Integer.parseInt(orderId);
            } catch (Exception e) {
                msg += "参数orderId错误！";
                return false;
            }

            order = orderDao.queryByOrderId(request, orderId);

            if (order == null) {
                msg += "（查无此订单）";
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

            if (request.getSession().getAttribute("msg") != null) {
                msg += request.getSession().getAttribute("msg").toString();
                request.getSession().removeAttribute("msg");
                request.setAttribute("msg", msg);
            }

            request.setAttribute("order", order);
        }

        return false;
    }

    /**------------------------------ 创建订单 */
    public boolean add(HttpServletRequest request) {

        String msg = "";

        try {
            String userId = (String) request.getSession().getAttribute("userId");

            if (userId == null || userId.equals("")) {
                userId = request.getSession().getId();
            }

            String username = (String) request.getSession().getAttribute("username");
            if (username == null || username.equals("")) {
                username = "游客";
            }

            String receiverName = request.getParameter("receiverName");
            String receiverPhone = request.getParameter("receiverPhone");
            String receiverAddress = request.getParameter("receiverAddress");
            String remark = request.getParameter("remark");

            if (receiverName == null || receiverName.trim().equals("")) {
                msg += "请输入收货人姓名！";
                return false;
            }

            if (receiverPhone == null || receiverPhone.trim().equals("")) {
                msg += "请输入收货人电话！";
                return false;
            }

            if (receiverAddress == null || receiverAddress.trim().equals("")) {
                msg += "请输入收货地址！";
                return false;
            }

            List<Cart> cartList = cartDao.queryByUserId(request, userId);

            if (cartList == null || cartList.size() == 0) {
                msg += "购物车为空，无法创建订单！";
                return false;
            }

            float totalAmount = 0;
            for (Cart cart : cartList) {
                totalAmount += Float.parseFloat(cart.getPrice()) * Integer.parseInt(cart.getQuantity());
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String orderNo = "ORD" + sdf.format(new Date());

            Order order = new Order();
            order.setOrderNo(orderNo);
            order.setUserId(userId);
            order.setUsername(username);
            order.setTotalAmount(String.valueOf(totalAmount));
            order.setStatus("待付款");
            order.setReceiverName(receiverName);
            order.setReceiverPhone(receiverPhone);
            order.setReceiverAddress(receiverAddress);
            order.setRemark(remark == null ? "" : remark);

            String orderId = orderDao.add(request, order);

            if (orderId.equals("0")) {
                msg += "创建订单失败！";
                return false;
            }

            for (Cart cart : cartList) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(orderId);
                detail.setOrderNo(orderNo);
                detail.setPetId(cart.getPetId());
                detail.setPetNo(cart.getPetNo());
                detail.setPetName(cart.getPetName());
                detail.setBreedName(cart.getBreedName());
                detail.setPrice(cart.getPrice());
                detail.setQuantity(cart.getQuantity());
                detail.setImage(cart.getImage());

                String detailId = orderDetailDao.add(request, detail);

                if (detailId.equals("0")) {
                    msg += "添加订单详情失败！";
                    return false;
                }
            }

            cartDao.clearByUserId(request, userId);

            msg += "订单创建成功！订单号：" + orderNo;
            request.getSession().setAttribute("msg", msg);
            request.setAttribute("orderId", orderId);
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

    /**------------------------------ 取消订单 */
    public boolean cancel(HttpServletRequest request) {

        String msg = "";

        try {
            String orderId = request.getParameter("orderId");

            if (orderId == null || orderId.equals("")) {
                msg += "参数orderId错误！";
                return false;
            }

            try {
                Integer.parseInt(orderId);
            } catch (Exception e) {
                msg += "参数orderId错误！";
                return false;
            }

            Order order = orderDao.queryByOrderId(request, orderId);

            if (order == null) {
                msg += "订单不存在！";
                return false;
            }

            if (!order.getStatus().equals("待付款")) {
                msg += "只有待付款订单才能取消！";
                return false;
            }

            int count = orderDao.cancel(request, orderId);

            if (count == 0) {
                msg += "取消订单失败！";
                return false;
            }

            msg += "订单已取消！";
            request.getSession().setAttribute("msg", msg);
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

    /**------------------------------ 查询所有订单（admin用） */
    public boolean queryAll(HttpServletRequest request) {

        List<Order> orderList = null;
        String msg = "";

        try {
            orderList = orderDao.queryAll(request);

            if (orderList == null || orderList.size() == 0) {
                msg += "（暂无订单）";
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

            if (request.getSession().getAttribute("msg") != null) {
                msg += request.getSession().getAttribute("msg").toString();
                request.getSession().removeAttribute("msg");
                request.setAttribute("msg", msg);
            }

            request.setAttribute("orderList", orderList);
        }

        return false;
    }

    /**------------------------------ 编辑订单 */
    public boolean edit(HttpServletRequest request) {

        String msg = "";

        try {
            String orderId = request.getParameter("orderId");
            String receiverName = request.getParameter("receiverName");
            String receiverPhone = request.getParameter("receiverPhone");
            String receiverAddress = request.getParameter("receiverAddress");
            String remark = request.getParameter("remark");
            String status = request.getParameter("status");

            if (orderId == null || orderId.equals("")) {
                msg += "参数orderId错误！";
                return false;
            }

            try {
                Integer.parseInt(orderId);
            } catch (Exception e) {
                msg += "参数orderId错误！";
                return false;
            }

            if (receiverName == null || receiverName.trim().equals("")) {
                msg += "请输入收货人姓名！";
                return false;
            }

            if (receiverPhone == null || receiverPhone.trim().equals("")) {
                msg += "请输入收货人电话！";
                return false;
            }

            if (receiverAddress == null || receiverAddress.trim().equals("")) {
                msg += "请输入收货地址！";
                return false;
            }

            if (status == null || status.equals("")) {
                msg += "请选择订单状态！";
                return false;
            }

            Order order = orderDao.queryByOrderId(request, orderId);

            if (order == null) {
                msg += "订单不存在！";
                return false;
            }

            order.setReceiverName(receiverName);
            order.setReceiverPhone(receiverPhone);
            order.setReceiverAddress(receiverAddress);
            order.setRemark(remark == null ? "" : remark);
            order.setStatus(status);

            int count = orderDao.edit(request, order);

            if (count == 0) {
                msg += "订单修改失败！";
                return false;
            }

            msg += "订单修改成功！";
            request.getSession().setAttribute("msg", msg);
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

    /**------------------------------ 删除订单 */
    public boolean delete(HttpServletRequest request) {

        String msg = "";

        try {
            String orderId = request.getParameter("orderId");

            if (orderId == null || orderId.equals("")) {
                msg += "参数orderId错误！";
                return false;
            }

            try {
                Integer.parseInt(orderId);
            } catch (Exception e) {
                msg += "参数orderId错误！";
                return false;
            }

            Order order = orderDao.queryByOrderId(request, orderId);

            if (order == null) {
                msg += "订单不存在！";
                return false;
            }

            if (!order.getStatus().equals("已取消")) {
                msg += "只有已取消的订单才能删除！";
                return false;
            }

            boolean result = orderDao.delete(request, orderId);

            if (result == false) {
                msg += "删除订单失败！";
                return false;
            }

            msg += "订单已删除！";
            request.getSession().setAttribute("msg", msg);
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
}