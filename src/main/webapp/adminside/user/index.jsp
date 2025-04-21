<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <c:choose>
	    <c:when test="${sessionScope.role eq 'Admin'}">
	        <title>Manage Users | Planzone Admin</title>
	    </c:when>
	    <c:when test="${sessionScope.role eq 'Organizer'}">
	        <title>View Users | Planzone Admin</title>
	    </c:when>
	</c:choose>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminside/assets/favicon.png" type="image/png">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-orange-50 min-h-screen flex">

<%@ include file="../partials/sidebar.jsp" %>

<main class="flex-1 p-8">
    <!-- Greeting Message -->
    <div class="mb-6">
        <p class="text-lg font-semibold text-gray-700">
            Hello, ${sessionScope.name}! You are logged in as <span class="text-orange-500">${sessionScope.role}</span>.
        </p>
    </div>

    <div class="flex justify-between items-center mb-6">
        <c:choose>
		    <c:when test="${sessionScope.role eq 'Admin'}">
		        <h1 class="text-2xl font-bold text-orange-600">
		            <i class="fa-solid fa-users-gear mr-2"></i> Manage Users
		        </h1>
		    </c:when>
		    <c:when test="${sessionScope.role eq 'Organizer'}">
		        <h1 class="text-2xl font-bold text-orange-600">
		            <i class="fa-solid fa-users-gear mr-2"></i> View Users
		        </h1>
		    </c:when>
		</c:choose>

        <c:if test="${sessionScope.role eq 'Admin'}">
            <a href="${pageContext.request.contextPath}/admin/user?action=create"
               class="bg-orange-500 text-white px-4 py-2 rounded-lg text-sm hover:bg-orange-600 transition">
                <i class="fa-solid fa-plus mr-1"></i> Create User
            </a>
        </c:if>
    </div>

    <div class="mb-4">
        <input type="text" id="search" placeholder="Search user..."
               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
    </div>

    <div class="overflow-x-auto rounded-lg border border-gray-300 bg-white">
        <table class="w-full text-sm">
            <thead class="bg-orange-500 text-white">
                <tr>
                    <th class="py-3 px-4 text-left">ID</th>
                    <th class="py-3 px-4 text-left">Name</th>
                    <th class="py-3 px-4 text-left">Email</th>
                    <th class="py-3 px-4 text-left">Role</th>
                    <c:if test="${sessionScope.role eq 'Admin'}">
                    	<th class="py-3 px-4 text-left">Actions</th>
                    </c:if>
                </tr>
            </thead>
            <tbody id="userTable">
                <c:forEach var="user" items="${users}">
                    <tr class="border-t">
                        <td class="py-3 px-4">${user.user_id}</td>
                        <td class="py-3 px-4">${user.full_name}</td>
                        <td class="py-3 px-4">${user.email}</td>
                        <td class="py-3 px-4">${user.role}</td>
                        <c:if test="${sessionScope.role eq 'Admin'}">
	                        <td class="py-3 px-4">
	                        	<a href="${pageContext.request.contextPath}/admin/user?action=edit&id=${user.user_id}"
	                               class="text-blue-500 hover:text-blue-700 mr-3"><i class="fa-solid fa-pen-to-square"></i></a>
	                            <a href="javascript:void(0);" onclick="confirmDelete('${pageContext.request.contextPath}/admin/user?action=delete&id=${user.user_id}')"
	                               class="text-red-500 hover:text-red-700"><i class="fa-solid fa-trash"></i></a>
	                        </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>

<script>
    function confirmDelete(url) {
        if (confirm("Are you sure you want to delete this user?")) {
            window.location.href = url;
        }
    }

    document.getElementById("search").addEventListener("input", function () {
        const query = this.value.toLowerCase();
        document.querySelectorAll("#userTable tr").forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? "" : "none";
        });
    });
</script>

</body>
</html>