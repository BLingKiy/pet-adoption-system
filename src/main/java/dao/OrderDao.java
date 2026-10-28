package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Order;

public class OrderDao {

    Db db = new Db();
    String sql = "";
    ResultSet rs = null;

    /**------------------------------ 查询用户订单列表 */
    public List<Order> queryByUserId(HttpServletRequest request, String userId) {

        List<Order> orderList = new ArrayList<Order>();
        String msg = "";

        try {
            String orderId, orderNo, username, totalAmount, status, receiverName, receiverPhone, receiverAddress, remark, timeCreate, timeUpdate;

            sql = "select * from tb_order where userId = ? order by timeCreate desc";
            rs = db.select(sql, userId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return orderList;
            }

            Order order = null;

            while (rs.next()) {
                orderId = rs.getString("orderId");
                orderNo = rs.getString("orderNo");
                username = rs.getString("username");
                totalAmount = rs.getString("totalAmount");
                status = rs.getString("status");
                receiverName = rs.getString("receiverName");
                receiverPhone = rs.getString("receiverPhone");
                receiverAddress = rs.getString("receiverAddress");
                remark = rs.getString("remark");
                timeCreate = rs.getString("timeCreate");
                timeUpdate = rs.getString("timeUpdate");

                order = new Order();

                order.setOrderId(orderId);
                order.setOrderNo(orderNo);
                order.setUserId(userId);
                order.setUsername(username);
                order.setTotalAmount(totalAmount);
                order.setStatus(status);
                order.setReceiverName(receiverName);
                order.setReceiverPhone(receiverPhone);
                order.setReceiverAddress(receiverAddress);
                order.setRemark(remark);
                order.setTimeCreate(timeCreate);
                order.setTimeUpdate(timeUpdate);

                orderList.add(order);
            }
            db.close();

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return orderList;
    }

    /**------------------------------ 根据ID查询订单 */
    public Order queryByOrderId(HttpServletRequest request, String orderId) {

        Order order = null;
        String msg = "";

        try {
            String orderNo, userId, username, totalAmount, status, receiverName, receiverPhone, receiverAddress, remark, timeCreate, timeUpdate;

            sql = "select * from tb_order where orderId = ?";
            rs = db.select(sql, orderId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return order;
            }

            if (rs.next() == false) {
                db.close();
                return order;
            }

            orderNo = rs.getString("orderNo");
            userId = rs.getString("userId");
            username = rs.getString("username");
            totalAmount = rs.getString("totalAmount");
            status = rs.getString("status");
            receiverName = rs.getString("receiverName");
            receiverPhone = rs.getString("receiverPhone");
            receiverAddress = rs.getString("receiverAddress");
            remark = rs.getString("remark");
            timeCreate = rs.getString("timeCreate");
            timeUpdate = rs.getString("timeUpdate");
            db.close();

            order = new Order();

            order.setOrderId(orderId);
            order.setOrderNo(orderNo);
            order.setUserId(userId);
            order.setUsername(username);
            order.setTotalAmount(totalAmount);
            order.setStatus(status);
            order.setReceiverName(receiverName);
            order.setReceiverPhone(receiverPhone);
            order.setReceiverAddress(receiverAddress);
            order.setRemark(remark);
            order.setTimeCreate(timeCreate);
            order.setTimeUpdate(timeUpdate);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return order;
    }

    /**------------------------------ 创建订单 */
    public String add(HttpServletRequest request, Order order) {

        String orderId = "0";
        String msg = "";

        try {
            String orderNo, userId, username, totalAmount, status, receiverName, receiverPhone, receiverAddress, remark;

            orderNo = order.getOrderNo();
            userId = order.getUserId();
            username = order.getUsername();
            totalAmount = order.getTotalAmount();
            status = order.getStatus();
            receiverName = order.getReceiverName();
            receiverPhone = order.getReceiverPhone();
            receiverAddress = order.getReceiverAddress();
            remark = order.getRemark();

            sql = "insert tb_order (orderNo, userId, username, totalAmount, status, receiverName, receiverPhone, receiverAddress, remark)"
                    + " values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            orderId = db.insert(sql, orderNo, userId, username, totalAmount, status, receiverName, receiverPhone, receiverAddress, remark);

            if (orderId.equals("0")) {
                return orderId;
            }

            return orderId;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return orderId;
    }

    /**------------------------------ 更新订单状态 */
    public int updateStatus(HttpServletRequest request, String orderId, String status) {

        int count = 0;
        String msg = "";

        try {
            sql = "update tb_order set status = ?, timeUpdate = (now()) where orderId = ?";
            count = db.update(sql, status, orderId);

            if (count == 0) {
                return count;
            }

            return count;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return count;
    }

    /**------------------------------ 取消订单 */
    public int cancel(HttpServletRequest request, String orderId) {

        int count = 0;
        String msg = "";

        try {
            sql = "update tb_order set status = '已取消', timeUpdate = (now()) where orderId = ?";
            count = db.update(sql, orderId);

            if (count == 0) {
                return count;
            }

            return count;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return count;
    }

    /**------------------------------ 查询所有订单 */
    public List<Order> queryAll(HttpServletRequest request) {

        List<Order> orderList = new ArrayList<Order>();
        String msg = "";

        try {
            String orderId, orderNo, userId, username, totalAmount, status, receiverName, receiverPhone, receiverAddress, remark, timeCreate, timeUpdate;

            sql = "select * from tb_order order by timeCreate desc";
            rs = db.select(sql);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return orderList;
            }

            Order order = null;

            while (rs.next()) {
                orderId = rs.getString("orderId");
                orderNo = rs.getString("orderNo");
                userId = rs.getString("userId");
                username = rs.getString("username");
                totalAmount = rs.getString("totalAmount");
                status = rs.getString("status");
                receiverName = rs.getString("receiverName");
                receiverPhone = rs.getString("receiverPhone");
                receiverAddress = rs.getString("receiverAddress");
                remark = rs.getString("remark");
                timeCreate = rs.getString("timeCreate");
                timeUpdate = rs.getString("timeUpdate");

                order = new Order();

                order.setOrderId(orderId);
                order.setOrderNo(orderNo);
                order.setUserId(userId);
                order.setUsername(username);
                order.setTotalAmount(totalAmount);
                order.setStatus(status);
                order.setReceiverName(receiverName);
                order.setReceiverPhone(receiverPhone);
                order.setReceiverAddress(receiverAddress);
                order.setRemark(remark);
                order.setTimeCreate(timeCreate);
                order.setTimeUpdate(timeUpdate);

                orderList.add(order);
            }
            db.close();

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return orderList;
    }

    /**------------------------------ 编辑订单 */
    public int edit(HttpServletRequest request, Order order) {

        int count = 0;
        String msg = "";

        try {
            String orderId, receiverName, receiverPhone, receiverAddress, remark, status;

            orderId = order.getOrderId();
            receiverName = order.getReceiverName();
            receiverPhone = order.getReceiverPhone();
            receiverAddress = order.getReceiverAddress();
            remark = order.getRemark();
            status = order.getStatus();

            sql = "update tb_order set receiverName = ?, receiverPhone = ?, receiverAddress = ?, remark = ?, status = ?, timeUpdate = (now()) where orderId = ?";
            count = db.update(sql, receiverName, receiverPhone, receiverAddress, remark, status, orderId);

            if (count == 0) {
                return count;
            }

            return count;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return count;
    }

    /**------------------------------ 删除订单 */
    public boolean delete(HttpServletRequest request, String orderId) {

        String msg = "";

        try {
            sql = "delete from tb_order where orderId = ?";
            int count = db.delete(sql, orderId);

            if (count == 0) {
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
        }

        return false;
    }
}