package com.example.util;

import javax.servlet.http.HttpSession;
import java.util.Set;

public class PermissionUtils {

    public static boolean hasPermission(HttpSession session, String permissionCode) {
        @SuppressWarnings("unchecked")
        Set<String> permissionCodes = (Set<String>) session.getAttribute("permissionCodes");
        if (permissionCodes == null || permissionCodes.isEmpty()) {
            return false;
        }
        return permissionCodes.contains(permissionCode);
    }

    public static boolean hasAnyPermission(HttpSession session, String... permissionCodes) {
        @SuppressWarnings("unchecked")
        Set<String> userPermissions = (Set<String>) session.getAttribute("permissionCodes");
        if (userPermissions == null || userPermissions.isEmpty()) {
            return false;
        }
        for (String code : permissionCodes) {
            if (userPermissions.contains(code)) {
                return true;
            }
        }
        return false;
    }

    public static boolean hasViewPermission(HttpSession session, String moduleType) {
        String viewPermission = moduleType + ":view";
        String managePermission = moduleType + ":manage";
        return hasAnyPermission(session, viewPermission, managePermission);
    }

    public static boolean hasManagePermission(HttpSession session, String moduleType) {
        String managePermission = moduleType + ":manage";
        return hasPermission(session, managePermission);
    }

    public static boolean isAdmin(HttpSession session) {
        return hasPermission(session, "system:manage");
    }
}