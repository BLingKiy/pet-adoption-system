package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Cart;

public class CartDao {

    Db db = new Db();
    String sql = "";
    ResultSet rs = null;

    /**------------------------------ 查询用户购物车列表 */
    public List<Cart> queryByUserId(HttpServletRequest request, String userId) {

        List<Cart> cartList = new ArrayList<Cart>();
        String msg = "";

        try {
            String cartId, petId, petNo, petName, breedName, price, quantity, image, timeAdd;

            sql = "select * from tb_cart where userId = ? order by timeAdd desc";
            rs = db.select(sql, userId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return cartList;
            }

            Cart cart = null;

            while (rs.next()) {
                cartId = rs.getString("cartId");
                petId = rs.getString("petId");
                petNo = rs.getString("petNo");
                petName = rs.getString("petName");
                breedName = rs.getString("breedName");
                price = rs.getString("price");
                quantity = rs.getString("quantity");
                image = rs.getString("image");
                timeAdd = rs.getString("timeAdd");

                cart = new Cart();

                cart.setCartId(cartId);
                cart.setUserId(userId);
                cart.setPetId(petId);
                cart.setPetNo(petNo);
                cart.setPetName(petName);
                cart.setBreedName(breedName);
                cart.setPrice(price);
                cart.setQuantity(quantity);
                cart.setImage(image);
                cart.setTimeAdd(timeAdd);

                cartList.add(cart);
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

        return cartList;
    }

    /**------------------------------ 检查购物车中是否已存在该宠物 */
    public boolean existsPet(HttpServletRequest request, String userId, String petId) {

        String msg = "";

        try {
            sql = "select * from tb_cart where userId = ? and petId = ?";
            rs = db.select(sql, userId, petId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return false;
            }

            if (rs.next() == false) {
                db.close();
                return false;
            }
            db.close();

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

    /**------------------------------ 添加到购物车 */
    public String add(HttpServletRequest request, Cart cart) {

        String cartId = "0";
        String msg = "";

        try {
            String userId, petId, petNo, petName, breedName, price, quantity, image;

            userId = cart.getUserId();
            petId = cart.getPetId();
            petNo = cart.getPetNo();
            petName = cart.getPetName();
            breedName = cart.getBreedName();
            price = cart.getPrice();
            quantity = cart.getQuantity();
            image = cart.getImage();

            sql = "insert tb_cart (userId, petId, petNo, petName, breedName, price, quantity, image)"
                    + " values (?, ?, ?, ?, ?, ?, ?, ?)";
            cartId = db.insert(sql, userId, petId, petNo, petName, breedName, price, quantity, image);

            if (cartId.equals("0")) {
                return cartId;
            }

            return cartId;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return cartId;
    }

    /**------------------------------ 更新购物车数量 */
    public int updateQuantity(HttpServletRequest request, String cartId, String quantity) {

        int count = 0;
        String msg = "";

        try {
            sql = "update tb_cart set quantity = ? where cartId = ?";
            count = db.update(sql, quantity, cartId);

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

    /**------------------------------ 删除购物车项 */
    public boolean deleteByCartId(HttpServletRequest request, String cartId) {

        String msg = "";

        try {
            sql = "delete from tb_cart where cartId = ?";
            int count = db.delete(sql, cartId);

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

    /**------------------------------ 清空用户购物车 */
    public boolean clearByUserId(HttpServletRequest request, String userId) {

        String msg = "";

        try {
            sql = "delete from tb_cart where userId = ?";
            int count = db.delete(sql, userId);

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

    /**------------------------------ 根据ID查询购物车项 */
    public Cart queryByCartId(HttpServletRequest request, String cartId) {

        Cart cart = null;
        String msg = "";

        try {
            String userId, petId, petNo, petName, breedName, price, quantity, image, timeAdd;

            sql = "select * from tb_cart where cartId = ?";
            rs = db.select(sql, cartId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return cart;
            }

            if (rs.next() == false) {
                db.close();
                return cart;
            }

            userId = rs.getString("userId");
            petId = rs.getString("petId");
            petNo = rs.getString("petNo");
            petName = rs.getString("petName");
            breedName = rs.getString("breedName");
            price = rs.getString("price");
            quantity = rs.getString("quantity");
            image = rs.getString("image");
            timeAdd = rs.getString("timeAdd");
            db.close();

            cart = new Cart();

            cart.setCartId(cartId);
            cart.setUserId(userId);
            cart.setPetId(petId);
            cart.setPetNo(petNo);
            cart.setPetName(petName);
            cart.setBreedName(breedName);
            cart.setPrice(price);
            cart.setQuantity(quantity);
            cart.setImage(image);
            cart.setTimeAdd(timeAdd);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return cart;
    }
}