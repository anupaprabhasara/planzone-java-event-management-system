<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile | Planzone</title>
  	<link rel="shortcut icon" href="${pageContext.request.contextPath}/clientside/assets/favicon.png" type="image/png">
  	<script src="https://cdn.tailwindcss.com"></script>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <%@ include file="partials/navbarsession.jsp" %>

    <div class="max-w-3xl mx-auto my-12 bg-white p-8 rounded-lg shadow">
        <div class="flex items-center space-x-6">
            <img src="https://ui-avatars.com/api/?name=${sessionScope.name}&background=818CF8&color=fff"
                alt="${sessionScope.name}" class="w-20 h-20 rounded-full">
            <div>
                <h2 class="text-2xl font-bold text-gray-800">${user.full_name}</h2>
                <p class="text-gray-600">${user.email}</p>
                <span class="inline-block mt-2 bg-indigo-100 text-indigo-800 px-3 py-1 rounded-full text-sm font-medium">
                    ${user.role}
                </span>
            </div>
        </div>

        <div class="mt-8">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Profile Details</h3>
            <ul class="space-y-2 text-gray-600">
                <li><strong>Email:</strong> ${user.email}</li>
                <li><strong>Full Name:</strong> ${user.full_name}</li>
                <li><strong>Role:</strong> ${user.role}</li>
                <li><strong>Joined:</strong> ${user.created_at}</li>
            </ul>
        </div>
    </div>

    <%@ include file="partials/footer.jsp" %>
</body>
</html>