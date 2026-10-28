package util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import bean.User;

/**
 * 权限工具类 - 处理登录验证和权限控制
 */
public class AuthUtil {

    /**
     * 检查用户是否已登录
     * @param request HttpServletRequest
     * @return true表示已登录，false表示未登录
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        User myUser = (User) request.getSession().getAttribute("myUser");
        return myUser != null;
    }

    /**
     * 获取当前登录用户
     * @param request HttpServletRequest
     * @return User对象，如果未登录返回null
     */
    public static User getCurrentUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("myUser");
    }

    /**
     * 获取当前用户的角色
     * @param request HttpServletRequest
     * @return 角色字符串，如果未登录返回"guest"
     */
    public static String getCurrentUserRole(HttpServletRequest request) {
        User myUser = getCurrentUser(request);
        return myUser != null ? myUser.getRole() : "guest";
    }

    /**
     * 检查用户是否有管理员权限
     * @param request HttpServletRequest
     * @return true表示是管理员，false表示不是
     */
    public static boolean isAdmin(HttpServletRequest request) {
        return "admin".equals(getCurrentUserRole(request));
    }

    /**
     * 检查用户是否有管理员或普通用户权限
     * @param request HttpServletRequest
     * @return true表示有权限，false表示没有
     */
    public static boolean isUserOrAdmin(HttpServletRequest request) {
        String role = getCurrentUserRole(request);
        return "admin".equals(role) || "user".equals(role);
    }

    /**
     * 检查用户是否有指定权限
     * @param request HttpServletRequest
     * @param role 期望的角色
     * @return true表示有权限，false表示没有
     */
    public static boolean hasRole(HttpServletRequest request, String role) {
        return role.equals(getCurrentUserRole(request));
    }

    /**
     * 要求用户必须登录，否则重定向到登录页
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return true表示已登录，false表示未登录并已重定向
     * @throws IOException
     */
    public static boolean requireLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return false;
        }
        return true;
    }

    /**
     * 要求用户必须有管理员或普通用户权限，否则重定向到主页面
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return true表示有权限，false表示没有权限并已重定向
     * @throws IOException
     */
    public static boolean requireUserOrAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!requireLogin(request, response)) {
            return false;
        }
        if (!isUserOrAdmin(request)) {
            response.sendRedirect("main.jsp");
            return false;
        }
        return true;
    }

    /**
     * 要求用户必须有管理员权限，否则重定向到主页面
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return true表示是管理员，false表示不是管理员并已重定向
     * @throws IOException
     */
    public static boolean requireAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!requireLogin(request, response)) {
            return false;
        }
        if (!isAdmin(request)) {
            response.sendRedirect("main.jsp");
            return false;
        }
        return true;
    }

    /**
     * 智能跳转：根据用户角色跳转到不同的详情页
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param guestUrl 游客详情页URL
     * @param adminUrl 管理员详情页URL
     * @throws IOException
     */
    public static void redirectByRole(HttpServletRequest request, HttpServletResponse response, 
                                       String guestUrl, String adminUrl) throws IOException {
        String role = getCurrentUserRole(request);
        if ("guest".equals(role) || "user".equals(role)) {
            response.sendRedirect(guestUrl);
        } else if ("admin".equals(role)) {
            response.sendRedirect(adminUrl);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    /**
     * 智能跳转：根据用户角色跳转到不同的详情页（带参数）
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param guestUrl 游客详情页URL
     * @param adminUrl 管理员详情页URL
     * @param paramName 参数名
     * @param paramValue 参数值
     * @throws IOException
     */
    public static void redirectByRoleWithParam(HttpServletRequest request, HttpServletResponse response,
                                                String guestUrl, String adminUrl,
                                                String paramName, String paramValue) throws IOException {
        String role = getCurrentUserRole(request);
        String url = "";
        if ("guest".equals(role) || "user".equals(role)) {
            url = guestUrl + "?" + paramName + "=" + paramValue;
        } else if ("admin".equals(role)) {
            url = adminUrl + "?" + paramName + "=" + paramValue;
        } else {
            response.sendRedirect("login.jsp");
            return;
        }
        response.sendRedirect(url);
    }
}