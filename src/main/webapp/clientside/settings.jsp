<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Settings | Planzone</title>
  	<link rel="shortcut icon" href="${pageContext.request.contextPath}/clientside/assets/favicon.png" type="image/png">
  	<script src="https://cdn.tailwindcss.com"></script>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <%@ include file="partials/navbarsession.jsp" %>

    <div class="max-w-2xl mx-auto my-12 bg-white p-8 rounded-lg shadow">
        <h2 class="text-2xl font-bold text-gray-800 mb-6">Update Your Profile</h2>

        <form method="post" action="${pageContext.request.contextPath}/settings">
            <div class="space-y-4">
                <div>
                    <label class="block text-gray-700 font-medium">Full Name</label>
                    <input type="text" name="full_name" value="${user.full_name}" required class="w-full px-4 py-2 border rounded-md">
                </div>
                <div>
                    <label class="block text-gray-700 font-medium">Email</label>
                    <input type="email" name="email" value="${user.email}" required class="w-full px-4 py-2 border rounded-md">
                </div>
                <div>
                    <label class="block text-gray-700 font-medium">New Password</label>
                    <input type="password" name="new_password" placeholder="Leave blank to keep current password" class="w-full px-4 py-2 border rounded-md">
                </div>
                <div>
                    <label class="block text-gray-700 font-medium">Current Password <span class="text-red-600">*</span></label>
                    <input type="password" name="current_password" required class="w-full px-4 py-2 border rounded-md">
                </div>
            </div>

            <div class="mt-6">
                <button type="submit" class="bg-indigo-600 text-white px-6 py-2 rounded-md hover:bg-indigo-700">Save Changes</button>
            </div>
        </form>

        <c:if test="${not empty error}">
            <div class="mt-4 text-red-600 font-medium">${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="mt-4 text-green-600 font-medium">${success}</div>
        </c:if>
    </div>

    <%@ include file="partials/footer.jsp" %>
</body>
</html>