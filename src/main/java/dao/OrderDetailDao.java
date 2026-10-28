package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.OrderDetail;

public class OrderDetailDao {

    Db db = new Db();
    String sql = "";
    ResultSet rs = null;

    /**------------------------------ 查询订单详情列表 */
    public List<OrderDetail> queryByOrderId(HttpServletRequest request, String orderId) {

        List<OrderDetail> detailList = new ArrayList<OrderDetail>();
        String msg = "";

        try {
            String detailId, orderNo, petId, petNo, petName, breedName, price, quantity, image;

            sql = "select * from tb_order_detail where orderId = ? order by detailId";
            rs = db.select(sql, orderId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return detailList;
            }

            OrderDetail detail = null;

            while (rs.next()) {
                detailId = rs.getString("detailId");
                orderNo = rs.getString("orderNo");
                petId = rs.getString("petId");
                petNo = rs.getString("petNo");
                petName = rs.getString("petName");
                breedName = rs.getString("breedName");
                price = rs.getString("price");
                quantity = rs.getString("quantity");
                image = rs.getString("image");

                detail = new OrderDetail();

                detail.setDetailId(detailId);
                detail.setOrderId(orderId);
                detail.setOrderNo(orderNo);
                detail.setPetId(petId);
                detail.setPetNo(petNo);
                detail.setPetName(petName);
                detail.setBreedName(breedName);
                detail.setPrice(price);
                detail.setQuantity(quantity);
                detail.setImage(image);

                detailList.add(detail);
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

        return detailList;
    }

    /**------------------------------ 添加订单详情 */
    public String add(HttpServletRequest request, OrderDetail detail) {

        String detailId = "0";
        String msg = "";

        try {
            String orderId, orderNo, petId, petNo, petName, breedName, price, quantity, image;

            orderId = detail.getOrderId();
            orderNo = detail.getOrderNo();
            petId = detail.getPetId();
            petNo = detail.getPetNo();
            petName = detail.getPetName();
            breedName = detail.getBreedName();
            price = detail.getPrice();
            quantity = detail.getQuantity();
            image = detail.getImage();

            sql = "insert tb_order_detail (orderId, orderNo, petId, petNo, petName, breedName, price, quantity, image)"
                    + " values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            detailId = db.insert(sql, orderId, orderNo, petId, petNo, petName, breedName, price, quantity, image);

            if (detailId.equals("0")) {
                return detailId;
            }

            return detailId;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return detailId;
    }
}