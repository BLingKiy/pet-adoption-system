package service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Cart;
import dao.CartDao;

public class CartService {

    CartDao cartDao = new CartDao();

    /**------------------------------ 查询用户购物车列表 */
    public boolean queryByUserId(HttpServletRequest request) {

        List<Cart> cartList = null;
        String msg = "";

        try {
            String userId = (String) request.getSession().getAttribute("userId");

            if (userId == null || userId.equals("")) {
                userId = request.getSession().getId();
            }

            cartList = cartDao.queryByUserId(request, userId);

            if (cartList == null || cartList.size() == 0) {
                msg += "（购物车为空）";
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

            request.setAttribute("cartList", cartList);
        }

        return false;
    }

    /**------------------------------ 添加到购物车 */
    public boolean add(HttpServletRequest request) {

        String msg = "";

        try {
            String userId = (String) request.getSession().getAttribute("userId");

            if (userId == null || userId.equals("")) {
                userId = request.getSession().getId();
            }

            String petId = request.getParameter("petId");

            if (petId == null || petId.equals("")) {
                msg += "参数petId错误！";
                return false;
            }

            try {
                Integer.parseInt(petId);
            } catch (Exception e) {
                msg += "参数petId错误！";
                return false;
            }

            dao.PetDao petDao = new dao.PetDao();
            bean.Pet pet = petDao.queryByPetId(request, petId);

            if (pet == null) {
                msg += "宠物不存在！";
                return false;
            }

            if (cartDao.existsPet(request, userId, petId)) {
                msg += "该宠物已在购物车中！";
                return false;
            }

            Cart cart = new Cart();
            cart.setUserId(userId);
            cart.setPetId(petId);
            cart.setPetNo(pet.getPetNo());
            cart.setPetName(pet.getPetName());
            cart.setBreedName(pet.getBreedName());
            cart.setPrice(pet.getPrice());
            cart.setQuantity("1");
            cart.setImage(pet.getImage());

            String cartId = cartDao.add(request, cart);

            if (cartId.equals("0")) {
                msg += "添加到购物车失败！";
                return false;
            }

            msg += "成功添加到购物车！";
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

    /**------------------------------ 更新购物车数量 */
    public boolean updateQuantity(HttpServletRequest request) {

        String msg = "";

        try {
            String cartId = request.getParameter("cartId");
            String quantity = request.getParameter("quantity");

            if (cartId == null || cartId.equals("")) {
                msg += "参数cartId错误！";
                return false;
            }

            if (quantity == null || quantity.equals("")) {
                msg += "参数quantity错误！";
                return false;
            }

            try {
                int qty = Integer.parseInt(quantity);
                if (qty < 1) {
                    msg += "数量必须大于0！";
                    return false;
                }
            } catch (Exception e) {
                msg += "参数quantity错误！";
                return false;
            }

            int count = cartDao.updateQuantity(request, cartId, quantity);

            if (count == 0) {
                msg += "更新失败！";
                return false;
            }

            msg += "更新成功！";
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

    /**------------------------------ 删除购物车项 */
    public boolean delete(HttpServletRequest request) {

        String msg = "";

        try {
            String cartId = request.getParameter("cartId");

            if (cartId == null || cartId.equals("")) {
                msg += "参数cartId错误！";
                return false;
            }

            try {
                Integer.parseInt(cartId);
            } catch (Exception e) {
                msg += "参数cartId错误！";
                return false;
            }

            boolean result = cartDao.deleteByCartId(request, cartId);

            if (result == false) {
                msg += "删除失败！";
                return false;
            }

            msg += "删除成功！";
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

    /**------------------------------ 清空购物车 */
    public boolean clear(HttpServletRequest request) {

        String msg = "";

        try {
            String userId = (String) request.getSession().getAttribute("userId");

            if (userId == null || userId.equals("")) {
                userId = request.getSession().getId();
            }

            boolean result = cartDao.clearByUserId(request, userId);

            if (result == false) {
                msg += "清空购物车失败！";
                return false;
            }

            msg += "购物车已清空！";
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