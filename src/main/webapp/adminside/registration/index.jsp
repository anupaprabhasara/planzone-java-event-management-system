<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Registrations | Planzone Admin</title>
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
        <h1 class="text-2xl font-bold text-orange-600">
            <i class="fa-solid fa-users mr-2"></i> Manage Registrations
        </h1>
    </div>

    <div class="mb-4">
        <input type="text" id="search" placeholder="Search by user or event..."
               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
    </div>

    <div class="overflow-x-auto rounded-lg border border-gray-300 bg-white">
        <table class="w-full text-sm">
            <thead class="bg-orange-500 text-white">
                <tr>
                    <th class="py-3 px-4 text-left">ID</th>
                    <th class="py-3 px-4 text-left">User</th>
                    <th class="py-3 px-4 text-left">Event</th>
                    <th class="py-3 px-4 text-left">Registered At</th>
                    <th class="py-3 px-4 text-left">Actions</th>
                </tr>
            </thead>
            <tbody id="registrationTable">
                <c:forEach var="reg" items="${registrations}">
                    <tr class="border-t">
                        <td class="py-3 px-4">${reg.registrationId}</td>
                        <td class="py-3 px-4">${reg.userName}</td>
                        <td class="py-3 px-4">${reg.eventTitle}</td>
                        <td class="py-3 px-4">${reg.registeredAt}</td>
                        <td class="py-3 px-4">
                            <a href="javascript:void(0);" onclick="confirmDelete('${pageContext.request.contextPath}/admin/registration?action=delete&id=${reg.registrationId}')"
                               class="text-red-500 hover:text-red-700"><i class="fa-solid fa-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>

<script>
    function confirmDelete(url) {
        if (confirm("Are you sure you want to delete this registration?")) {
            window.location.href = url;
        }
    }

    document.getElementById("search").addEventListener("input", function () {
        const query = this.value.toLowerCase();
        document.querySelectorAll("#registrationTable tr").forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? "" : "none";
        });
    });
</script>

</body>
</html>