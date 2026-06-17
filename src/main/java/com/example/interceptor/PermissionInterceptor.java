package com.example.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Set;

@Component
public class PermissionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        @SuppressWarnings("unchecked")
        Set<String> permissionCodes = (Set<String>) session.getAttribute("permissionCodes");
        if (permissionCodes == null || permissionCodes.isEmpty()) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>alert('您没有任何权限，请联系管理员分配权限'); window.location.href='" + request.getContextPath() + "/main';</script>");
            return false;
        }

        String requestUri = request.getRequestURI();
        String ctxPath = request.getContextPath();
        String path = requestUri.substring(ctxPath.length());

        if (path.startsWith("/system/")) {
            if (!permissionCodes.contains("system:manage")) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<script>alert('您没有系统管理权限，无法访问该页面'); window.location.href='" + ctxPath + "/main';</script>");
                return false;
            }
        } else if (path.startsWith("/school/")) {
            if (!permissionCodes.contains("school:view") && !permissionCodes.contains("school:manage")) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<script>alert('您没有学校管理权限，无法访问该页面'); window.location.href='" + ctxPath + "/main';</script>");
                return false;
            }
        } else if (path.startsWith("/equipment/")) {
            if (!permissionCodes.contains("equipment:view") && !permissionCodes.contains("equipment:manage")) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<script>alert('您没有设备管理权限，无法访问该页面'); window.location.href='" + ctxPath + "/main';</script>");
                return false;
            }
        }

        return true;
    }
}